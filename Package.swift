// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TelegramTextureChat",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "TelegramTextureChat", targets: ["TelegramTextureChat"])
    ],
    dependencies: [
        .package(url: "https://github.com/TextureGroup/Texture.git", from: "3.2.0")
    ],
    targets: [
        .target(
            name: "TelegramTextureChat",
            dependencies: [.product(name: "Texture", package: "Texture")],
            path: "Sources/TelegramTextureChat"
        )
    ]
)
