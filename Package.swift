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
            name: "CoreUtils",
            dependencies: [
                "DarwellPerdux",
                "ConsoleLogger",
                "GalenitCoreUtils",
            ],
            path: "_Export"
        ),
        .target(
            name: "DarwellPerdux",
            dependencies: Package.perduxDependencies,
            path: "DarwellPerdux"
        ),
        .target(
            name: "ConsoleLogger",
            dependencies: Package.consoleLoggerDependencies,
            path: "ConsoleLogger"
        ),
        .target(
            name: "GalenitCoreUtils",
            dependencies: Package.coreUtilsDependencies,
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
            .package(url: "git@github.com:galen-it/darwin-perdux.git", from: "0.2.0"),
            .package(url: "git@github.com:galen-it/darwin-logger.git", from: "0.1.1"),
        ]
    }

    static var consoleLoggerDependencies: [Target.Dependency] {
        [
            .product(name: "Logger", package: "darwin-logger", condition: .none),
        ]
    }
    
    static var coreUtilsDependencies: [Target.Dependency] {
        [
            .product(name: "Logger", package: "darwin-logger", condition: .none),
        ]
    }
    
    static var perduxDependencies: [Target.Dependency] {
        [
            .productItem(name: "Perdux", package: "darwin-perdux", condition: .none),
            .productItem(name: "Logger", package: "darwin-logger", condition: .none),
        ]
    }
}
