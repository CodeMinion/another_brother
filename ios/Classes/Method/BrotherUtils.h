//
//  BrotherUtils.h
//  another_brother
//
//  Created by admin on 4/11/21.
//

#ifndef BrotherUtils_h
#define BrotherUtils_h

#import <BRLMPrinterKit/BRLMPrinterKit.h>
#import <BRLMPrinterKit/BRLMPrinterDefine.h>
#import <BRLMPrinterKit/BRPtouchPrinterKit.h>


@interface LabelName : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *model;
- (instancetype)initWithName:(NSString *)name
                  model:(NSString *)model;
@end

@interface BrotherUtils :NSObject

+ (BRLMChannelType) portFromMapWithValue:(NSDictionary<NSString *, NSObject *>*) map;

+ (BRLMPrinterModel) modelFromMapWithValue:(NSDictionary<NSString *, NSObject *>*) map;

+ (BRLMPrintSettingsHalftone) halftoneFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (BRLMPrintSettingsHorizontalAlignment) alignFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (BRLMPrintSettingsVerticalAlignment) vAlignFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (BRLMPrintSettingsOrientation) orientationFromMapWithValue:(NSDictionary<NSString *, NSObject*> *) map;

+ (BRLMPrintSettingsResolution) printQualityFromMapWithValue:(NSDictionary<NSString*, NSObject *> *) map;

+ (BRLMPrintSettingsScaleMode) printModeFromMapWithValue:(NSDictionary<NSString*, NSObject*> *) map;

+ (BRLMCustomPaperSizePaperKind) paperKindFromMapWithValue:(NSDictionary<NSString *, NSObject*> *) map;

+ (BRLMCustomPaperSizeLengthUnit) unitFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (BRLMCustomPaperSizeMargins) customMarginFromMapWithValue:(NSDictionary<NSString*, NSObject *> *) map;

+ (BRLMPrinterModel) printerModelFromPrinterInfoMapWithValue:(NSDictionary<NSString *, NSObject*> *) map;

+ (LabelName *) labelNameFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (BRLMQLPrintSettingsLabelSize) qlLabelSizeWithName:(LabelName *) labelName;

+ (BRLMChannel *) printChannelWithPrintSettingsMap:(NSDictionary<NSString *, NSObject *> *) map;

+ (id<BRLMPrintSettingsProtocol>) printSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

    // DONE
+ (BRLMQLPrintSettings *) qlPrintSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

    // DONE
+ (BRLMPJPrintSettings *) pjPrintSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

    // DONE
+ (BRLMRJPrintSettings *) rjPrintSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

    // DONE
+ (BRLMTDPrintSettings *) tdPrintSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

    // DONE
+ (BRLMPTPrintSettings *) ptPrintSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

    // DONE
+ (BRLMMWPrintSettings *) mwPrintSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (NSDictionary<NSString *, NSObject *> *) errorCodeToMapWithValue:(BRLMPrintErrorCode)error;

+ (NSDictionary<NSString *, NSObject *> *) printerStatusToMapWithError:(BRLMPrintErrorCode)error status:(BRLMPrinterStatus *) status;

+ (NSDictionary<NSString *, NSObject *> *) bRPtouchDeviceInfoToNetPrinterMap:(BRPtouchDeviceInfo *) deviceInfo;

+ (NSDictionary<NSString *, NSObject *> *) bRPtouchDeviceInfoToBlePrinterMap:(BRPtouchDeviceInfo *) deviceInfo;

+ (NSDictionary<NSString *, NSObject *> *) bRPtouchDeviceInfoToBluetoothPrinterMap:(BRPtouchDeviceInfo *) deviceInfo;

+ (BRLMCustomPaperSize *) customPaperInfoFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (BRLMPJPrintSettingsPaperSizeStandard) pjPaperSizeStandardFromMapWithValue:(NSDictionary<NSString *, NSObject*> *) map;

+ (BRLMPJPrintSettingsPaperSize * ) pjPrinterPaperSizeFromMapWithValue:(NSDictionary<NSString *, NSObject*> *) map;

+ (BRLMPJPrintSettingsPaperInsertionPosition) pjPaperPositionFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;


+ (BRLMRJPrintSettingsDensity) rjPrintDensityWithValue:(NSNumber *) density;

+ (BRLMPJPrintSettingsPaperType) pjPaperKindFromMapWithValue:(NSDictionary<NSString*, NSObject *> *) map;

+ (BRLMPJPrintSettingsRollCase) pjRollCaseFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (BRLMPJPrintSettingsFeedMode) pjFeedModeFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;

+ (BRLMPJPrintSettingsPrintSpeed) pjPrintSpeedWithValue:(NSNumber *)pjSpeed;

+ (BRLMPJPrintSettingsDensity) pjPrintDensityWithValue:(NSNumber *) density;

+ (BRLMTDPrintSettingsDensity) tdPrintDensityWithValue:(NSNumber *) density;


+ (BRLMPTPrintSettingsLabelSize) ptLabelSizeWithName:(LabelName *) labelName;

+ (BRLMMWPrintSettingsPaperSize) mwPaperSizeFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map;


@end




/*
@interface  BRLMChannelType (BRLMChannelTypeEncoding)
- (NSMutableDictionary<NSString *, NSObject *>)toMap;
@end
*/



#endif /* BrotherUtils_h */
