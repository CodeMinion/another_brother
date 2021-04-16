//
//  BrotherManager.m
//  another_brother
//
//  Created by admin on 4/11/21.
//

#import <Foundation/Foundation.h>
#import "BrotherManager.h"

@implementation BrotherManager

+ (BrotherManager *)instance {
    static BrotherManager *sharedClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClass = [[self alloc] init];
    });
    return sharedClass;
}

- (id)init {
    if (self = [super init]) {
        mActivePrinters = [[NSMutableDictionary alloc]initWithCapacity:10];
        //mActivePrinters = @{};
    }
    return self;
}

- (BRLMPrinterDriver *)getPrinterWithValue:(NSString *) printerId {
    return [mActivePrinters objectForKey:printerId];
}

- (void) trackPrinterWithFirstValue: (NSString *) printerId secondValue: (BRLMPrinterDriver*) printer {
    [mActivePrinters setObject:printer forKey:printerId];
}

- (void) untrackPrinterWithValue:(NSString *) printerId {
    [mActivePrinters removeObjectForKey:printerId];
}

@end
