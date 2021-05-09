//
//  TbPrinterInfo.m
//  another_brother
//
//  Created by admin on 5/8/21.
//

#import <Foundation/Foundation.h>
#import "TbPrinterInfo.h"

@implementation TbPrinterInfo

- (instancetype)initWithIpAddress:(NSString*) ipAddress
                       portNumber:(NSString *) portNumber
                        btAddress: (NSString *) btAddress
                        iOSBtPath: (NSString *) iOSBtPath
                        localName: (NSString *) localName
                             port: (BRLMChannelType) port

{
    self = [super init];
    if (self) {
        _ipAddress = ipAddress;
        _portNumber = portNumber;
        _btAddress = btAddress;
        _iOSBtPath = iOSBtPath;
        _localName = localName;
        _port = port;
    }
    return self;
}

+ (TbPrinterInfo *)fromMap:(NSDictionary<NSString *,NSObject *> *)map {
    NSString * ipAddress = (NSString *) [map objectForKey:@"ipAddress"];
    NSString * portNumber = (NSString *) [map objectForKey:@"portNumber"];
    NSString * btAddress = (NSString *) [map objectForKey:@"btAddress"];
    NSString * iOSBtPath = (NSString *) [map objectForKey:@"iOSBtPath"];
    NSString * localName = (NSString *) [map objectForKey:@"localName"];
    
    NSDictionary<NSString *, NSObject*> * dartPort = (NSDictionary<NSString *, NSObject *> * )[map objectForKey:@"port"];
    
    BRLMChannelType port = [BrotherUtils portFromMapWithValue:dartPort];
    
    return [[TbPrinterInfo alloc] initWithIpAddress:ipAddress portNumber:portNumber btAddress:btAddress iOSBtPath:iOSBtPath localName:localName port:port];
    
}
@end
