import ProjectDescription

public extension Target {
    static var nutritionCore: Target {
        .module(
            name: "NutritionCore",
            sources: "Modules/Core/Sources/**/*.swift",
            resources: ["Modules/Core/Resources/**"]
        )
    }
}
