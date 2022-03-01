// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIUtility",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "UIUtility",
            targets: ["UIUtility"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UIUtility",
            dependencies: []),
        .testTarget(
            name: "UIUtilityTests",
            dependencies: ["UIUtility"]),
    ]
)
