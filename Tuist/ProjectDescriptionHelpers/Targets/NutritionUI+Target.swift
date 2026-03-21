import ProjectDescription

public extension Target {
    static var nutritionUI: Target {
        .module(
            name: "NutritionUI",
            sources: "Modules/UI/Sources/**/*.swift",
            dependencies: [.target(name: "NutritionCore")]
        )
    }
}
