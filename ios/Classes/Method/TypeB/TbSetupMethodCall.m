//
//  TbSetupMethodCall.m
//  another_brother
//
//  Created by admin on 5/8/21.
//

#import <Foundation/Foundation.h>
#import "TbSetupMethodCall.h"

@implementation TbSetupMethodCall

static NSString * METHOD_NAME = @"typeB-setup";

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
                NSDictionary<NSString *, NSObject *> * dartPrintInfo = self->_call.arguments[@"printInfo"];
                NSString * printerId = self->_call.arguments[@"printerId"];
                NSNumber * width = self->_call.arguments[@"width"];
                NSNumber * height = self-> _call.arguments[@"height"];
                NSNumber * speed = self -> _call.arguments[@"speed"];
                NSNumber * density = self->_call.arguments[@"density"];
                NSNumber * sensor = self->_call.arguments[@"sensor"];
                NSNumber * sensorDistance = self->_call.arguments[@"sensorDistance"];
                NSNumber * sensorOffset = self -> _call.arguments[@"sensorOffset"];
                
                
                
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
                
                success = [printer setup:[width stringValue] height:[height stringValue] speed:[speed stringValue] density:[density stringValue] sensor:[sensor stringValue] vertical:[sensorDistance stringValue] offset:[sensorOffset stringValue]] == 1;
                
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
