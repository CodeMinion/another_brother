//
//  BrotherUtils.m
//  another_brother
//
//  Created by admin on 4/11/21.
//

#import <Foundation/Foundation.h>

#import "BrotherUtils.h"

@implementation BrotherUtils

static NSObject<FlutterPluginRegistrar>* _registrarFlutter;

+ (NSObject<FlutterPluginRegistrar>*) registrarFlutter {
  return _registrarFlutter;
}

+ (void)setRegistrarFlutter:(NSObject<FlutterPluginRegistrar>*)newRegistrar {
  if (newRegistrar != _registrarFlutter) {
      _registrarFlutter = newRegistrar;//[newRegistrar copy];
  }
}

+ (BRLMChannelType) portFromMapWithValue:(NSMutableDictionary<NSString *, NSObject *>*) map {
    NSString * name = (NSString *) [map objectForKey:@"name"];
    if ([@"BLUETOOTH" isEqualToString:name]) {
        return BRLMChannelTypeBluetoothMFi;
    }
    else if ([@"NET" isEqualToString:name]) {
        return BRLMChannelTypeWiFi;
    }
    else if ([@"BLE" isEqualToString:name]) {
        return BRLMChannelTypeBluetoothLowEnergy;
    }
    else {
        return BRLMChannelTypeWiFi;
    }
}

+ (BRLMPrinterModel)modelFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    NSString *  name = (NSString *) [map objectForKey:@"name"];
    if ([@"MW_140BT" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"MW_145BT" isEqualToString:name]) {
        return BRLMPrinterModelMW_145MFi;
    }
    else if([@"MW_260" isEqualToString:name]) {
        return BRLMPrinterModelMW_260MFi;
    }
    else if([@"PJ_522" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_523" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_520" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_560" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_562" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_563" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_622" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_623" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_662" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_663" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"RJ_4030" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
        //return BRLMPrinterModelRJ_4030Ai;
    }
    else if([@"RJ_4040" isEqualToString:name]) {
        return BRLMPrinterModelRJ_4040;
    }
    else if([@"RJ_3150" isEqualToString:name]) {
        return BRLMPrinterModelRJ_3150;
    }
    else if([@"RJ_3050" isEqualToString:name]) {
        return BRLMPrinterModelRJ_3050;
    }
    else if([@"QL_580N" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"QL_710W" isEqualToString:name]) {
        return BRLMPrinterModelQL_710W;
    }
    else if([@"QL_720NW" isEqualToString:name]) {
        return BRLMPrinterModelQL_720NW;
    }
    else if([@"TD_2020" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"TD_2120N" isEqualToString:name]) {
        return BRLMPrinterModelTD_2120N;
    }
    else if([@"TD_2130N" isEqualToString:name]) {
        return BRLMPrinterModelTD_2130N;
    }
    else if([@"PT_E550W" isEqualToString:name]) {
        return BRLMPrinterModelPT_E550W;
    }
    else if([@"PT_P750W" isEqualToString:name]) {
        return BRLMPrinterModelPT_P750W;
    }
    else if([@"TD_4100N" isEqualToString:name]) {
        return BRLMPrinterModelTD_4100N;
    }
    else if([@"TD_4000" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_762" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_763" isEqualToString:name]) {
        return BRLMPrinterModelPJ_763MFi;
    }
    else if([@"PJ_773" isEqualToString:name]) {
        return BRLMPrinterModelPJ_773;
    }
    else if([@"PJ_722" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_723" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"PJ_763MFi" isEqualToString:name]) {
        return BRLMPrinterModelPJ_763MFi;
    }
    else if([@"MW_145MFi" isEqualToString:name]) {
        return BRLMPrinterModelMW_145MFi;
    }
    else if([@"MW_260MFi" isEqualToString:name]) {
        return BRLMPrinterModelMW_260MFi;
    }
    else if([@"PT_P300BT" isEqualToString:name]) {
        return BRLMPrinterModelPT_P300BT;
    }
    else if([@"PT_E850TKW" isEqualToString:name]) {
        return BRLMPrinterModelPT_E850TKW;
    }
    else if([@"PT_D800W" isEqualToString:name]) {
        return BRLMPrinterModelPT_D800W;
    }
    else if([@"PT_P900W" isEqualToString:name]) {
        return BRLMPrinterModelPT_P900W;
    }
    else if([@"PT_P950NW" isEqualToString:name]) {
        return BRLMPrinterModelPT_P950NW;
    }
    else if([@"RJ_4030Ai" isEqualToString:name]) {
        return BRLMPrinterModelRJ_4030Ai;
    }
    else if([@"PT_E800W" isEqualToString:name]) {
        return BRLMPrinterModelPT_E800W;
    }
    else if([@"RJ_2030" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"RJ_2050" isEqualToString:name]) {
        return BRLMPrinterModelRJ_2050;
    }
    else if([@"RJ_2140" isEqualToString:name]) {
        return BRLMPrinterModelRJ_2140;
    }
    else if([@"RJ_2150" isEqualToString:name]) {
        return BRLMPrinterModelRJ_2150;
    }
    else if([@"RJ_3050Ai" isEqualToString:name]) {
        return BRLMPrinterModelRJ_3050Ai;
    }
    else if([@"RJ_3150Ai" isEqualToString:name]) {
        return BRLMPrinterModelRJ_3150Ai;
    }
    else if([@"QL_800" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"QL_810W" isEqualToString:name]) {
        return BRLMPrinterModelQL_810W;
    }
    else if([@"QL_820NWB" isEqualToString:name]) {
        return BRLMPrinterModelQL_820NWB;
    }
    else if([@"QL_1100" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"QL_1110NWB" isEqualToString:name]) {
        return BRLMPrinterModelQL_1110NWB;
    }
    else if([@"QL_1115NWB" isEqualToString:name]) {
        return BRLMPrinterModelQL_1115NWB;
    }
    else if([@"PT_P710BT" isEqualToString:name]) {
        return BRLMPrinterModelPT_P710BT;
    }
    else if([@"PT_E500" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"RJ_4230B" isEqualToString:name]) {
        return BRLMPrinterModelRJ_4230B;
    }
    else if([@"RJ_4250WB" isEqualToString:name]) {
        return BRLMPrinterModelRJ_4250WB;
    }
    else if([@"TD_4410D" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"TD_4420DN" isEqualToString:name]) {
        return BRLMPrinterModelTD_4420DN;
    }
    else if([@"TD_4510D" isEqualToString:name]) {
        return BRLMPrinterModelUnknown;
    }
    else if([@"TD_4520DN" isEqualToString:name]) {
        return BRLMPrinterModelTD_4520DN;
    }
    else if([@"TD_4550DNWB" isEqualToString:name]) {
        return BRLMPrinterModelTD_4550DNWB;
    }
    else if([@"MW_170" isEqualToString:name]) {
        return BRLMPrinterModelMW_170;
    }
    else if([@"MW_270" isEqualToString:name]) {
        return BRLMPrinterModelMW_270;
    }
    else if([@"PT_P715eBT" isEqualToString:name]) {
        return BRLMPrinterModelPT_P715eBT;
    }
    else if([@"PT_P910BT" isEqualToString:name]) {
        return BRLMPrinterModelPT_P910BT;
    }
    
    return BRLMPrinterModelUnknown;
    
}

+ (BRLMPrintSettingsHalftone)halftoneFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if ([@"THRESHOLD" isEqualToString:name]) {
        return BRLMPrintSettingsHalftoneThreshold;
    }
    else if ([@"PATTERNDITHER" isEqualToString:name]){
        return BRLMPrintSettingsHalftonePatternDither;
    }
    else if ([@"ERRORDIFFUSION" isEqualToString:name]) {
        return BRLMPrintSettingsHalftoneErrorDiffusion;
    }
    
    return BRLMPrintSettingsHalftoneErrorDiffusion;
    
}

+ (BRLMPrintSettingsHorizontalAlignment)alignFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    NSString * name = (NSString * )[map objectForKey:@"name"];
    
    if([@"LEFT" isEqualToString:name]) {
        return BRLMPrintSettingsHorizontalAlignmentLeft;
    }
    else if([@"CENTER" isEqualToString:name]) {
        return BRLMPrintSettingsHorizontalAlignmentCenter;
    }
    else if([@"RIGHT" isEqualToString:name]) {
        return BRLMPrintSettingsHorizontalAlignmentRight;
    }
    
    return BRLMPrintSettingsHorizontalAlignmentLeft;
}

+ (BRLMPrintSettingsVerticalAlignment)vAlignFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *) [map objectForKey:@"name"];
    
    if([@"TOP" isEqualToString:name]) {
        return BRLMPrintSettingsVerticalAlignmentTop;
    }
    else if([@"MIDDLE" isEqualToString:name]) {
        return BRLMPrintSettingsVerticalAlignmentCenter;
    }
    else if([@"BOTTOM" isEqualToString:name]) {
        return BRLMPrintSettingsVerticalAlignmentBottom;
    }
    
    return BRLMPrintSettingsVerticalAlignmentTop;
    
}

+ (BRLMPrintSettingsOrientation)orientationFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *) [map objectForKey:@"name"];
    
    if ([@"PORTRAIT" isEqualToString:name]) {
        return BRLMPrintSettingsOrientationPortrait;
    }
    else if ([@"LANDSCAPE" isEqualToString:name]) {
        return BRLMPrintSettingsOrientationLandscape;
    }
    
    return BRLMPrintSettingsOrientationPortrait;
}


+ (BRLMPrintSettingsResolution)printResolutionFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if ([@"LOW_RESOLUTION" isEqualToString:name]) {
        return BRLMPrintSettingsResolutionLow;
    }
    else if ([@"NORMAL" isEqualToString:name]) {
        return BRLMPrintSettingsResolutionNormal;
    }
    else if ([@"DOUBLE_SPEED" isEqualToString:name]) {
        return BRLMPrintSettingsResolutionLow;
    }
    else if ([@"HIGH_RESOLUTION" isEqualToString:name]) {
        return BRLMPrintSettingsResolutionHigh;
    }
    
    return BRLMPrintSettingsResolutionNormal;
}

+ (BRLMPrintSettingsPrintQuality)printQualityFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if ([@"LOW_RESOLUTION" isEqualToString:name]) {
        return BRLMPrintSettingsPrintQualityFast;
    }
    else if ([@"NORMAL" isEqualToString:name]) {
        return BRLMPrintSettingsPrintQualityBest;
    }
    else if ([@"DOUBLE_SPEED" isEqualToString:name]) {
        return BRLMPrintSettingsPrintQualityFast;
    }
    else if ([@"HIGH_RESOLUTION" isEqualToString:name]) {
        return BRLMPrintSettingsPrintQualityBest;
    }
    
    return BRLMPrintSettingsPrintQualityBest;
    
}

