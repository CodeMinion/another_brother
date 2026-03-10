//
//  BRLMChannelCredential.h
//  BRLMPrinterKit
//
//  Created by debug on 2025/04/03.
//  Copyright © 2025 Brother Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BRLMChannelCredentialType) {
    BRLMChannelCredentialTypePrinterAdminPassword
};

@interface BRLMChannelCredential : NSObject

@property (nonatomic, copy, readonly) NSString * _Nullable password;
@property (nonatomic, readonly) BRLMChannelCredentialType type;

- (instancetype)initWithPrinterAdminPassword:(NSString *)password;

- (instancetype)init __unavailable;
- (instancetype)copy __unavailable;

@end

NS_ASSUME_NONNULL_END
