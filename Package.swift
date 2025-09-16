// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "cursor-api-swift",
  platforms: [
    .macOS(.v15),
    .iOS(.v18),
  ],
  products: [
    .library(
      name: "CursorAPI",
      targets: ["CursorAPI"]
    ),
    .library(
      name: "CursorAPITesting",
      targets: ["CursorAPITesting"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-distributed-tracing.git", from: "1.2.0"),
    .package(url: "https://github.com/apple/swift-log", from: "1.6.0"),
    .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.9.0"),
    .package(url: "https://github.com/swift-server/swift-service-lifecycle.git", from: "2.0.0"),
  ],
  targets: [
    .target(
      name: "CursorAPI",
      dependencies: [
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        .product(name: "Logging", package: "swift-log"),
        .product(name: "ServiceLifecycle", package: "swift-service-lifecycle"),
        .product(name: "Tracing", package: "swift-distributed-tracing"),
      ]
    ),
    .target(
      name: "CursorAPITesting",
      dependencies: ["CursorAPI"]
    ),
    .testTarget(
      name: "CursorAPITests",
      dependencies: ["CursorAPI"]
    ),
  ]
)
