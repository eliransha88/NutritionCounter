import SwiftUI

struct SettingsView: View {
    var store: NutritionStore
    @Environment(\.dismiss) private var dismiss

    @State private var proteinGoal: Double
    @State private var carbsGoal: Double
    @State private var fatGoal: Double

    init(store: NutritionStore) {
        self.store = store
        self._proteinGoal = State(initialValue: store.dailyGoals.protein)
        self._carbsGoal = State(initialValue: store.dailyGoals.carbs)
        self._fatGoal = State(initialValue: store.dailyGoals.fat)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Daily Goals")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Set your daily target servings for each macronutrient")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                }

                Section {
                    NutrientGoalRow(
                        title: "Protein",
                        value: $proteinGoal,
                        color: .blue
                    )

                    NutrientGoalRow(
                        title: "Carbohydrates",
                        value: $carbsGoal,
                        color: .orange
                    )

                    NutrientGoalRow(
                        title: "Fat",
                        value: $fatGoal,
                        color: .green
                    )
                }

                Section {
                    Button("Save Goals") {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            saveGoals()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .navigationTitle("Daily Goals")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveGoals() {
        store.dailyGoals.protein = proteinGoal
        store.dailyGoals.carbs = carbsGoal
        store.dailyGoals.fat = fatGoal
        store.saveData()
        dismiss()
    }
}

#Preview {
    SettingsView(store: NutritionStore())
}
