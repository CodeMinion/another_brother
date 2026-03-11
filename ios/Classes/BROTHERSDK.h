//
//  BROTHERSDK.h
//  another_brother
//
//  Compatibility header for Type B printer API (legacy Brother SDK).
//  Uses BRLMPrinterKit's BRPtouchPrinter when available.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BROTHERSDK : NSObject

- (BOOL)openport:(NSString *)address;
- (BOOL)openportMFI:(NSString *)path;
- (BOOL)closeport:(int)timeoutSec;

- (int)printerfont:(NSString *)x y:(NSString *)y fontName:(NSString *)fontName rotation:(NSString *)rotation magnificationRateX:(NSString *)magnificationRateX magnificationRateY:(NSString *)magnificationRateY content:(NSString *)content;
- (int)downloadpcx:(NSString *)filePath asName:(NSString *)name;
- (int)nobackfeed;
- (int)sendCommand:(NSString *)command;
- (int)barcode:(NSString *)x y:(NSString *)y barcodeType:(NSString *)barcodeType height:(NSString *)height readable:(NSString *)readable rotation:(NSString *)rotation narrow:(NSString *)narrow wide:(NSString *)wide code:(NSString *)code;
- (int)clearbuffer;
- (int)printlabel:(NSString *)quantity copies:(NSString *)copies;
- (int)formfeed;
- (int)setup:(NSString *)width height:(NSString *)height speed:(NSString *)speed density:(NSString *)density sensor:(NSString *)sensor vertical:(NSString *)vertical offset:(NSString *)offset;

- (nullable NSData *)printerstatus;

- (int)downloadbmp:(NSString *)filePath asName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
