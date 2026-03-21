import SwiftUI
import Charts

struct PieChartView: View {
    let protein: Double
    let carbs: Double
    let fat: Double
    let proteinGoal: Double
    let carbsGoal: Double
    let fatGoal: Double

    var body: some View {
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
                        Circle()
                            .fill(.blue)
                            .frame(width: 8, height: 8)
                        Text("Protein")
                            .font(.caption)
                    }

                    HStack(spacing: 4) {
                        Circle()
                            .fill(.orange)
                            .frame(width: 8, height: 8)
                        Text("Carbs")
                            .font(.caption)
                    }

                    HStack(spacing: 4) {
                        Circle()
                            .fill(.green)
                            .frame(width: 8, height: 8)
                        Text("Fat")
                            .font(.caption)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Daily Totals")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: 16) {
                    VStack(spacing: 2) {
                        Text("P")
                            .font(.caption)
                            .foregroundStyle(.blue)
                            .accessibilityLabel("Protein")
                        Text(protein, format: .number.precision(.fractionLength(1)))
                            .font(.caption)
                            .fontWeight(.semibold)
                    }

                    VStack(spacing: 2) {
                        Text("C")
                            .font(.caption)
                            .foregroundStyle(.orange)
                            .accessibilityLabel("Carbs")
                        Text(carbs, format: .number.precision(.fractionLength(1)))
                            .font(.caption)
                            .fontWeight(.semibold)
                    }

                    VStack(spacing: 2) {
                        Text("F")
                            .font(.caption)
                            .foregroundStyle(.green)
                            .accessibilityLabel("Fat")
                        Text(fat, format: .number.precision(.fractionLength(1)))
                            .font(.caption)
                            .fontWeight(.semibold)
                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
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
