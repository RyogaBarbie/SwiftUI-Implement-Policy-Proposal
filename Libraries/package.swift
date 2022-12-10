// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Libraries",
    platforms: [.iOS(.v16)],
    products: [
        // // AppCore
        // .library(name: "AppCore", type: .static, targets: ["API", "UserDefaults", "FeatureInterfaces"]),
        // .library(name: "API", type: .static, targets: ["API"]),
        // .library(name: "UserDefaults", type: .static, targets: ["UserDefaults"]),
        // .library(name: "FeatureInterfaces", type: .static, targets: ["FeatureInterfaces"]),
        // // Features
        // .library(name: "Features", type: .static, targets: ["Home", "Detail", "Profile", "Setting"]),
        // .library(name: "Home", type: .static, targets: ["Home"]),
        // .library(name: "Detail", type: .static, targets: ["Detail"]),
        // .library(name: "Profile", type: .static, targets: ["Profile"]),
        // .library(name: "Setting", type: .static, targets: ["Setting"]),
        // .library(name: "User", type: .static, targets: ["Profile", "Setting"]),
        // // FeatureProvider
        // .library(name: "FeatureProvider", type: .static, targets: ["FeatureProvider"]),
    ],
    dependencies: [
        // .package(name: "APIKit", url: "https://github.com/ishkawa/APIKit", from: "5.2.0")
    ],
    targets: [
        // // AppCore
        // .target(name: "API", dependencies: ["APIKit"]),
        // .target(name: "UserDefaults"),
        // .target(name: "FeatureInterfaces"),
        // // Features
        // .target(name: "Home", dependencies: ["API", "UserDefaults", "FeatureInterfaces"]),
        // .target(name: "Detail", dependencies: ["API", "UserDefaults", "FeatureInterfaces"]),
        // .target(name: "Profile", dependencies: ["API", "UserDefaults", "FeatureInterfaces"]),
        // .target(name: "Setting", dependencies: ["API", "UserDefaults", "FeatureInterfaces"]),
        // // FeatureProvider
        // .target(
        //     name: "FeatureProvider",
        //     dependencies: [
        //         "API", "UserDefaults", "FeatureInterfaces", "Home", "Detail", "Profile", "Setting"
        //     ]
        // ),
    ]
)
