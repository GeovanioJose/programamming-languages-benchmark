// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "pidigits",
    targets: [
        .executableTarget(
            name: "pidigits",
            linkerSettings: [
                .linkedLibrary("gmp"),
            ]
        ),
    ]
)
