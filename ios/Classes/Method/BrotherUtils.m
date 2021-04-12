//
//  BrotherUtils.m
//  another_brother
//
//  Created by admin on 4/11/21.
//

#import <Foundation/Foundation.h>

#import "BrotherUtils.h"

@implementation BrotherUtils

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

@end

