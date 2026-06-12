//
//  UpdatePrinterSettingsMethodCall.m
//  another_brother
//
//  Mirrors the Android UpdatePrinterSettingsMethodCall behavior. The new
//  BRLMPrinterDriver API used elsewhere in the plugin does not provide a way
//  to update printer settings, so we fall back to the legacy BRPtouchPrinter
//  API which exposes setPrinterSettings: for that purpose.
//

#import <Foundation/Foundation.h>
#import "UpdatePrinterSettingsMethodCall.h"

@implementation UpdatePrinterSettingsMethodCall
static NSString * METHOD_NAME = @"updatePrinterSettings";

+ (NSString *) METHOD_NAME {
    return METHOD_NAME;
}

- (instancetype)initWithCall:(FlutterMethodCall *)call
                      result:(FlutterResult) result {
    self = [super init];
    if (self) {
        _call = call;
        _result = result;
    }
    return self;
}

// Translates the legacy BRPtouchPrinter integer error codes into the dart
// ErrorCode names the rest of the plugin uses.
+ (NSString *)errorNameForLegacyCode:(int)code {
    switch (code) {
        case ERROR_NONE_: return @"ERROR_NONE";
        case ERROR_TIMEOUT: return @"ERROR_EVALUATION_TIMEUP";
        case ERROR_BADPAPERRES: return @"ERROR_WRONG_LABEL";
        case ERROR_IMAGELARGE: return @"ERROR_SET_OVER_MARGIN";
        case ERROR_CREATESTREAM: return @"ERROR_CREATE_SOCKET_FAILED";
        case ERROR_OPENSTREAM: return @"ERROR_GET_OUTPUT_STREAM_FAILED";
        case ERROR_FILENOTEXIST: return @"ERROR_FILE_NOT_FOUND";
        case ERROR_PAGERANGEERROR: return @"ERROR_INVALID_PARAMETER";
        case ERROR_NOT_SAME_MODEL_: return @"ERROR_NOT_SAME_MODEL";
        case ERROR_BROTHER_PRINTER_NOT_FOUND_: return @"ERROR_BROTHER_PRINTER_NOT_FOUND";
        case ERROR_PAPER_EMPTY_: return @"ERROR_PAPER_EMPTY";
        case ERROR_BATTERY_EMPTY_: return @"ERROR_BATTERY_EMPTY";
        case ERROR_COMMUNICATION_ERROR_: return @"ERROR_COMMUNICATION_ERROR";
        case ERROR_OVERHEAT_: return @"ERROR_OVERHEAT";
        case ERROR_PAPER_JAM_: return @"ERROR_PAPER_JAM";
        case ERROR_HIGH_VOLTAGE_ADAPTER_: return @"ERROR_HIGH_VOLTAGE_ADAPTER";
        case ERROR_CHANGE_CASSETTE_: return @"ERROR_CHANGE_CASSETTE";
        case ERROR_FEED_OR_CASSETTE_EMPTY_: return @"ERROR_FEED_OR_CASSETTE_EMPTY";
        case ERROR_SYSTEM_ERROR_: return @"ERROR_SYSTEM_ERROR";
        case ERROR_NO_CASSETTE_: return @"ERROR_NO_CASSETTE";
        case ERROR_WRONG_CASSENDTE_DIRECT_: return @"ERROR_WRONG_CASSETTE_DIRECT";
        case ERROR_CREATE_SOCKET_FAILED_: return @"ERROR_CREATE_SOCKET_FAILED";
        case ERROR_CONNECT_SOCKET_FAILED_: return @"ERROR_CONNECT_SOCKET_FAILED";
        case ERROR_GET_OUTPUT_STREAM_FAILED_: return @"ERROR_GET_OUTPUT_STREAM_FAILED";
        case ERROR_GET_INPUT_STREAM_FAILED_: return @"ERROR_GET_INPUT_STREAM_FAILED";
        case ERROR_CLOSE_SOCKET_FAILED_: return @"ERROR_CLOSE_SOCKET_FAILED";
        case ERROR_OUT_OF_MEMORY_: return @"ERROR_OUT_OF_MEMORY";
        case ERROR_SET_OVER_MARGIN_: return @"ERROR_SET_OVER_MARGIN";
        case ERROR_NO_SD_CARD_: return @"ERROR_NO_SD_CARD";
        case ERROR_FILE_NOT_SUPPORTED_: return @"ERROR_FILE_NOT_SUPPORTED";
        case ERROR_EVALUATION_TIMEUP_: return @"ERROR_EVALUATION_TIMEUP";
        case ERROR_WRONG_CUSTOM_INFO_: return @"ERROR_WRONG_CUSTOM_INFO";
        case ERROR_NO_ADDRESS_: return @"ERROR_NO_ADDRESS";
        case ERROR_NOT_MATCH_ADDRESS_: return @"ERROR_NOT_MATCH_ADDRESS";
        case ERROR_FILE_NOT_FOUND_: return @"ERROR_FILE_NOT_FOUND";
        case ERROR_TEMPLATE_FILE_NOT_MATCH_MODEL_: return @"ERROR_TEMPLATE_FILE_NOT_MATCH_MODEL";
        case ERROR_TEMPLATE_NOT_TRANS_MODEL_: return @"ERROR_TEMPLATE_NOT_TRANS_MODEL";
        case ERROR_COVER_OPEN_: return @"ERROR_COVER_OPEN";
        case ERROR_WRONG_LABEL_: return @"ERROR_WRONG_LABEL";
        case ERROR_PORT_NOT_SUPPORTED_: return @"ERROR_PORT_NOT_SUPPORTED";
        case ERROR_WRONG_TEMPLATE_KEY_: return @"ERROR_WRONG_TEMPLATE_KEY";
        case ERROR_BUSY_: return @"ERROR_BUSY";
        case ERROR_TEMPLATE_NOT_PRINT_MODEL_: return @"ERROR_TEMPLATE_NOT_PRINT_MODEL";
        case ERROR_CANCEL_: return @"ERROR_CANCEL";
        case ERROR_PRINTER_SETTING_NOT_SUPPORTED_: return @"ERROR_PRINTER_SETTING_NOT_SUPPORTED";
        case ERROR_INVALID_PARAMETER_: return @"ERROR_INVALID_PARAMETER";
        case ERROR_INTERNAL_ERROR_: return @"ERROR_INTERNAL_ERROR";
        case ERROR_TEMPLATE_NOT_CONTROL_MODEL_: return @"ERROR_TEMPLATE_NOT_CONTROL_MODEL";
        case ERROR_TEMPLATE_NOT_EXIST_: return @"ERROR_TEMPLATE_NOT_EXIST";
        case ERROR_BUFFER_FULL_: return @"ERROR_BUFFER_FULL";
        case ERROR_TUBE_EMPTY_: return @"ERROR_TUBE_EMPTY";
        case ERROR_TUBE_RIBON_EMPTY_: return @"ERROR_TUBE_RIBBON_EMPTY";
        case ERROR_MINIMUM_LENGTH_LIMIT_: return @"ERROR_MINIMUM_LENGTH_LIMIT";
        default: return @"ERROR_INTERNAL_ERROR";
    }
}

