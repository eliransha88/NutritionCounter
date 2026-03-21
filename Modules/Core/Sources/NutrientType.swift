import SwiftUI

public enum NutrientType: String, CaseIterable, Sendable {
    case protein = "Protein"
    case carbs   = "Carbs"
    case fat     = "Fat"

    /// Localized display name — routes through the strings catalog.
    public var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }

    /// First character of the localized nutrient name (e.g. "P" / "ח").
    public var localizedAbbreviation: String {
        String(NSLocalizedString(rawValue, comment: "").prefix(1))
    }

    public var color: Color {
        switch self {
        case .protein: .blue
        case .carbs:   .orange
        case .fat:     .green
        }
    }
}
