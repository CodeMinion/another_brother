//
//  GetNetPrintersMethodCall.m
//  another_brother
//
//  Created by admin on 4/16/21.
//

#import <Foundation/Foundation.h>
#import "GetNetPrintersMethodCall.h"

@implementation GetNetPrintersMethodCall

static NSString * METHOD_NAME = @"getNetPrinters";

- (instancetype)initWithCall:(FlutterMethodCall *)call
                      result:(FlutterResult) result {
    self = [super init];
    if (self) {
        _call = call;
        _result = result;
        _foundPrinters = [[NSMutableArray<BRPtouchDeviceInfo *> alloc] init];
    }
    return self;
}

+ (NSString *) METHOD_NAME {
    return METHOD_NAME;
}
- (void)execute {
    NSArray * printerModels = _call.arguments[@"models"];
    if (!printerModels) {
        _result([FlutterError errorWithCode:@"INVALID_ARGUMENT"
                                  message:@"Printer models array is required"
                                  details:nil]);
        return;
    }
    
    _netManager = [[BRPtouchNetworkManager alloc] initWithPrinterNames:printerModels];
    if (!_netManager) {
        _result([FlutterError errorWithCode:@"INITIALIZATION_ERROR"
                                  message:@"Failed to initialize network manager"
                                  details:nil]);
        return;
    }
    
    [_netManager setDelegate:self];
    [_netManager setIsEnableIPv6Search:false];
    [_netManager startSearch:2];
}

- (void)didFindDevice:(BRPtouchDeviceInfo *)deviceInfo {
    if (deviceInfo) {
        [_foundPrinters addObject:deviceInfo];
    }
}

- (void)didFinishSearch:(id)sender {
    // Get found printer list. Array of BRPtouchDeviceInfo
    NSArray<BRPtouchPrintInfo *> * scanResults = [_netManager getPrinterNetInfo];
    
    // Map the paths into Dart Net Printers
    NSMutableArray<NSDictionary<NSString *, NSObject*> *> * dartNetPrinters = [NSMutableArray arrayWithCapacity:[scanResults count]];
    [scanResults enumerateObjectsUsingBlock:^(id printerInfo, NSUInteger idx, BOOL *stop) {
        id mapObj = [BrotherUtils bRPtouchDeviceInfoToNetPrinterMap:printerInfo];
        [dartNetPrinters addObject:mapObj];
    }];
    
    _result(dartNetPrinters);
}

@end
