// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let Actomaton = Target.Dependency.product(name: "Actomaton", package: "actomaton")
let ActomatonUI = Target.Dependency.product(name: "ActomatonUI", package: "actomaton")

let package = Package(
    name: "Libraries",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Design", targets: ["Design"]),
        .library(name: "Timeline", targets: ["Timeline"]),
        .library(name: "EditProfile", targets: ["EditProfile"]),
        // // AppCore
        // .library(name: "AppCore", type: .static, targets: ["API", "UserDefaults", "FeatureInterfaces"]),
        // .library(name: "API", type: .static, targets: ["API"]),
        // .library(name: "UserDefaults", type: .static, targets: ["UserDefaults"]),
        // .library(name: "FeatureInterfaces", type: .static, targets: ["FeatureInterfaces"]),
        // // FeatureProvider
        // .library(name: "FeatureProvider", type: .static, targets: ["FeatureProvider"]),
    ],
    dependencies: [
        // .package(name: "APIKit", url: "https://github.com/ishkawa/APIKit", from: "5.2.0")
        .package(url: "https://github.com/Actomaton/Actomaton", branch: "main")
    ],
    targets: [
        // Core
        .target(name: "Model"),
        .target(name: "FeatureInterface"),
        .target(name: "FeatureProvider", dependencies: ["Model", "FeatureInterface"]),

        // Design
        .target(name: "Design"),
        
        // Features
        .target(name: "Timeline", dependencies: [Actomaton, ActomatonUI, "Model"], path: "Sources/Feature/Timeline"),
        .target(name: "EditProfile", dependencies: [Actomaton, ActomatonUI, "Model"], path: "Sources/Feature/EditProfile"),
         // FeatureProvider
        // .target(
        //     name: "FeatureProvider",
        //     dependencies: [
        //         "API", "UserDefaults", "FeatureInterfaces", "Home", "Detail", "Profile", "Setting"
        //     ]
        // ),
    ]
)


