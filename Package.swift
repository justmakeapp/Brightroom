// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "Brightroom",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(name: "BrightroomEngine", targets: ["BrightroomUI"]),
    .library(name: "BrightroomUI", targets: ["BrightroomUI"]),
    .library(name: "BrightroomUIPhotosCrop", targets: ["BrightroomUIPhotosCrop"])
  ],
  dependencies: [
    .package(path: "../swift-verge"),
    .package(url: "https://github.com/FluidGroup/TransitionPatch", from: "1.0.3"),
    .package(url: "https://github.com/FluidGroup/PrecisionLevelSlider", from: "2.1.0"),
  ],
  targets: [
    .target(
      name: "BrightroomEngine",
      dependencies: [
        .product(name: "Verge", package: "swift-verge"),
      ]
    ),
    .target(
      name: "BrightroomUI",
      dependencies: [
        "BrightroomEngine",
        .product(name: "Verge", package: "swift-verge"),
        "TransitionPatch"
      ]
    ),
    .target(
      name: "BrightroomUIPhotosCrop",
      dependencies: ["BrightroomUI", "PrecisionLevelSlider"]
    )
  ]
)
