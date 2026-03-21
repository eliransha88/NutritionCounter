import Foundation

struct DailyLog: Codable, Identifiable, Equatable {
    let id: UUID
    let date: Date
    var protein: Double
    var carbs: Double
    var fat: Double

    var total: Double {
        protein + carbs + fat
    }

    init(
        id: UUID = UUID(),
        date: Date = .now,
        protein: Double = 0,
        carbs: Double = 0,
        fat: Double = 0
    ) {
        self.id = id
        self.date = date
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
    }
}
