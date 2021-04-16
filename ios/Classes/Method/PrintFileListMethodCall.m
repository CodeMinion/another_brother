//
//  PrintFileListMethodCall.m
//  another_brother
//
//  Created by admin on 4/15/21.
//

#import <Foundation/Foundation.h>
#import "PrintFileListMethodCall.h"

@implementation PrintFileListMethodCall
static NSString * METHOD_NAME = @"printFileList";

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
    // Get printInfo dart params from call
    NSDictionary<NSString *, NSObject *> * dartPrintInfo = _call.arguments[@"printInfo"];
    // Get list of file paths from call
    NSArray * dartFilePathList = _call.arguments[@"filePathList"];
    
    
    // Map the paths into a list of NSURLs
    NSMutableArray *urlList = [NSMutableArray arrayWithCapacity:[dartFilePathList count]];
    [dartFilePathList enumerateObjectsUsingBlock:^(id filePath, NSUInteger idx, BOOL *stop) {
        id mapObj = [NSURL fileURLWithPath:filePath];
        [urlList addObject:mapObj];
    }];
    
    
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
    
    //NSURL * url = [NSURL fileURLWithPath:filePath];
    
    // Call print method
    BRLMPrintError * printError = [printerDriver printImageWithURLs:urlList settings:printerSettings];

    
    [printerDriver closeChannel];
    
    // Notify status to Flutter.
    NSDictionary<NSString *, NSObject *> * printStatus = [BrotherUtils printerStatusToMapWithError:printError.code  status:nil];
    
    _result(printStatus);
    
   
}


@end
