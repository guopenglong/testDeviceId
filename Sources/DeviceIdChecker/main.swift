import UIKit
import CryptoKit
import AdSupport

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func md5_16(_ input: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(input.utf8))
        let hex = digest.map { String(format: "%02X", $0) }.joined()
        return String(hex.prefix(16))
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        var results: [String] = []
        
        // 1. IDFV（已验证不对）
        if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            results.append("IDFV: \(idfv)\nMD5_16: \(md5_16(idfv))")
        }
        
        // 2. IDFA（广告标识符）
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        if idfa != "00000000-0000-0000-0000-000000000000" {
            results.append("IDFA: \(idfa)\nMD5_16: \(md5_16(idfa))")
        }
        
        // 3. IDFV 大写后 MD5
        if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            results.append("IDFV大写: \(idfv.uppercased())\nMD5_16: \(md5_16(idfv.uppercased()))")
        }
        
        // 4. IDFV 去掉横杠
        if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            let noDash = idfv.replacingOccurrences(of: "-", with: "")
            results.append("IDFV无横杠: \(noDash)\nMD5_16: \(md5_16(noDash))")
        }
        
        // 5. IDFV 小写
        if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            results.append("IDFV小写: \(idfv.lowercased())\nMD5_16: \(md5_16(idfv.lowercased()))")
        }
        
        let message = results.joined(separator: "\n\n")
        print(message)
        
        let alert = UIAlertController(title: "所有可能输入源", message: message, preferredStyle: .alert)
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
