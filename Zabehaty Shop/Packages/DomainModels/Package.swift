
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DomainModels",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DomainModels", targets: ["DomainModels"])
    ],
    targets: [
        .target(name: "DomainModels")
    ]
)
