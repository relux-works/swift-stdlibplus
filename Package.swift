// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "swift-libplus",
    platforms: [
        .iOS(.v13),
		.macOS(.v11),
		.tvOS(.v12),
		.watchOS(.v4),
		.macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "swiftlibplus",
            type: .static,
            targets: ["SwiftPlus"]
        )
    ],
    targets: [
        .target(
            name: "SwiftPlus",
            path: "Sources"
        )
    ]
)
