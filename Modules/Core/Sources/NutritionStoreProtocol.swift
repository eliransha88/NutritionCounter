import Foundation
import Observation

/// The contract for the app's central nutrition state container.
///
/// Views and tests depend on this protocol rather than on the concrete
/// `NutritionStore` class, enabling fast unit tests via `MockNutritionStore`
/// and clean SwiftUI previews with lightweight stub data.
@MainActor
public protocol NutritionStoreProtocol: AnyObject, Observable {
    var dailyGoals: DailyGoals { get set }
    var weeklyLogs: [DailyLog] { get set }

    func loadData()
    func saveData()
    func initializeWeekIfNeeded()
    func updateNutrient(for date: Date, type: NutrientType, value: Double)
    func getCurrentDayLog() -> DailyLog?
    func checkAndCreateNewDayIfNeeded()
    func handleAppBecameActive()
}
