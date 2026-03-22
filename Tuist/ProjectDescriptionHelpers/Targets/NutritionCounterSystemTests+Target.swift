import ProjectDescription

public extension Target {
    /// KIF-based system tests that drive the app via the accessibility layer.
    /// The target is a UITest bundle so Xcode launches NutritionCounter as its host.
    static var nutritionCounterSystemTests: Target {
        .target(
            name: "NutritionCounterSystemTests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionCounterSystemTests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionCounterSystemTests/**/*.swift"],
            dependencies: [
                .target(name: "NutritionCounter"),
                .package(product: "KIF"),
            ]
        )
    }
}
