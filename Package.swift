// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "swift-utils",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftUtils",
            type: .dynamic,
            targets: ["SwiftUtils"]
        )
    ],
    targets: [
        .target(
            name: "SwiftUtils",
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
            name: "SwiftUtilsTests",
            dependencies: ["SwiftUtils"],
            path: "Tests"
        ),
    ]
)
