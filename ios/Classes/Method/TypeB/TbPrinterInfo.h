//
//  TbPrinterInfo.h
//  another_brother
//
//  Created by admin on 5/8/21.
//

#ifndef TbPrinterInfo_h
#define TbPrinterInfo_h

#import <BRLMPrinterKit/BRLMPrinterKit.h>
#import "BrotherUtils.h"

@interface TbPrinterInfo : NSObject

@property (strong, nonatomic) NSString * ipAddress;

@property (strong, nonatomic) NSString * portNumber;

@property (strong, nonatomic) NSString * btAddress;

@property (strong, nonatomic) NSString * iOSBtPath;

@property (strong, nonatomic) NSString * localName;

@property BRLMChannelType port;

+ (TbPrinterInfo *) fromMap:(NSDictionary<NSString *, NSObject *> *) map;


@end

#endif /* TbPrinterInfo_h */
