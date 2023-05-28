//
//  PrintImageMethodCall.m
//  another_brother
//
//  Created by admin on 4/13/21.
//

#import <Foundation/Foundation.h>
#import "PrintImageMethodCall.h"

@implementation PrintImageMethodCall
static NSString * METHOD_NAME = @"printImage";

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

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
                dispatch_async(queue, ^{


        // Get printInfo dart params from call
        NSDictionary<NSString *, NSObject *> * dartPrintInfo = _call.arguments[@"printInfo"];
        // Get image bytes from call
        FlutterStandardTypedData * imageData = _call.arguments[@"imageBytes"];
        NSData * imageBytes = imageData.data;

        //NSData * imageBytes = [FlutterStandardTypedData typedDataWithBytes:_call.arguments[@"imageBytes"]].data;

        // TODO Get channel from printInfo
        BRLMChannel *channel = [BrotherUtils printChannelWithPrintSettingsMap:dartPrintInfo];

        // TODO Generate printer driver
        BRLMPrinterDriverGenerateResult * driverGenerateResult = [BRLMPrinterDriverGenerator openChannel:channel];
            if (driverGenerateResult.error.code != BRLMOpenChannelErrorCodeNoError ||
                driverGenerateResult.driver == nil) {

                // On Error report error
                NSDictionary<NSString *, NSObject *> * printStatus = [BrotherUtils printerStatusToMapWithError:BRLMPrintErrorCodePrinterStatusErrorCommunicationError  status:nil];
                //_result(printStatus);
                BRLMPrinterDriver *printerDriver = driverGenerateResult.driver;
                [printerDriver closeChannel];


                dispatch_sync(dispatch_get_main_queue(), ^{
                                            // Update UI
                                            self->_result(printStatus);
                                        });
                return;
            }


        BRLMPrinterDriver *printerDriver = driverGenerateResult.driver;

        // Get printer settings.
        id<BRLMPrintSettingsProtocol>  printerSettings = [BrotherUtils printSettingsFromMapWithValue:dartPrintInfo];

        CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)(imageBytes));
        CGImageRef imageRef = CGImageCreateWithPNGDataProvider
    (imgDataProvider, NULL, true, kCGRenderingIntentDefault);

        // Call print method
        BRLMPrintError * printError = [printerDriver printImageWithImage:imageRef settings:printerSettings];


        [printerDriver closeChannel];

        // Notify status to Flutter.
        NSDictionary<NSString *, NSObject *> * printStatus = [BrotherUtils printerStatusToMapWithError:printError.code  status:nil];

        //_result(printStatus);
                    
                            // Notify on the UI thread.
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                    // Update UI
                                    // Call the desired channel message here.
                                    self->_result(printStatus);
                                });
                     
       });
}


@end
