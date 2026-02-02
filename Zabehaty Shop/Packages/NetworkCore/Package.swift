
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NetworkCore",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "NetworkCore", targets: ["NetworkCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0"),
        .package(path: "../AppFoundation")
    ],
    targets: [
        .target(name: "NetworkCore", dependencies: ["Moya", "AppFoundation"])
    ]
)
