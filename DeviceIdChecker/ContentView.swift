import SwiftUI
import CryptoKit

struct ContentView: View {
    func getDeviceId() -> String {
        guard let idfv = UIDevice.current.identifierForVendor?.uuidString else {
            return "无法获取 IDFV"
        }
        let digest = Insecure.MD5.hash(data: Data(idfv.utf8))
        let hex = digest.map { String(format: "%02X", $0) }.joined()
        return String(hex.prefix(16))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("给你生成的DeviceId:")
                .font(.headline)
            
            Text(getDeviceId())
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .foregroundColor(.blue)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            
            Text("IDFV: \(UIDevice.current.identifierForVendor?.uuidString ?? "无")")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("算法: MD5(IDFV) 取前16位大写")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
