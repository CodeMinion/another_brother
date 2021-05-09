//
//  TbSetupMethodCall.h
//  another_brother
//
//  Created by admin on 5/8/21.
//

#ifndef TbSetupMethodCall_h
#define TbSetupMethodCall_h

#import "AnotherBrotherPlugin.h"

#import "TbPrinterInfo.h"

@interface TbSetupMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (strong, nonatomic) AnotherBrotherPlugin * plugin;

@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result
                      plugin: (AnotherBrotherPlugin *) plugin;

- (void) execute;
@end


#endif /* TbSetupMethodCall_h */
