//
//  TbPrintLabelMethodCall.h
//  another_brother
//
//  Created by admin on 5/8/21.
//

#ifndef TbPrintLabelMethodCall_h
#define TbPrintLabelMethodCall_h

#import "AnotherBrotherPlugin.h"
#import "TbPrinterInfo.h"

@interface TbPrintLabelMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (strong, nonatomic) AnotherBrotherPlugin * plugin;

@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result
                      plugin: (AnotherBrotherPlugin *) plugin;

- (void) execute;
@end


#endif /* TbPrintLabelMethodCall_h */
