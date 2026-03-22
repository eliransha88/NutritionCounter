import ProjectDescription

public extension Target {
    /// KIF-based system tests that exercise the `NutritionHome` screen-level flows —
    /// `DailyTrackerView` counter interactions, `SettingsView` navigation,
    /// goal row presence, and sheet dismissal.
    static var nutritionHomeSystemTests: Target {
        .target(
            name: "NutritionHomeSystemTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionHomeSystemTests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionHomeSystemTests/**/*.swift"],
            dependencies: [
                .target(name: "NutritionCounter"),
                .target(name: "NutritionTestsHelper"),
                .package(product: "KIF"),
            ],
            settings: .settings(base: ["OTHER_LDFLAGS": "$(inherited) -ObjC"])
        )
    }
}
