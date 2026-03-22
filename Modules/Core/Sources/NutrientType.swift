import SwiftUI

public enum NutrientType: CaseIterable, Sendable {
    case protein
    case carbs
    case fat

    /// Localized display name sourced from NutritionCore's resource bundle.
    public var localizedName: String {
        switch self {
        case .protein: NutritionCoreStrings.protein
        case .carbs:   NutritionCoreStrings.carbs
        case .fat:     NutritionCoreStrings.fat
        }
    }

    /// First character of the localized nutrient name (e.g. "P" / "ח").
    public var localizedAbbreviation: String {
        String(localizedName.prefix(1))
    }

    public var color: Color {
        switch self {
        case .protein: .blue
        case .carbs:   .orange
        case .fat:     .green
        }
    }
}
