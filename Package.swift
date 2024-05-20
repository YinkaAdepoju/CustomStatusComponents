// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "CustomStatusComponents",
    platforms: [
        .iOS(.v17),
        .macOS(.v10_15) // Add macOS support
    ],
    products: [
        .library(
            name: "CustomStatusComponents",
            targets: ["CustomStatusComponents"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CustomStatusComponents",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "CustomStatusComponentsTests",
            dependencies: ["CustomStatusComponents"],
            path: "Tests"),
    ]
)
