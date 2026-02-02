// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Modules", targets: ["Modules"])
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0"),
        .package(path: "../AppFoundation"),
        .package(path: "../NetworkCore"),
        .package(path: "../DomainModels"),
    ],
    targets: [
        .target(name: "Modules", dependencies: [
            "NetworkCore",
            "DomainModels",
            "Moya",
            "AppFoundation"]),
        .testTarget(name: "ModulesTests",dependencies: ["Modules"])
    ]
)
