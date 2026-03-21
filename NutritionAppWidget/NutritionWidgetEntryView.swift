import AppIntents
import SwiftUI
import WidgetKit
import NutritionCore

// MARK: - Root dispatcher

struct NutritionWidgetEntryView: View {
    let entry: NutritionEntry
    @Environment(\.widgetFamily) private var family

    var body: some View {
        switch family {
        case .systemSmall:  SmallWidgetView(entry: entry)
        case .systemMedium: MediumWidgetView(entry: entry)
        case .systemLarge:  LargeWidgetView(entry: entry)
        default:            MediumWidgetView(entry: entry)
        }
    }
}

// MARK: - Small widget

private struct SmallWidgetView: View {
    let entry: NutritionEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Nutrition", systemImage: "fork.knife")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
                .labelStyle(.titleOnly)

            ForEach(NutrientTypeAppEnum.allCases, id: \.rawValue) { nutrient in
                SmallNutrientRow(
                    nutrient: nutrient,
                    value: entry.todayLog.value(for: nutrient),
                    goal: entry.goals.goal(for: nutrient)
                )
            }

            Spacer(minLength: 0)

            Text(entry.date, format: .dateTime.weekday(.abbreviated))
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

private struct SmallNutrientRow: View {
    let nutrient: NutrientTypeAppEnum
    let value: Double
    let goal: Double

    private var progress: Double { goal > 0 ? min(value / goal, 1.0) : 0 }
    private var isComplete: Bool { value >= goal }

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(isComplete ? .green : nutrient.color)
                .frame(width: 7, height: 7)

            Text(nutrient.abbreviation)
                .font(.caption2.bold())
                .foregroundStyle(.primary)
                .frame(width: 10, alignment: .leading)

            if isComplete {
                Label("Done", systemImage: "checkmark.circle.fill")
                    .labelStyle(.titleAndIcon)
                    .font(.caption2.bold())
                    .foregroundStyle(.green)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(.quaternary).frame(height: 5)
                        Capsule()
                            .fill(nutrient.color)
                            .frame(width: geo.size.width * progress, height: 5)
                    }
                }
                .frame(height: 5)

                Text(value, format: .number.precision(.fractionLength(1)))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(width: 24, alignment: .trailing)
            }
        }
    }
}

// MARK: - Medium widget

private struct MediumWidgetView: View {
    let entry: NutritionEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Nutrition").font(.headline.bold())
                Spacer()
                Text(entry.date, format: .dateTime.weekday(.wide))
                    .font(.caption).foregroundStyle(.secondary)
            }

            ForEach(NutrientTypeAppEnum.allCases, id: \.rawValue) { nutrient in
                MediumNutrientRow(
                    nutrient: nutrient,
                    value: entry.todayLog.value(for: nutrient),
                    goal: entry.goals.goal(for: nutrient)
                )
            }
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

private struct MediumNutrientRow: View {
    let nutrient: NutrientTypeAppEnum
    let value: Double
    let goal: Double

    private var progress: Double { goal > 0 ? min(value / goal, 1.0) : 0 }
    private var isComplete: Bool { value >= goal }

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(isComplete ? .green : nutrient.color)
                .frame(width: 9, height: 9)

            Text(nutrient.rawValue)
                .font(.caption.bold())
                .frame(width: 48, alignment: .leading)

            if isComplete {
                Label("Congrats!", systemImage: "trophy.fill")
                    .font(.caption.bold())
                    .foregroundStyle(.green)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(.quaternary).frame(height: 6)
                        Capsule()
                            .fill(nutrient.color)
                            .frame(width: geo.size.width * progress, height: 6)
                    }
                }
                .frame(height: 6)

                Text("\(value, format: .number.precision(.fractionLength(1)))/\(goal, format: .number.precision(.fractionLength(0)))")
                    .font(.caption2).foregroundStyle(.secondary)
                    .frame(width: 38, alignment: .trailing)

                Button(intent: IncrementNutrientIntent(nutrient: nutrient)) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundStyle(nutrient.color)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Large widget

private struct LargeWidgetView: View {
    let entry: NutritionEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Nutrition Tracker").font(.headline.bold())
                Spacer()
                Text(entry.date, format: .dateTime.weekday(.wide))
                    .font(.caption).foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 8)

            Divider()

            ForEach(Array(NutrientTypeAppEnum.allCases.enumerated()), id: \.element.rawValue) { index, nutrient in
                LargeNutrientCard(
                    nutrient: nutrient,
                    value: entry.todayLog.value(for: nutrient),
                    goal: entry.goals.goal(for: nutrient)
                )
                if index < NutrientTypeAppEnum.allCases.count - 1 {
                    Divider().padding(.horizontal)
                }
            }

            Spacer(minLength: 0)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

private struct LargeNutrientCard: View {
    let nutrient: NutrientTypeAppEnum
    let value: Double
    let goal: Double

    private var progress: Double { goal > 0 ? min(value / goal, 1.0) : 0 }
    private var isComplete: Bool { value >= goal }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(isComplete ? .green : nutrient.color)
                    .frame(width: 10, height: 10)
                Text(nutrient.rawValue).font(.subheadline.bold())
                Spacer()
            }

            ProgressView(value: progress).tint(isComplete ? .green : nutrient.color)

            if isComplete {
                HStack(spacing: 10) {
                    Image(systemName: "trophy.fill")
                        .font(.title3).foregroundStyle(nutrient.color)

                    VStack(alignment: .leading, spacing: 1) {
                        Text("Congrats! Goal reached")
                            .font(.caption.bold()).foregroundStyle(.green)
                        Text("\(value, format: .number.precision(.fractionLength(1))) / \(goal, format: .number.precision(.fractionLength(1))) servings")
                            .font(.caption2).foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button(intent: DecrementNutrientIntent(nutrient: nutrient)) {
                        Image(systemName: "minus.circle")
                            .font(.title3).foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            } else {
                HStack {
                    Button(intent: DecrementNutrientIntent(nutrient: nutrient)) {
                        Image(systemName: "minus.circle.fill")
                            .font(.title2).foregroundStyle(.red.opacity(0.8))
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Text("\(value, format: .number.precision(.fractionLength(1))) / \(goal, format: .number.precision(.fractionLength(1))) servings")
                        .font(.caption).foregroundStyle(.secondary)

                    Spacer()

                    Button(intent: IncrementNutrientIntent(nutrient: nutrient)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2).foregroundStyle(nutrient.color)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
    }
}

// MARK: - Previews

#Preview("Small", as: .systemSmall) {
    NutritionWidget()
} timeline: {
    NutritionEntry.placeholder
    NutritionEntry.allGoalsReached
}

#Preview("Medium", as: .systemMedium) {
    NutritionWidget()
} timeline: {
    NutritionEntry.placeholder
    NutritionEntry.allGoalsReached
}

#Preview("Large", as: .systemLarge) {
    NutritionWidget()
} timeline: {
    NutritionEntry.placeholder
    NutritionEntry.allGoalsReached
}
