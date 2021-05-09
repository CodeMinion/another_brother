//
//  TbPrinterFontMethodCall.m
//  another_brother
//
//  Created by admin on 5/9/21.
//

#import <Foundation/Foundation.h>
#import "TbPrinterFontMethodCall.h"

@implementation TbPrinterFontMethodCall

static NSString * METHOD_NAME = @"typeB-printerFont";

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
                NSNumber * y = self->_call.arguments[@"y"];
                NSString * size = self->_call.arguments[@"size"];
                NSNumber * rotation = self->_call.arguments[@"rotation"];
                NSNumber * xMultiplication = self->_call.arguments[@"xMultiplication"];
                NSNumber * yMultiplication = self->_call.arguments[@"yMultiplication"];
                
                
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
                
                success = [printer printerfont:[x stringValue] y:[y stringValue] fontName:size rotation:[rotation stringValue] magnificationRateX:[xMultiplication stringValue] magnificationRateY:[yMultiplication stringValue] content:content] == 1;
                 
                
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
