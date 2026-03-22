import SwiftUI
import NutritionCore
import NutritionUI

public struct DailyTrackerView: View {
    public var store: any NutritionStoreProtocol
    @State private var showingSettings = false

    public init(store: any NutritionStoreProtocol) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    DayHeaderView()
                    DailySummaryChartView(currentLog: store.getCurrentDayLog(), dailyGoals: store.dailyGoals)
                    DailyCountersView(store: store)
                    WeeklyGraphView(weeklyLogs: store.weeklyLogs)
                }
                .padding()
            }
            .navigationTitle("Nutrition Tracker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Settings", systemImage: "gear") {
                        showingSettings = true
                    }
                    .labelStyle(.iconOnly)
                }
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView(store: store)
        }
    }
}

#Preview {
    DailyTrackerView(store: NutritionStore())
}
