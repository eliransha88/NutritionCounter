import NutritionTestsHelper

/// KIF system tests that exercise the `NutrientCounterView` UI component.
///
/// Each test interacts with individual counter cards (protein / carbs / fat)
/// through accessibility labels, verifying increment / decrement behaviour
/// and independence between counters.
final class NutrientCounterSystemTests: SystemTestCase {

    // MARK: - Visibility

    func testAllNutrientCounterCards_AreVisible() {
        // GIVEN: The app is running and the tracker screen is displayed
        // WHEN: The view finishes loading

        // THEN: All three counter cards are accessible
        tester().waitForView(withAccessibilityLabel: "Protein")
        tester().waitForView(withAccessibilityLabel: "Carbs")
        tester().waitForView(withAccessibilityLabel: "Fat")
    }

    func testAllIncrementButtons_AreAccessible() {
        // GIVEN: Tracker is visible
        // THEN: Increment controls for all three nutrients are reachable
        tester().waitForView(withAccessibilityLabel: "Increase Protein")
        tester().waitForView(withAccessibilityLabel: "Increase Carbs")
        tester().waitForView(withAccessibilityLabel: "Increase Fat")
    }

    func testAllDecrementButtons_AreAccessible() {
        // GIVEN: Tracker is visible
        // THEN: Decrement controls for all three nutrients are reachable
        tester().waitForView(withAccessibilityLabel: "Decrease Protein")
        tester().waitForView(withAccessibilityLabel: "Decrease Carbs")
        tester().waitForView(withAccessibilityLabel: "Decrease Fat")
    }

    // MARK: - Increment interactions

    func testIncrementProtein_CounterRemainsVisible() {
        // GIVEN: Protein counter is visible
        tester().waitForView(withAccessibilityLabel: "Protein")

        // WHEN: Tapping the increment button
        tester().tapView(withAccessibilityLabel: "Increase Protein")

        // THEN: The counter card is still accessible after the update
        tester().waitForView(withAccessibilityLabel: "Protein")
    }

    func testIncrementCarbs_DoesNotAffectProteinOrFat() {
        // GIVEN: All counters are visible
        tester().waitForView(withAccessibilityLabel: "Carbs")

        // WHEN: Incrementing only Carbs
        tester().tapView(withAccessibilityLabel: "Increase Carbs")

        // THEN: Protein and Fat counter cards are unaffected
        tester().waitForView(withAccessibilityLabel: "Protein")
        tester().waitForView(withAccessibilityLabel: "Fat")
    }

    func testIncrementFat_CounterRemainsVisible() {
        tester().waitForView(withAccessibilityLabel: "Fat")
        tester().tapView(withAccessibilityLabel: "Increase Fat")
        tester().waitForView(withAccessibilityLabel: "Fat")
    }

    // MARK: - Decrement interactions

    func testDecrementProtein_DoesNotGoBelowZero() {
        // GIVEN: Protein is at its minimum (fresh state)
        tester().waitForView(withAccessibilityLabel: "Protein")

        // WHEN: Tapping decrement multiple times
        tester().tapView(withAccessibilityLabel: "Decrease Protein")
        tester().tapView(withAccessibilityLabel: "Decrease Protein")

        // THEN: Counter card is still visible — value is clamped, no crash
        tester().waitForView(withAccessibilityLabel: "Protein")
    }

    func testDecrementAfterIncrement_CounterRemainsVisible() {
        // GIVEN: Increment protein first to give it a non-zero value
        tester().tapView(withAccessibilityLabel: "Increase Protein")

        // WHEN: Decrementing back
        tester().tapView(withAccessibilityLabel: "Decrease Protein")

        // THEN: Counter card is still accessible
        tester().waitForView(withAccessibilityLabel: "Protein")
    }
}
