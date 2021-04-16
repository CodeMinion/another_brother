//
//  CancelMethodCall.h
//  another_brother
//
//  Created by admin on 4/15/21.
//

#ifndef CancelMethodCall_h
#define CancelMethodCall_h

#import <Flutter/Flutter.h>
#import "BrotherUtils.h"

@interface CancelMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end

#endif /* CancelMethodCall_h */
