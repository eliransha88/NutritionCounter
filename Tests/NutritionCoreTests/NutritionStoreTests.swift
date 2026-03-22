import XCTest
import Cuckoo
@testable import NutritionCore

/// Unit tests for `NutritionStore`.
///
/// Each test exercises the store in isolation:
/// - A dedicated `UserDefaults` suite prevents production data pollution.
/// - `MockWidgetReloaderProtocol` (generated) replaces `WidgetCenter` so
///   widget-reload calls can be stubbed and verified without live IPC.
@MainActor
final class NutritionStoreTests: XCTestCase {

    private var sut: NutritionStore!
    private let testSuiteName       = "com.eliransharabi.NutritionCoreTests"
    private let widgetTestSuiteName = "com.eliransharabi.NutritionCoreTests.widget"

    // MARK: - Lifecycle

    override func setUp() async throws {
        try await super.setUp()
        cleanUpTestDefaults()
        sut = NutritionStore(storageSuiteName: testSuiteName, widgetReloader: NoOpWidgetReloader())
    }

    override func tearDown() async throws {
        cleanUpTestDefaults()
        cleanUpWidgetTestDefaults()
        sut = nil
        try await super.tearDown()
    }

    // MARK: - initializeWeekIfNeeded Tests

    func testInitializeWeekIfNeeded_CreatesSevenDayLogs() {
        // GIVEN: A fresh store with an empty weekly log

        // WHEN: The store initialises (happens automatically in setUp)

        // THEN: Exactly 7 logs are created — one per day of the current week
        XCTAssertEqual(sut.weeklyLogs.count, 7)
    }

    func testInitializeWeekIfNeeded_AllLogsDefaultToZeroNutrients() {
        // GIVEN/WHEN: A freshly initialised store

        // THEN: Every day starts with no nutrients tracked
        for log in sut.weeklyLogs {
            XCTAssertEqual(log.protein, 0)
            XCTAssertEqual(log.carbs,   0)
            XCTAssertEqual(log.fat,     0)
        }
    }

    func testInitializeWeekIfNeeded_DoesNotResetExistingWeek() {
        // GIVEN: A store with an already-tracked day
        sut.updateNutrient(for: .now, type: .protein, value: 3.0)

        // WHEN: Calling initializeWeekIfNeeded again
        sut.initializeWeekIfNeeded()

        // THEN: Tracked value is preserved
        XCTAssertEqual(sut.getCurrentDayLog()?.protein, 3.0)
    }

    // MARK: - updateNutrient Tests

    func testUpdateNutrient_UpdatesProtein() {
        // GIVEN: A fresh store with today's log at zero

        // WHEN: Updating protein to 2.5
        sut.updateNutrient(for: .now, type: .protein, value: 2.5)

        // THEN: Today's protein reflects the new value
        XCTAssertEqual(sut.getCurrentDayLog()?.protein, 2.5)
    }

    func testUpdateNutrient_UpdatesCarbs() {
        // GIVEN: A fresh store

        // WHEN: Updating carbs to 3.0
        sut.updateNutrient(for: .now, type: .carbs, value: 3.0)

        // THEN: Carbs are updated
        XCTAssertEqual(sut.getCurrentDayLog()?.carbs, 3.0)
    }

    func testUpdateNutrient_UpdatesFat() {
        // GIVEN: A fresh store

        // WHEN: Updating fat to 1.5
        sut.updateNutrient(for: .now, type: .fat, value: 1.5)

        // THEN: Fat is updated
        XCTAssertEqual(sut.getCurrentDayLog()?.fat, 1.5)
    }

    func testUpdateNutrient_ClampsValueAboveMax() {
        // GIVEN: A value above the allowed maximum of 10

        // WHEN: Updating protein with an out-of-bounds value
        sut.updateNutrient(for: .now, type: .protein, value: 15)

        // THEN: Value is clamped to 10
        XCTAssertEqual(sut.getCurrentDayLog()?.protein, 10)
    }

    func testUpdateNutrient_ClampsNegativeValueToZero() {
        // GIVEN: A negative value (invalid for nutrient counters)

        // WHEN: Attempting to set protein below zero
        sut.updateNutrient(for: .now, type: .protein, value: -2)

        // THEN: Value is clamped to 0
        XCTAssertEqual(sut.getCurrentDayLog()?.protein, 0)
    }

    func testUpdateNutrient_DoesNothingForUnknownDate() {
        // GIVEN: A date outside the current week
        let distantPast = Calendar.current.date(byAdding: .year, value: -1, to: .now)!

        // WHEN: Attempting to update a nutrient for that date
        sut.updateNutrient(for: distantPast, type: .protein, value: 5.0)

        // THEN: Weekly logs are unchanged
        let allProtein = sut.weeklyLogs.map(\.protein)
        XCTAssertTrue(allProtein.allSatisfy { $0 == 0 })
    }

