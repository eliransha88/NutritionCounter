import AppIntents
import WidgetKit

struct IncrementNutrientIntent: AppIntent {
    static var title: LocalizedStringResource = "Increment Nutrient"
    static var description = IntentDescription("Increase a nutrient by 0.5 servings.")

    @Parameter(title: "Nutrient")
    var nutrient: NutrientTypeAppEnum

    init() {}

    init(nutrient: NutrientTypeAppEnum) {
        self.nutrient = nutrient
    }

    func perform() async throws -> some IntentResult {
        await WidgetMutationActor.shared.adjustNutrient(nutrient, delta: 0.5)
        WidgetCenter.shared.reloadTimelines(ofKind: WidgetDataStore.widgetKind)
        return .result()
    }
}

struct DecrementNutrientIntent: AppIntent {
    static var title: LocalizedStringResource = "Decrement Nutrient"
    static var description = IntentDescription("Decrease a nutrient by 0.5 servings.")

    @Parameter(title: "Nutrient")
    var nutrient: NutrientTypeAppEnum

    init() {}

    init(nutrient: NutrientTypeAppEnum) {
        self.nutrient = nutrient
    }

    func perform() async throws -> some IntentResult {
        await WidgetMutationActor.shared.adjustNutrient(nutrient, delta: -0.5)
        WidgetCenter.shared.reloadTimelines(ofKind: WidgetDataStore.widgetKind)
        return .result()
    }
}
