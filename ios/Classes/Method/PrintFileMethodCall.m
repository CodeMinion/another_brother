//
//  PrintFileMethodCall.m
//  another_brother
//
//  Created by admin on 4/12/21.
//

#import <Foundation/Foundation.h>
#import "PrintFileMethodCall.h"

@implementation PrintFileMethodCall
static NSString * METHOD_NAME = @"printFile";

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
    // TODO Call print method
}


@end
