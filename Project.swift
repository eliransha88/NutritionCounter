import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "NutritionCounter",
    organizationName: ProjectConstants.organizationName,
    packages: .testPackages,
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
