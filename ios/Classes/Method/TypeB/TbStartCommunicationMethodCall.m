//
//  TbStartCommunicationMethodCall.m
//  another_brother
//
//  Created by admin on 5/8/21.
//

#import <Foundation/Foundation.h>
#import "TbStartCommunicationMethodCall.h"

@implementation TbStartCommunicationMethodCall

static NSString * METHOD_NAME = @"typeB-startCommunication";

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
                
                // TODO Launch as a background thread.
                TbPrinterInfo * printerInfo  = [TbPrinterInfo fromMap:dartPrintInfo];
                
                BROTHERSDK * printer;
                if (printerInfo.port == BRLMChannelTypeWiFi
                    //|| printerInfo.port == BRLMChannelTypeBluetoothLowEnergy
                    || printerInfo.port == BRLMChannelTypeBluetoothMFi) {
                    // TODO Connect over WIFI
                    printer = [BROTHERSDK new];
                }
                else {
                    printer = NULL;
                }
                
                if (printer == NULL) {
                    // Notify failure
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            self->_result(@"");
                        });
                    return;
                }
                
                bool connectionSuccess = false;
                NSString * printerId = @"";
                if (printerInfo.port == BRLMChannelTypeWiFi) {
                    // Connect over WIFI
                    connectionSuccess = [printer openport:printerInfo.ipAddress];
                    printerId = printerInfo.ipAddress;
                }
                else if (printerInfo.port == BRLMChannelTypeBluetoothLowEnergy) {
                    // TODO Connect over BLE
                    //connectionSuccess = [printer openport:(printerInfo.localName];
                    //printerId = printerInfo.localName;
                    
                }
                else if (printerInfo.port == BRLMChannelTypeBluetoothMFi) {
                    // TODO Connect over MFI
                    connectionSuccess = [printer openportMFI:printerInfo.iOSBtPath];
                    // TODO Once we get a bluetooth peripheral use the uri instead
                    printerId = printerInfo.iOSBtPath;
                }
                
                if (!connectionSuccess) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            self->_result(@"");
                        });
                    return;
                }
                
                // Track the priner.
                
                [self->_plugin trackTypeBPrinterWithId:printerId typeBPrinter:printer ];
                
                    // Notify on the UI thread.
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            // Call the desired channel message here.
                            self->_result(printerId);
                        });
                 
            });
    
}

@end
