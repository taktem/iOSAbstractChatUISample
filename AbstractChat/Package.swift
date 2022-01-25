// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AbstractChat",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "AbstractChat",
            targets: ["AbstractChat"]),
    ],
    dependencies: [
        .package(url: "../UIUtility", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "AbstractChat",
            dependencies: ["UIUtility"]
        ),
        .testTarget(
            name: "AbstractChatTests",
            dependencies: ["AbstractChat"]),
    ]
)
