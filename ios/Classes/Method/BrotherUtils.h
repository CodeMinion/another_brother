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

@end
/*
@interface  BRLMChannelType (BRLMChannelTypeEncoding)
- (NSMutableDictionary<NSString *, NSObject *>)toMap;
@end
*/



#endif /* BrotherUtils_h */
