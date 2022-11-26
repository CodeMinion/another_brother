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
#import "Method/PrintPdfFileMethodCall.h"
#import "Method/CancelMethodCall.h"
#import "Method/GetPrinterStatusMethodCall.h"
#import "Method/GetNetPrintersMethodCall.h"
#import "Method/GetBluetoothPrintersMethodCall.h"
#import "Method/StartCommunicationMethodCall.h"
#import "Method/EndCommunicationMethodCall.h"
#import "Method/GetPdfFilePagesMethodCall.h"
#import "Method/TypeB/TbStartCommunicationMethodCall.h"
#import "Method/TypeB/TbEndCommunicationMethodCall.h"
#import "Method/TypeB/TbSendCommandMethodCall.h"
#import "Method/TypeB/TbSendCommandBinMethodCall.h"
#import "Method/TypeB/TbGetBluetoothPrintersMethodCall.h"
#import "Method/TypeB/TbSetupMethodCall.h"
#import "Method/TypeB/TbBarcodeMethodCall.h"
#import "Method/TypeB/TbClearBufferMethodCall.h"
#import "Method/TypeB/TbDownloadBmpMethodCall.h"
#import "Method/TypeB/TbDownloadPcxMethodCall.h"
#import "Method/TypeB/TbFormFeedMethodCall.h"
#import "Method/TypeB/TbNoBackFeedMethodCall.h"
#import "Method/TypeB/TbPrintLabelMethodCall.h"
#import "Method/TypeB/TbPrinterFontMethodCall.h"
#import "Method/TypeB/TbGetPrinterStatusMethodCall.h"

/*
@implementation AnotherBrotherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnotherBrotherPlugin registerWithRegistrar:registrar];
}
*/

#import "AnotherBrotherPlugin.h"
#import "Method/BrotherUtils.h"

@implementation AnotherBrotherPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    // Track the registrar to get Asstes from.
    [BrotherUtils setRegistrarFlutter:registrar];
    
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
      [[[PrintImageMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[PrintFileListMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[PrintFileListMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[PrintPdfFileMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[PrintPdfFileMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[CancelMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[CancelMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[GetPrinterStatusMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[GetPrinterStatusMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[GetNetPrintersMethodCall METHOD_NAME] isEqualToString:call.method]){
      //[[[GetNetPrintersMethodCall alloc] initWithCall:call result:result] execute];
      _lastNetPrinterCall = [[GetNetPrintersMethodCall alloc] initWithCall:call result:result];
      [(GetNetPrintersMethodCall*)_lastNetPrinterCall execute];
  }
  else if ([[GetBluetoothPrintersMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[GetBluetoothPrintersMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[StartCommunicationMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[StartCommunicationMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[EndCommunicationMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[EndCommunicationMethodCall alloc] initWithCall:call result:result] execute];
  }
  else if ([[GetPdfFilePagesMethodCall METHOD_NAME] isEqualToString:call.method]) {
        [[[GetPdfFilePagesMethodCall alloc] initWithCall:call result:result] execute];
  }
  // TYPE B
  else if ([[TbStartCommunicationMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbStartCommunicationMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbEndCommunicationMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbEndCommunicationMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbSendCommandMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbSendCommandMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbSendCommandBinMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbSendCommandBinMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbGetBluetoothPrintersMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbGetBluetoothPrintersMethodCall alloc] initWithCall:call result:result plugin:self ] execute];
  }
  else if ([[TbSetupMethodCall METHOD_NAME] isEqualToString:call.method ]) {
      [[[TbSetupMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbBarcodeMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbBarcodeMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbClearBufferMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbClearBufferMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbDownloadPcxMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbDownloadPcxMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbDownloadBmpMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbDownloadBmpMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbFormFeedMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbFormFeedMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbNoBackFeedMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbNoBackFeedMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbPrintLabelMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbPrintLabelMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbPrinterFontMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbPrinterFontMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else if ([[TbGetPrinterStatusMethodCall METHOD_NAME] isEqualToString:call.method]) {
      [[[TbGetPrinterStatusMethodCall alloc] initWithCall:call result:result plugin:self] execute];
  }
  else {
      result(FlutterMethodNotImplemented);
  }
    
}

- (void)trackTypeBPrinterWithId:(NSString *)printerId typeBPrinter:(BROTHERSDK *)typeBPrinter {
    if (_mActiveTypeBPrinters == NULL) {
        _mActiveTypeBPrinters = [[NSMutableDictionary<NSString *, BROTHERSDK *> alloc] init];
    }
    
    [_mActiveTypeBPrinters setObject:typeBPrinter forKey:printerId ] ;
}

- (void)untrackTypeBPrinterWithId:(NSString *)printerId {
    [_mActiveTypeBPrinters removeObjectForKey:printerId];
}

- (BROTHERSDK *)getTypeBPrinterWithId:(NSString *)printerId {
    return [_mActiveTypeBPrinters objectForKey:printerId];
}


@end
