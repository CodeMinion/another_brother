//
//  BrotherManager.h
//  another_brother
//
//  Created by admin on 4/11/21.
//

#ifndef BrotherManager_h
#define BrotherManager_h

// TODO Move this to it's own header
#import <BRLMPrinterKit/BRLMPrinterKit.h>

@interface BrotherManager : NSObject {
    NSMutableDictionary<NSString *, BRLMPrinterDriver *> * mActivePrinters;
    
    //- (void)someMethodWithValue:(SomeType)value;

    
}
+ (BrotherManager *)instance;

- (BRLMPrinterDriver *)getPrinterWithValue:(NSString *) printerId;

- (void) trackPrinterWithFirstValue: (NSString *) printerId secondValue: (BRLMPrinterDriver*) printer;

- (void) untrackPrinterWithValue:(NSString *) printerId;

@end
#endif /* BrotherManager_h */
