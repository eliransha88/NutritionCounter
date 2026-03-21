import Foundation

// MARK: - Read-only store (synchronous, safe to call from TimelineProvider callbacks)

enum WidgetDataStore {
    private static let suiteName = "group.com.eliransharabi.NutritionCounter"
    private static let goalsKey = "DailyGoals"
    private static let logsKey = "WeeklyLogs"
    static let widgetKind = "NutritionWidget"

    private static var defaults: UserDefaults {
        UserDefaults(suiteName: suiteName) ?? .standard
    }

    static func loadGoals() -> WidgetDailyGoals {
        guard let data = defaults.data(forKey: goalsKey),
              let goals = try? JSONDecoder().decode(WidgetDailyGoals.self, from: data)
        else { return .default }
        return goals
    }

    static func loadTodayLog() -> WidgetDailyLog {
        guard let data = defaults.data(forKey: logsKey),
              let logs = try? JSONDecoder().decode([WidgetDailyLog].self, from: data)
        else { return .empty }
        return logs.first { Calendar.current.isDateInToday($0.date) } ?? .empty
    }

    // Called only from within WidgetMutationActor to keep the read-modify-write atomic.
    fileprivate static func performAdjust(_ nutrient: NutrientTypeAppEnum, delta: Double) {
        guard let data = defaults.data(forKey: logsKey),
              var logs = try? JSONDecoder().decode([WidgetDailyLog].self, from: data)
        else { return }

        guard let index = logs.firstIndex(where: { Calendar.current.isDateInToday($0.date) }) else { return }

        let current = logs[index].value(for: nutrient)
        let newValue = max(0, min(10, current + delta))
        let log = logs[index]

        logs[index] = switch nutrient {
        case .protein: WidgetDailyLog(id: log.id, date: log.date, protein: newValue, carbs: log.carbs, fat: log.fat)
        case .carbs:   WidgetDailyLog(id: log.id, date: log.date, protein: log.protein, carbs: newValue, fat: log.fat)
        case .fat:     WidgetDailyLog(id: log.id, date: log.date, protein: log.protein, carbs: log.carbs, fat: newValue)
        }

        if let encoded = try? JSONEncoder().encode(logs) {
            defaults.set(encoded, forKey: logsKey)
        }
    }
}

// MARK: - Serialised mutation actor

/// Serialises all write operations so that rapid concurrent AppIntent.perform() calls
/// cannot interleave their read-modify-write cycle and lose a delta.
actor WidgetMutationActor {
    static let shared = WidgetMutationActor()

    func adjustNutrient(_ nutrient: NutrientTypeAppEnum, delta: Double) {
        WidgetDataStore.performAdjust(nutrient, delta: delta)
    }
}
