// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SwiftATProto",
    products: [
        .library(
            name: "SwiftATProto",
            targets: ["SwiftATProto"]),
    ],
    dependencies: [
        .package(url: "https://github.com/chead/SwiftLexicon.git", from: "0.1.5"),
    ],
    targets: [
        .target(
            name: "SwiftATProto",
            dependencies: [.product(name: "SwiftLexicon", package: "SwiftLexicon")]),
        .testTarget(
            name: "SwiftATProtoTests",
            dependencies: ["SwiftATProto"]),
    ]
)
