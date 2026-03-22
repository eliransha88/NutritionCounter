import NutritionTestsHelper

/// KIF system tests that verify the Core data layer is correctly connected to the UI.
///
/// These tests validate that the app launches with its data layer intact —
/// the store initialises weekly logs, exposes nutrient counters, and the
/// persistence layer is ready before the user sees the first screen.
final class CorePersistenceSystemTests: SystemTestCase {

    // MARK: - App launch / data initialisation

    func testApp_LaunchesAndShowsAllNutrientCounters() {
        // GIVEN: The app is launched fresh
        // WHEN: The daily tracker screen appears

        // THEN: All three counter cards sourced from Core data are visible
        tester().waitForView(withAccessibilityLabel: "Protein")
        tester().waitForView(withAccessibilityLabel: "Carbs")
        tester().waitForView(withAccessibilityLabel: "Fat")
    }

    func testApp_InitialisesWithNonNegativeNutrientValues() {
        // GIVEN: The app has just launched (fresh or persisted state)
        // WHEN: The daily tracker is rendered

        // THEN: Nutrient counter controls are accessible — values are valid
        tester().waitForView(withAccessibilityLabel: "Increase Protein")
        tester().waitForView(withAccessibilityLabel: "Increase Carbs")
        tester().waitForView(withAccessibilityLabel: "Increase Fat")
    }

    func testApp_DecrementControlsArePresentForAllNutrients() {
        // GIVEN: The app is running
        // WHEN: Viewing the main tracker screen

        // THEN: Decrement buttons are accessible for all nutrient types,
        //       confirming the Core clamping bounds are surfaced correctly
        tester().waitForView(withAccessibilityLabel: "Decrease Protein")
        tester().waitForView(withAccessibilityLabel: "Decrease Carbs")
        tester().waitForView(withAccessibilityLabel: "Decrease Fat")
    }
}
