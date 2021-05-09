//
//  TbEndCommunicationMethodCall.h
//  another_brother
//
//  Created by admin on 5/8/21.
//

#ifndef TbEndCommunicationMethodCall_h
#define TbEndCommunicationMethodCall_h

#import <Flutter/Flutter.h>
#import "AnotherBrotherPlugin.h"
#import "TbPrinterInfo.h"

@interface TbEndCommunicationMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (strong, nonatomic) AnotherBrotherPlugin * plugin;

@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result
                      plugin: (AnotherBrotherPlugin *) plugin;

- (void) execute;
@end

#endif /* TbEndCommunicationMethodCall_h */
