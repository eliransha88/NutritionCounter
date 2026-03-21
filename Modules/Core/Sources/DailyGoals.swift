import Foundation

public struct DailyGoals: Codable, Sendable {
    public var protein: Double
    public var carbs: Double
    public var fat: Double

    public init(protein: Double, carbs: Double, fat: Double) {
        self.protein = protein
        self.carbs   = carbs
        self.fat     = fat
    }

    public static let `default` = DailyGoals(protein: 3.0, carbs: 4.0, fat: 2.0)
}
