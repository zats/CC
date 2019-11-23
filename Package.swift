// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CC",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "CC", targets: ["CC"]),
    ],
    dependencies: [
      .package(
          url: "https://github.com/zats/MathExtensions.git",
          .branch("master")
      )
    ],
    targets: [
        .target(name: "CC", dependencies: [
          "MathExtensions"
        ]),
    ]
)
