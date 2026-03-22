import ProjectDescription

public extension Target {
    /// Unit tests for the `NutritionUI` module.
    ///
    /// Covers `NutrientConfig`, `NutrientType` UI properties (colours, labels),
    /// and accessibility-label conventions used by KIF system tests.
    static var nutritionUITests: Target {
        .target(
            name: "NutritionUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionUITests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionUITests/**/*.swift"],
            dependencies: [
                .target(name: "NutritionUI"),
                .target(name: "NutritionCore"),
            ]
        )
    }
}
