import SwiftUI

struct NutrientGoalRow: View {
    let title: String
    @Binding var value: Double
    let color: Color

    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .foregroundStyle(.primary)
                .font(.body)
                .transition(.opacity.combined(with: .move(edge: .leading)))

            Spacer()

            HStack(spacing: 16) {
                Button("Decrease \(title) goal", systemImage: "minus.circle.fill", action: decrementValue)
                    .font(.title2)
                    .foregroundStyle(.red)
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())

                Text(value, format: .number.precision(.fractionLength(1)))
                    .font(.headline)
                    .foregroundStyle(color)
                    .frame(minWidth: 50)

                Button("Increase \(title) goal", systemImage: "plus.circle.fill", action: incrementValue)
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
    NutrientGoalRow(
        title: "Protein",
        value: .constant(3.0),
        color: .blue
    )
    .padding()
}
