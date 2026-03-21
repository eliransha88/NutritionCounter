import SwiftUI

struct NutrientCounterView: View {
    let nutrient: NutrientType
    let value: Double
    let goal: Double
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    @State private var isPressed = false
    @State private var valueScale: CGFloat = 1.0

    private var isGoalReached: Bool { value >= goal }

    var body: some View {
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
                Text(nutrient.rawValue)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text("Congrats! Goal reached")
                    .font(.subheadline.bold())
                    .foregroundStyle(.green)

                let valueText = Text(value, format: .number.precision(.fractionLength(1)))
                let goalText = Text(goal, format: .number.precision(.fractionLength(1)))
                Text("\(valueText)/\(goalText) servings")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button("Decrease \(nutrient.rawValue)", systemImage: "minus.circle") {
                onDecrement()
            }
            .font(.title2)
            .foregroundStyle(.secondary)
            .labelStyle(.iconOnly)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
        """
            \(nutrient.rawValue): goal reached.
            \(value, format: .number.precision(.fractionLength(1))) of 
            \(goal, format: .number.precision(.fractionLength(1))) servings.
        """
        )
    }

    // MARK: - Normal counter state

    private var counterContent: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(nutrient.rawValue)
                    .font(.headline)
                    .foregroundStyle(.primary)

                let valueText = Text(value, format: .number.precision(.fractionLength(1)))
                let goalText = Text(goal, format: .number.precision(.fractionLength(1)))
                Text("\(valueText)/\(goalText) servings")
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
                Button("Decrease \(nutrient.rawValue)", systemImage: "minus.circle.fill") {
                    animateValueChange()
                    onDecrement()
                }
                .font(.title2)
                .foregroundStyle(.red)
                .labelStyle(.iconOnly)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                    isPressed = pressing
                }, perform: {})

                Button("Increase \(nutrient.rawValue)", systemImage: "plus.circle.fill") {
                    animateValueChange()
                    onIncrement()
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
