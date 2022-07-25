import Flutter
import UIKit

public class SwiftFlutterEloClientPlugin: NSObject, FlutterPlugin {
  
  private let service: HttpService

  init(service: HttpService = HttpServiceImpl()) {
        self.service = service
    }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_elo_client", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterEloClientPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "request") {
      DispatchQueue.main.async {
        makeRequest(call, result)
      }
    } else {
        result(FlutterMethodNotImplemented)
    }
  }

   private func makeRequest(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
    var param = Params.init(
      path: call.arguments["path"] as! String,
      body: call.arguments["body"] as! [String: Any],
      headers: call.arguments["headers"] as! [String: Any],
      method: call.arguments["method"] as! String,
      queryParams: call.arguments["queryParams"] as! [String: Any] 
    )

    service.makeRequest(endpoint: "", parameters: nil) { response in
      DispatchQueue.main.async {
        result(response)
      }
    }

    // result()
  }
}
