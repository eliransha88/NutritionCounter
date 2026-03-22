import ProjectDescription

public extension Target {
    /// KIF-based system tests that exercise individual `NutritionUI` components
    /// — `NutrientCounterView` increment / decrement interactions and
    /// accessibility of all counter cards.
    static var nutritionUISystemTests: Target {
        .target(
            name: "NutritionUISystemTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionUISystemTests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionUISystemTests/**/*.swift"],
            dependencies: [
                .target(name: "NutritionCounter"),
                .target(name: "NutritionTestsHelper"),
                .package(product: "KIF"),
            ],
            settings: .settings(base: ["OTHER_LDFLAGS": "$(inherited) -ObjC"])
        )
    }
}