    // MARK: - getCurrentDayLog Tests

    func testGetCurrentDayLog_ReturnsNonNilForToday() {
        // GIVEN/WHEN: A store initialised for the current week

        // THEN: Today's log is present
        XCTAssertNotNil(sut.getCurrentDayLog())
    }

    func testGetCurrentDayLog_ReflectsLatestUpdate() {
        // GIVEN: An initial protein value of 0
        // WHEN: Updating protein and then fetching today's log
        sut.updateNutrient(for: .now, type: .protein, value: 4.0)
        sut.updateNutrient(for: .now, type: .carbs,   value: 2.0)

        let log = sut.getCurrentDayLog()

        // THEN: Both updated nutrients are reflected
        XCTAssertEqual(log?.protein, 4.0)
        XCTAssertEqual(log?.carbs,   2.0)
    }

    // MARK: - dailyGoals Tests

    func testDailyGoals_DefaultsMatchDailyGoalsDefault() {
        // GIVEN/WHEN: A freshly constructed store

        // THEN: Goals match the DailyGoals.default
        XCTAssertEqual(sut.dailyGoals.protein, DailyGoals.default.protein)
        XCTAssertEqual(sut.dailyGoals.carbs,   DailyGoals.default.carbs)
        XCTAssertEqual(sut.dailyGoals.fat,     DailyGoals.default.fat)
    }

    func testDailyGoals_PersistsAfterSave() {
        // GIVEN: Updated goals
        sut.dailyGoals = DailyGoals(protein: 8, carbs: 9, fat: 4)

        // WHEN: Saving and reloading into a fresh store (same suite)
        sut.saveData()
        let reloaded = NutritionStore(storageSuiteName: testSuiteName, widgetReloader: NoOpWidgetReloader())

        // THEN: Persisted goals are restored
        XCTAssertEqual(reloaded.dailyGoals.protein, 8)
        XCTAssertEqual(reloaded.dailyGoals.carbs,   9)
        XCTAssertEqual(reloaded.dailyGoals.fat,     4)
    }

    // MARK: - WidgetReloader Tests

    func testSaveData_TriggersWidgetReload() {
        // GIVEN: A store backed by an empty suite so init always calls saveData once.
        let (store, reloader) = makeWidgetTestStorePair()

        // WHEN: Explicitly saving data
        store.saveData()

        // THEN: 2 total reloads (1 from init + 1 from explicit saveData)
        verify(reloader, times(2)).reloadTimelines(ofKind: any())
    }

    func testSaveData_ReloadsCorrectWidgetKind() {
        // GIVEN: A store backed by an empty suite
        let (store, reloader) = makeWidgetTestStorePair()

        // WHEN: Saving data
        store.saveData()

        // THEN: Every reload used the correct widget kind
        verify(reloader, atLeastOnce()).reloadTimelines(ofKind: equal(to: AppGroup.widgetKind))
    }

    func testUpdateNutrient_TriggersWidgetReloadOncePerUpdate() {
        // GIVEN: A store backed by an empty suite so init contributes exactly 1 reload.
        let (store, reloader) = makeWidgetTestStorePair()

        // WHEN: Updating two nutrients
        store.updateNutrient(for: .now, type: .protein, value: 1.0)
        store.updateNutrient(for: .now, type: .carbs,   value: 2.0)

        // THEN: 3 total reloads (1 from init + 1 per update)
        verify(reloader, times(3)).reloadTimelines(ofKind: any())
    }
}

// MARK: - Helpers

private extension NutritionStoreTests {

    func cleanUpTestDefaults() {
        UserDefaults(suiteName: testSuiteName)?.removePersistentDomain(forName: testSuiteName)
    }

    func cleanUpWidgetTestDefaults() {
        UserDefaults(suiteName: widgetTestSuiteName)?
            .removePersistentDomain(forName: widgetTestSuiteName)
    }

    /// Returns a (store, reloader) pair backed by a **clean** `widgetTestSuiteName`
    /// suite, guaranteeing that `initializeWeekIfNeeded` always runs from empty
    /// storage and calls `saveData` exactly once during `init`.
    func makeWidgetTestStorePair() -> (NutritionStore, MockWidgetReloaderProtocol) {
        cleanUpWidgetTestDefaults()
        let reloader = MockWidgetReloaderProtocol()
        stub(reloader) { when($0.reloadTimelines(ofKind: any())).thenDoNothing() }
        let store = NutritionStore(storageSuiteName: widgetTestSuiteName, widgetReloader: reloader)
        return (store, reloader)
    }
}
