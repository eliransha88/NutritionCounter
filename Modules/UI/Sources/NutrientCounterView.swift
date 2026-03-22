import SwiftUI
import NutritionCore

public struct NutrientCounterView: View {
    public let nutrient: NutrientType
    public let value: Double
    public let goal: Double
    public let onIncrement: () -> Void
    public let onDecrement: () -> Void

    @State private var isPressed = false
    @State private var valueScale: CGFloat = 1.0

    public init(
        nutrient: NutrientType,
        value: Double,
        goal: Double,
        onIncrement: @escaping () -> Void,
        onDecrement: @escaping () -> Void
    ) {
        self.nutrient = nutrient
        self.value = value
        self.goal = goal
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
    }

    private var isGoalReached: Bool { value >= goal }

    public var body: some View {
        Group {
            if isGoalReached {
                congratsContent
            } else {
                counterContent
            }
        }
        .padding()
        .background(isGoalReached ? Color.green.opacity(0.07) : Color(.systemBackground))
        .clipShape(.rect(cornerRadius: 12))
        .shadow(radius: 2)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isGoalReached)
    }

    // MARK: - Congrats state

    private var congratsContent: some View {
        HStack(spacing: 16) {
            Image(systemName: "trophy.fill")
                .font(.largeTitle)
                .foregroundStyle(nutrientColor)
                .symbolEffect(.pulse)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                Text(nutrient.localizedName)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(NutritionUIStrings.congratsGoalReached)
                    .font(.subheadline.bold())
                    .foregroundStyle(.green)

                Text(
                    "\(value, format: .number.precision(.fractionLength(1)))/\(goal, format: .number.precision(.fractionLength(1))) servings"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                onDecrement()
            } label: {
                Label(NutritionUIStrings.decrease(nutrient.localizedName), systemImage: "minus.circle")
            }
            .font(.title2)
            .foregroundStyle(.secondary)
            .labelStyle(.iconOnly)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(verbatim:
            "\(nutrient.localizedName): goal reached. " +
            "\(value.formatted(.number.precision(.fractionLength(1)))) of " +
            "\(goal.formatted(.number.precision(.fractionLength(1)))) servings."
        ))
    }

    // MARK: - Normal counter state

    private var counterContent: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(nutrient.localizedName)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(
                    "\(value, format: .number.precision(.fractionLength(1)))/\(goal, format: .number.precision(.fractionLength(1))) servings"
                )
                .font(.subheadline)
                .foregroundStyle(servingsTextColor)
                .scaleEffect(valueScale)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: value)

                ProgressView(value: min(value, goal), total: goal)
                    .progressViewStyle(LinearProgressViewStyle(tint: nutrientColor))
                    .scaleEffect(x: 1.0, y: 0.8, anchor: .center)
            }

            Spacer()

            HStack(spacing: 12) {
                Button {
                    animateValueChange()
                    onDecrement()
                } label: {
                    Label(NutritionUIStrings.decrease(nutrient.localizedName), systemImage: "minus.circle.fill")
                }
                .font(.title2)
                .foregroundStyle(.red)
                .labelStyle(.iconOnly)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                    isPressed = pressing
                }, perform: {})

                Button {
                    animateValueChange()
                    onIncrement()
                } label: {
                    Label(NutritionUIStrings.increase(nutrient.localizedName), systemImage: "plus.circle.fill")
                }
                .font(.title2)
                .foregroundStyle(.green)
                .labelStyle(.iconOnly)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                    isPressed = pressing
                }, perform: {})
            }
        }
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
    }

    // MARK: - Helpers

    private func animateValueChange() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            valueScale = 1.2
        } completion: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                valueScale = 1.0
            }
        }
    }

    private var servingsTextColor: Color {
        value > 0 ? nutrientColor : .secondary
    }

    private var nutrientColor: Color {
        switch nutrient {
        case .protein: .blue
        case .carbs: .orange
        case .fat: .green
        }
    }
}

#Preview("In Progress") {
    NutrientCounterView(nutrient: .protein, value: 2.5, goal: 4.0, onIncrement: {}, onDecrement: {})
        .padding()
}

#Preview("Goal Reached") {
    NutrientCounterView(nutrient: .protein, value: 4.0, goal: 4.0, onIncrement: {}, onDecrement: {})
        .padding()
}
