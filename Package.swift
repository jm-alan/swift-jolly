// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "swift-jolly",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(name: "Jolly", targets: ["Jolly"]),
        .library(name: "Jest", targets: ["Jest"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-collections.git",
            from: "1.0.2"
        )
    ],
    targets: [
        .target(name: "Jolly", dependencies: [
            .product(name: "OrderedCollections", package: "swift-collections"),
        ]),
        .target(name: "Jest", dependencies: ["Jolly"]),
        .testTarget(name: "JollyTests", dependencies: ["Jolly", "Jest"]),
    ]
)
