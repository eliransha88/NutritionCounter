import SwiftUI

enum NutrientType: String, CaseIterable {
    case protein = "Protein"
    case carbs = "Carbs"
    case fat = "Fat"

    var color: Color {
        switch self {
        case .protein: .blue
        case .carbs: .orange
        case .fat: .green
        }
    }
}
