import SwiftUI

struct DailyCountersView: View {
    var store: NutritionStore

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
            ForEach(NutrientType.allCases, id: \.self) { nutrient in
                NutrientCounterView(
                    nutrient: nutrient,
                    value: currentNutrientValue(for: nutrient),
                    goal: currentNutrientGoal(for: nutrient),
                    onIncrement: { incrementNutrient(nutrient) },
                    onDecrement: { decrementNutrient(nutrient) }
                )
            }
        }
    }

    private func currentNutrientValue(for nutrient: NutrientType) -> Double {
        guard let currentLog = store.getCurrentDayLog() else { return 0 }
        return switch nutrient {
        case .protein: currentLog.protein
        case .carbs: currentLog.carbs
        case .fat: currentLog.fat
        }
    }

    private func currentNutrientGoal(for nutrient: NutrientType) -> Double {
        switch nutrient {
        case .protein: store.dailyGoals.protein
        case .carbs: store.dailyGoals.carbs
        case .fat: store.dailyGoals.fat
        }
    }

    private func incrementNutrient(_ nutrient: NutrientType) {
        let currentValue = currentNutrientValue(for: nutrient)
        let newValue = min(10, currentValue + 0.5)
        withAnimation {
            store.updateNutrient(for: .now, type: nutrient, value: newValue)
        }
    }

    private func decrementNutrient(_ nutrient: NutrientType) {
        let currentValue = currentNutrientValue(for: nutrient)
        let newValue = max(0, currentValue - 0.5)
        withAnimation {
            store.updateNutrient(for: .now, type: nutrient, value: newValue)
        }
    }
}

#Preview {
    DailyCountersView(store: NutritionStore())
}