// Builds a Dart-side PrinterStatus dictionary populated with just the error
// code. Matches the shape produced by [BrotherUtils printerStatusToMapWithError:status:].
+ (NSDictionary<NSString *, NSObject *> *)printerStatusMapWithErrorName:(NSString *)errorName {
    NSDictionary<NSString *, NSObject *> * dartError = @{
        @"name": errorName,
        @"id": [[NSNumber alloc] initWithInt:(-1)]
    };

    return @{
        @"errorCode": dartError,
        @"labelId": [[NSNumber alloc] initWithInt:(-1)],
        @"labelType": [[NSNumber alloc] initWithInt:(-1)],
        @"isACConnected": @{ @"id": [[NSNumber alloc] initWithInt:(-1)], @"name": @"Unknown" },
        @"isBatteryMounted": @{ @"id": [[NSNumber alloc] initWithInt:(-1)], @"name": @"Unknown" },
        @"batteryLevel": [[NSNumber alloc] initWithInt:(-1)],
        @"batteryResidualQuantityLevel": [[NSNumber alloc] initWithInt:(-1)],
        @"maxOfBatteryResidualQuantityLevel": [[NSNumber alloc] initWithInt:(-1)],
    };
}

// Converts the dart-side Model name (e.g. "PJ_773") to the printer name
// expected by the Brother SDK (e.g. "Brother PJ-773").
+ (NSString *)brotherPrinterNameFromDartModelName:(NSString *)dartModelName {
    NSString * normalized = [dartModelName stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
    return [@"Brother " stringByAppendingString:normalized];
}

- (void)execute {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{

        NSDictionary<NSString *, NSObject *> * dartPrintInfo = self->_call.arguments[@"printInfo"];
        NSDictionary * dartSettings = self->_call.arguments[@"settings"];

        NSDictionary<NSString *, NSObject*> * dartPort = (NSDictionary<NSString *, NSObject*> *)[dartPrintInfo objectForKey:@"port"];
        BRLMChannelType channelType = [BrotherUtils portFromMapWithValue:dartPort];

        NSString * ipAddress = (NSString *)[dartPrintInfo objectForKey:@"ipAddress"];
        NSString * macAddress = (NSString *)[dartPrintInfo objectForKey:@"macAddress"];
        NSString * localName = (NSString *)[dartPrintInfo objectForKey:@"localName"];

        NSDictionary<NSString *, NSObject*> * dartModel = (NSDictionary<NSString *, NSObject*> *)[dartPrintInfo objectForKey:@"printerModel"];
        NSString * dartModelName = (NSString *)[dartModel objectForKey:@"name"];
        NSString * brotherPrinterName = [UpdatePrinterSettingsMethodCall brotherPrinterNameFromDartModelName:dartModelName];

        CONNECTION_TYPE connectionType;
        if (channelType == BRLMChannelTypeWiFi) {
            connectionType = CONNECTION_TYPE_WLAN;
        } else if (channelType == BRLMChannelTypeBluetoothMFi) {
            connectionType = CONNECTION_TYPE_BLUETOOTH;
        } else if (channelType == BRLMChannelTypeBluetoothLowEnergy) {
            connectionType = CONNECTION_TYPE_BLE;
        } else {
            connectionType = CONNECTION_TYPE_WLAN;
        }

        BRPtouchPrinter * printer = [[BRPtouchPrinter alloc] initWithPrinterName:brotherPrinterName interface:connectionType];

        if (channelType == BRLMChannelTypeWiFi) {
            [printer setIPAddress:ipAddress];
        } else if (channelType == BRLMChannelTypeBluetoothMFi) {
            [printer setupForBluetoothDeviceWithSerialNumber:macAddress];
        } else if (channelType == BRLMChannelTypeBluetoothLowEnergy) {
            [printer setBLEAdvertiseLocalName:localName];
        }

        // Build the dictionary expected by setPrinterSettings:. Keys are the
        // PrinterSettingItem enum raw values wrapped in NSNumber, values are
        // strings.
        NSMutableDictionary<NSNumber *, NSString *> * iosSettings = [NSMutableDictionary dictionaryWithCapacity:[dartSettings count]];
        for (id rawKey in dartSettings) {
            NSString * value = [dartSettings objectForKey:rawKey];
            if (![rawKey isKindOfClass:[NSDictionary class]] || ![value isKindOfClass:[NSString class]]) {
                continue;
            }
            NSDictionary<NSString *, NSObject *> * keyMap = (NSDictionary<NSString *, NSObject *> *)rawKey;
            NSNumber * settingId = (NSNumber *)[keyMap objectForKey:@"id"];
            if (settingId == nil) {
                continue;
            }
            [iosSettings setObject:value forKey:settingId];
        }

        // Open communication. BRPtouchPrinter requires this to be called
        // before setPrinterSettings:.
        BOOL connOpened = [printer startCommunication];
        if (!connOpened) {
            NSDictionary<NSString *, NSObject *> * status = [UpdatePrinterSettingsMethodCall printerStatusMapWithErrorName:@"ERROR_COMMUNICATION_ERROR"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self->_result(status);
            });
            return;
        }

        int settingResult = [printer setPrinterSettings:iosSettings];

        [printer endCommunication];

        NSString * errorName = [UpdatePrinterSettingsMethodCall errorNameForLegacyCode:settingResult];
        NSDictionary<NSString *, NSObject *> * status = [UpdatePrinterSettingsMethodCall printerStatusMapWithErrorName:errorName];

        dispatch_sync(dispatch_get_main_queue(), ^{
            self->_result(status);
        });
    });
}

@end
