import Foundation

public struct DailyLog: Codable, Identifiable, Equatable, Sendable {
    public let id: UUID
    public let date: Date
    public var protein: Double
    public var carbs: Double
    public var fat: Double

    public var total: Double { protein + carbs + fat }

    public init(
        id: UUID = UUID(),
        date: Date = .now,
        protein: Double = 0,
        carbs: Double = 0,
        fat: Double = 0
    ) {
        self.id      = id
        self.date    = date
        self.protein = protein
        self.carbs   = carbs
        self.fat     = fat
    }
}
