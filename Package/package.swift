// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let Actomaton = Target.Dependency.product(name: "Actomaton", package: "actomaton")
let ActomatonUI = Target.Dependency.product(name: "ActomatonUI", package: "actomaton")

let package = Package(
    name: "Libraries",
    platforms: [.iOS(.v16)],
    products: [
        // Core
        .library(name: "Model", targets: ["Model"]),
        .library(name: "API", targets: ["API"]),
        .library(name: "FeatureProvider", targets: ["FeatureProvider"]),
        // Design
        .library(name: "DesignCore", targets: ["DesignCore"]),

        // Features
        .library(name: "Timeline", targets: ["Timeline"]),
        .library(name: "EditProfile", targets: ["EditProfile"]),
    ],
    dependencies: [
        // .package(name: "APIKit", url: "https://github.com/ishkawa/APIKit", from: "5.2.0")
        .package(url: "https://github.com/Actomaton/Actomaton", branch: "main")
    ],
    targets: [
        // Core
        .target(name: "Model", path: "Sources/Core/Model"),
        .target(name: "API", dependencies: ["Model"], path: "Sources/Core/API"),
        .target(name: "FeatureInterface", path: "Sources/Core/FeatureInterface"),
        .target(name: "FeatureProvider", dependencies: ["Model", "FeatureInterface"], path: "Sources/Core/FeatureProvider"),

        // Design
        .target(name: "DesignCore"),
        
        // Features
        .target(name: "Timeline", dependencies: [Actomaton, ActomatonUI, "Model", "API"], path: "Sources/Feature/Timeline"),
        .target(name: "EditProfile", dependencies: [Actomaton, ActomatonUI, "Model", "API"], path: "Sources/Feature/EditProfile"),
    ]
)


