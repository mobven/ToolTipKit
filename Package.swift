// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "ToolTipKit",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "ToolTipKit",
            targets: ["ToolTipKit"]
        ),
        .library(
            name: "TooltipKitUI",
            targets: ["TooltipKitUI"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ToolTipKit",
            dependencies: []
        ),
        .target(
            name: "TooltipKitUI",
            dependencies: []
        ),
        .testTarget(
            name: "ToolTipKitTests",
            dependencies: ["ToolTipKit"]
        )
    ]
)
