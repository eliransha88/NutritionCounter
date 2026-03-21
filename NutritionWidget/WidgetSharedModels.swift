import Foundation
import SwiftUI

// MARK: - Shared Codable models (must match main app's DailyLog / DailyGoals)

struct WidgetDailyGoals: Codable, Sendable {
    var protein: Double
    var carbs: Double
    var fat: Double

    static let `default` = WidgetDailyGoals(protein: 3.0, carbs: 4.0, fat: 2.0)

    func goal(for nutrient: NutrientTypeAppEnum) -> Double {
        switch nutrient {
        case .protein: protein
        case .carbs: carbs
        case .fat: fat
        }
    }
}

struct WidgetDailyLog: Codable, Sendable {
    let id: UUID
    let date: Date
    var protein: Double
    var carbs: Double
    var fat: Double

    static let empty = WidgetDailyLog(id: UUID(), date: .now, protein: 0, carbs: 0, fat: 0)

    func value(for nutrient: NutrientTypeAppEnum) -> Double {
        switch nutrient {
        case .protein: protein
        case .carbs: carbs
        case .fat: fat
        }
    }
}

// MARK: - App Enum for use in App Intents

import AppIntents

enum NutrientTypeAppEnum: String, AppEnum, CaseIterable {
    case protein = "Protein"
    case carbs = "Carbs"
    case fat = "Fat"

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Nutrient")
    static var caseDisplayRepresentations: [NutrientTypeAppEnum: DisplayRepresentation] = [
        .protein: "Protein",
        .carbs: "Carbs",
        .fat: "Fat",
    ]

    var color: Color {
        switch self {
        case .protein: .blue
        case .carbs: .orange
        case .fat: .green
        }
    }

    var abbreviation: String {
        switch self {
        case .protein: "P"
        case .carbs: "C"
        case .fat: "F"
        }
    }
}
