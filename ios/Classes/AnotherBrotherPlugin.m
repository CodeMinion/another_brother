#import "AnotherBrotherPlugin.h"
#if __has_include(<another_brother/another_brother-Swift.h>)
#import <another_brother/another_brother-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
//#import "another_brother-Swift.h"
#endif

#import <BRLMPrinterKit/BRLMPrinterKit.h>
#import <BRLMPrinterKit/BRPtouchDeviceInfo.h>

#import "Method/PrintFileMethodCall.h"
#import "Method/PrintImageMethodCall.h"
#import "Method/PrintFileListMethodCall.h"

/*
@implementation AnotherBrotherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnotherBrotherPlugin registerWithRegistrar:registrar];
}
*/

#import "AnotherBrotherPlugin.h"


@implementation AnotherBrotherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"another_brother" binaryMessenger:[registrar messenger]];
    AnotherBrotherPlugin* instance = [AnotherBrotherPlugin new];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
      result([NSString stringWithFormat:@"iOS %@", UIDevice.currentDevice.systemVersion]);
  }
  else if ([[PrintFileMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[PrintFileMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[PrintImageMethodCall METHOD_NAME] isEqualToString:call.method]) {
      //PrintImageMethodCall
      [[[PrintImageMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[PrintFileListMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[PrintFileListMethodCall alloc] initWithCall:call result:result] execute];
  }
  else {
      result(FlutterMethodNotImplemented);
  }
    
}




@end
