// ContentView.swift
import SwiftUI
import CryptoKit

struct ContentView: View {
    var deviceId: String {
        guard let idfv = UIDevice.current.identifierForVendor?.uuidString else {
            return "无法获取 IDFV"
        }
        let digest = Insecure.MD5.hash(data: Data(idfv.utf8))
        let hex = digest.map { String(format: "%02X", $0) }.joined()
        return String(hex.prefix(16))
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("DeviceId")
                .font(.headline)
            Text(deviceId)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.blue)
            Text("来源: IDFV MD5 前16位大写")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
