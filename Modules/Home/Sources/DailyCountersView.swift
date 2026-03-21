import SwiftUI
import NutritionCore
import NutritionUI

public struct DailyCountersView: View {
    public var store: NutritionStore

    public init(store: NutritionStore) {
        self.store = store
    }

    public var body: some View {
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
        let newValue = min(10, currentNutrientValue(for: nutrient) + 0.5)
        withAnimation {
            store.updateNutrient(for: .now, type: nutrient, value: newValue)
        }
    }

    private func decrementNutrient(_ nutrient: NutrientType) {
        let newValue = max(0, currentNutrientValue(for: nutrient) - 0.5)
        withAnimation {
            store.updateNutrient(for: .now, type: nutrient, value: newValue)
        }
    }
}

#Preview {
    DailyCountersView(store: NutritionStore())
}
