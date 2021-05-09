//
//  TbSendCommandBinMethodCall.m
//  another_brother
//
//  Created by admin on 5/8/21.
//

#import <Foundation/Foundation.h>
#import "TbSendCommandBinMethodCall.h"

@implementation TbSendCommandBinMethodCall

static NSString * METHOD_NAME = @"typeB-sendCommandBin";

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
                FlutterStandardTypedData * commandData = self->_call.arguments[@"data"];
                NSData * commandBytes = commandData.data;
                
                
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
                
                
                NSString* command = [[NSString alloc] initWithBytes:[commandBytes bytes] length:commandBytes.length encoding:NSUTF8StringEncoding];
                
                //NSString* command = [[NSString alloc] initWithData:commandBytes encoding:NSUTF8StringEncoding];
                
                
                //NSString* command = [NSString stringWithUTF8String:[commandBytes bytes]];

                success = [printer sendCommand:command] == 1;
                
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
