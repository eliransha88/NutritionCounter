import SwiftUI
import Charts
import NutritionCore

public struct WeeklyChartView: View {
    public let weeklyLogs: [DailyLog]

    public init(weeklyLogs: [DailyLog]) {
        self.weeklyLogs = weeklyLogs
    }

    private let nutrientConfigs: [NutrientConfig] = [
        .init(type: .protein, color: .blue, symbol: .circle),
        .init(type: .carbs, color: .orange, symbol: .square),
        .init(type: .fat, color: .green, symbol: .triangle),
    ]

    public var body: some View {
        Chart {
            ForEach(nutrientConfigs, id: \.type) { config in
                ForEach(weeklyLogs) { log in
                    LineMark(
                        x: .value("Day", dayString(from: log.date)),
                        y: .value(config.type.localizedName, getNutrientValue(for: config.type, from: log)),
                        series: .value("", config.type.localizedName)
                    )
                    .foregroundStyle(config.color)
                    .symbol(config.symbol)
                    .lineStyle(StrokeStyle(lineWidth: 3))
                }
            }
        }
        .chartLegend(position: .bottom)
        .accessibilityLabel(NutritionUIStrings.weeklyNutrientIntakeChartShowingProteinCarbsAndFatServingsForEachDayOfTheWeek)
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .font(.caption)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { _ in
                AxisValueLabel()
                    .font(.caption)
            }
        }
    }

    private func dayString(from date: Date) -> String {
        date.formatted(.dateTime.weekday(.abbreviated))
    }

    private func getNutrientValue(for type: NutrientType, from log: DailyLog) -> Double {
        switch type {
        case .protein: log.protein
        case .carbs: log.carbs
        case .fat: log.fat
        }
    }
}

#Preview {
    WeeklyChartView(weeklyLogs: [
        DailyLog(date: .now, protein: 2.0, carbs: 3.0, fat: 1.5),
        DailyLog(date: Date.now.addingTimeInterval(86400), protein: 2.5, carbs: 2.8, fat: 1.8),
        DailyLog(date: Date.now.addingTimeInterval(172800), protein: 1.8, carbs: 3.2, fat: 1.2),
    ])
    .frame(height: 200)
}
