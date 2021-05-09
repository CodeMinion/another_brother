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
            _foundPrinters = [NSMutableArray<BRPtouchDeviceInfo *> alloc];
            
        }
        return self;
}

+ (NSString *) METHOD_NAME {
    return METHOD_NAME;
}
- (void)execute {
    // Get printInfo dart params from call
    //NSDictionary<NSString *, NSObject *> * dartPrintInfo = _call.arguments[@"printInfo"];
    // Get list of file paths from call
    NSArray * printerModels = _call.arguments[@"models"];
    
    
    // Create network manager.
    // Pass printers.
    _netManager = [[BRPtouchNetworkManager alloc] initWithPrinterNames:printerModels];
    // Set delegate
    [_netManager setDelegate:self];
    [_netManager setIsEnableIPv6Search:false];
    //_netManager.isEnableIPv6Search = false;
    // Start searching for devices for 2 seconds.
    [_netManager startSearch:2];
    
}

- (void)didFindDevice:(BRPtouchDeviceInfo *)deviceInfo {

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
