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

+ (BRLMChannelType) portFromMapWithValue:(NSMutableDictionary<NSString *, NSObject *>*) map;

+ (BRLMPrinterModel) modelFromMapWithValue:(NSDictionary<NSString *, NSObject *>*) map;

@end
/*
@interface  BRLMChannelType (BRLMChannelTypeEncoding)
- (NSMutableDictionary<NSString *, NSObject *>)toMap;
@end
*/



#endif /* BrotherUtils_h */
