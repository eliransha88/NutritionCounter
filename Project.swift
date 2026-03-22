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
        .nutritionCounterTests,
        .nutritionCounterSystemTests,
    ]
)
