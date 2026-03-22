import ProjectDescription

public extension Target {
    /// KIF-based system tests that verify the Core data layer is correctly
    /// integrated — the store initialises, persists, and surfaces data to the UI.
    static var nutritionCoreSystemTests: Target {
        .target(
            name: "NutritionCoreSystemTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionCoreSystemTests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionCoreSystemTests/**/*.swift"],
            dependencies: [
                .target(name: "NutritionCounter"),
                .target(name: "NutritionTestsHelper"),
                .package(product: "KIF"),
            ],
            settings: .settings(base: ["OTHER_LDFLAGS": "$(inherited) -ObjC"])
        )
    }
}
