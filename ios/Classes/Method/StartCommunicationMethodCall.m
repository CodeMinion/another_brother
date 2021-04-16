//
//  StartCommunicationMethodCall.m
//  another_brother
//
//  Created by admin on 4/16/21.
//

#import <Foundation/Foundation.h>
#import "StartCommunicationMethodCall.h"

@implementation StartCommunicationMethodCall
static NSString * METHOD_NAME = @"startCommunication";

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
    NSDictionary<NSString *, NSObject *> * dartPrintInfo = _call.arguments[@"printInfo"];
    
    // TODO Maybe open a channel and track it.
    // For now just return.
    
    _result(@YES);
   
}


@end
