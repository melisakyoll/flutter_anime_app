import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var methodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("rootViewController is not type FlutterViewController")
    }
    methodChannel = FlutterMethodChannel(name: "com.example.flutter_anime_list/channel",
                                         binaryMessenger: controller.binaryMessenger)

    methodChannel?.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Check if method call is fetchAnimeData
      if call.method == "fetchAnimeData" {
        self.triggerFetchInFlutter()
        result(nil) // You can return some data or confirmation if necessary
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func triggerFetchInFlutter() {
    methodChannel?.invokeMethod("triggerFetchInFlutter", arguments: nil)
  }
}