+ (BRLMPrintSettingsScaleMode)printModeFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if([@"ORIGINAL" isEqualToString:name]) {
        return BRLMPrintSettingsScaleModeActualSize;
    }
    else if([@"FIT_TO_PAGE" isEqualToString:name]) {
        return BRLMPrintSettingsScaleModeFitPageAspect;
    }
    else if([@"SCALE" isEqualToString:name]) {
        return BRLMPrintSettingsScaleModeScaleValue;
    }
    else if([@"FIT_TO_PAPER" isEqualToString:name]) {
        return BRLMPrintSettingsScaleModeFitPaperAspect;
    }
    
    return BRLMPrintSettingsScaleModeActualSize;
}

+ (BRLMCustomPaperSizePaperKind)paperKindFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *) [map objectForKey:@"name"];
    
    if ([@"ROLL" isEqualToString:name]) {
        return BRLMCustomPaperSizePaperKindRoll;
    }
    else if ([@"DIE_CUT" isEqualToString:name]) {
        return BRLMCustomPaperSizePaperKindDieCut;
    }
    else if ([@"MARKED_ROLL" isEqualToString:name]) {
        return BRLMCustomPaperSizePaperKindMarkRoll;
    }
    
    return BRLMCustomPaperSizePaperKindRoll;
}

+ (BRLMCustomPaperSizeLengthUnit)unitFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString*) [map objectForKey:@"name"];
    
    if ([@"Inch" isEqualToString: name]) {
        return BRLMCustomPaperSizeLengthUnitInch;
    }
    else if ([@"Mm" isEqualToString: name]) {
        return BRLMCustomPaperSizeLengthUnitMm;
    }
    
    return BRLMCustomPaperSizeLengthUnitInch;
}

+ (BRLMCustomPaperSizeMargins)customMarginFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    CGFloat topMargin = [(NSNumber *)[map objectForKey:@"topMargin"] doubleValue];
    CGFloat bottomMargin = [(NSNumber *)[map objectForKey:@"bottomMargin"] doubleValue];
    CGFloat leftMargin = [(NSNumber *)[map objectForKey:@"leftMargin"] doubleValue];
    CGFloat rightMargin = [(NSNumber *)[map objectForKey:@"rightMargin"] doubleValue];
    
    return BRLMCustomPaperSizeMarginsMake(
                                        topMargin,
                                          leftMargin,
                                          bottomMargin,
                                          rightMargin);
}

+ (BRLMCustomPaperSize *)customPaperInfoFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map binCustomPaperMap:(NSDictionary<NSString *, NSObject *> *)binCustomPaperMap{
    
    if (![binCustomPaperMap isEqual:[NSNull null]]) {
        // TODO Get Asset key
        NSString * assetFile = (NSString *)[binCustomPaperMap objectForKey:@"assetPath"];
        NSString* key = [[BrotherUtils registrarFlutter] lookupKeyForAsset:assetFile];
        NSString* path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
        
        NSURL * customPaperFileUrl = [NSURL fileURLWithPath:path];
        
        BRLMCustomPaperSize *customPaperSize = [[BRLMCustomPaperSize alloc] initWithFile:customPaperFileUrl];
        return customPaperSize;
            
    }
    
    if ([map isEqual:[NSNull null]] ) {
        // No bin file or custom paper was passed.
        return NULL;
    }
    
    NSDictionary<NSString*, NSObject *> * dartPaperKind = (NSDictionary<NSString*, NSObject *> *)[map objectForKey:@"paperKind"];
    
    BRLMCustomPaperSizePaperKind paperKind = [BrotherUtils paperKindFromMapWithValue:dartPaperKind];
    
    NSDictionary<NSString*, NSObject *> * dartUnit = (NSDictionary<NSString*, NSObject *> *)[map objectForKey:@"unit"];
    
    BRLMCustomPaperSizeLengthUnit unit = [BrotherUtils unitFromMapWithValue: dartUnit];
    
    BRLMCustomPaperSizeMargins margins = [BrotherUtils customMarginFromMapWithValue:map];
    
    float tapeWidth = [(NSNumber *)[map objectForKey:@"tapeWidth"] floatValue];
    float tapeLength = [(NSNumber *)[map objectForKey:@"tapeLength"] floatValue];
    float markHeight = [(NSNumber *)[map objectForKey:@"markHeight"] floatValue];
    float gapLength = [(NSNumber *)[map objectForKey:@"labelPitch"] floatValue];
    float markPosition = [(NSNumber *)[map objectForKey:@"markPosition"] floatValue];
    
    
    if (paperKind == BRLMCustomPaperSizePaperKindDieCut) {
        return [[BRLMCustomPaperSize alloc] initDieCutWithTapeWidth:tapeWidth tapeLength:tapeLength margins:margins gapLength:gapLength unitOfLength:unit];
    }
    else if (paperKind == BRLMCustomPaperSizePaperKindByFile) {
        // Note: This is handled with the asset files as the start of the method.
        //[[BRLMCustomPaperSize alloc] initWithFile:<#(nonnull NSURL *)#>]
        
    }
    else if (paperKind == BRLMCustomPaperSizePaperKindMarkRoll) {
        return [[BRLMCustomPaperSize alloc] initMarkRollWithTapeWidth:tapeWidth tapeLength:tapeLength margins:margins markPosition:markPosition markHeight:markHeight unitOfLength:unit];
    }
    else if (paperKind == BRLMCustomPaperSizePaperKindRoll) {
        return [[BRLMCustomPaperSize alloc] initRollWithTapeWidth:tapeWidth margins:margins unitOfLength:unit];
    }
    
    return [[BRLMCustomPaperSize alloc] initRollWithTapeWidth:tapeWidth margins:margins unitOfLength:unit];
}

+ (BRLMPrinterModel) printerModelFromPrinterInfoMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSDictionary<NSString *,NSObject *> * dartPrinterModel = (NSDictionary<NSString *,NSObject *> *) [map objectForKey:@"printerModel"];
    
    return [BrotherUtils modelFromMapWithValue:dartPrinterModel];
}

+ (LabelName *)labelNameFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    NSString * name = (NSString *)[map objectForKey:@"name"];
    NSString * model = (NSString *)[map objectForKey:@"model"];
    return [[LabelName alloc] initWithName:name model:model];
}

+ (BRLMChannel *)printChannelWithPrintSettingsMap:(NSDictionary<NSString *,NSObject *> *) map {
    // TODO Get port dart info
    NSDictionary<NSString *, NSObject*> * dartPort = (NSDictionary<NSString *, NSObject*> *)[map objectForKey:@"port"];
    // TODO Get Channel type
    BRLMChannelType channelType = [BrotherUtils portFromMapWithValue:dartPort];
    // TODO From channel type create channel.
    BRLMChannel * outChannel;
    
    NSString * ipAddress = (NSString *) [map objectForKey:@"ipAddress"];
    NSString * macAddress = (NSString *) [map objectForKey:@"macAddress"];
    NSString * localName = (NSString *) [map objectForKey:@"localName"];
    
    if (channelType == BRLMChannelTypeWiFi) {
        outChannel = [[BRLMChannel alloc] initWithWifiIPAddress:ipAddress];
    }
    else if (channelType == BRLMChannelTypeBluetoothMFi) {
        outChannel = [[BRLMChannel alloc] initWithBluetoothSerialNumber:macAddress];
        
    }
    else if (channelType == BRLMChannelTypeBluetoothLowEnergy) {
        outChannel = [[BRLMChannel alloc] initWithBLELocalName:localName];
    }
    else {
        outChannel = [[BRLMChannel alloc] initWithWifiIPAddress:ipAddress];
    }
    
    return outChannel;
}

