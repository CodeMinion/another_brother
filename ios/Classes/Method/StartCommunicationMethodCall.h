//
//  StartCommunicationMethodCall.h
//  another_brother
//
//  Created by admin on 4/16/21.
//

#ifndef StartCommunicationMethodCall_h
#define StartCommunicationMethodCall_h

#import <Flutter/Flutter.h>
#import "BrotherUtils.h"

@interface StartCommunicationMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end

#endif /* StartCommunicationMethodCall_h */
