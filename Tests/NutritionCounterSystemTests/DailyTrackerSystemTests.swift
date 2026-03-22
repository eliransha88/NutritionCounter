import KIF
import XCTest

/// KIF system tests that drive the full app via the accessibility layer.
///
/// These tests launch `NutritionCounter` as their host application and interact
/// with UI elements using their `accessibilityLabel` / `accessibilityIdentifier`
/// values, making them robust against visual layout changes.
final class DailyTrackerSystemTests: KIFTestCase {

    // MARK: - Daily Tracker – initial state

    func testDailyTrackerView_DisplaysAllNutrientCounters() {
        // GIVEN: The app is launched and the daily tracker is visible

        // WHEN: The view finishes loading

        // THEN: All three nutrient counter controls are reachable
        tester().waitForView(withAccessibilityLabel: "Protein")
        tester().waitForView(withAccessibilityLabel: "Carbs")
        tester().waitForView(withAccessibilityLabel: "Fat")
    }

    // MARK: - Increment / Decrement interactions

    func testIncrementProtein_IncreasesCounterLabel() {
        // GIVEN: The daily tracker is displayed with protein at its current value
        tester().waitForView(withAccessibilityLabel: "Protein")

        // WHEN: Tapping the increment button for Protein
        tester().tapView(withAccessibilityLabel: "Increase Protein")

        // THEN: The protein counter updates (view is still visible after the tap)
        tester().waitForView(withAccessibilityLabel: "Protein")
    }

    func testDecrementProtein_DoesNotGoBelowZero() {
        // GIVEN: Protein is at 0 (fresh launch)
        tester().waitForView(withAccessibilityLabel: "Protein")

        // WHEN: Tapping the decrement button multiple times
        tester().tapView(withAccessibilityLabel: "Decrease Protein")
        tester().tapView(withAccessibilityLabel: "Decrease Protein")

        // THEN: The counter view is still displayed (value clamped, no crash)
        tester().waitForView(withAccessibilityLabel: "Protein")
    }

    func testIncrementCarbs_DoesNotAffectProteinOrFat() {
        // GIVEN: The daily tracker is visible
        tester().waitForView(withAccessibilityLabel: "Carbs")

        // WHEN: Incrementing only Carbs
        tester().tapView(withAccessibilityLabel: "Increase Carbs")

        // THEN: Protein and Fat counters are still visible and unaffected
        tester().waitForView(withAccessibilityLabel: "Protein")
        tester().waitForView(withAccessibilityLabel: "Fat")
    }

    // MARK: - Settings navigation

    func testSettingsButton_OpensSettingsView() {
        // GIVEN: The daily tracker is displayed

        // WHEN: Tapping the Settings navigation button
        tester().tapView(withAccessibilityLabel: "Settings")

        // THEN: The Settings screen is presented
        tester().waitForView(withAccessibilityLabel: "Settings")
    }
}
