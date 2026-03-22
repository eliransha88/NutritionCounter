import XCTest
import SwiftUI
@testable import NutritionCore

final class NutrientTypeTests: XCTestCase {

    // MARK: - rawValue Tests

    func testRawValue_ProteinIsCorrect() {
        // GIVEN/WHEN: The protein nutrient type
        // THEN: Its raw string value matches the expected key
        XCTAssertEqual(NutrientType.protein.rawValue, "Protein")
    }

    func testRawValue_CarbsIsCorrect() {
        XCTAssertEqual(NutrientType.carbs.rawValue, "Carbs")
    }

    func testRawValue_FatIsCorrect() {
        XCTAssertEqual(NutrientType.fat.rawValue, "Fat")
    }

    // MARK: - color Tests

    func testColor_ProteinIsBlue() {
        // GIVEN/WHEN: The protein nutrient type
        // THEN: Its color is blue
        XCTAssertEqual(NutrientType.protein.color, Color.blue)
    }

    func testColor_CarbsIsOrange() {
        XCTAssertEqual(NutrientType.carbs.color, Color.orange)
    }

    func testColor_FatIsGreen() {
        XCTAssertEqual(NutrientType.fat.color, Color.green)
    }

    func testColor_AllTypesHaveDistinctColors() {
        // GIVEN: All nutrient types
        let colors = NutrientType.allCases.map(\.color)

        // THEN: Each type has a unique color
        let uniqueDescriptions = Set(colors.map { "\($0)" })
        XCTAssertEqual(uniqueDescriptions.count, NutrientType.allCases.count)
    }

    // MARK: - CaseIterable Tests

    func testCaseIterable_HasExactlyThreeCases() {
        // GIVEN/WHEN: All nutrient type cases
        // THEN: Three nutrient types exist
        XCTAssertEqual(NutrientType.allCases.count, 3)
    }

    func testCaseIterable_ContainsAllExpectedTypes() {
        // GIVEN/WHEN: All nutrient type cases
        let allCases = NutrientType.allCases

        // THEN: Protein, carbs, and fat are all present
        XCTAssertTrue(allCases.contains(.protein))
        XCTAssertTrue(allCases.contains(.carbs))
        XCTAssertTrue(allCases.contains(.fat))
    }

    // MARK: - localizedAbbreviation Tests

    func testLocalizedAbbreviation_IsNonEmpty() {
        // GIVEN/WHEN: Each nutrient type
        // THEN: All abbreviated names have at least one character
        for type in NutrientType.allCases {
            XCTAssertFalse(
                type.localizedAbbreviation.isEmpty,
                "\(type.rawValue) abbreviation should not be empty"
            )
        }
    }

    func testLocalizedAbbreviation_IsExactlyOneCharacter() {
        // GIVEN/WHEN: Each nutrient type
        // THEN: Abbreviation is a single character (first letter of the name)
        for type in NutrientType.allCases {
            XCTAssertEqual(
                type.localizedAbbreviation.count, 1,
                "\(type.rawValue) abbreviation should be a single character"
            )
        }
    }
}
