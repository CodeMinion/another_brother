//
//  GetPdfFilePagesMethodCall.h
//  another_brother
//
//  Created by Frank Hernandez on 11/26/22.
//

#ifndef GetPdfFilePagesMethodCall_h
#define GetPdfFilePagesMethodCall_h

#import <Flutter/Flutter.h>
#import "BrotherUtils.h"

@interface GetPdfFilePagesMethodCall : NSObject

@property (strong, nonatomic) FlutterMethodCall* call;
@property (strong, nonatomic) FlutterResult result;
@property (class, nonatomic, assign, readonly) NSString * METHOD_NAME;

- (instancetype)initWithCall:(FlutterMethodCall *)call
                  result:(FlutterResult) result;

- (void) execute;
@end


#endif /* GetPdfFilePagesMethodCall_h */
