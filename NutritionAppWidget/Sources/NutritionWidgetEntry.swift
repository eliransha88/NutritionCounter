import WidgetKit
import NutritionCore

struct NutritionEntry: TimelineEntry, Sendable {
    let date: Date
    let todayLog: DailyLog
    let goals: DailyGoals

    static let placeholder = NutritionEntry(
        date: .now,
        todayLog: DailyLog(id: UUID(), date: .now, protein: 2.0, carbs: 3.0, fat: 1.5),
        goals: DailyGoals(protein: 3.0, carbs: 4.0, fat: 2.0)
    )

    static let allGoalsReached = NutritionEntry(
        date: .now,
        todayLog: DailyLog(id: UUID(), date: .now, protein: 3.0, carbs: 4.0, fat: 2.0),
        goals: DailyGoals(protein: 3.0, carbs: 4.0, fat: 2.0)
    )
}
