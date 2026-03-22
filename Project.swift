import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "NutritionCounter",
    organizationName: ProjectConstants.organizationName,
    packages: .testPackages,
    settings: .settings(base: [
        "SWIFT_EMIT_LOC_STRINGS": "YES",
        "STRING_CATALOG_GENERATE_SYMBOLS": "YES",
    ]),
    targets: [
        .nutritionCore,
        .nutritionUI,
        .nutritionHome,
        .nutritionCounter,
        .nutritionAppWidget,
        .nutritionTestsHelper,

        // MARK: - NutritionCore tests
        .nutritionCoreTests,
        .nutritionCoreSystemTests,

        // MARK: - NutritionUI tests
        .nutritionUITests,
        .nutritionUISystemTests,

        // MARK: - NutritionHome tests
        .nutritionHomeTests,
        .nutritionHomeSystemTests,

    ]
)
