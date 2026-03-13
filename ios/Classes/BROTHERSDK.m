//
//  BROTHERSDK.m
//  another_brother
//
//  Type B API compatibility layer using BRLMPrinterKit BRPtouchPrinter.
//

#import "BROTHERSDK.h"
#import <BRLMPrinterKit/BRLMPrinterKit.h>
#import <BRLMPrinterKit/BRPtouchPrinter.h>

@interface BROTHERSDK ()
@property (nonatomic, strong, nullable) BRPtouchPrinter *printer;
@end

@implementation BROTHERSDK

- (BOOL)openport:(NSString *)address {
    if (!address.length) return NO;
    _printer = [[BRPtouchPrinter alloc] initWithPrinterIPAddress:address];
    return [_printer startCommunication];
}

- (BOOL)openportMFI:(NSString *)path {
    if (!path.length) return NO;
    _printer = [[BRPtouchPrinter alloc] initWithPrinterName:@"" interface:CONNECTION_TYPE_BLUETOOTH];
    [_printer setupForBluetoothDeviceWithSerialNumber:path];
    return [_printer startCommunication];
}

- (BOOL)closeport:(int)timeoutSec {
    (void)timeoutSec;
    if (_printer) {
        [_printer endCommunication];
        _printer = nil;
    }
    return YES;
}

- (int)printerfont:(NSString *)x y:(NSString *)y fontName:(NSString *)fontName rotation:(NSString *)rotation magnificationRateX:(NSString *)magnificationRateX magnificationRateY:(NSString *)magnificationRateY content:(NSString *)content {
    (void)x; (void)y; (void)fontName; (void)rotation; (void)magnificationRateX; (void)magnificationRateY; (void)content;
    if (!_printer) return 0;
    // BRPtouchPrinter has replaceText/replaceTextName - no direct printerfont equivalent; return unsupported
    return 0;
}

- (int)downloadpcx:(NSString *)filePath asName:(NSString *)name {
    (void)filePath; (void)name;
    if (!_printer) return 0;
    return 0;
}

- (int)nobackfeed {
    if (!_printer) return 0;
    return 0;
}

- (int)sendCommand:(NSString *)command {
    if (!_printer || !command) return 0;
    NSData *data = [command dataUsingEncoding:NSUTF8StringEncoding];
    return (int)[_printer sendData:data];
}

- (int)barcode:(NSString *)x y:(NSString *)y barcodeType:(NSString *)barcodeType height:(NSString *)height readable:(NSString *)readable rotation:(NSString *)rotation narrow:(NSString *)narrow wide:(NSString *)wide code:(NSString *)code {
    (void)x; (void)y; (void)barcodeType; (void)height; (void)readable; (void)rotation; (void)narrow; (void)wide; (void)code;
    if (!_printer) return 0;
    return 0;
}

- (int)clearbuffer {
    if (!_printer) return 0;
    return 0;
}

- (int)printlabel:(NSString *)quantity copies:(NSString *)copies {
    (void)quantity; (void)copies;
    if (!_printer) return 0;
    return 0;
}

- (int)formfeed {
    if (!_printer) return 0;
    return 0;
}

- (int)setup:(NSString *)width height:(NSString *)height speed:(NSString *)speed density:(NSString *)density sensor:(NSString *)sensor vertical:(NSString *)vertical offset:(NSString *)offset {
    (void)width; (void)height; (void)speed; (void)density; (void)sensor; (void)vertical; (void)offset;
    if (!_printer) return 0;
    return 0;
}

- (NSData *)printerstatus {
    if (!_printer) return nil;
    BRPtouchPrinterStatus *__autoreleasing status = nil;
    int ret = [_printer getStatus:&status];
    if (ret != 0 || !status) {
        unsigned char err = 0x80;
        return [NSData dataWithBytes:&err length:1];
    }
    // Caller expects at least one byte (e.g. status code); minimal placeholder
    unsigned char code = 0x00;
    return [NSData dataWithBytes:&code length:1];
}

- (int)downloadbmp:(NSString *)filePath asName:(NSString *)name {
    (void)filePath; (void)name;
    if (!_printer) return 0;
    return 0;
}

@end
