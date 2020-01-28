#import "FlutterKountPlugin.h"
#if __has_include(<flutter_kount/flutter_kount-Swift.h>)
#import <flutter_kount/flutter_kount-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_kount-Swift.h"
#endif

@implementation FlutterKountPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterKountPlugin registerWithRegistrar:registrar];
}
@end
