// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "galenit-coreutils",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "GalenitCoreUtils",
            type: .dynamic,
            targets: ["GalenitCoreUtils"]
        ),
    ],
    targets: [
        .target(
            name: "GalenitCoreUtils",
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
            name: "GalenitCoreUtilsTests",
            dependencies: ["GalenitCoreUtils"],
            path: "Tests"
        ),
    ]
)
