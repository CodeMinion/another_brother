//
//  UpdatePrinterSettingsMethodCall.h
//  another_brother
//
//  Updates the printer settings of a Brother printer using the legacy
//  BRPtouchPrinter API (the new BRLMPrinterDriver does not expose
//  setPrinterSettings:).
//

#ifndef UpdatePrinterSettingsMethodCall_h
#define UpdatePrinterSettingsMethodCall_h

#import <Flutter/Flutter.h>
#import <BRLMPrinterKit/BRPtouchPrinterKit.h>
#import "BrotherUtils.h"

@interface UpdatePrinterSettingsMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end

#endif /* UpdatePrinterSettingsMethodCall_h */
