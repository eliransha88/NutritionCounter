import XCTest
@testable import NutritionCore

final class DailyGoalsTests: XCTestCase {

    // MARK: - Lifecycle

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - default Tests

    func testDefault_HasExpectedProteinGoal() {
        // GIVEN/WHEN: The default DailyGoals value
        let sut = DailyGoals.default

        // THEN: Protein goal is 3.0
        XCTAssertEqual(sut.protein, 3.0)
    }

    func testDefault_HasExpectedCarbsGoal() {
        // GIVEN/WHEN: The default DailyGoals value
        let sut = DailyGoals.default

        // THEN: Carbs goal is 4.0
        XCTAssertEqual(sut.carbs, 4.0)
    }

    func testDefault_HasExpectedFatGoal() {
        // GIVEN/WHEN: The default DailyGoals value
        let sut = DailyGoals.default

        // THEN: Fat goal is 2.0
        XCTAssertEqual(sut.fat, 2.0)
    }

    // MARK: - Codable Tests

    func testEncodeDecode_RoundTripsSuccessfully() throws {
        // GIVEN: A custom DailyGoals instance
        let original = DailyGoals(protein: 5.0, carbs: 6.0, fat: 3.0)

        // WHEN: Encoding then decoding
        let data    = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(DailyGoals.self, from: data)

        // THEN: Values are preserved
        XCTAssertEqual(decoded.protein, original.protein)
        XCTAssertEqual(decoded.carbs,   original.carbs)
        XCTAssertEqual(decoded.fat,     original.fat)
    }

    func testEncodeDecode_PreservesZeroValues() throws {
        // GIVEN: A DailyGoals instance with all zeros
        let zeroed = DailyGoals(protein: 0, carbs: 0, fat: 0)

        // WHEN: Encoding then decoding
        let data    = try JSONEncoder().encode(zeroed)
        let decoded = try JSONDecoder().decode(DailyGoals.self, from: data)

        // THEN: Zero values are preserved
        XCTAssertEqual(decoded.protein, 0)
        XCTAssertEqual(decoded.carbs,   0)
        XCTAssertEqual(decoded.fat,     0)
    }

    // MARK: - Mutability Tests

    func testMutability_CanUpdateProtein() {
        // GIVEN: A default DailyGoals
        var sut = DailyGoals.default

        // WHEN: Updating protein goal
        sut.protein = 7.5

        // THEN: New value is reflected
        XCTAssertEqual(sut.protein, 7.5)
    }
}
