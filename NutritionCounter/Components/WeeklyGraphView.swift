import SwiftUI

struct WeeklyGraphView: View {
    let weeklyLogs: [DailyLog]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Weekly Overview")
                .font(.headline)
                .foregroundStyle(.primary)
                .transition(.opacity.combined(with: .move(edge: .trailing)))

            WeeklyChartView(weeklyLogs: weeklyLogs)
                .frame(height: 200)
                .transition(.opacity.combined(with: .scale))
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 12))
        .animation(.easeInOut(duration: 0.6), value: weeklyLogs.count)
    }
}

#Preview {
    WeeklyGraphView(weeklyLogs: [
        DailyLog(date: .now, protein: 2.0, carbs: 3.0, fat: 1.5),
        DailyLog(date: Date.now.addingTimeInterval(86400), protein: 2.5, carbs: 2.8, fat: 1.8),
    ])
}
