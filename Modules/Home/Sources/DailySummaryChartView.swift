import SwiftUI
import NutritionCore
import NutritionUI

public struct DailySummaryChartView: View {
    public let currentLog: DailyLog?
    public let dailyGoals: DailyGoals

    public init(currentLog: DailyLog?, dailyGoals: DailyGoals) {
        self.currentLog = currentLog
        self.dailyGoals = dailyGoals
    }

    public var body: some View {
        if let currentLog {
            PieChartView(
                protein: currentLog.protein,
                carbs: currentLog.carbs,
                fat: currentLog.fat,
                proteinGoal: dailyGoals.protein,
                carbsGoal: dailyGoals.carbs,
                fatGoal: dailyGoals.fat
            )
            .frame(height: 150)
            .padding()
            .transition(.scale.combined(with: .opacity))
        }
    }
}

#Preview {
    DailySummaryChartView(
        currentLog: DailyLog(protein: 2.0, carbs: 3.0, fat: 1.5),
        dailyGoals: .default
    )
}
