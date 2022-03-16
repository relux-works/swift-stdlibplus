// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GalenIT_CoreSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "galenit.coreutils.static",
            type: .static,
            targets: ["CoreUtils"]
        ),
        .library(
            name: "galenit.coreUtils.dynamic",
            type: .dynamic,
            targets: ["CoreUtils"]
        ),
    ],
    targets: [
        .target(
            name: "CoreUtils",
            path: "Sources",
            linkerSettings: [
                .linkedFramework("CoreTelephony")
            ]
        ),
        .testTarget(
            name: "CoreUtilsTests",
            dependencies: ["CoreUtils"],
            path: "Tests"
        ),
    ]
)
