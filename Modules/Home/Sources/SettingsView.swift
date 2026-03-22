import SwiftUI
import NutritionCore
import NutritionUI

public struct SettingsView: View {
    public var store: any NutritionStoreProtocol
    @Environment(\.dismiss) private var dismiss
    @State private var proteinGoal: Double
    @State private var carbsGoal: Double
    @State private var fatGoal: Double

    public init(store: any NutritionStoreProtocol) {
        self.store = store
        self._proteinGoal = State(initialValue: store.dailyGoals.protein)
        self._carbsGoal = State(initialValue: store.dailyGoals.carbs)
        self._fatGoal = State(initialValue: store.dailyGoals.fat)
    }

    public var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(NutritionHomeStrings.dailyGoals)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(NutritionHomeStrings.setYourDailyTargetServingsForEachMacronutrient)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                }

                Section {
                    NutrientGoalRow(title: NutritionCoreStrings.protein, value: $proteinGoal, color: .blue)
                    NutrientGoalRow(title: NutritionCoreStrings.carbs,   value: $carbsGoal,   color: .orange)
                    NutrientGoalRow(title: NutritionCoreStrings.fat,     value: $fatGoal,     color: .green)

                    Button(NutritionHomeStrings.saveGoals) {
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

                Section(header: Text(NutritionHomeStrings.language)) {
                    Button {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        HStack {
                            Text(NutritionHomeStrings.language)
                                .foregroundStyle(.primary)
                            Spacer()
                            Text(currentLanguageName)
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.forward")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section {
                    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "–"
                    let build   = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "–"
                    Text(NutritionHomeStrings.version(version, build))
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle(NutritionHomeStrings.dailyGoals)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(NutritionHomeStrings.cancel) { dismiss() }
                }
            }
        }
    }

    private var currentLanguageName: String {
        let code = Bundle.main.preferredLocalizations.first ?? "en"
        return Locale(identifier: code).localizedString(forLanguageCode: code)?.capitalized ?? code
    }

    private func saveGoals() {
        store.dailyGoals.protein = proteinGoal
        store.dailyGoals.carbs   = carbsGoal
        store.dailyGoals.fat     = fatGoal
        store.saveData()
        dismiss()
    }
}

#Preview {
    SettingsView(store: NutritionStore())
}
