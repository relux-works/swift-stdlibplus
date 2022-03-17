// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GalenitCoreKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "GalenitCoreKit",
            type: .dynamic,
            targets: ["GalenitCoreKit"]
        ),
    ],
    targets: [
        .target(
            name: "GalenitCoreKit",
            path: "Sources",
            exclude: [
                "PhoneUtils/PhoneNumberKit/Resources/Metadata.md",
                "PhoneUtils/PhoneNumberKit/Resources/PhoneNumberMetadata.xml"
            ],
            resources: [.copy("PhoneUtils/PhoneNumberKit/Resources/PhoneNumberMetadata.json")],
            linkerSettings: [
                .linkedFramework("CoreTelephony")
            ]
        ),
        .testTarget(
            name: "GalenitCoreKitTests",
            dependencies: ["GalenitCoreKit"],
            path: "Tests"
        ),
    ]
)
