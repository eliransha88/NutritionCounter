import WidgetKit
import NutritionCore

struct NutritionWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> NutritionEntry {
        .placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (NutritionEntry) -> Void) {
        completion(context.isPreview ? .placeholder : makeEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<NutritionEntry>) -> Void) {
        let entry = makeEntry()
        let nextRefresh = Calendar.current.nextDate(
            after: .now,
            matching: DateComponents(minute: 0),
            matchingPolicy: .nextTime
        ) ?? Date(timeIntervalSinceNow: 3600)
        completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
    }

    private func makeEntry() -> NutritionEntry {
        NutritionEntry(
            date: .now,
            todayLog: WidgetDataStore.loadTodayLog(),
            goals: WidgetDataStore.loadGoals()
        )
    }
}
