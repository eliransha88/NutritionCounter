import ProjectDescription

public extension Target {
    static var nutritionHome: Target {
        .module(
            name: "NutritionHome",
            sources: "Modules/Home/Sources/**/*.swift",
            dependencies: [
                .target(name: "NutritionCore"),
                .target(name: "NutritionUI"),
            ]
        )
    }
}
