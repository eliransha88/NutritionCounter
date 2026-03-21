import WidgetKit

struct NutritionEntry: TimelineEntry, Sendable {
    let date: Date
    let todayLog: WidgetDailyLog
    let goals: WidgetDailyGoals

    static let placeholder = NutritionEntry(
        date: .now,
        todayLog: WidgetDailyLog(id: UUID(), date: .now, protein: 2.0, carbs: 3.0, fat: 1.5),
        goals: WidgetDailyGoals(protein: 3.0, carbs: 4.0, fat: 2.0)
    )
}
