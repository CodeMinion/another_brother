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
    // TODO Move to background thread.

    // Get printInfo dart params from call
    NSDictionary<NSString *, NSObject *> * dartPrintInfo = _call.arguments[@"printInfo"];
    // Get file path from call
    NSString * filePath = _call.arguments[@"filePath"];
    
    
    // TODO Get channel from printInfo
    BRLMChannel *channel = [BrotherUtils printChannelWithPrintSettingsMap:dartPrintInfo];
    
    // TODO Generate printer driver
    BRLMPrinterDriverGenerateResult * driverGenerateResult = [BRLMPrinterDriverGenerator openChannel:channel];
        if (driverGenerateResult.error.code != BRLMOpenChannelErrorCodeNoError ||
            driverGenerateResult.driver == nil) {
            
            // On Error report error
            NSDictionary<NSString *, NSObject *> * printStatus = [BrotherUtils printerStatusToMapWithError:BRLMPrintErrorCodePrinterStatusErrorCommunicationError  status:nil];
            _result(printStatus);
            return;
        }

    
    BRLMPrinterDriver *printerDriver = driverGenerateResult.driver;
    
    // Get printer settings.
    id<BRLMPrintSettingsProtocol>  printerSettings = [BrotherUtils printSettingsFromMapWithValue:dartPrintInfo];
    
    // If no error create URL from path
    
    NSURL * url = [NSURL fileURLWithPath:filePath];
    
    NSString * extension = [url pathExtension];
    NSDictionary<NSString *, NSObject *> * printStatus;
    
    if ([extension isEqualToString:@"prn"]) {
        // SDK 4.12.0+ replaced sendPRNFileWithURL: with transferBinaryFiles:progress:
        BRLMTransferResult *transferResult = [printerDriver transferBinaryFiles:@[ url ] progress:^(NSURL *current, int progress) {}];
        BRLMPrintErrorCode code = (transferResult.code == BRLMTransferSummaryErrorAllSuccess)
            ? BRLMPrintErrorCodeNoError
            : BRLMPrintErrorCodeUnknownError;
        printStatus = [BrotherUtils printerStatusToMapWithError:code status:nil];
    } else {
        BRLMPrintError * printError = [printerDriver printImageWithURL:url settings:printerSettings];
        printStatus = [BrotherUtils printerStatusToMapWithError:printError.code status:nil];
    }
    
    [printerDriver closeChannel];
    _result(printStatus);
    
   
}


@end
