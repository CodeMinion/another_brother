//
//  GetBluetoothPrintersMethodCall.m
//  another_brother
//
//  Created by admin on 4/16/21.
//

#import <Foundation/Foundation.h>
#import "GetBluetoothPrintersMethodCall.h"

@implementation GetBluetoothPrintersMethodCall

static NSString * METHOD_NAME = @"getBluetoothPrinters";

- (instancetype)initWithCall:(FlutterMethodCall *)call
                      result:(FlutterResult) result {
    self = [super init];
        if (self) {
            _call = call;
            _result = result;
            
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
    
    NSArray * pairedDevices = [[BRPtouchBluetoothManager sharedManager] pairedDevices];
    
    // TODO Filter out based on the name specified
    // Map the paths into a list of NSURLs
    NSMutableArray<NSDictionary<NSString *, NSObject*> *> * dartBluetoothPrinters = [NSMutableArray arrayWithCapacity:[pairedDevices count]];
    [pairedDevices enumerateObjectsUsingBlock:^(id printerInfo, NSUInteger idx, BOOL *stop) {
        
        if ([printerModels containsObject:[(BRPtouchDeviceInfo*) printerInfo strModelName]] ) {
        id mapObj = [BrotherUtils bRPtouchDeviceInfoToBluetoothPrinterMap:printerInfo];
        [dartBluetoothPrinters addObject:mapObj];
        }
    }];
    
    _result(dartBluetoothPrinters);
}

@end
