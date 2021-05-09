//
//  TbSendCommandMethodCall.h
//  another_brother
//
//  Created by admin on 5/8/21.
//

#ifndef TbSendCommandMethodCall_h
#define TbSendCommandMethodCall_h

#import <Flutter/Flutter.h>
#import "AnotherBrotherPlugin.h"
#import "TbPrinterInfo.h"

@interface TbSendCommandMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (strong, nonatomic) AnotherBrotherPlugin * plugin;

@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result
                      plugin: (AnotherBrotherPlugin *) plugin;

- (void) execute;
@end


#endif /* TbSendCommandMethodCall_h */
