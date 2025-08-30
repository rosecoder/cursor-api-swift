// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "cursor-api-swift",
    products: [
        .library(
            name: "CursorAPI",
            targets: ["CursorAPI"]
        )
    ],
    targets: [
        .target(name: "CursorAPI"),
        .testTarget(
            name: "CursorAPITests",
            dependencies: ["CursorAPI"]
        ),
    ]
)
