//
//  TbBarcodeMethodCall.m
//  another_brother
//
//  Created by admin on 5/8/21.
//

#import <Foundation/Foundation.h>
#import "TbBarcodeMethodCall.h"

@implementation TbBarcodeMethodCall

static NSString * METHOD_NAME = @"typeB-barcode";

- (instancetype)initWithCall:(FlutterMethodCall *)call
                      result:(FlutterResult) result
                      plugin:(AnotherBrotherPlugin *) plugin{
    self = [super init];
        if (self) {
            _call = call;
            _result = result;
            _plugin = plugin;
            
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
                //NSDictionary<NSString *, NSObject *> * dartPrintInfo = self->_call.arguments[@"printInfo"];
                NSString * printerId = self->_call.arguments[@"printerId"];
                NSString * content = self->_call.arguments[@"content"];
                NSNumber * x = self->_call.arguments[@"x"];
                NSNumber * y = self-> _call.arguments[@"y"];
                NSString * type = self-> _call.arguments[@"type"];
                NSNumber * height = self->_call.arguments[@"height"];
                NSNumber * humanReadable = self-> _call.arguments[@"humanReadable"];
                NSNumber * rotation = self->_call.arguments[@"rotation"];
                NSNumber * narrowBarRatio = self->_call.arguments[@"narrowBarRatio"];
                NSNumber * wideBarRatio = self->_call.arguments[@"wideBarRatio"];
                
                
                
                BROTHERSDK * printer = [self->_plugin getTypeBPrinterWithId:printerId];
                
                if (printer == NULL) {
                    // Notify failure
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            self->_result(@NO);
                        });
                    return;
                }
                
                bool success = false;
                
                success = [printer barcode:[x stringValue] y:[y stringValue] barcodeType:type height:[height stringValue] readable:[humanReadable stringValue] rotation:[rotation stringValue] narrow:[narrowBarRatio stringValue] wide:[wideBarRatio stringValue] code:content ] == 1;
                 
                
                if (!success) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            self->_result(@NO);
                        });
                    return;
                }
                
                    // Notify on the UI thread.
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            // Call the desired channel message here.
                            self->_result(@YES);
                        });
                 
            });
    
}

@end
