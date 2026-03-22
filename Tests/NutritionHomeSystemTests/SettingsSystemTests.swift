import NutritionTestsHelper

/// KIF system tests that exercise the `SettingsView` screen.
///
/// These tests open the Settings sheet from the main tracker, verify that
/// goal stepper rows are accessible, and confirm the sheet can be dismissed.
final class SettingsSystemTests: SystemTestCase {

    // MARK: - Opening Settings

    func testSettingsSheet_OpensFromMainView() {
        // GIVEN: The daily tracker is visible
        tester().waitForView(withAccessibilityLabel: "Protein")

        // WHEN: Tapping the Settings button in the navigation bar
        tester().tapView(withAccessibilityLabel: "Settings")

        // THEN: The Daily Goals form is presented
        tester().waitForView(withAccessibilityLabel: "Daily Goals")
    }

    // MARK: - Goal rows

    func testSettingsSheet_HasProteinGoalRow() {
        // GIVEN: Settings sheet is open
        tester().tapView(withAccessibilityLabel: "Settings")
        tester().waitForView(withAccessibilityLabel: "Daily Goals")

        // THEN: The Protein stepper row is visible
        tester().waitForView(withAccessibilityLabel: "Protein")
    }

    func testSettingsSheet_HasCarbsGoalRow() {
        tester().tapView(withAccessibilityLabel: "Settings")
        tester().waitForView(withAccessibilityLabel: "Daily Goals")

        tester().waitForView(withAccessibilityLabel: "Carbs")
    }

    func testSettingsSheet_HasFatGoalRow() {
        tester().tapView(withAccessibilityLabel: "Settings")
        tester().waitForView(withAccessibilityLabel: "Daily Goals")

        tester().waitForView(withAccessibilityLabel: "Fat")
    }

    func testSettingsSheet_HasSaveGoalsButton() {
        // GIVEN: Settings sheet is open
        tester().tapView(withAccessibilityLabel: "Settings")
        tester().waitForView(withAccessibilityLabel: "Daily Goals")

        // THEN: Save Goals button is accessible
        tester().waitForView(withAccessibilityLabel: "Save Goals")
    }

    // MARK: - Dismissal

    func testSettingsSheet_CanBeDismissedWithCancelButton() {
        // GIVEN: Settings sheet is open
        tester().tapView(withAccessibilityLabel: "Settings")
        tester().waitForView(withAccessibilityLabel: "Daily Goals")

        // WHEN: Tapping Cancel
        tester().tapView(withAccessibilityLabel: "Cancel")

        // THEN: The daily tracker screen is shown again
        tester().waitForView(withAccessibilityLabel: "Protein")
        tester().waitForView(withAccessibilityLabel: "Carbs")
        tester().waitForView(withAccessibilityLabel: "Fat")
    }
}
