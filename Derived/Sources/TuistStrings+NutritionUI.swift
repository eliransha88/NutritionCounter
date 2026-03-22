// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum NutritionUIStrings: Sendable {
  /// Congrats! Goal reached
  public static let congratsGoalReached = NutritionUIStrings.tr("Localizable", "Congrats! Goal reached")
  /// Daily Totals
  public static let dailyTotals = NutritionUIStrings.tr("Localizable", "Daily Totals")
  /// Decrease %1$@
  public static func decrease(_ p1: Any) -> String {
    return NutritionUIStrings.tr("Localizable", "Decrease %@",String(describing: p1))
  }
  /// Decrease %1$@ goal
  public static func decreaseGoal(_ p1: Any) -> String {
    return NutritionUIStrings.tr("Localizable", "Decrease %@ goal",String(describing: p1))
  }
  /// Increase %1$@
  public static func increase(_ p1: Any) -> String {
    return NutritionUIStrings.tr("Localizable", "Increase %@",String(describing: p1))
  }
  /// Increase %1$@ goal
  public static func increaseGoal(_ p1: Any) -> String {
    return NutritionUIStrings.tr("Localizable", "Increase %@ goal",String(describing: p1))
  }
  /// No servings logged yet
  public static let noServingsLoggedYet = NutritionUIStrings.tr("Localizable", "No servings logged yet")
  /// Tap + on a nutrient below to start tracking
  public static let tapOnANutrientBelowToStartTracking = NutritionUIStrings.tr("Localizable", "Tap + on a nutrient below to start tracking")
  /// Weekly nutrient intake chart showing protein, carbs, and fat servings for each day of the week
  public static let weeklyNutrientIntakeChartShowingProteinCarbsAndFatServingsForEachDayOfTheWeek = NutritionUIStrings.tr("Localizable", "Weekly nutrient intake chart showing protein, carbs, and fat servings for each day of the week")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension NutritionUIStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
