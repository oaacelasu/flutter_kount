import Flutter
import UIKit


//#import "KDataCollector.h"

public class SwiftFlutterKountPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_kount", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterKountPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    //result(UUID().uuidString.replacingOccurrences(of: "-", with: ""))

   // let deviceCollector:KDataCollector = KDataCollector.shared()

   // deviceCollector.environment = KEnvironment.test

   //        let sessioniD = UUID().uuidString.replacingOccurrences(of: "-", with: "")

   //         collect(sessioniD) { (error) in

       //     }
   //         result(sessioniD)

  }
}
