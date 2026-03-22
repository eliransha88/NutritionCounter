import SwiftUI
import NutritionCore

public struct NutrientGoalRow: View {
    public let title: String
    @Binding public var value: Double
    public let color: Color

    public init(title: String, value: Binding<Double>, color: Color) {
        self.title = title
        self._value = value
        self.color = color
    }

    public var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.primary)
                .font(.body)
                .transition(.opacity.combined(with: .move(edge: .leading)))

            Spacer()

            HStack(spacing: 16) {
                Button {
                    decrementValue()
                } label: {
                    Label(NutritionUIStrings.decreaseGoal(title), systemImage: "minus.circle.fill")
                }
                .font(.title2)
                .foregroundStyle(.red)
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .contentShape(Rectangle())

                Text(value, format: .number.precision(.fractionLength(1)))
                    .font(.headline)
                    .foregroundStyle(color)
                    .frame(minWidth: 50)

                Button {
                    incrementValue()
                } label: {
                    Label(NutritionUIStrings.increaseGoal(title), systemImage: "plus.circle.fill")
                }
                .font(.title2)
                .foregroundStyle(.green)
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .contentShape(Rectangle())
            }
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }

    private func incrementValue() {
        withAnimation(.easeInOut(duration: 0.2)) {
            value = min(10, value + 0.5)
        }
    }

    private func decrementValue() {
        withAnimation(.easeInOut(duration: 0.2)) {
            value = max(0.5, value - 0.5)
        }
    }
}

#Preview {
    NutrientGoalRow(title: NutritionCoreStrings.protein, value: .constant(3.0), color: .blue)
        .padding()
}
