import ProjectDescription

public extension Target {
    /// Shared test-support module for all KIF system test targets.
    ///
    /// Provides `SystemTestCase` — a Swift-friendly `KIFTestCase` subclass that
    /// exposes the `tester()` helper (KIF's `tester` macro is invisible to Swift).
    /// Re-exports KIF via `@_exported import` so consumers only need a single
    /// `import NutritionTestsHelper` to access the full KIF surface.
    static var nutritionTestsHelper: Target {
        .target(
            name: "NutritionTestsHelper",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionTestsHelper",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionTestsHelper/**/*.swift"],
            dependencies: [
                .package(product: "KIF"),
            ],
            settings: .settings(base: ["OTHER_LDFLAGS": "$(inherited) -ObjC"])
        )
    }
}
