//
//  PrintFileMethodCall.h
//  another_brother
//
//  Created by admin on 4/12/21.
//

#ifndef PrintFileMethodCall_h
#define PrintFileMethodCall_h

#import <Flutter/Flutter.h>
#import "BrotherUtils.h"

@interface PrintFileMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end

#endif /* PrintFileMethodCall_h */
