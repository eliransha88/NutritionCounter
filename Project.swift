import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "NutritionCounter",
    organizationName: ProjectConstants.organizationName,
    targets: [
        .nutritionCore,
        .nutritionUI,
        .nutritionHome,
        .nutritionCounter,
        .nutritionAppWidget,
    ]
)
