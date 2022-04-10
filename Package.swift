// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swift-jolly",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(name: "Jolly", targets: ["Jolly"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.2"),
    ],
    targets: [
        .target(name: "Jolly", dependencies: [
            .product(name: "OrderedCollections", package: "swift-collections"),
        ]),
    ]
)
