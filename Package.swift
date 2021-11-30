// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DBChainSm2",
    products: [
        .library(
            name: "DBChainSm2", targets: ["DBChainSm2"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "DBChainSm2",dependencies: ["openssl"],path:"DBChainSm2"),
        .binaryTarget(name: "openssl", path: "XCFrameworks/openssl.xcframework")
    ]
)