+ (BRLMQLPrintSettingsLabelSize)qlLabelSizeWithName:(LabelName *)labelName {

    if ([@"W17H54" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW17H54;
    }
    else if ([@"W17H87" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW17H87;
    }
    else if ([@"W23H23" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW23H23;
    }
    else if ([@"W29H42" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW29H42;
    }
    else if ([@"W29H90" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW29H90;
    }
    else if ([@"W38H90" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW38H90;
    }
    else if ([@"W39H48" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW39H48;
    }
    else if ([@"W52H29" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW52H29;
    }
    else if ([@"W54H29" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW54H29;
    }
    else if ([@"W62H29" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW62H29;
    }
    else if ([@"W62H100" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW62H100;
    }
    else if ([@"W12" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW12;
    }
    else if ([@"W29" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW29;
    }
    else if ([@"W38" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW38;
    }
    else if ([@"W50" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW50;
    }
    else if ([@"W54" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW54;
    }
    else if ([@"W62" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW62;
    }
    else if ([@"W62RB" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW62RB;
    }
    else if ([@"W60H86" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW60H86;
    }
    else if ([@"W102" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW102;
    }
    else if ([@"W102H51" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDTRollW102H51;
    }
    else if ([@"W102H152" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDTRollW102H152;
    }
    else if ([@"W103" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeRollW103;
    }
    else if ([@"W103H164" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDieCutW103H164;
    }
    else if ([@"DT_W90" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDTRollW90;
    }
    else if ([@"DT_W102" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDTRollW102;
    }
    else if ([@"DT_W102H51" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDTRollW102H51;
    }
    else if ([@"DT_W102H152" isEqualToString:[labelName name]]) {
        return BRLMQLPrintSettingsLabelSizeDTRollW102H152;
    }

    return BRLMQLPrintSettingsLabelSizeDieCutW103H164;
}

+ (BRLMPTPrintSettingsLabelSize)ptLabelSizeWithName:(LabelName *)labelName {
    
    if ([@"W3_5" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidth3_5mm;
    }
    else if ([@"W6" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidth6mm;
    }
    else if ([@"W9" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidth9mm;
    }
    else if ([@"W12" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidth12mm;
    }
    else if ([@"W18" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidth18mm;
    }
    else if ([@"W24" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidth24mm;
    }
    else if ([@"W36" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidth36mm;
    }
    else if ([@"HS_W6" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidthHS_5_8mm;
    }
    else if ([@"HS_W9" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidthHS_8_8mm;
    }
    else if ([@"HS_W12" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidthHS_11_7mm;
    }
    else if ([@"HS_W18" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidthHS_17_7mm;
    }
    else if ([@"HS_W24" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidthHS_23_6mm;
    }
    else if ([@"FLE_W21H45" isEqualToString:[labelName name]]) {
        return BRLMPTPrintSettingsLabelSizeWidthFL_21x45mm;
    }
    
    /*
      Note: These were not found in the iOS side.
         R6_5,
         R6_0,
         R5_0,
         R4_0,
         R3_5,
         R3_0,
         R2_5,
         UNSUPPORT
     */
    
    return BRLMPTPrintSettingsLabelSizeWidth3_5mm;
}

+ (BRLMQLPrintSettings *) qlPrintSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map {
    
    BRLMPrinterModel printerModel = [BrotherUtils printerModelFromPrinterInfoMapWithValue:map];
    
    NSDictionary<NSString*, NSObject*> * dartLabelName = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"labelName"];
    LabelName * labelName = [BrotherUtils labelNameFromMapWithValue:dartLabelName];
    
    BRLMQLPrintSettings * printerSettings = [[BRLMQLPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:printerModel];
    
    NSDictionary<NSString*, NSObject*> * dartPrintQuality = (NSDictionary<NSString*, NSObject*> *) [map objectForKey:@"printQuality"];
    
    printerSettings.labelSize = [BrotherUtils qlLabelSizeWithName:labelName];
    printerSettings.autoCut = [[map objectForKey:@"isAutoCut"] isEqual:@(YES)];
    printerSettings.cutAtEnd = [[map objectForKey:@"isEndCut"] isEqual:@(YES)];
    printerSettings.resolution = [BrotherUtils printResolutionFromMapWithValue:dartPrintQuality];
    
    // TODO Extract info from map.
    //[x]labelSize
    //autoCutForEachPageCount
    //[x]autoCut
    //[x]cutAtEnd
    //[x]resolution
    
    
    NSDictionary<NSString*, NSObject*> * dartPrintMode = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printMode"];
    
    printerSettings.scaleMode = [BrotherUtils printModeFromMapWithValue:dartPrintMode];
    
    printerSettings.scaleValue = [(NSNumber *)[map objectForKey:@"scaleValue"] doubleValue];
    
    NSDictionary<NSString*, NSObject*> * dartOrientation = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"orientation"];
    
    printerSettings.printOrientation = [BrotherUtils orientationFromMapWithValue:dartOrientation];
    
    NSDictionary<NSString*, NSObject*> * dartHalftone = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"halftone"];
    
    printerSettings.halftone = [BrotherUtils halftoneFromMapWithValue:dartHalftone];

    NSDictionary<NSString*, NSObject*> * dartAlign = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"align"];

    printerSettings.hAlignment = [BrotherUtils alignFromMapWithValue:dartAlign];
    
    NSDictionary<NSString*, NSObject*> * dartValign = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"valign"];
    
    printerSettings.vAlignment = [BrotherUtils vAlignFromMapWithValue:dartValign];

    
    if ([[map objectForKey:@"mode9"] isEqual:@(YES)]) {
        printerSettings.compress = BRLMPrintSettingsCompressModeMode9;
    }
    else {
        printerSettings.compress = BRLMPrintSettingsCompressModeNone;
    }
    
    printerSettings.halftoneThreshold = [(NSNumber *)[map objectForKey:@"thresholdingValue"] intValue];
    
    
    printerSettings.numCopies = (NSUInteger)[(NSNumber *)[map objectForKey:@"numberOfCopies"] integerValue];
    
    printerSettings.skipStatusCheck = [[map objectForKey:@"skipStatusCheck"] isEqual:@(YES)];
    
    NSDictionary<NSString*, NSObject*> * dartPrintQuality2 = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printQuality"];
    
    printerSettings.printQuality = [BrotherUtils printQualityFromMapWithValue:dartPrintQuality2];
    
    // TODO Add extra configuration
    //[x]scaleMode @"printMode"(map)
    //[x]scaleValue @"scaleValue" (double)
    //[x]printOrientation @"orientation" (map)
    //[x]halftone @"halftone" (map)
    //[x]hAlignment @"align" (map)
    //[x]vAlignment @"valign" (map)
    //[x]compress ???
    //[x]halftoneThreshold @"thresholdingValue" (int)
    //[x]numCopies @"numberOfCopies" (int)
    //[x]skipStatusCheck @"skipStatusCheck" (@YES/@NO type)
    //printQuality @"printQuality" (map)
    
    return printerSettings;
}

+ (BRLMRJPrintSettingsDensity)rjPrintDensityWithValue:(NSNumber *)density {
    if ([density isEqualToNumber:@0]) {
        return BRLMRJPrintSettingsDensityWeakLevel5;
    }
    else if ([density isEqualToNumber:@1]) {
        return BRLMRJPrintSettingsDensityWeakLevel4;
    }
    else if ([density isEqualToNumber:@2]) {
        return BRLMRJPrintSettingsDensityWeakLevel3;
    }
    else if ([density isEqualToNumber:@3]) {
        return BRLMRJPrintSettingsDensityWeakLevel2;
    }
    else if ([density isEqualToNumber:@4]) {
        return BRLMRJPrintSettingsDensityWeakLevel1;
    }
    else if ([density isEqualToNumber:@5]) {
        return BRLMRJPrintSettingsDensityNeutral;
    }
    else if ([density isEqualToNumber:@6]) {
        return BRLMRJPrintSettingsDensityStrongLevel1;
    }
    else if ([density isEqualToNumber:@7]) {
        return BRLMRJPrintSettingsDensityStrongLevel2;
    }
    else if ([density isEqualToNumber:@8]) {
        return BRLMRJPrintSettingsDensityStrongLevel3;
    }
    else if ([density isEqualToNumber:@9]) {
        return BRLMRJPrintSettingsDensityStrongLevel4;
    }
    else if ([density isEqualToNumber:@10]) {
        return BRLMRJPrintSettingsDensityStrongLevel5;
    }
    
    return BRLMRJPrintSettingsDensityNeutral;
}

+ (BRLMRJPrintSettings *)rjPrintSettingsFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    BRLMPrinterModel printerModel = [BrotherUtils printerModelFromPrinterInfoMapWithValue:map];
    
     
    NSDictionary<NSString*, NSObject*> * dartBinCustomPaperMap = (NSDictionary<NSString*, NSObject*> *) [map objectForKey:@"binCustomPaper"];
    
    NSDictionary<NSString*, NSObject*> * dartCustomPaperInfo = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"customPaperInfo"];
    
    BRLMCustomPaperSize * customPaperSize = [BrotherUtils customPaperInfoFromMapWithValue:dartCustomPaperInfo binCustomPaperMap:dartBinCustomPaperMap];
    
    BRLMRJPrintSettings * printerSettings = [[BRLMRJPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:printerModel];
    
    NSNumber * density = (NSNumber *)[map objectForKey:@"rjDensity"];
    
    printerSettings.density = [BrotherUtils rjPrintDensityWithValue:density];
    printerSettings.rotate180degrees = [[map objectForKey:@"rotate180"] isEqual:@(YES)];
    printerSettings.peelLabel = [[map objectForKey:@"peelMode"]isEqual:@(YES)];
    printerSettings.customPaperSize = customPaperSize;
    
    
    //customPaperSize "customPaperInfo" TODO
    
    NSDictionary<NSString*, NSObject*> * dartPrintMode = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printMode"];
    
    printerSettings.scaleMode = [BrotherUtils printModeFromMapWithValue:dartPrintMode];
    
    printerSettings.scaleValue = [(NSNumber *)[map objectForKey:@"scaleValue"] doubleValue];
    
    NSDictionary<NSString*, NSObject*> * dartOrientation = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"orientation"];
    
    printerSettings.printOrientation = [BrotherUtils orientationFromMapWithValue:dartOrientation];
    
    NSDictionary<NSString*, NSObject*> * dartHalftone = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"halftone"];
    
    printerSettings.halftone = [BrotherUtils halftoneFromMapWithValue:dartHalftone];

    NSDictionary<NSString*, NSObject*> * dartAlign = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"align"];

    printerSettings.hAlignment = [BrotherUtils alignFromMapWithValue:dartAlign];
    
    NSDictionary<NSString*, NSObject*> * dartValign = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"valign"];
    
    printerSettings.vAlignment = [BrotherUtils vAlignFromMapWithValue:dartValign];

    
    if ([[map objectForKey:@"mode9"] isEqual:@(YES)]) {
        printerSettings.compress = BRLMPrintSettingsCompressModeMode9;
    }
    else {
        printerSettings.compress = BRLMPrintSettingsCompressModeNone;
    }
    
    printerSettings.halftoneThreshold = [(NSNumber *)[map objectForKey:@"thresholdingValue"] intValue];
    
    
    NSUInteger numberOfCopies =
    printerSettings.numCopies = (NSUInteger)[(NSNumber *)[map objectForKey:@"numberOfCopies"] integerValue];
    
    printerSettings.numCopies = (NSUInteger)[(NSNumber *)[map objectForKey:@"numberOfCopies"] integerValue];
    
    printerSettings.skipStatusCheck = [[map objectForKey:@"skipStatusCheck"] isEqual:@(YES)];
    
    NSDictionary<NSString*, NSObject*> * dartPrintQuality2 = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printQuality"];
    
    printerSettings.printQuality = [BrotherUtils printQualityFromMapWithValue:dartPrintQuality2];
    
    // TODO Add extra configuration
    //[x]scaleMode @"printMode"(map)
    //[x]scaleValue @"scaleValue" (double)
    //[x]printOrientation @"orientation" (map)
    //[x]halftone @"halftone" (map)
    //[x]hAlignment @"align" (map)
    //[x]vAlignment @"valign" (map)
    //[x]compress ???
    //[x]halftoneThreshold @"thresholdingValue" (int)
    //[x]numCopies @"numberOfCopies" (int)
    //[x]skipStatusCheck @"skipStatusCheck" (@YES/@NO type)
    //printQuality @"printQuality" (map)
    
    return printerSettings;
}

+ (BRLMPJPrintSettingsDensity)pjPrintDensityWithValue:(NSNumber *)density {
    if ([density isEqualToNumber:@0]) {
        return BRLMPJPrintSettingsDensityWeakLevel5;
    }
    else if ([density isEqualToNumber:@1]) {
        return BRLMPJPrintSettingsDensityWeakLevel4;
    }
    else if ([density isEqualToNumber:@2]) {
        return BRLMPJPrintSettingsDensityWeakLevel3;
    }
    else if ([density isEqualToNumber:@3]) {
        return BRLMPJPrintSettingsDensityWeakLevel2;
    }
    else if ([density isEqualToNumber:@4]) {
        return BRLMPJPrintSettingsDensityWeakLevel1;
    }
    else if ([density isEqualToNumber:@5]) {
        return BRLMPJPrintSettingsDensityNeutral;
    }
    else if ([density isEqualToNumber:@6]) {
        return BRLMPJPrintSettingsDensityStrongLevel1;
    }
    else if ([density isEqualToNumber:@7]) {
        return BRLMPJPrintSettingsDensityStrongLevel2;
    }
    else if ([density isEqualToNumber:@8]) {
        return BRLMPJPrintSettingsDensityStrongLevel3;
    }
    else if ([density isEqualToNumber:@9]) {
        return BRLMPJPrintSettingsDensityStrongLevel4;
    }
    else if ([density isEqualToNumber:@10]) {
        return BRLMPJPrintSettingsDensityStrongLevel5;
    }
    
    return BRLMPJPrintSettingsDensityNeutral;
}


+ (BRLMPJPrintSettingsPaperSizeStandard) pjPaperSizeStandardFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if ([@"CUSTOM" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperSizeStandardCustom;
    }
    else if  ([@"A7" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperSizeStandardA5;
    }
    else if  ([@"A6" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperSizeStandardA5;
    }
    else if  ([@"A5" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperSizeStandardA5;
    }
    else if  ([@"A4" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperSizeStandardA4;
    }
    else if  ([@"LEGAL" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperSizeStandardLegal;
    }
    else if  ([@"LETTER" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperSizeStandardLetter;
    }
    
    else return BRLMPJPrintSettingsPaperSizeStandardA4;
}

+ (BRLMPJPrintSettingsPaperSize *)pjPrinterPaperSizeFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSDictionary<NSString *, NSObject*> * dartStandardSize = (NSDictionary<NSString *, NSObject *>*) [map objectForKey:@"paperSize"];
    
    //paperSizeStandard
    BRLMPJPrintSettingsPaperSizeStandard standardPaperSize = [BrotherUtils pjPaperSizeStandardFromMapWithValue:dartStandardSize];
    
    //customPaper
    // TODO Support Custom size, need to send paper in.
    
    return [[BRLMPJPrintSettingsPaperSize alloc] initWithPaperSizeStandard:standardPaperSize];
    
}

+ (BRLMPJPrintSettingsPaperType)pjPaperKindFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if ([@"PJ_ROLL" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperTypeRoll;
    }
    else if ([@"PJ_CUT_PAPER" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperTypeCutSheet;
    }
    
    return BRLMPJPrintSettingsPaperTypeCutSheet;

}

+ (BRLMPJPrintSettingsRollCase)pjRollCaseFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if ([@"PJ_ROLLCASE_OFF" isEqualToString:name]) {
        return BRLMPJPrintSettingsRollCaseNone;
    }
    else if ([@"PJ_ROLLCASE_ON" isEqualToString:name]) {
        return BRLMPJPrintSettingsRollCasePARC001;
    }
    else if ([@"PJ_ROLLCASE_WITH_ANTICURL" isEqualToString:name]) {
        return BRLMPJPrintSettingsRollCasePARC001_NoAntiCurl;
    }
    
    return BRLMPJPrintSettingsRollCaseNone;
    
}

+ (BRLMPJPrintSettingsFeedMode)pjFeedModeFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if ([@"PJ_FEED_MODE_FREE" isEqualToString:name]) {
        return BRLMPJPrintSettingsFeedModeNoFeed;
    }
    else if ([@"PJ_FEED_MODE_FIXEDPAGE" isEqualToString:name]) {
        return BRLMPJPrintSettingsFeedModeFixedPage;
    }
    else if ([@"PJ_FEED_MODE_ENDOFPAGE" isEqualToString:name]) {
        return BRLMPJPrintSettingsFeedModeEndOfPage;
    }
    else if ([@"PJ_FEED_MODE_ENDOFPAGERETRACT" isEqualToString:name]) {
        return BRLMPJPrintSettingsFeedModeEndOfPageRetract;
    }
    
    return BRLMPJPrintSettingsFeedModeFixedPage;
}

+ (BRLMPJPrintSettingsPrintSpeed)pjPrintSpeedWithValue:(NSNumber *)pjSpeed {
    
    if ([pjSpeed isEqualToNumber: @0]) {
        return BRLMPJPrintSettingsPrintSpeed2_5inchPerSec;
    }
    else if([pjSpeed isEqualToNumber:@1]) {
        return BRLMPJPrintSettingsPrintSpeed1_9inchPerSec;
    }
    else if ([pjSpeed isEqualToNumber:@2]) {
        return BRLMPJPrintSettingsPrintSpeed1_6inchPerSec;
    }
    else if ([pjSpeed isEqualToNumber:@3]) {
        return BRLMPJPrintSettingsPrintSpeed1_1inchPerSec;
    }
    
    return BRLMPJPrintSettingsPrintSpeed1_6inchPerSec;
}

+ (BRLMPJPrintSettingsPaperInsertionPosition) pjPaperPositionFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if ([@"LEFT" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperInsertionPositionLeft;
    }
    else if ([@"CENTER" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperInsertionPositionCenter;
    }
    else if ([@"RIGHT" isEqualToString:name]) {
        return BRLMPJPrintSettingsPaperInsertionPositionRight;
    }
    
    return BRLMPJPrintSettingsPaperInsertionPositionLeft;
}

+ (BRLMPJPrintSettings *)pjPrintSettingsFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    
    BRLMPrinterModel printerModel = [BrotherUtils printerModelFromPrinterInfoMapWithValue:map];
    
    BRLMPJPrintSettings * printerSettings = [[BRLMPJPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:printerModel];
    
    
    NSDictionary<NSString *, NSObject *> * dartPaperKind = (NSDictionary<NSString *, NSObject *> *)[map objectForKey:@"pjPaperKind"];
    
    NSDictionary<NSString *, NSObject *> * dartPjFeedMode = (NSDictionary<NSString *, NSObject *> *)[map objectForKey:@"pjFeedMode"];
    
    NSNumber * dartPjDensity = (NSNumber *) [map objectForKey:@"pjDensity"];
    
    NSDictionary<NSString *, NSObject *> * dartPjRollCase = (NSDictionary<NSString *, NSObject *> *)[map objectForKey:@"rollPrinterCase"];
    
    NSDictionary<NSString *, NSObject *> * dartPaperPosition = (NSDictionary<NSString *, NSObject *> *)[map objectForKey:@"paperPosition"];
    
    NSNumber * dartPjSpeed = (NSNumber *) [map objectForKey:@"pjSpeed"];
    
    bool dashLine = [[map objectForKey:@"dashLine"] isEqual:@(YES)];
    
    printerSettings.paperSize = [BrotherUtils pjPrinterPaperSizeFromMapWithValue:map];
    
    
    printerSettings.paperType = [BrotherUtils pjPaperKindFromMapWithValue:dartPaperKind];
    
    printerSettings.paperInsertionPosition = [BrotherUtils pjPaperPositionFromMapWithValue:dartPaperPosition];
    
    printerSettings.feedMode = [BrotherUtils pjFeedModeFromMapWithValue:dartPjFeedMode];
    
    printerSettings.density = [BrotherUtils pjPrintDensityWithValue:dartPjDensity];
    
    printerSettings.rollCase = [BrotherUtils pjRollCaseFromMapWithValue:dartPjRollCase];
    
    printerSettings.printSpeed = [BrotherUtils pjPrintSpeedWithValue:dartPjSpeed];
    
    
    printerSettings.usingCarbonCopyPaper = [[map objectForKey:@"pjCarbon"] isEqual:@(YES)];
    
    printerSettings.printDashLine = dashLine;
    
    NSDictionary<NSString*, NSObject*> * dartPrintMode = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printMode"];
    
    printerSettings.scaleMode = [BrotherUtils printModeFromMapWithValue:dartPrintMode];
    
    printerSettings.scaleValue = [(NSNumber *)[map objectForKey:@"scaleValue"] doubleValue];
    
    NSDictionary<NSString*, NSObject*> * dartOrientation = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"orientation"];
    
    printerSettings.printOrientation = [BrotherUtils orientationFromMapWithValue:dartOrientation];
    
    NSDictionary<NSString*, NSObject*> * dartHalftone = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"halftone"];
    
    printerSettings.halftone = [BrotherUtils halftoneFromMapWithValue:dartHalftone];

    NSDictionary<NSString*, NSObject*> * dartAlign = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"align"];

    printerSettings.hAlignment = [BrotherUtils alignFromMapWithValue:dartAlign];
    
    NSDictionary<NSString*, NSObject*> * dartValign = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"valign"];
    
    printerSettings.vAlignment = [BrotherUtils vAlignFromMapWithValue:dartValign];

    
    if ([[map objectForKey:@"mode9"] isEqual:@(YES)]) {
        printerSettings.compress = BRLMPrintSettingsCompressModeMode9;
    }
    else {
        printerSettings.compress = BRLMPrintSettingsCompressModeNone;
    }
    
    printerSettings.halftoneThreshold = [(NSNumber *)[map objectForKey:@"thresholdingValue"] intValue];
    
    printerSettings.numCopies = (NSUInteger)[(NSNumber *)[map objectForKey:@"numberOfCopies"] integerValue];
    
    printerSettings.skipStatusCheck = [[map objectForKey:@"skipStatusCheck"] isEqual:@(YES)];
    
    NSDictionary<NSString*, NSObject*> * dartPrintQuality2 = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printQuality"];
    
    printerSettings.printQuality = [BrotherUtils printQualityFromMapWithValue:dartPrintQuality2];
    
    // TODO Add extra configuration
    //[x]scaleMode @"printMode"(map)
    //[x]scaleValue @"scaleValue" (double)
    //[x]printOrientation @"orientation" (map)
    //[x]halftone @"halftone" (map)
    //[x]hAlignment @"align" (map)
    //[x]vAlignment @"valign" (map)
    //[x]compress ???
    //[x]halftoneThreshold @"thresholdingValue" (int)
    //[x]numCopies @"numberOfCopies" (int)
    //[x]skipStatusCheck @"skipStatusCheck" (@YES/@NO type)
    //printQuality @"printQuality" (map)
    
    return printerSettings;
}


+ (BRLMTDPrintSettingsDensity)tdPrintDensityWithValue:(NSNumber *)density {
    
    if ([density isEqualToNumber:@0]) {
        return BRLMTDPrintSettingsDensityWeakLevel5;
    }
    else if ([density isEqualToNumber:@1]) {
        return BRLMTDPrintSettingsDensityWeakLevel4;
    }
    else if ([density isEqualToNumber:@2]) {
        return BRLMTDPrintSettingsDensityWeakLevel3;
    }
    else if ([density isEqualToNumber:@3]) {
        return BRLMTDPrintSettingsDensityWeakLevel2;
    }
    else if ([density isEqualToNumber:@4]) {
        return BRLMTDPrintSettingsDensityWeakLevel1;
    }
    else if ([density isEqualToNumber:@5]) {
        return BRLMTDPrintSettingsDensityNeutral;
    }
    else if ([density isEqualToNumber:@6]) {
        return BRLMTDPrintSettingsDensityStrongLevel1;
    }
    else if ([density isEqualToNumber:@7]) {
        return BRLMTDPrintSettingsDensityStrongLevel2;
    }
    else if ([density isEqualToNumber:@8]) {
        return BRLMTDPrintSettingsDensityStrongLevel3;
    }
    else if ([density isEqualToNumber:@9]) {
        return BRLMTDPrintSettingsDensityStrongLevel4;
    }
    else if ([density isEqualToNumber:@10]) {
        return BRLMTDPrintSettingsDensityStrongLevel5;
    }
    
    return BRLMTDPrintSettingsDensityNeutral;
}

+ (BRLMTDPrintSettings *)tdPrintSettingsFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    //NSDictionary<NSString*, NSObject*> * dartPrintModel = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printerModel"];
    
    BRLMPrinterModel printerModel = [BrotherUtils printerModelFromPrinterInfoMapWithValue:map];
    
    NSDictionary<NSString *, NSObject *> * dartCustomPaperInfo = (NSDictionary<NSString *, NSObject *> *) [map objectForKey:@"customPaperInfo"];
    
    NSNumber * dartRjDensity = (NSNumber *) [map objectForKey:@"rjDensity"];
    
    bool peelLabel = [[map objectForKey:@"peelMode"]isEqual:@(YES)];
    
    BRLMTDPrintSettings * printerSettings = [[BRLMTDPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:printerModel];
    
    NSDictionary<NSString*, NSObject*> * dartBinCustomPaperMap = (NSDictionary<NSString*, NSObject*> *) [map objectForKey:@"binCustomPaper"];
    
    printerSettings.customPaperSize = [BrotherUtils customPaperInfoFromMapWithValue:dartCustomPaperInfo binCustomPaperMap:dartBinCustomPaperMap];
    
    printerSettings.density = [BrotherUtils tdPrintDensityWithValue:dartRjDensity];
    printerSettings.peelLabel = peelLabel;
    
    NSDictionary<NSString*, NSObject*> * dartPrintMode = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printMode"];
    
    printerSettings.scaleMode = [BrotherUtils printModeFromMapWithValue:dartPrintMode];
    
    printerSettings.scaleValue = [(NSNumber *)[map objectForKey:@"scaleValue"] doubleValue];
    
    NSDictionary<NSString*, NSObject*> * dartOrientation = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"orientation"];
    
    printerSettings.printOrientation = [BrotherUtils orientationFromMapWithValue:dartOrientation];
    
    NSDictionary<NSString*, NSObject*> * dartHalftone = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"halftone"];
    
    printerSettings.halftone = [BrotherUtils halftoneFromMapWithValue:dartHalftone];

    NSDictionary<NSString*, NSObject*> * dartAlign = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"align"];

    printerSettings.hAlignment = [BrotherUtils alignFromMapWithValue:dartAlign];
    
    NSDictionary<NSString*, NSObject*> * dartValign = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"valign"];
    
    printerSettings.vAlignment = [BrotherUtils vAlignFromMapWithValue:dartValign];

    
    if ([[map objectForKey:@"mode9"] isEqual:@(YES)]) {
        printerSettings.compress = BRLMPrintSettingsCompressModeMode9;
    }
    else {
        printerSettings.compress = BRLMPrintSettingsCompressModeNone;
    }
    
    printerSettings.halftoneThreshold = [(NSNumber *)[map objectForKey:@"thresholdingValue"] intValue];
    
    printerSettings.numCopies = (NSUInteger)[(NSNumber *)[map objectForKey:@"numberOfCopies"] integerValue];
    
    printerSettings.skipStatusCheck = [[map objectForKey:@"skipStatusCheck"] isEqual:@(YES)];
    
    NSDictionary<NSString*, NSObject*> * dartPrintQuality2 = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printQuality"];
    
    printerSettings.printQuality = [BrotherUtils printQualityFromMapWithValue:dartPrintQuality2];
    
    // TODO Add extra configuration
    //[x]scaleMode @"printMode"(map)
    //[x]scaleValue @"scaleValue" (double)
    //[x]printOrientation @"orientation" (map)
    //[x]halftone @"halftone" (map)
    //[x]hAlignment @"align" (map)
    //[x]vAlignment @"valign" (map)
    //[x]compress ???
    //[x]halftoneThreshold @"thresholdingValue" (int)
    //[x]numCopies @"numberOfCopies" (int)
    //[x]skipStatusCheck @"skipStatusCheck" (@YES/@NO type)
    //printQuality @"printQuality" (map)
    
    return printerSettings;
}

+ (BRLMPTPrintSettings *)ptPrintSettingsFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    //NSDictionary<NSString*, NSObject*> * dartPrintModel = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printerModel"];
    
    BRLMPrinterModel printerModel = [BrotherUtils printerModelFromPrinterInfoMapWithValue:map];
    
    NSDictionary<NSString *, NSObject *> * dartLabelName = (NSDictionary<NSString *, NSObject *> *)[map objectForKey:@"labelName"];
    
    LabelName * labelName = [BrotherUtils labelNameFromMapWithValue:dartLabelName];
    
    bool cutmarkPrint = [[map objectForKey:@"isCutMark"] isEqual:@(YES)];
    bool autoCut = [[map objectForKey:@"isAutoCut"] isEqual:@(YES)];
    bool halfCut = [[map objectForKey:@"isHalfCut"] isEqual:@(YES)];
    bool specialTapePrint = [[map objectForKey:@"isSpecialTape"] isEqual:@(YES)];
    
    NSDictionary<NSString *, NSObject *> * dartResolution = (NSDictionary<NSString *, NSObject *> *)[map objectForKey:@"printQuality"];
    
    bool forceVanishingMargin = [[map objectForKey:@"banishMargin"] isEqual:@(YES)];
    
    NSDictionary<NSString*, NSObject*> * dartOrientation = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"orientation"];
    
    BRLMPTPrintSettings * printerSettings = [[BRLMPTPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:printerModel];
    
    printerSettings.labelSize = [BrotherUtils ptLabelSizeWithName:labelName];
    printerSettings.cutmarkPrint = cutmarkPrint;
    printerSettings.autoCut = autoCut;
    printerSettings.halfCut = halfCut;
    printerSettings.specialTapePrint = specialTapePrint;
    printerSettings.resolution = [BrotherUtils printResolutionFromMapWithValue:dartResolution];
    printerSettings.forceVanishingMargin = forceVanishingMargin;
    printerSettings.printOrientation = [BrotherUtils orientationFromMapWithValue:dartOrientation];
    
    
    // chainPrint @"???"
    // highResolutionPrint @"???"
    // autoCutForEachPageCount @"???"
    //
    
    return printerSettings;
}

+ (BRLMMWPrintSettingsPaperSize)mwPaperSizeFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    NSString * name = (NSString *)[map objectForKey:@"name"];
    
    if  ([@"A7" isEqualToString:name]) {
        return BRLMMWPrintSettingsPaperSizeA7;
    }
    else if  ([@"A6" isEqualToString:name]) {
        return BRLMMWPrintSettingsPaperSizeA6;
    }
    
    
    else return BRLMMWPrintSettingsPaperSizeA6;
}
 
+ (BRLMMWPrintSettings *)mwPrintSettingsFromMapWithValue:(NSDictionary<NSString *,NSObject *> *)map {
    
    //NSDictionary<NSString*, NSObject*> * dartPrintModel = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"printerModel"];
    
    BRLMPrinterModel printerModel = [BrotherUtils printerModelFromPrinterInfoMapWithValue:map];
    
    NSDictionary<NSString*, NSObject*> * dartPaperSize = (NSDictionary<NSString*, NSObject*> *)[map objectForKey:@"paperSize"];
    
    
    BRLMMWPrintSettings * printerSettings = [[BRLMMWPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:printerModel];
    
    // TODO Ask Brother Why this is read only, seems odd.
    //printerSettings.paperSize = [BrotherUtils mwPaperSizeFromMapWithValue:dartPaperSize];
    
    return printerSettings;
}

+ (id<BRLMPrintSettingsProtocol>) printSettingsFromMapWithValue:(NSDictionary<NSString *, NSObject *> *) map {
    
    BRLMPrinterModel printerModel = [BrotherUtils printerModelFromPrinterInfoMapWithValue:map];
    
    if (printerModel == BRLMPrinterModelQL_710W
        || printerModel == BRLMPrinterModelQL_720NW
        || printerModel == BRLMPrinterModelQL_810W
        || printerModel == BRLMPrinterModelQL_1110NWB
        || printerModel == BRLMPrinterModelQL_1115NWB
        ) {
        return [BrotherUtils qlPrintSettingsFromMapWithValue:map];
    }
    else if (printerModel == BRLMPrinterModelPJ_673
             || printerModel == BRLMPrinterModelPJ_773
             || printerModel == BRLMPrinterModelPJ_763MFi
             ) {
        return [BrotherUtils pjPrintSettingsFromMapWithValue:map];
    }
    else if (printerModel == BRLMPrinterModelRJ_2050
             || printerModel == BRLMPrinterModelRJ_2140
             || printerModel == BRLMPrinterModelRJ_2150
             || printerModel == BRLMPrinterModelRJ_3050
             || printerModel == BRLMPrinterModelRJ_3150
             || printerModel == BRLMPrinterModelRJ_4040
             || printerModel == BRLMPrinterModelRJ_4230B
             || printerModel == BRLMPrinterModelRJ_4250WB
             ) {
        return [BrotherUtils rjPrintSettingsFromMapWithValue:map];
    }
    else if (printerModel == BRLMPrinterModelTD_2120N
             || printerModel == BRLMPrinterModelTD_2130N
             || printerModel == BRLMPrinterModelTD_4100N
             || printerModel == BRLMPrinterModelTD_4420DN
             || printerModel == BRLMPrinterModelTD_4520DN
             || printerModel == BRLMPrinterModelTD_4550DNWB
             ) {
        return [BrotherUtils tdPrintSettingsFromMapWithValue:map];
    }
    else if (printerModel == BRLMPrinterModelPT_D800W
             || printerModel == BRLMPrinterModelPT_E550W
             || printerModel == BRLMPrinterModelPT_E800W
             || printerModel == BRLMPrinterModelPT_P750W
             || printerModel == BRLMPrinterModelPT_P900W
             || printerModel == BRLMPrinterModelPT_P300BT
             || printerModel == BRLMPrinterModelPT_P710BT
             || printerModel == BRLMPrinterModelPT_P910BT
             || printerModel == BRLMPrinterModelPT_P950NW
             || printerModel == BRLMPrinterModelPT_E850TKW
             || printerModel == BRLMPrinterModelPT_P715eBT
             ) {
        return [BrotherUtils ptPrintSettingsFromMapWithValue:map];
    }
    else if (printerModel == BRLMPrinterModelMW_170
             || printerModel == BRLMPrinterModelMW_270
             || printerModel == BRLMPrinterModelMW_145MFi
             || printerModel == BRLMPrinterModelMW_260MFi
             || printerModel == BRLMPrinterModelMW_145MFi
             ) {
        return [BrotherUtils mwPrintSettingsFromMapWithValue:map];
    }
    
    return [BrotherUtils qlPrintSettingsFromMapWithValue:map];
}


+ (NSDictionary<NSString *,NSObject *> *)errorCodeToMapWithValue:(BRLMPrintErrorCode)error {
    
    NSString * errorName = @"ERROR_NONE";
    if (error == BRLMPrintErrorCodeNoError) {
        errorName = @"ERROR_NONE";
    }
    else if (error == BRLMPrintErrorCodePrintSettingsError) {
        errorName = @"ERROR_PRINTER_SETTING_NOT_SUPPORTED";
    }
    else if (error == BRLMPrintErrorCodeFilepathURLError) {
        errorName = @"ERROR_FILE_NOT_FOUND";
    }
    else if (error == BRLMPrintErrorCodePDFPageError) {
        errorName = @"ERROR_FILE_NOT_FOUND";
    }
    else if (error == BRLMPrintErrorCodePrintSettingsNotSupportError) {
        errorName = @"ERROR_PRINTER_SETTING_NOT_SUPPORTED";
    }
    else if (error == BRLMPrintErrorCodeDataBufferError) {
        errorName = @"ERROR_BUFFER_FULL";
    }
    else if (error == BRLMPrintErrorCodePrinterModelError) {
        errorName = @"ERROR_NOT_SAME_MODEL";
    }
    else if (error == BRLMPrintErrorCodeCanceled) {
        errorName = @"ERROR_CANCEL";
    }
    else if (error == BRLMPrintErrorCodeChannelTimeout) {
        errorName = @"ERROR_EVALUATION_TIMEUP";
    }
    else if (error == BRLMPrintErrorCodeSetModelError) {
        errorName = @"ERROR_NOT_SAME_MODEL";
    }
    else if (error == BRLMPrintErrorCodeUnsupportedFile) {
        errorName = @"ERROR_UNSUPPORTED_MEDIA";
    }
    else if (error == BRLMPrintErrorCodeSetMarginError) {
        errorName = @"ERROR_SET_OVER_MARGIN";
    }
    else if (error == BRLMPrintErrorCodeSetLabelSizeError) {
        errorName = @"ERROR_WRONG_LABEL";
    }
    else if (error == BRLMPrintErrorCodeCustomPaperSizeError) {
        errorName = @"ERROR_WRONG_CUSTOM_INFO";
    }
    else if (error == BRLMPrintErrorCodeSetLengthError) {
        errorName = @"ERROR_MINIMUM_LENGTH_LIMIT";
    }
    else if (error == BRLMPrintErrorCodeTubeSettingError) {
        errorName = @"ERROR_PRINTER_SETTING_NOT_SUPPORTED";
    }
    else if (error == BRLMPrintErrorCodeChannelErrorStreamStatusError) {
        errorName = @"ERROR_GET_OUTPUT_STREAM_FAILED";
    }
    else if (error == BRLMPrintErrorCodeChannelErrorUnsupportedChannel) {
        errorName = @"ERROR_PORT_NOT_SUPPORTED";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorPaperEmpty) {
        errorName = @"ERROR_PAPER_EMPTY";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorCoverOpen) {
        errorName = @"ERROR_COVER_OPEN";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorBusy) {
        errorName = @"ERROR_BUSY";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorPrinterTurnedOff) {
        errorName = @"ERROR_INTERNAL_ERROR";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorBatteryWeak) {
        errorName = @"ERROR_BATTERY_TROUBLE";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorExpansionBufferFull) {
        errorName = @"ERROR_BUFFER_FULL";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorCommunicationError) {
        errorName = @"ERROR_COMMUNICATION_ERROR";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorPaperJam) {
        errorName = @"ERROR_PAPER_JAM";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorMediaCannotBeFed) {
        errorName = @"ERROR_FEED_OR_CASSETTE_EMPTY";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorOverHeat) {
        errorName = @"ERROR_OVERHEAT";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorHighVoltageAdapter) {
        errorName = @"ERROR_HIGH_VOLTAGE_ADAPTER";
    }
    else if (error == BRLMPrintErrorCodePrinterStatusErrorUnknownError) {
        errorName = @"ERROR_INTERNAL_ERROR";
    }
    else if (error == BRLMPrintErrorCodeUnknownError) {
        errorName = @"ERROR_INTERNAL_ERROR";
    }
    NSDictionary<NSString*, NSObject *> * dartErrorCode = @{
        @"name":errorName,
        @"id": [[NSNumber alloc] initWithInt:(-1)]
    };

    return dartErrorCode;
}

+ (NSDictionary<NSString *, NSObject *> *) errorCodeToMapWithId:(NSNumber *)errorId {
    
    NSString * errorName = @"ERROR_NONE";
    if ([errorId isEqualToNumber:@1]) {
        errorName = @"ERROR_NONE";
    }
    else if ([errorId isEqualToNumber:@2]) {
        errorName = @"ERROR_NOT_SAME_MODEL";
    }
    else if ([errorId isEqualToNumber:@3]) {
        errorName = @"ERROR_BROTHER_PRINTER_NOT_FOUND";
    }
    else if ([errorId isEqualToNumber:@4]) {
        errorName = @"ERROR_PAPER_EMPTY";
    }
    else if ([errorId isEqualToNumber:@5]) {
        errorName = @"ERROR_BATTERY_EMPTY";
    }
    else if ([errorId isEqualToNumber:@6]) {
        errorName = @"ERROR_COMMUNICATION_ERROR";
    }
    else if ([errorId isEqualToNumber:@7]) {
        errorName = @"ERROR_OVERHEAT";
    }
    else if ([errorId isEqualToNumber:@8]) {
        errorName = @"ERROR_PAPER_JAM";
    }
    else if ([errorId isEqualToNumber:@9]) {
        errorName = @"ERROR_HIGH_VOLTAGE_ADAPTER";
    }
    else if ([errorId isEqualToNumber:@10]) {
        errorName = @"ERROR_CHANGE_CASSETTE";
    }
    else if ([errorId isEqualToNumber:@11]) {
        errorName = @"ERROR_FEED_OR_CASSETTE_EMPTY";
    }
    else if ([errorId isEqualToNumber:@12]) {
        errorName = @"ERROR_SYSTEM_ERROR";
    }
    else if ([errorId isEqualToNumber:@13]) {
        errorName = @"ERROR_NO_CASSETTE";
    }
    else if ([errorId isEqualToNumber:@14]) {
        errorName = @"ERROR_WRONG_CASSETTE_DIRECT";
    }
    else if ([errorId isEqualToNumber:@15]) {
        errorName = @"ERROR_CREATE_SOCKET_FAILED";
    }
    else if ([errorId isEqualToNumber:@16]) {
        errorName = @"ERROR_CONNECT_SOCKET_FAILED";
    }
    else if ([errorId isEqualToNumber:@17]) {
        errorName = @"ERROR_GET_OUTPUT_STREAM_FAILED";
    }
    else if ([errorId isEqualToNumber:@18]) {
        errorName = @"ERROR_GET_INPUT_STREAM_FAILED";
    }
    else if ([errorId isEqualToNumber:@19]) {
        errorName = @"ERROR_CLOSE_SOCKET_FAILED";
    }
    else if ([errorId isEqualToNumber:@20]) {
        errorName = @"ERROR_OUT_OF_MEMORY";
    }
    else if ([errorId isEqualToNumber:@21]) {
        errorName = @"ERROR_SET_OVER_MARGIN";
    }
    else if ([errorId isEqualToNumber:@22]) {
        errorName = @"ERROR_NO_SD_CARD";
    }
    else if ([errorId isEqualToNumber:@23]) {
        errorName = @"ERROR_FILE_NOT_SUPPORTED";
    }
    else if ([errorId isEqualToNumber:@24]) {
        errorName = @"ERROR_EVALUATION_TIMEUP";
    }
    else if ([errorId isEqualToNumber:@25]) {
        errorName = @"ERROR_WRONG_CUSTOM_INFO";
    }
    else if ([errorId isEqualToNumber:@26]) {
        errorName = @"ERROR_NO_ADDRESS";
    }
    else if ([errorId isEqualToNumber:@27]) {
        errorName = @"ERROR_NOT_MATCH_ADDRESS";
    }
    else if ([errorId isEqualToNumber:@28]) {
        errorName = @"ERROR_FILE_NOT_FOUND";
    }
    else if ([errorId isEqualToNumber:@29]) {
        errorName = @"ERROR_TEMPLATE_FILE_NOT_MATCH_MODEL";
    }
    else if ([errorId isEqualToNumber:@30]) {
        errorName = @"ERROR_TEMPLATE_NOT_TRANS_MODEL";
    }
    else if ([errorId isEqualToNumber:@31]) {
        errorName = @"ERROR_COVER_OPEN";
    }
    else if ([errorId isEqualToNumber:@32]) {
        errorName = @"ERROR_WRONG_LABEL";
    }
    else if ([errorId isEqualToNumber:@33]) {
        errorName = @"ERROR_PORT_NOT_SUPPORTED";
    }
    else if ([errorId isEqualToNumber:@34]) {
        errorName = @"ERROR_WRONG_TEMPLATE_KEY";
    }
    else if ([errorId isEqualToNumber:@35]) {
        errorName = @"ERROR_BUSY";
    }
    else if ([errorId isEqualToNumber:@36]) {
        errorName = @"ERROR_TEMPLATE_NOT_PRINT_MODEL";
    }
    else if ([errorId isEqualToNumber:@37]) {
        errorName = @"ERROR_CANCEL";
    }
    else if ([errorId isEqualToNumber:@38]) {
        errorName = @"ERROR_PRINTER_SETTING_NOT_SUPPORTED";
    }
    else if ([errorId isEqualToNumber:@39]) {
        errorName = @"ERROR_INVALID_PARAMETER";
    }
    else if ([errorId isEqualToNumber:@40]) {
        errorName = @"ERROR_INTERNAL_ERROR";
    }
    else if ([errorId isEqualToNumber:@41]) {
        errorName = @"ERROR_TEMPLATE_NOT_CONTROL_MODEL";
    }
    else if ([errorId isEqualToNumber:@42]) {
        errorName = @"ERROR_TEMPLATE_NOT_EXIST";
    }
    else if ([errorId isEqualToNumber:@44]) {
        errorName = @"ERROR_BUFFER_FULL";
    }
    else if ([errorId isEqualToNumber:@45]) {
        errorName = @"ERROR_TUBE_EMPTY";
    }
    else if ([errorId isEqualToNumber:@46]) {
        errorName = @"ERROR_TUBE_RIBBON_EMPTY";
    }
    else if ([errorId isEqualToNumber:@47]) {
        errorName = @"ERROR_UPDATE_FRIM_NOT_SUPPORTED";
    }
    else if ([errorId isEqualToNumber:@48]) {
        errorName = @"ERROR_OS_VERSION_NOT_SUPPORTED";
    }
    else if ([errorId isEqualToNumber:@49]) {
        errorName = @"ERROR_RESOLUTION_MODE";
    }
    else if ([errorId isEqualToNumber:@50]) {
        errorName = @"ERROR_POWER_CABLE_UNPLUGGING";
    }
    else if ([errorId isEqualToNumber:@51]) {
        errorName = @"ERROR_BATTERY_TROUBLE";
    }
    else if ([errorId isEqualToNumber:@52]) {
        errorName = @"ERROR_UNSUPPORTED_MEDIA";
    }
    else if ([errorId isEqualToNumber:@53]) {
        errorName = @"ERROR_TUBE_CUTTER";
    }
    else if ([errorId isEqualToNumber:@54]) {
        errorName = @"ERROR_UNSUPPORTED_TWO_COLOR";
    }
    else if ([errorId isEqualToNumber:@55]) {
        errorName = @"ERROR_UNSUPPORTED_MONO_COLOR";
    }
    else if ([errorId isEqualToNumber:@56]) {
        errorName = @"ERROR_MINIMUM_LENGTH_LIMIT";
    }
    else if ([errorId isEqualToNumber:@57]) {
        errorName = @"ERROR_WORKPATH_NOT_SET";
    }
    
    NSDictionary<NSString*, NSObject *> * dartErrorCode = @{
        @"name":errorName,
        @"id": errorId
    };

    return dartErrorCode;
}

+ (BRLMPrintErrorCode) statusErrorCodeToMapWithRawStatus:(BRLMPrinterStatusRawDataStructure)status {
    
    Byte statusType = status.byStatusType;
    Byte errorInfo1 = status.byErrorInf;
    Byte errorInfo2 = status.byErrorInf2;
    
    if ((errorInfo1 & 1) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorPaperEmpty;
    }
    
    if ((errorInfo1 & 2) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorMediaCannotBeFed;
    }
    
    if ((errorInfo1 & 4) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorPaperJam;
    }
    
    if ((errorInfo1 & 10) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorBusy;
    }
    
    if ((errorInfo1 & 20) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorPrinterTurnedOff;
    }
    
    if ((errorInfo1 & 40) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorHighVoltageAdapter;
    }
    
    if ((errorInfo1 & 80) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorOverHeat;
    }
    
    if ((errorInfo2 & 1) > 0) {
        return BRLMPrintErrorCodeSetLabelSizeError;
    }
    
    if ((errorInfo2 & 2) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorExpansionBufferFull;
    }
    
    if ((errorInfo2 & 4) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorCommunicationError;
    }
    
    if ((errorInfo2 & 8) > 0) {
        return BRLMPrintErrorCodeDataBufferError;
    }
    
    if ((errorInfo2 & 10) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorCoverOpen;
    }
    
    if ((errorInfo2 & 20) > 0) {
        return BRLMPrintErrorCodeCanceled;
    }
    
    if ((errorInfo2 & 40) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorPaperJam;
    }
    
    if ((errorInfo2 & 80) > 0) {
        return BRLMPrintErrorCodePrinterStatusErrorUnknownError;
    }
    
    
    
    return BRLMPrintErrorCodeNoError;
}

+ (NSNumber *) labelIdTypeToNumberWithValue:(LabelIdType) labelTypeId {
    
    if (labelTypeId == LabelIdTypeW17H54) {
        return [[NSNumber alloc] initWithInt:(0x01)];
    }
    if (labelTypeId == LabelIdTypeW17H87) {
        return [[NSNumber alloc] initWithInt:(0x02)];
    }
    if (labelTypeId == LabelIdTypeW23H23) {
        return [[NSNumber alloc] initWithInt:(0x03)];
    }
    if (labelTypeId == LabelIdTypeW29H42) {
        return [[NSNumber alloc] initWithInt:(0x04)];
    }
    if (labelTypeId == LabelIdTypeW29H90) {
        return [[NSNumber alloc] initWithInt:(0x05)];
    }
    if (labelTypeId == LabelIdTypeW38H90) {
        return [[NSNumber alloc] initWithInt:(0x06)];
    }
    if (labelTypeId == LabelIdTypeW39H48) {
        return [[NSNumber alloc] initWithInt:(0x07)];
    }
    if (labelTypeId == LabelIdTypeW52H29) {
        return [[NSNumber alloc] initWithInt:(0x08)];
    }
    if (labelTypeId == LabelIdTypeW62H29) {
        return [[NSNumber alloc] initWithInt:(0x09)];
    }
    if (labelTypeId == LabelIdTypeW62H100) {
        return [[NSNumber alloc] initWithInt:(0x0a)];
    }
    if (labelTypeId == LabelIdTypeW12) {
        return [[NSNumber alloc] initWithInt:(0x0b)];
    }
    if (labelTypeId == LabelIdTypeW29) {
        return [[NSNumber alloc] initWithInt:(0x0c)];
    }
    if (labelTypeId == LabelIdTypeW38) {
        return [[NSNumber alloc] initWithInt:(0x0d)];
    }
    if (labelTypeId == LabelIdTypeW50) {
        return [[NSNumber alloc] initWithInt:(0x0e)];
    }
    if (labelTypeId == LabelIdTypeW54) {
        return [[NSNumber alloc] initWithInt:(0x0f)];
    }
    if (labelTypeId == LabelIdTypeW62) {
        return [[NSNumber alloc] initWithInt:(0x10)];
    }
    if (labelTypeId == LabelIdTypeW60H86) {
        return [[NSNumber alloc] initWithInt:(0x11)];
    }
    //PT
    if (labelTypeId == LabelIdTypeW3_5) {
        return [[NSNumber alloc] initWithInt:(0x12)];
    }
    if (labelTypeId == LabelIdTypeW6) {
        return [[NSNumber alloc] initWithInt:(0x13)];
    }
    if (labelTypeId == LabelIdTypeW9) {
        return [[NSNumber alloc] initWithInt:(0x14)];
    }
    if (labelTypeId == LabelIdTypeW18) {
        return [[NSNumber alloc] initWithInt:(0x15)];
    }
    if (labelTypeId == LabelIdTypeW24) {
        return [[NSNumber alloc] initWithInt:(0x16)];
    }
    if (labelTypeId == LabelIdTypeHS_W6) {
        return [[NSNumber alloc] initWithInt:(0x17)];
    }
    if (labelTypeId == LabelIdTypeHS_W9) {
        return [[NSNumber alloc] initWithInt:(0x18)];
    }
    if (labelTypeId == LabelIdTypeHS_W12) {
        return [[NSNumber alloc] initWithInt:(0x19)];
    }
    if (labelTypeId == LabelIdTypeHS_W18) {
        return [[NSNumber alloc] initWithInt:(0x1a)];
    }
    if (labelTypeId == LabelIdTypeHS_W24) {
        return [[NSNumber alloc] initWithInt:(0x1b)];
    }
    if (labelTypeId == LabelIdTypeW36) {
        return [[NSNumber alloc] initWithInt:(0x1c)];
    }
    if (labelTypeId == LabelIdTypeR6_5) {
        return [[NSNumber alloc] initWithInt:(0x1d)];
    }
    if (labelTypeId == LabelIdTypeR6_0) {
        return [[NSNumber alloc] initWithInt:(0x1f)];
    }
    if (labelTypeId == LabelIdTypeR5_0) {
        return [[NSNumber alloc] initWithInt:(0x20)];
    }
    if (labelTypeId == LabelIdTypeR4_0) {
        return [[NSNumber alloc] initWithInt:(0x21)];
    }
    if (labelTypeId == LabelIdTypeR3_5) {
        return [[NSNumber alloc] initWithInt:(0x22)];
    }
    if (labelTypeId == LabelIdTypeR3_0) {
        return [[NSNumber alloc] initWithInt:(0x23)];
    }
    if (labelTypeId == LabelIdTypeR2_5) {
        return [[NSNumber alloc] initWithInt:(0x24)];
    }
    if (labelTypeId == LabelIdTypeFLE_W21H45) {
        return [[NSNumber alloc] initWithInt:(0x25)];
    }
    //QL-8対応
    if (labelTypeId == LabelIdTypeW62RB) {
        return [[NSNumber alloc] initWithInt:(0x26)];
    }
    if (labelTypeId == LabelIdTypeW54H29) {
        return [[NSNumber alloc] initWithInt:(0x27)];
    }
    //QL_1100
    if (labelTypeId == LabelIdTypeW102) {
        return [[NSNumber alloc] initWithInt:(0x28)];
    }
    if (labelTypeId == LabelIdTypeW102H51) {
        return [[NSNumber alloc] initWithInt:(0x29)];
    }
    if (labelTypeId == LabelIdTypeW102H152) {
        return [[NSNumber alloc] initWithInt:(0x30)];
    }
    if (labelTypeId == LabelIdTypeW103) {
        return [[NSNumber alloc] initWithInt:(0x31)];
    }
    if (labelTypeId == LabelIdTypeW103H164) {
        return [[NSNumber alloc] initWithInt:(0x32)];
    }
    if (labelTypeId == LabelIdTypeDT_W90) {
        return [[NSNumber alloc] initWithInt:(0x33)];
    }
    if (labelTypeId == LabelIdTypeDT_W102) {
        return [[NSNumber alloc] initWithInt:(0x34)];
    }
    if (labelTypeId == LabelIdTypeDT_W102H51) {
        return [[NSNumber alloc] initWithInt:(0x35)];
    }
    if (labelTypeId == LabelIdTypeDT_W102H152) {
        return [[NSNumber alloc] initWithInt:(0x36)];
    }
    
    return [[NSNumber alloc] initWithInt:(-1)];
}

+ (NSNumber *) colorTypeToNumberWithValue:(ColorType) colorType {
    
    if (colorType == WHITE) {
        return [[NSNumber alloc] initWithInt:(0x01)];
    }
    if (colorType == OTHERS) {
        return [[NSNumber alloc] initWithInt:(0x02)];
    }
    if (colorType == CLEAR) {
        return [[NSNumber alloc] initWithInt:(0x03)];
    }
    if (colorType == RED) {
        return [[NSNumber alloc] initWithInt:(0x04)];
    }
    if (colorType == BLUE) {
        return [[NSNumber alloc] initWithInt:(0x05)];
    }
    if (colorType == YELLOW) {
        return [[NSNumber alloc] initWithInt:(0x06)];
    }
    if (colorType == GREEN) {
        return [[NSNumber alloc] initWithInt:(0x07)];
    }
    if (colorType == BLACK) {
        return [[NSNumber alloc] initWithInt:(0x08)];
    }
    if (colorType == CLEAR_WHITE) {
        return [[NSNumber alloc] initWithInt:(0x09)];
    }
    if (colorType == GOLD) {
        return [[NSNumber alloc] initWithInt:(0x0A)];
    }
    if (colorType == GOLD_PREMIUM) {
        return [[NSNumber alloc] initWithInt:(0x0B)];
    }
    if (colorType == SILVER_PREMIUM) {
        return [[NSNumber alloc] initWithInt:(0x0C)];
    }
    if (colorType == OTHERS_PREMIUM) {
        return [[NSNumber alloc] initWithInt:(0x0D)];
    }
    if (colorType == OTHERS_MASKING) {
        return [[NSNumber alloc] initWithInt:(0x0E)];
    }
    if (colorType == SATIN_LIGHTBLUE) {
        return [[NSNumber alloc] initWithInt:(0x0F)];
    }
    if (colorType == SATIN_MINT) {
        return [[NSNumber alloc] initWithInt:(0x10)];
    }
    /*
    if (colorType == SILVER_SATIN) {
        return [[NSNumber alloc] initWithInt:(0x11)];
    }
     */
    if (colorType == MATTE_WHITE) {
        return [[NSNumber alloc] initWithInt:(0x20)];
    }
    if (colorType == MATTE_CLEAR) {
        return [[NSNumber alloc] initWithInt:(0x21)];
    }
    if (colorType == MATTE_SILVER) {
        return [[NSNumber alloc] initWithInt:(0x22)];
    }
    if (colorType == SATIN_GOLD) {
        return [[NSNumber alloc] initWithInt:(0x23)];
    }
    if (colorType == SATIN_SILVER) {
        return [[NSNumber alloc] initWithInt:(0x24)];
    }
    /*
    if (colorType == PASTEL_PURPLE) {
        return [[NSNumber alloc] initWithInt:(0x25)];
    }
     */
    if (colorType == BLUE_WHITE) {
        return [[NSNumber alloc] initWithInt:(0x30)];
    }
    if (colorType == RED_WHITE) {
        return [[NSNumber alloc] initWithInt:(0x31)];
    }
    if (colorType == FLOURESCENT_ORANGE) {
        return [[NSNumber alloc] initWithInt:(0x40)];
    }
    if (colorType == FLOURESCENT_YELLOW) {
        return [[NSNumber alloc] initWithInt:(0x41)];
    }
    if (colorType == BERRY_PINK) {
        return [[NSNumber alloc] initWithInt:(0x50)];
    }
    if (colorType == LIGHT_GLAY) {
        return [[NSNumber alloc] initWithInt:(0x51)];
    }
    if (colorType == LIME_GREEN) {
        return [[NSNumber alloc] initWithInt:(0x52)];
    }
    /*
    if (colorType == NAVY_BLUE_SATIN) {
        return [[NSNumber alloc] initWithInt:(0x53)];
    }
    */
    /*
    if (colorType == WINE_RED_SATIN) {
        return [[NSNumber alloc] initWithInt:(0x54)];
    }
    */
    if (colorType == FABRIC_YELLOW) {
        return [[NSNumber alloc] initWithInt:(0x60)];
    }
    if (colorType == FABRIC_PINK) {
        return [[NSNumber alloc] initWithInt:(0x61)];
    }
    if (colorType == FABRIC_BLUE) {
        return [[NSNumber alloc] initWithInt:(0x62)];
    }
    if (colorType == TUBE_WHITE) {
        return [[NSNumber alloc] initWithInt:(0x70)];
    }
    if (colorType == SELF_WHITE) {
        return [[NSNumber alloc] initWithInt:(0x80)];
    }
    if (colorType == FLEXIBLE_WHITE) {
        return [[NSNumber alloc] initWithInt:(0x90)];
    }
    if (colorType == FLEXIBLE_YELLOW) {
        return [[NSNumber alloc] initWithInt:(0x91)];
    }
    if (colorType == CLEANING) {
        return [[NSNumber alloc] initWithInt:(0xF0)];
    }
    if (colorType == STENCIL) {
        return [[NSNumber alloc] initWithInt:(0xF1)];
    }
    if (colorType == UNSUPPORT) {
        return [[NSNumber alloc] initWithInt:(0xFF)];
    }
    return [[NSNumber alloc] initWithInt:(-1)];
}

+ (NSString *) colorTypeToNameWithValue:(ColorType) colorType {
    
    if (colorType == WHITE) {
        return @"WHITE";
    }
    if (colorType == OTHERS) {
        return @"OTHERS";
    }
    if (colorType == CLEAR) {
        return @"CLEAR";
    }
    if (colorType == RED) {
        return @"RED";
    }
    if (colorType == BLUE) {
        return @"BLUE";
    }
    if (colorType == YELLOW) {
        return @"YELLOW";
    }
    if (colorType == GREEN) {
        return @"GREEN";
    }
    if (colorType == BLACK) {
        return @"BLACK";
    }
    if (colorType == CLEAR_WHITE) {
        return @"CLEAR_WHITE";
    }
    if (colorType == GOLD) {
        return @"GOLD";
    }
    if (colorType == GOLD_PREMIUM) {
        return @"GOLD_PREMIUM";
    }
    if (colorType == SILVER_PREMIUM) {
        return @"SILVER_PREMIUM";
    }
    if (colorType == OTHERS_PREMIUM) {
        return @"OTHERS_PREMIUM";
    }
    if (colorType == OTHERS_MASKING) {
        return @"OTHERS_MASKING";
    }
    if (colorType == SATIN_LIGHTBLUE) {
        return @"SATIN_LIGHTBLUE";
    }
    if (colorType == SATIN_MINT) {
        return @"SATIN_MINT";
    }
    /*
    if (colorType == SILVER_SATIN) {
        return @"SILVER_SATIN";
    }
     */
    if (colorType == MATTE_WHITE) {
        return @"MATTE_WHITE";
    }
    if (colorType == MATTE_CLEAR) {
        return @"MATTE_CLEAR";
    }
    if (colorType == MATTE_SILVER) {
        return @"MATTE_SILVER";
    }
    if (colorType == SATIN_GOLD) {
        return @"SATIN_GOLD";
    }
    if (colorType == SATIN_SILVER) {
        return @"SATIN_SILVER";
    }
    /*
    if (colorType == PASTEL_PURPLE) {
        return @"PASTEL_PURPLE";
    }
     */
    if (colorType == BLUE_WHITE) {
        return @"BLUE_WHITE";
    }
    if (colorType == RED_WHITE) {
        return @"RED_WHITE";
    }
    if (colorType == FLOURESCENT_ORANGE) {
        return [[NSNumber alloc] initWithInt:(0x40)];
    }
    if (colorType == FLOURESCENT_YELLOW) {
        return @"FLOURESCENT_ORANGE";
    }
    if (colorType == BERRY_PINK) {
        return @"BERRY_PINK";
    }
    if (colorType == LIGHT_GLAY) {
        return @"LIGHT_GLAY";
    }
    if (colorType == LIME_GREEN) {
        return @"LIME_GREEN";
    }
    /*
    if (colorType == NAVY_BLUE_SATIN) {
        return @"NAVY_BLUE_SATIN";
    }
    */
    /*
    if (colorType == WINE_RED_SATIN) {
        return @"WINE_RED_SATIN";
    }
    */
    if (colorType == FABRIC_YELLOW) {
        return @"FABRIC_YELLOW";
    }
    if (colorType == FABRIC_PINK) {
        return @"FABRIC_PINK";
    }
    if (colorType == FABRIC_BLUE) {
        return @"FABRIC_BLUE";
    }
    if (colorType == TUBE_WHITE) {
        return @"TUBE_WHITE";
    }
    if (colorType == SELF_WHITE) {
        return @"SELF_WHITE";
    }
    if (colorType == FLEXIBLE_WHITE) {
        return @"FLEXIBLE_WHITE";
    }
    if (colorType == FLEXIBLE_YELLOW) {
        return @"FLEXIBLE_YELLOW";
    }
    if (colorType == CLEANING) {
        return @"CLEANING";
    }
    if (colorType == STENCIL) {
        return @"STENCIL";
    }
    if (colorType == UNSUPPORT) {
        return @"UNSUPPORT";
    }
    return @"UNSUPPORT";
}

+ (NSDictionary<NSString *, NSObject *> *) colorTypeToMapWithValue:(ColorType)colorType {
 
    NSDictionary<NSString*, NSObject *> * dartLabelColor = @{
        @"id":[BrotherUtils colorTypeToNumberWithValue:colorType],
        @"name": [BrotherUtils colorTypeToNameWithValue:colorType]
    };
    
    return dartLabelColor;
    
}

+ (NSDictionary<NSString *,NSObject *> *)printerStatusToMapWithError:(BRLMPrintErrorCode)error status:(BRLMPrinterStatus *)status {
    
    NSObject * dartError = [BrotherUtils errorCodeToMapWithValue: error];
    
    // TODO Figure out good way to get status from raw status data.
    //NSObject * dartError2 = [BrotherUtils errorCodeToMapWithId: [NSNumber numberWithInt:status.ptStatus.byStatusType] ];
    
    // TODO Translate status if not nill
    NSDictionary<NSString*, NSObject *> * dartPrintStatus = @{
        @"errorCode":dartError,//dartError,
        @"labelId": [[NSNumber alloc] initWithInt:(-1)], // TODO
        @"labelType": [[NSNumber alloc] initWithInt:(-1)], // TODO
        @"isACConnected": @{@"id": [[NSNumber alloc] initWithInt:(-1)], @"name": @"Unknown" }, // TODO
        @"isBatteryMounted": @{@"id": [[NSNumber alloc] initWithInt:(-1)], @"name": @"Unknown" }, // TODO
        @"batteryLevel": [[NSNumber alloc] initWithInt:(-1)], // TODO
        @"batteryResidualQuantityLevel":[[NSNumber alloc] initWithInt:(-1)], // TODO
        @"maxOfBatteryResidualQuantityLevel":[[NSNumber alloc] initWithInt:(-1)], // TODO
    };
    
    return dartPrintStatus;
}

+ (NSDictionary<NSString *, NSObject *> *) labelInfoStatuesToMapWithStatus:(BRPtouchLabelInfoStatus *) status{
    
    // TODO Continue implementation after color type is added
    NSDictionary<NSString*, NSObject *> * dartLabelInfoStatus = @{
        @"labelNameIndex": [BrotherUtils labelIdTypeToNumberWithValue: [status labelID ]],
        @"isAutoCut": @FALSE, // TODO
        @"isEndCut": @FALSE, // TODO
        @"isHalfCut": @FALSE, // TODO
        @"isSpecialTape": @FALSE, // TODO
        @"isCutMark": @FALSE, // TODO
        @"labelColor": [BrotherUtils colorTypeToMapWithValue:[status labelColor]],
        @"labelFontColor": [BrotherUtils colorTypeToMapWithValue:[status fontColor]],
        @"labelType": [BrotherUtils labelIdTypeToNumberWithValue: [status labelID ]]
    };
    
    return dartLabelInfoStatus;
}


+ (NSDictionary<NSString *,NSObject *> *)bRPtouchDeviceInfoToNetPrinterMap:(BRPtouchDeviceInfo *)deviceInfo {
    
    NSDictionary<NSString *, NSObject *> * dartNetPrinter = @{
        @"modelName": [deviceInfo strModelName],
              @"serNo": [deviceInfo strSerialNumber],
              @"ipAddress": [deviceInfo strIPAddress],
              @"macAddress": [deviceInfo strMACAddress],
              @"nodeName": [deviceInfo strNodeName],
              @"location": [deviceInfo strLocation]
    };
    
    return dartNetPrinter;
}

+ (NSDictionary<NSString *,NSObject *> *)bRPtouchDeviceInfoToBluetoothPrinterMap:(BRPtouchDeviceInfo *)deviceInfo {
    
    NSDictionary<NSString *, NSObject *> * dartPrinter = @{
        @"modelName": [deviceInfo strModelName],
              @"macAddress": [deviceInfo strSerialNumber],
              
    };
    
    return dartPrinter;
}

+ (NSDictionary<NSString *,NSObject *> *)bRPtouchDeviceInfoToBlePrinterMap:(BRPtouchDeviceInfo *)deviceInfo {
    
    NSDictionary<NSString *, NSObject *> * dartBlePrinter = @{
        @"localName": [deviceInfo strBLEAdvertiseLocalName]
    };
    
    return dartBlePrinter;
}


+ (NSDictionary<NSString *,NSObject *> *)cpPeripheralToBluetoothPrinterMap:(CBPeripheral *)peripheral {
    
    NSDictionary<NSString *, NSObject *> * dartPrinter = @{
        @"modelName": [peripheral name],
              @"macAddress": [peripheral identifier],
              
    };
    
    return dartPrinter;
}

+ (NSDictionary<NSString *,NSObject *> *)eaAccessoryToBluetoothPrinterMap:(EAAccessory *)accessory {
    
    
    NSDictionary<NSString *, NSObject *> * dartPrinter = @{
        @"modelName": [accessory name],
              @"macAddress": [accessory serialNumber]//[NSString stringWithFormat:@"%@",  @([accessory connectionID])]
              
    };
    
    return dartPrinter;
}

@end



@implementation LabelName
- (instancetype)initWithName:(NSString *)name model:(NSString *)model {
    self = [super init];
        if (self) {
            _name = name;
            _model = model;
            
        }
        return self;
}



@end
