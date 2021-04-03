#import "AnotherBrotherPlugin.h"
#if __has_include(<another_brother/another_brother-Swift.h>)
#import <another_brother/another_brother-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "another_brother-Swift.h"
#endif

@implementation AnotherBrotherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnotherBrotherPlugin registerWithRegistrar:registrar];
}
@end
