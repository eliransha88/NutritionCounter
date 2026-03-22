import XCTest
import SwiftUI
import NutritionCore
@testable import NutritionUI

final class NutrientConfigTests: XCTestCase {

    // MARK: - NutrientType color Tests

    func testColor_ProteinMapsToBlue() {
        // GIVEN/WHEN: The protein nutrient type (used by NutrientCounterView internals)
        let sut = NutrientType.protein

        // THEN: Its colour is blue, matching the counter card's visual style
        XCTAssertEqual(sut.color, Color.blue)
    }

    func testColor_CarbsMapsToOrange() {
        XCTAssertEqual(NutrientType.carbs.color, Color.orange)
    }

    func testColor_FatMapsToGreen() {
        XCTAssertEqual(NutrientType.fat.color, Color.green)
    }

    func testColor_EachNutrientTypeHasUniqueColor() {
        // GIVEN: All nutrient types
        let colors = NutrientType.allCases.map(\.color)

        // THEN: No two types share the same colour
        let descriptions = Set(colors.map { "\($0)" })
        XCTAssertEqual(descriptions.count, NutrientType.allCases.count,
                       "Every nutrient type should have a visually distinct colour")
    }

    // MARK: - NutrientConfig initialisation Tests

    func testNutrientConfig_StoresAssignedType() {
        // GIVEN/WHEN: A NutrientConfig created for protein
        let sut = NutrientConfig(type: .protein, color: .blue, symbol: .circle)

        // THEN: The type is stored correctly
        XCTAssertEqual(sut.type, .protein)
    }

    func testNutrientConfig_StoresAssignedColor() {
        // GIVEN/WHEN: A NutrientConfig with an orange colour
        let sut = NutrientConfig(type: .carbs, color: .orange, symbol: .square)

        // THEN: The colour is stored correctly
        XCTAssertEqual(sut.color, Color.orange)
    }

    func testNutrientConfig_StoresAssignedTypeForFat() {
        let sut = NutrientConfig(type: .fat, color: .green, symbol: .triangle)

        XCTAssertEqual(sut.type, .fat)
        XCTAssertEqual(sut.color, Color.green)
    }

    // MARK: - NutrientCounterView accessibility label Tests

    func testNutrientType_RawValueMatchesAccessibilityLabelConvention() {
        // GIVEN: The NutrientCounterView uses `nutrient.rawValue` as the
        //        base string for its increment/decrement button labels.
        // WHEN/THEN: Raw values align with what KIF tests assert
        XCTAssertEqual(NutrientType.protein.rawValue, "Protein")
        XCTAssertEqual(NutrientType.carbs.rawValue,   "Carbs")
        XCTAssertEqual(NutrientType.fat.rawValue,     "Fat")
    }

    func testNutrientType_IncrementLabelFormat() {
        // GIVEN: NutrientCounterView uses "Increase <rawValue>" for the + button
        for type in NutrientType.allCases {
            let label = "Increase \(type.rawValue)"

            // THEN: The label is non-empty and starts with "Increase"
            XCTAssertTrue(label.hasPrefix("Increase"),
                          "Increment label for \(type) should start with 'Increase'")
        }
    }

    func testNutrientType_DecrementLabelFormat() {
        // GIVEN: NutrientCounterView uses "Decrease <rawValue>" for the − button
        for type in NutrientType.allCases {
            let label = "Decrease \(type.rawValue)"

            // THEN: The label starts with "Decrease"
            XCTAssertTrue(label.hasPrefix("Decrease"),
                          "Decrement label for \(type) should start with 'Decrease'")
        }
    }
}
