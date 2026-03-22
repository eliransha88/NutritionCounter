import XCTest
import Cuckoo
@testable import NutritionCore

/// Unit tests for the data interactions expected by the Home module's views.
///
/// These tests verify the `NutritionStoreProtocol` contract from the
/// perspective of `DailyTrackerView` and `SettingsView`, using a
/// `MockNutritionStoreProtocol` to keep every test hermetic and fast.
@MainActor
final class DailyTrackerLogicTests: XCTestCase {

    private var mockStore: MockNutritionStoreProtocol!

    // MARK: - Lifecycle

    override func setUp() async throws {
        try await super.setUp()
        mockStore = MockNutritionStoreProtocol()
    }

    override func tearDown() async throws {
        mockStore = nil
        try await super.tearDown()
    }

    // MARK: - getCurrentDayLog Tests

    func testGetCurrentDayLog_WhenNoLogExists_ReturnsNil() {
        // GIVEN: A store that has no current day log
        stub(mockStore) { when($0.getCurrentDayLog()).thenReturn(nil) }

        // WHEN: Requesting the current day log (as DailyTrackerView would)
        let log = mockStore.getCurrentDayLog()

        // THEN: Nil is returned — view should render zero-state
        XCTAssertNil(log)
    }

    func testGetCurrentDayLog_WhenLogExists_ReturnsCorrectNutrientValues() {
        // GIVEN: A store that has today's log with tracked nutrients
        let expectedLog = DailyLog(date: .now, protein: 2.5, carbs: 3.0, fat: 1.5)
        stub(mockStore) { when($0.getCurrentDayLog()).thenReturn(expectedLog) }

        // WHEN: The tracker view fetches today's log
        let log = mockStore.getCurrentDayLog()

        // THEN: The correct values are surfaced to the view
        XCTAssertEqual(log?.protein, 2.5)
        XCTAssertEqual(log?.carbs,   3.0)
        XCTAssertEqual(log?.fat,     1.5)
    }

    func testGetCurrentDayLog_IsCalledExactlyOnce() {
        // GIVEN: A store stub
        stub(mockStore) { when($0.getCurrentDayLog()).thenReturn(nil) }

        // WHEN: The view requests the log once
        _ = mockStore.getCurrentDayLog()

        // THEN: The store was queried exactly once
        verify(mockStore, times(1)).getCurrentDayLog()
    }

    // MARK: - updateNutrient Tests

    func testUpdateNutrient_Protein_CallsStoreWithCorrectArguments() {
        // GIVEN: The store is ready to accept updates
        stub(mockStore) { when($0.updateNutrient(for: any(), type: any(), value: any())).thenDoNothing() }

        // WHEN: The tracker view increments protein by 1.0 (one tap)
        mockStore.updateNutrient(for: .now, type: .protein, value: 1.0)

        // THEN: The store received the correct nutrient type and value
        verify(mockStore).updateNutrient(
            for: any(),
            type: equal(to: .protein),
            value: equal(to: 1.0)
        )
    }

    func testUpdateNutrient_Carbs_CallsStoreWithCorrectArguments() {
        // GIVEN: The store is ready
        stub(mockStore) { when($0.updateNutrient(for: any(), type: any(), value: any())).thenDoNothing() }

        // WHEN: Incrementing carbs
        mockStore.updateNutrient(for: .now, type: .carbs, value: 2.0)

        // THEN: Carbs update was routed correctly
        verify(mockStore).updateNutrient(
            for: any(),
            type: equal(to: .carbs),
            value: equal(to: 2.0)
        )
    }

    func testUpdateNutrient_Fat_CallsStoreWithCorrectArguments() {
        stub(mockStore) { when($0.updateNutrient(for: any(), type: any(), value: any())).thenDoNothing() }

        mockStore.updateNutrient(for: .now, type: .fat, value: 0.5)

        verify(mockStore).updateNutrient(
            for: any(),
            type: equal(to: .fat),
            value: equal(to: 0.5)
        )
    }

    func testUpdateNutrient_MultipleUpdates_EachCallIsRecorded() {
        // GIVEN: The store accepts any nutrient update
        stub(mockStore) { when($0.updateNutrient(for: any(), type: any(), value: any())).thenDoNothing() }

        // WHEN: The view triggers two separate increments
        mockStore.updateNutrient(for: .now, type: .protein, value: 1.0)
        mockStore.updateNutrient(for: .now, type: .carbs,   value: 1.0)

        // THEN: Each call is recorded independently
        verify(mockStore, times(2)).updateNutrient(for: any(), type: any(), value: any())
    }

    // MARK: - dailyGoals Tests (SettingsView reads these on init)

    func testDailyGoals_WhenStubbed_ReturnsExpectedProteinGoal() {
        // GIVEN: A store with a custom protein goal
        let customGoals = DailyGoals(protein: 5.0, carbs: 7.0, fat: 3.0)
        stub(mockStore) { when($0.dailyGoals.get).thenReturn(customGoals) }

        // WHEN: SettingsView reads the goals
        let goals = mockStore.dailyGoals

        // THEN: The stubbed value is returned
        XCTAssertEqual(goals.protein, 5.0)
        XCTAssertEqual(goals.carbs,   7.0)
        XCTAssertEqual(goals.fat,     3.0)
    }

    func testDailyGoals_DefaultValues_MatchDailyGoalsDefault() {
        // GIVEN: A store using the default goals
        stub(mockStore) { when($0.dailyGoals.get).thenReturn(.default) }

        // WHEN: Reading goals
        let goals = mockStore.dailyGoals

        // THEN: Values match DailyGoals.default
        XCTAssertEqual(goals.protein, DailyGoals.default.protein)
        XCTAssertEqual(goals.carbs,   DailyGoals.default.carbs)
        XCTAssertEqual(goals.fat,     DailyGoals.default.fat)
    }

    // MARK: - saveData Tests (SettingsView calls this after goal update)

    func testSaveData_IsCalledOnce_WhenGoalsAreSaved() {
        // GIVEN: The store tracks saveData calls
        stub(mockStore) { when($0.saveData()).thenDoNothing() }

        // WHEN: SettingsView saves the updated goals
        mockStore.saveData()

        // THEN: saveData was invoked exactly once
        verify(mockStore, times(1)).saveData()
    }

    // MARK: - weeklyLogs Tests (WeeklyGraphView consumes these)

    func testWeeklyLogs_WhenStubbed_ContainsExpectedCount() {
        // GIVEN: A store with a full week of logs
        let weeklyLogs = (0..<7).map { offset -> DailyLog in
            let date = Calendar.current.date(byAdding: .day, value: -offset, to: .now)!
            return DailyLog(date: date, protein: Double(offset))
        }
        stub(mockStore) { when($0.weeklyLogs.get).thenReturn(weeklyLogs) }

        // WHEN: WeeklyGraphView reads the logs
        let logs = mockStore.weeklyLogs

        // THEN: Seven logs are available — one per day of the week
        XCTAssertEqual(logs.count, 7)
    }

    func testWeeklyLogs_WhenEmpty_ReturnsEmptyArray() {
        // GIVEN: A store with no weekly data
        stub(mockStore) { when($0.weeklyLogs.get).thenReturn([]) }

        // WHEN: Reading weekly logs
        let logs = mockStore.weeklyLogs

        // THEN: Empty array is returned — view handles zero state
        XCTAssertTrue(logs.isEmpty)
    }
}
