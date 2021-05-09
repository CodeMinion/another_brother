//
//  TbEndCommunicationMethodCall.m
//  another_brother
//
//  Created by admin on 5/8/21.
//

#import <Foundation/Foundation.h>
#import "TbEndCommunicationMethodCall.h"

@implementation TbEndCommunicationMethodCall

static NSString * METHOD_NAME = @"typeB-endCommunication";

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
                NSNumber * timeoutMillis = self->_call.arguments[@"timeout"];
                
                
                BROTHERSDK * printer = [self->_plugin getTypeBPrinterWithId:printerId];
                
                if (printer == NULL) {
                    // Notify failure
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            self->_result(printerId);
                        });
                    return;
                }
                
                bool success = false;
                
                success = [printer closeport:([timeoutMillis intValue] / 1000)];
                
                if (!success) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            self->_result(printerId);
                        });
                    return;
                }
                
                // Untrack Printer the priner.
                
                [self->_plugin untrackTypeBPrinterWithId:printerId];
                
                    // Notify on the UI thread.
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            // Call the desired channel message here.
                            self->_result(@"");
                        });
                 
            });
    
}

@end
