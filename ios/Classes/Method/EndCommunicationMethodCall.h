//
//  EndCommunicationMethodCall.h
//  another_brother
//
//  Created by admin on 4/16/21.
//

#ifndef EndCommunicationMethodCall_h
#define EndCommunicationMethodCall_h

#import <Flutter/Flutter.h>
#import "BrotherUtils.h"

@interface EndCommunicationMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end


#endif /* EndCommunicationMethodCall_h */
