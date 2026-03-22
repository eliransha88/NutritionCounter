import AppIntents
import SwiftUI

// MARK: - App Enum for use in AppIntents

enum NutrientTypeAppEnum: String, AppEnum, CaseIterable {
    case protein = "Protein"
    case carbs   = "Carbs"
    case fat     = "Fat"

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Nutrient")
    static var caseDisplayRepresentations: [NutrientTypeAppEnum: DisplayRepresentation] = [
        .protein: "Protein",
        .carbs:   "Carbs",
        .fat:     "Fat",
    ]

    var color: Color {
        switch self {
        case .protein: .blue
        case .carbs:   .orange
        case .fat:     .green
        }
    }

    var abbreviation: String {
        switch self {
        case .protein: "P"
        case .carbs:   "C"
        case .fat:     "F"
        }
    }
}
