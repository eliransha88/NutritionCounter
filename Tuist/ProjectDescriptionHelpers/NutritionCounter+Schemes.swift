import ProjectDescription

/// Shared Xcode schemes wired to unit vs system test plans (`TestPlans/*.xctestplan`).
public enum NutritionCounterSchemes {
    public static var all: [Scheme] {
        [
            mainScheme,
            unitScheme,
            systemScheme,
        ]
    }

    private static let unitTestPlan = Path.relativeToManifest("TestPlans/NutritionCounter-Unit.xctestplan")
    private static let systemTestPlan = Path.relativeToManifest("TestPlans/NutritionCounter-System.xctestplan")

    private static let appBuildTargets: [TargetReference] = [
        .target("NutritionCounter"),
    ]

    /// Default app scheme with both test plans (first plan is the default in Xcode).
    private static var mainScheme: Scheme {
        .scheme(
            name: "NutritionCounter",
            shared: true,
            buildAction: .buildAction(targets: appBuildTargets),
            testAction: .testPlans(
                [unitTestPlan, systemTestPlan]
            ),
            runAction: .runAction(executable: .target("NutritionCounter")),
            archiveAction: .archiveAction(configuration: .release, revealArchiveInOrganizer: true)
        )
    }

    private static var unitScheme: Scheme {
        .scheme(
            name: "NutritionCounter-Unit",
            shared: true,
            buildAction: .buildAction(targets: appBuildTargets),
            testAction: .testPlans(
                [unitTestPlan]
            ),
            runAction: .runAction(executable: .target("NutritionCounter")),
            archiveAction: .archiveAction(configuration: .release, revealArchiveInOrganizer: true)
        )
    }

    private static var systemScheme: Scheme {
        .scheme(
            name: "NutritionCounter-System",
            shared: true,
            buildAction: .buildAction(targets: appBuildTargets),
            testAction: .testPlans(
                [systemTestPlan]
            ),
            runAction: .runAction(executable: .target("NutritionCounter")),
            archiveAction: .archiveAction(configuration: .release, revealArchiveInOrganizer: true)
        )
    }
}
