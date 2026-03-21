import Foundation
import Observation
import OSLog
import WidgetKit

@MainActor @Observable
public final class NutritionStore {
    public var dailyGoals: DailyGoals = DailyGoals.default
    public var weeklyLogs: [DailyLog] = []

    private let storage  = UserDefaults(suiteName: AppGroup.suiteName) ?? .standard
    private let calendar = Calendar.current
    private let logger   = Logger(subsystem: "com.eliransharabi.NutritionCounter", category: "NutritionStore")

    public init() {
        loadData()
        initializeWeekIfNeeded()
    }

    public func loadData() {
        if let data   = storage.data(forKey: AppGroup.goalsKey),
           let goals  = try? JSONDecoder().decode(DailyGoals.self, from: data) {
            dailyGoals = goals
        }
        if let data = storage.data(forKey: AppGroup.logsKey),
           let logs = try? JSONDecoder().decode([DailyLog].self, from: data) {
            weeklyLogs = logs
        }
    }

    public func saveData() {
        do { storage.set(try JSONEncoder().encode(dailyGoals), forKey: AppGroup.goalsKey) }
        catch { logger.error("Failed to encode dailyGoals: \(error)") }

        do { storage.set(try JSONEncoder().encode(weeklyLogs), forKey: AppGroup.logsKey) }
        catch { logger.error("Failed to encode weeklyLogs: \(error)") }

        WidgetCenter.shared.reloadTimelines(ofKind: AppGroup.widgetKind)
    }

    public func initializeWeekIfNeeded() {
        let today     = Date.now
        let weekStart = calendar.dateInterval(of: .weekOfYear, for: today)?.start ?? today

        let needsNewWeek = weeklyLogs.isEmpty ||
            !calendar.isDate(weeklyLogs.first?.date ?? .distantPast, equalTo: weekStart, toGranularity: .weekOfYear)

        if needsNewWeek {
            weeklyLogs = (0..<7).compactMap { i in
                calendar.date(byAdding: .day, value: i, to: weekStart).map { DailyLog(date: $0) }
            }
            saveData()
        } else {
            let existingDates    = Set(weeklyLogs.map { calendar.startOfDay(for: $0.date) })
            let currentWeekDates = (0..<7).compactMap { i in
                calendar.date(byAdding: .day, value: i, to: weekStart)
                    .map { calendar.startOfDay(for: $0) }
            }
            let missingDates = currentWeekDates.filter { !existingDates.contains($0) }

            if !missingDates.isEmpty {
                for missing in missingDates {
                    if let full = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: missing) {
                        weeklyLogs.append(DailyLog(date: full))
                    }
                }
                weeklyLogs.sort { $0.date < $1.date }
                saveData()
            }
        }
    }

    public func updateNutrient(for date: Date, type: NutrientType, value: Double) {
        guard let index = weeklyLogs.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: date) })
        else { return }

        switch type {
        case .protein: weeklyLogs[index].protein = max(0, min(10, value))
        case .carbs:   weeklyLogs[index].carbs   = max(0, min(10, value))
        case .fat:     weeklyLogs[index].fat     = max(0, min(10, value))
        }
        saveData()
    }

    public func getCurrentDayLog() -> DailyLog? {
        weeklyLogs.first { calendar.isDate($0.date, inSameDayAs: .now) }
    }

    public func checkAndCreateNewDayIfNeeded() {
        if !calendar.isDate(.now, inSameDayAs: getLastRecordedDate()) {
            initializeWeekIfNeeded()
        }
    }

    public func handleAppBecameActive() {
        checkAndCreateNewDayIfNeeded()
    }

    private func getLastRecordedDate() -> Date {
        weeklyLogs.map { $0.date }.max() ?? .distantPast
    }
}
