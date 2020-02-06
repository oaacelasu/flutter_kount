#import "FlutterKountPlugin.h"
#import "../Library/KDataCollector.h"
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
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_kount"
            binaryMessenger:[registrar messenger]];
  FlutterKountPlugin* instance = [[FlutterKountPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
      // Note: this method is invoked on the UI thread.
   //[[KDataCollector sharedCollector] setMerchantID:<MERCHANT_ID>];
  dispatch_async(dispatch_get_main_queue(), ^{
      [[KDataCollector sharedCollector] setMerchantID:500005];
      [[KDataCollector sharedCollector] setLocationCollectorConfig:KLocationCollectorConfigRequestPermission];
   // For Test Environment
      [[KDataCollector sharedCollector] setEnvironment:KEnvironmentTest];
     // [[KDataCollector sharedCollector] merchantID:@"500005"];
   // For Production Environment
   //[[KDataCollector sharedCollector] setEnvironment:KEnvironmentProduction];
       CFUUIDRef uuidRef = CFUUIDCreate(nil);
       CFStringRef uuidStrRef = CFUUIDCreateString(nil, uuidRef);
       CFRelease(uuidRef);
       NSString *sessionID = [(__bridge NSString *)uuidStrRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
      [[KDataCollector sharedCollector] collectForSession:sessionID
                                               completion:^(NSString * _Nonnull sessionID,
                                                            BOOL success,
                                                            NSError * _Nullable error) {
          if(success){
                                                            result(sessionID);

                                                            }else{

                                                            result([error description]);

                                                            }
        // Add handler code here if desired. The completion block is optional.
      }];
});
}

@end
