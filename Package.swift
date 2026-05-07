// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DeviceIdChecker",
    platforms: [.iOS(.v16)],
    products: [
        .executable(name: "DeviceIdChecker", targets: ["DeviceIdChecker"])
    ],
    targets: [
        .executableTarget(
            name: "DeviceIdChecker",
            path: "Sources/DeviceIdChecker"
        )
    ]
)
