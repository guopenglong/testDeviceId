import UIKit
import CryptoKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 生成 DeviceId
        let idfv = UIDevice.current.identifierForVendor?.uuidString ?? "未知"
        let digest = Insecure.MD5.hash(data: Data(idfv.utf8))
        let hex = digest.map { String(format: "%02X", $0) }.joined()
        let deviceId = String(hex.prefix(16))
        
        let message = "IDFV:\n\(idfv)\n\nDeviceId:\n\(deviceId)"
        print(message)
        
        // 弹窗
        let alert = UIAlertController(title: "DeviceId", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "复制", style: .default) { _ in
            UIPasteboard.general.string = deviceId
        })
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        vc.present(alert, animated: true)
        
        return true
    }
}

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(AppDelegate.self)
)
