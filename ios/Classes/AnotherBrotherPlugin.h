#import <Flutter/Flutter.h>
#import <BROTHERSDK/BROTHERSDK.h>

@interface AnotherBrotherPlugin : NSObject<FlutterPlugin>

@property (strong, nonatomic) id<NSObject> lastNetPrinterCall;

@property (strong, nonatomic) NSMutableDictionary<NSString *, BROTHERSDK *> * mActiveTypeBPrinters;

- (void) trackTypeBPrinterWithId:(NSString *) printerId typeBPrinter: (BROTHERSDK *) typeBPrinter;

- (void) untrackTypeBPrinterWithId:(NSString *) printerId;

- (BROTHERSDK *) getTypeBPrinterWithId:(NSString *) printerId;

@end

