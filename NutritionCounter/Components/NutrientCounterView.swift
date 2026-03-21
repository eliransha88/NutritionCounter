import SwiftUI

struct NutrientCounterView: View {
    let nutrient: NutrientType
    let value: Double
    let goal: Double
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    @State private var isPressed = false
    @State private var valueScale: CGFloat = 1.0

    var body: some View {
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

                if value > goal {
                    Label("Goal exceeded!", systemImage: "checkmark.circle.fill")
                        .font(.caption)
                        .foregroundStyle(nutrientColor)
                }

                ProgressView(value: min(value, goal), total: goal)
                    .progressViewStyle(LinearProgressViewStyle(tint: progressColor))
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
        .padding()
        .background(Color(.systemBackground))
        .clipShape(.rect(cornerRadius: 12))
        .shadow(radius: 2)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
    }

    private func animateValueChange() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            valueScale = 1.2
        } completion: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                valueScale = 1.0
            }
        }
    }

    private var progressColor: Color {
        if value >= goal {
            .green
        } else if value > 0 {
            nutrientColor
        } else {
            .gray
        }
    }

    private var servingsTextColor: Color {
        if value >= goal {
            .green
        } else if value > 0 {
            nutrientColor
        } else {
            .secondary
        }
    }

    private var nutrientColor: Color {
        switch nutrient {
        case .protein: .blue
        case .carbs: .orange
        case .fat: .green
        }
    }
}

#Preview {
    NutrientCounterView(
        nutrient: .protein,
        value: 2.5,
        goal: 4.0,
        onIncrement: {},
        onDecrement: {}
    )
}
