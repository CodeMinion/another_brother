//
//  TbDownloadPcxMethodCall.h
//  another_brother
//
//  Created by admin on 5/8/21.
//

#ifndef TbDownloadPcxMethodCall_h
#define TbDownloadPcxMethodCall_h

#import "AnotherBrotherPlugin.h"
#import "TbPrinterInfo.h"

@interface TbDownloadPcxMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (strong, nonatomic) AnotherBrotherPlugin * plugin;

@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result
                      plugin: (AnotherBrotherPlugin *) plugin;

- (void) execute;
@end


#endif /* TbDownloadPcxMethodCall_h */
