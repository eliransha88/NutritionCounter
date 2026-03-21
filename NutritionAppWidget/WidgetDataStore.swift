import Foundation
import NutritionCore

// MARK: - Read-only store (synchronous, safe to call from TimelineProvider callbacks)

enum WidgetDataStore {
    private static var defaults: UserDefaults {
        UserDefaults(suiteName: AppGroup.suiteName) ?? .standard
    }

    static func loadGoals() -> DailyGoals {
        guard let data  = defaults.data(forKey: AppGroup.goalsKey),
              let goals = try? JSONDecoder().decode(DailyGoals.self, from: data)
        else { return .default }
        return goals
    }

    static func loadTodayLog() -> DailyLog {
        guard let data = defaults.data(forKey: AppGroup.logsKey),
              let logs = try? JSONDecoder().decode([DailyLog].self, from: data)
        else { return DailyLog() }
        return logs.first { Calendar.current.isDateInToday($0.date) } ?? DailyLog()
    }

    /// Called only from within `WidgetMutationActor` to keep the read-modify-write atomic.
    fileprivate static func performAdjust(_ nutrient: NutrientTypeAppEnum, delta: Double) {
        guard let data = defaults.data(forKey: AppGroup.logsKey),
              var logs = try? JSONDecoder().decode([DailyLog].self, from: data)
        else { return }

        guard let index = logs.firstIndex(where: { Calendar.current.isDateInToday($0.date) }) else { return }

        let log     = logs[index]
        let current = log.value(for: nutrient)
        let newValue = max(0, min(10, current + delta))

        logs[index] = switch nutrient {
        case .protein: DailyLog(id: log.id, date: log.date, protein: newValue, carbs: log.carbs, fat: log.fat)
        case .carbs:   DailyLog(id: log.id, date: log.date, protein: log.protein, carbs: newValue, fat: log.fat)
        case .fat:     DailyLog(id: log.id, date: log.date, protein: log.protein, carbs: log.carbs, fat: newValue)
        }

        if let encoded = try? JSONEncoder().encode(logs) {
            defaults.set(encoded, forKey: AppGroup.logsKey)
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
