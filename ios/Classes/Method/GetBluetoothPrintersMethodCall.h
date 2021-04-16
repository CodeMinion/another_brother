//
//  GetBluetoothPrintersMethodCall.h
//  another_brother
//
//  Created by admin on 4/16/21.
//

#ifndef GetBluetoothPrintersMethodCall_h
#define GetBluetoothPrintersMethodCall_h

#import <Flutter/Flutter.h>
#import <BRLMPrinterKit/BRPtouchPrinterKit.h>
#import "BrotherUtils.h"

@interface GetBluetoothPrintersMethodCall : NSObject

@property (strong, nonatomic) NSMutableArray<BRPtouchDeviceInfo *> * foundPrinters;
@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end


#endif /* GetBluetoothPrintersMethodCall_h */
