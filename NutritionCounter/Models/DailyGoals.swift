import Foundation

struct DailyGoals: Codable, Sendable {
    var protein: Double
    var carbs: Double
    var fat: Double

    static let `default` = DailyGoals(protein: 3.0, carbs: 4.0, fat: 2.0)
}
