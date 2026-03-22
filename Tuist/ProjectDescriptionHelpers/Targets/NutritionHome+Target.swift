import ProjectDescription

public extension Target {
    static var nutritionHome: Target {
        .module(
            name: "NutritionHome",
            sources: "Modules/Home/Sources/**/*.swift",
            resources: ["Modules/Home/Resources/**"],
            dependencies: [
                .target(name: "NutritionCore"),
                .target(name: "NutritionUI"),
            ]
        )
    }
}
