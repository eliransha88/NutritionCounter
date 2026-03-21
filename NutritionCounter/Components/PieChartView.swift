import SwiftUI
import Charts

struct PieChartView: View {
    let protein: Double
    let carbs: Double
    let fat: Double
    let proteinGoal: Double
    let carbsGoal: Double
    let fatGoal: Double
    
    private var hasData: Bool { protein + carbs + fat > 0 }

    private func value(for nutrient: NutrientType) -> Double {
        switch nutrient {
        case .protein: protein
        case .carbs: carbs
        case .fat: fat
        }
    }
    
    var body: some View {
        if hasData {
            chartContent
        } else {
            ContentUnavailableView(
                "No servings logged yet",
                systemImage: "fork.knife",
                description: Text("Tap + on a nutrient below to start tracking")
            )
        }
    }
    
    private var chartContent: some View {
        HStack(spacing: 8) {
            Chart {
                SectorMark(
                    angle: .value("Protein", protein),
                    innerRadius: .ratio(0.4),
                    angularInset: 2
                )
                .foregroundStyle(.blue)
                .opacity(0.8)
                
                SectorMark(
                    angle: .value("Carbs", carbs),
                    innerRadius: .ratio(0.4),
                    angularInset: 2
                )
                .foregroundStyle(.orange)
                .opacity(0.8)
                
                SectorMark(
                    angle: .value("Fat", fat),
                    innerRadius: .ratio(0.4),
                    angularInset: 2
                )
                .foregroundStyle(.green)
                .opacity(0.8)
            }
            .frame(height: 120)
            .chartLegend(position: .bottom, spacing: 20)
            .chartLegend {
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Circle().fill(.blue).frame(width: 8, height: 8)
                        Text("Protein").font(.caption)
                    }
                    HStack(spacing: 4) {
                        Circle().fill(.orange).frame(width: 8, height: 8)
                        Text("Carbs").font(.caption)
                    }
                    HStack(spacing: 4) {
                        Circle().fill(.green).frame(width: 8, height: 8)
                        Text("Fat").font(.caption)
                    }
                }
            }
            .accessibilityLabel(
                """
Daily intake: Protein \(protein, format: .number.precision(.fractionLength(1))) servings,
                "Carbs \(carbs, format: .number.precision(.fractionLength(1))) servings,
                Fat \(fat, format: .number.precision(.fractionLength(1))) servings
"""
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Daily Totals")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: 16) {
                    ForEach(NutrientType.allCases, id: \.self) { nutrient in
                        VStack(spacing: 2) {
                            Text(nutrient.localizedAbbreviation)
                                .font(.caption)
                                .foregroundStyle(nutrient.color)
                                .accessibilityLabel(Text(nutrient.localizedName))
                            Text(value(for: nutrient), format: .number.precision(.fractionLength(1)))
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview("With Data") {
    PieChartView(
        protein: 2.5,
        carbs: 3.0,
        fat: 1.5,
        proteinGoal: 3.0,
        carbsGoal: 4.0,
        fatGoal: 2.0
    )
    .frame(width: 200, height: 200)
}

#Preview("Empty State") {
    PieChartView(
        protein: 0,
        carbs: 0,
        fat: 0,
        proteinGoal: 3.0,
        carbsGoal: 4.0,
        fatGoal: 2.0
    )
    .frame(width: 300, height: 150)
}
