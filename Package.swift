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
        .library(
            name: "DarwellPerdux",
            type: .dynamic,
            targets: ["DarwellPerdux"]
        ),
        .library(
            name: "ConsoleLogger",
            type: .dynamic,
            targets: ["ConsoleLogger"]
        )
    ],
    dependencies: Package.remoteDependencies,
    targets: [
        .target(
            name: "DarwellPerdux",
            dependencies: [
                .productItem(name: "Perdux", package: "darwin-perdux", condition: .none),
                .productItem(name: "Logger", package: "darwin-logger", condition: .none),
            ],
            path: "DarwellPerdux"
        ),
        .target(
            name: "ConsoleLogger",
            dependencies: [
                .productItem(name: "Logger", package: "darwin-logger", condition: .none),
            ],
            path: "ConsoleLogger"
        ),
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

// MARK: -- Dependencies
extension Package {
    static var remoteDependencies: [Package.Dependency] {
        [
            .package(url: "git@github.com:galen-it/darwin-perdux.git", from: "0.1.0"),
            .package(url: "git@github.com:galen-it/darwin-logger.git", from: "0.1.0"),
        ]
    }

//    static var coreDependencies: [Target.Dependency] {
//        [
//            .product(name: "Logger", package: "darwin-logger"),
//        ]
//    }
}
