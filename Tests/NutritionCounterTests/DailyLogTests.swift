import XCTest
@testable import NutritionCore

final class DailyLogTests: XCTestCase {

    // MARK: - Lifecycle

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - init Tests

    func testInit_DefaultsAllNutrientsToZero() {
        // GIVEN/WHEN: A DailyLog created with default arguments
        let sut = DailyLog(date: .now)

        // THEN: All nutrient values start at zero
        XCTAssertEqual(sut.protein, 0)
        XCTAssertEqual(sut.carbs,   0)
        XCTAssertEqual(sut.fat,     0)
    }

    func testInit_StoresProvidedValues() {
        // GIVEN/WHEN: A DailyLog created with explicit nutrient values
        let sut = DailyLog(date: .now, protein: 1.5, carbs: 2.5, fat: 0.5)

        // THEN: Values match the provided arguments
        XCTAssertEqual(sut.protein, 1.5)
        XCTAssertEqual(sut.carbs,   2.5)
        XCTAssertEqual(sut.fat,     0.5)
    }

    // MARK: - total Tests

    func testTotal_SumsAllNutrients() {
        // GIVEN: A log with known nutrient values
        let sut = DailyLog(date: .now, protein: 2.0, carbs: 3.0, fat: 1.0)

        // WHEN: Accessing the computed total
        let total = sut.total

        // THEN: Total equals the sum of all nutrients
        XCTAssertEqual(total, 6.0, accuracy: 0.001)
    }

    func testTotal_IsZeroWhenAllNutrientsAreZero() {
        // GIVEN: A log with no nutrients tracked
        let sut = DailyLog(date: .now)

        // THEN: Total is zero
        XCTAssertEqual(sut.total, 0)
    }

    // MARK: - Equatable Tests

    func testEquality_SameIdAreEqual() {
        // GIVEN: Two logs sharing the same UUID
        let id   = UUID()
        let date = Date.now
        let lhs  = DailyLog(id: id, date: date, protein: 1, carbs: 2, fat: 3)
        let rhs  = DailyLog(id: id, date: date, protein: 1, carbs: 2, fat: 3)

        // THEN: They are considered equal
        XCTAssertEqual(lhs, rhs)
    }

    func testEquality_DifferentIdsAreNotEqual() {
        // GIVEN: Two logs with distinct UUIDs
        let lhs = DailyLog(date: .now)
        let rhs = DailyLog(date: .now)

        // THEN: They are not equal
        XCTAssertNotEqual(lhs, rhs)
    }

    // MARK: - Codable Tests

    func testEncodeDecode_RoundTripsSuccessfully() throws {
        // GIVEN: A fully populated DailyLog
        let original = DailyLog(date: .now, protein: 1.0, carbs: 2.0, fat: 3.0)

        // WHEN: Encoding then decoding
        let data    = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(DailyLog.self, from: data)

        // THEN: All fields are preserved
        XCTAssertEqual(decoded.id,      original.id)
        XCTAssertEqual(decoded.protein, original.protein)
        XCTAssertEqual(decoded.carbs,   original.carbs)
        XCTAssertEqual(decoded.fat,     original.fat)
    }
}
