//
//  PrintFileMethodCall.m
//  another_brother
//
//  Created by admin on 4/12/21.
//

#import <Foundation/Foundation.h>
#import "PrintFileMethodCall.h"

@implementation PrintFileMethodCall
static NSString * METHOD_NAME = @"printFile";

- (instancetype)initWithCall:(FlutterMethodCall *)call
                      result:(FlutterResult) result {
    self = [super init];
        if (self) {
            _call = call;
            _result = result;
            
        }
        return self;
}

+ (NSString *) METHOD_NAME {
    return METHOD_NAME;
}
- (void)execute {
    // Move the execution to a background thread to avoid blocking the main thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            // Validate input parameters
            if (!_call.arguments[@"printInfo"] || !_call.arguments[@"filePath"]) {
                [self handleError:BRLMPrintErrorCodePrinterStatusErrorInvalidParameter];
                return;
            }

            NSDictionary<NSString *, NSObject *> * dartPrintInfo = _call.arguments[@"printInfo"];
            NSString * filePath = _call.arguments[@"filePath"];
            
            // Validate file exists
            if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                [self handleError:BRLMPrintErrorCodePrinterStatusErrorFileNotFound];
                return;
            }

            // Get channel from printInfo
            BRLMChannel *channel = [BrotherUtils printChannelWithPrintSettingsMap:dartPrintInfo];
            
            // Generate printer driver
            BRLMPrinterDriverGenerateResult * driverGenerateResult = [BRLMPrinterDriverGenerator openChannel:channel];
            if (driverGenerateResult.error.code != BRLMOpenChannelErrorCodeNoError ||
                driverGenerateResult.driver == nil) {
                [self handleError:BRLMPrintErrorCodePrinterStatusErrorCommunicationError];
                return;
            }

            BRLMPrinterDriver *printerDriver = driverGenerateResult.driver;
            @try {
                // Get printer settings.
                id<BRLMPrintSettingsProtocol> printerSettings = [BrotherUtils printSettingsFromMapWithValue:dartPrintInfo];

                NSURL *url = [NSURL fileURLWithPath:filePath];
                NSString *extension = [url pathExtension];
                BRLMPrintError *printError;

                if ([extension.lowercaseString isEqualToString:@"prn"]) {
                    printError = [printerDriver sendPRNFileWithURL:url];
                } else {
                    printError = [printerDriver printImageWithURL:url settings:printerSettings];
                }

                // Notify status to Flutter
                NSDictionary<NSString *, NSObject *> *printStatus = [BrotherUtils printerStatusToMapWithError:printError.code status:nil];
                [self notifyFlutterWithResult:printStatus];
            }
            @finally {
                // Ensure printer channel is always closed
                [printerDriver closeChannel];
            }
        }
        @catch (NSException *exception) {
            [self handleError:BRLMPrintErrorCodePrinterStatusErrorUnknown];
        }
    });
}

// Helper method to handle errors
- (void)handleError:(BRLMPrintErrorCode)errorCode {
    NSDictionary<NSString *, NSObject *> *printStatus = [BrotherUtils printerStatusToMapWithError:errorCode status:nil];
    [self notifyFlutterWithResult:printStatus];
}

// Helper method to notify Flutter on main thread
- (void)notifyFlutterWithResult:(NSDictionary<NSString *, NSObject *> *)result {
    dispatch_sync(dispatch_get_main_queue(), ^{
        self->_result(result);
    });
}

@end
