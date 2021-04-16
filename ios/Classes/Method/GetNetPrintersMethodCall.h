//
//  GetNetPrintersMethodCall.h
//  another_brother
//
//  Created by admin on 4/16/21.
//

#ifndef GetNetPrintersMethodCall_h
#define GetNetPrintersMethodCall_h

#import <Flutter/Flutter.h>
#import <BRLMPrinterKit/BRPtouchPrinterKit.h>
#import "BrotherUtils.h"

@interface GetNetPrintersMethodCall : NSObject<BRPtouchNetworkDelegate>

@property (strong, nonatomic) BRPtouchNetworkManager * netManager;

@property (strong, nonatomic) NSMutableArray<BRPtouchDeviceInfo *> * foundPrinters;
@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end

@interface NetPrinterDelegate : NSObject<BRPtouchNetworkDelegate>
@property (strong, nonatomic) BRPtouchNetworkManager * netManager;

@property (strong, nonatomic) FlutterResult result;

- (instancetype)initWithResult:(FlutterResult)result netManager:(BRPtouchNetworkManager *)netManager;

@end

#endif /* GetNetPrintersMethodCall_h */
