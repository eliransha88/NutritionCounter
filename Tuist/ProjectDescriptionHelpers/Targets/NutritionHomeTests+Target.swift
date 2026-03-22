import ProjectDescription

public extension Target {
    /// Unit tests for the `NutritionHome` module.
    ///
    /// Uses `MockNutritionStoreProtocol` (Cuckoo-generated) to verify that
    /// `DailyTrackerView` and `SettingsView` interact with the store
    /// protocol correctly — method calls, argument routing, and goal reads.
    static var nutritionHomeTests: Target {
        .target(
            name: "NutritionHomeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionHomeTests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionHomeTests/**/*.swift"],
            dependencies: [
                .target(name: "NutritionHome"),
                .target(name: "NutritionCore"),
                .package(product: "Cuckoo"),
            ]
        )
    }
}
