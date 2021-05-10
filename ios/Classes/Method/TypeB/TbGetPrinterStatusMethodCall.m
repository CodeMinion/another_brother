//
//  TbGetPrinterStatusMethodCall.m
//  another_brother
//
//  Created by admin on 5/8/21.
//

#import <Foundation/Foundation.h>
#import "TbGetPrinterStatusMethodCall.h"

@implementation TbGetPrinterStatusMethodCall

static NSString * METHOD_NAME = @"typeB-printerStatus";

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
                NSNumber * timeMillis = self->_call.arguments[@"delayMillis"];
                
                
                BROTHERSDK * printer = [self->_plugin getTypeBPrinterWithId:printerId];
                
                if (printer == NULL) {
                    // Notify failure
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            self->_result(@{
                                @"value" : @"80"
                                          });
                        });
                    return;
                }
                
                
                NSData * status = [printer printerstatus];
                 
                
                if (status == NULL) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                        self->_result(@{
                            @"value" : @"80"
                                      });
                        });
                    return;
                }
                
                    // Notify on the UI thread.
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            // Call the desired channel message here.
                        const unsigned char *dataBuffer = (const unsigned char *)[status bytes];
                        
                        NSString * statusCode = [NSString stringWithFormat:@"%02lx",  (unsigned long)dataBuffer[0]];
                        
                        self->_result(@{
                            @"value" : statusCode
                                      });
                
                
                        /*
                            self->_result(@{
                                @"value" : [[NSString alloc] initWithData:status encoding:NSUTF8StringEncoding]
                                          });
                         */
                        });
                         
                
                 
            });
    
}

@end
