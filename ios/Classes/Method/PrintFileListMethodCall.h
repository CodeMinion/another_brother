//
//  PrintFileListMethodCall.h
//  another_brother
//
//  Created by admin on 4/15/21.
//

#ifndef PrintFileListMethodCall_h
#define PrintFileListMethodCall_h


#import <Flutter/Flutter.h>
#import "BrotherUtils.h"


@interface PrintFileListMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end

#endif /* PrintFileListMethodCall_h */
