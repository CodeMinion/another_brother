//
//  TbGetBluetoothPrintersMethodCall.h
//  another_brother
//
//  Created by admin on 5/8/21.
//

#ifndef TbGetBluetoothPrintersMethodCall_h
#define TbGetBluetoothPrintersMethodCall_h

#import <Flutter/Flutter.h>
#import "AnotherBrotherPlugin.h"
#import <CoreBluetooth/CBCentralManager.h>
#import <ExternalAccessory/ExternalAccessory.h>

#import "TbPrinterInfo.h"

@interface TbGetBluetoothPrintersMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (strong, nonatomic) AnotherBrotherPlugin * plugin;

@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result
                      plugin: (AnotherBrotherPlugin *) plugin;

- (void) execute;
@end



#endif /* TbGetBluetoothPrintersMethodCall_h */
