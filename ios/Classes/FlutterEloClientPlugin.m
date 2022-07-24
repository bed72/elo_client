#import "FlutterEloClientPlugin.h"
#if __has_include(<flutter_elo_client/flutter_elo_client-Swift.h>)
#import <flutter_elo_client/flutter_elo_client-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_elo_client-Swift.h"
#endif

@implementation FlutterEloClientPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterEloClientPlugin registerWithRegistrar:registrar];
}
@end
