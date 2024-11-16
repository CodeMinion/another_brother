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
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{

        // Get printInfo dart params from call
        NSDictionary<NSString *, NSObject *> * dartPrintInfo = _call.arguments[@"printInfo"];
        // Get file path from call
        NSString * filePath = _call.arguments[@"filePath"];

        // Get channel from printInfo
        BRLMChannel *channel = [BrotherUtils printChannelWithPrintSettingsMap:dartPrintInfo];

        // Generate printer driver
        BRLMPrinterDriverGenerateResult * driverGenerateResult = [BRLMPrinterDriverGenerator openChannel:channel];
        if (driverGenerateResult.error.code != BRLMOpenChannelErrorCodeNoError ||
            driverGenerateResult.driver == nil) {

            // On Error report error
            NSDictionary<NSString *, NSObject *> * printStatus = [BrotherUtils printerStatusToMapWithError:BRLMPrintErrorCodePrinterStatusErrorCommunicationError status:nil];

            // Notify Flutter on the main thread
            dispatch_sync(dispatch_get_main_queue(), ^{
                self->_result(printStatus);
            });
            return;
        }

        BRLMPrinterDriver *printerDriver = driverGenerateResult.driver;

        // Get printer settings.
        id<BRLMPrintSettingsProtocol> printerSettings = [BrotherUtils printSettingsFromMapWithValue:dartPrintInfo];

        // If no error, create URL from file path
        NSURL *url = [NSURL fileURLWithPath:filePath];
        NSString *extension = [url pathExtension];
        BRLMPrintError *printError;

        if ([extension isEqualToString:@"prn"]) {
            // Print PRN file
            printError = [printerDriver sendPRNFileWithURL:url];
        } else {
            // Print normal file (image)
            printError = [printerDriver printImageWithURL:url settings:printerSettings];
        }

        // Close printer channel
        [printerDriver closeChannel];

        // Notify status to Flutter
        NSDictionary<NSString *, NSObject *> *printStatus = [BrotherUtils printerStatusToMapWithError:printError.code status:nil];

        // Update Flutter UI on the main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            self->_result(printStatus);
        });
    });
}


@end
