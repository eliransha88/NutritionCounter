import NutritionCore

// MARK: - Convenience accessors keyed by NutrientTypeAppEnum
// These extensions live in the widget target so that NutritionCore stays
// free of an AppIntents dependency.

extension DailyGoals {
    func goal(for nutrient: NutrientTypeAppEnum) -> Double {
        switch nutrient {
        case .protein: protein
        case .carbs:   carbs
        case .fat:     fat
        }
    }
}

extension DailyLog {
    func value(for nutrient: NutrientTypeAppEnum) -> Double {
        switch nutrient {
        case .protein: protein
        case .carbs:   carbs
        case .fat:     fat
        }
    }
}
