// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TelegramTextureChat",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "TelegramTextureChat", targets: ["TelegramTextureChat"])
    ],
    dependencies: [
        .package(url: "https://github.com/dychanny/texture-SPM.git", branch: "master")
    ],
    targets: [
        .target(
            name: "TelegramTextureChat",
            dependencies: [.product(name: "AsyncDisplayKit", package: "texture-SPM")],
            path: "Sources/TelegramTextureChat"
        )
    ]
)
