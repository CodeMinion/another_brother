import Flutter
import UIKit
import BRPtouchPrinterKit


public class SwiftAnotherBrotherPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "another_brother", binaryMessenger: registrar.messenger())
    let instance = SwiftAnotherBrotherPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let printer = BRPtouchPrinter(printerName: "PT-P900W", interface: .WLAN)
    
    if call.method == "getPlatformVersion" {
        result("iOS " + UIDevice.current.systemVersion)
    }
    else {
        
        result(FlutterMethodNotImplemented)
    }
  }
}
