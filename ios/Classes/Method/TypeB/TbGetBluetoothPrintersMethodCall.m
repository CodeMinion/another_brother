//
//  TbGetBluetoothPrintersMethodCall.m
//  another_brother
//
//  Created by admin on 5/8/21.
//

#import <Foundation/Foundation.h>
#import "TbGetBluetoothPrintersMethodCall.h"


@implementation TbGetBluetoothPrintersMethodCall

static NSString * METHOD_NAME = @"typeB-getBluetoothPrinters";

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
                NSDictionary<NSString *, NSObject *> * dartPrintInfo = _call.arguments[@"printInfo"];
                // Get list of file paths from call
                NSArray * printerModels = _call.arguments[@"models"];
                
                NSArray<EAAccessory *> * pairedDevices = [[EAAccessoryManager sharedAccessoryManager] connectedAccessories];
                
                /*
                NSArray<CBUUID *> * services = @[
                    [CBUUID UUIDWithString:@"00001101-0000-1000-8000-00805F9B34FB" ] ];
                
                NSArray * pairedDevices = [[CBCentralManager alloc] retrieveConnectedPeripheralsWithServices:services];
                */
                
                // TODO Filter out based on the name specified
                // Map the paths into a list of NSURLs
                NSMutableArray<NSDictionary<NSString *, NSObject*> *> * dartBluetoothPrinters = [NSMutableArray arrayWithCapacity:[pairedDevices count]];
                
                
                [pairedDevices enumerateObjectsUsingBlock:^(id printerInfo, NSUInteger idx, BOOL *stop) {
                    
                    // TODO Convert to CBPeripheral to Bluetooth Printer
                    //id mapObj = [BrotherUtils cpPeripheralToBluetoothPrinterMap:(CBPeripheral*) printerInfo];
                    
                    //[dartBluetoothPrinters addObject:mapObj];
                    
                    // TODO For not just send all the printers.
                    
                    
                    if ([printerModels containsObject:[(EAAccessory*) printerInfo name]] ) {
                    
                        // TODO Convert peripheral info into Bluetooth printer.
                        id mapObj = [BrotherUtils eaAccessoryToBluetoothPrinterMap:printerInfo];
                        
                        
                        [dartBluetoothPrinters addObject:mapObj];
                    }
                     
                    
                }];
                
                
                
                    // Notify on the UI thread.
                    dispatch_sync(dispatch_get_main_queue(), ^{
                            // Update UI
                            // Call the desired channel message here.
                            self->_result(dartBluetoothPrinters);
                                
                        });
                 
                 
            });
     
    
}

@end
