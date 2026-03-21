import Foundation

struct DailyGoals: Codable {
    var protein: Double
    var carbs: Double
    var fat: Double

    static let `default` = DailyGoals(protein: 3.0, carbs: 4.0, fat: 2.0)
}
