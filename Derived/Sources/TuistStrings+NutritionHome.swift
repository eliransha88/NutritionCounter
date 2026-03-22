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
public enum NutritionHomeStrings: Sendable {
  /// Cancel
  public static let cancel = NutritionHomeStrings.tr("Localizable", "Cancel")
  /// Daily Goals
  public static let dailyGoals = NutritionHomeStrings.tr("Localizable", "Daily Goals")
  /// Language
  public static let language = NutritionHomeStrings.tr("Localizable", "Language")
  /// Nutrition Tracker
  public static let nutritionTracker = NutritionHomeStrings.tr("Localizable", "Nutrition Tracker")
  /// Save Goals
  public static let saveGoals = NutritionHomeStrings.tr("Localizable", "Save Goals")
  /// Set your daily target servings for each macronutrient
  public static let setYourDailyTargetServingsForEachMacronutrient = NutritionHomeStrings.tr("Localizable", "Set your daily target servings for each macronutrient")
  /// Settings
  public static let settings = NutritionHomeStrings.tr("Localizable", "Settings")
  /// Version %1$@ (%2$@)
  public static func version(_ p1: Any, _ p2: Any) -> String {
    return NutritionHomeStrings.tr("Localizable", "Version %@ (%@)",String(describing: p1), String(describing: p2))
  }
  /// Weekly Overview
  public static let weeklyOverview = NutritionHomeStrings.tr("Localizable", "Weekly Overview")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension NutritionHomeStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
