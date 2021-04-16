//
//  PrintImageMethodCall.h
//  another_brother
//
//  Created by admin on 4/13/21.
//

#ifndef PrintImageMethodCall_h
#define PrintImageMethodCall_h

#import <Flutter/Flutter.h>
#import "BrotherUtils.h"

@interface PrintImageMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end

#endif /* PrintImageMethodCall_h */
