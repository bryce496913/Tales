import XCTest
@testable import Tales

/// Counts saves, so tests can check each action writes once.
private final class CountingDefaults: UserDefaults {
    var writes = 0

    override func set(_ value: Any?, forKey defaultName: String) {
        writes += 1
        super.set(value, forKey: defaultName)
    }
}

final class AppNavigationStateTests: XCTestCase {
    private var defaults: CountingDefaults!
    private var suiteName: String!
    private var clock = Date(timeIntervalSince1970: 1_000)

    override func setUp() {
        super.setUp()
        suiteName = "TalesTests.\(UUID().uuidString)"
        defaults = CountingDefaults(suiteName: suiteName)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suiteName)
        super.tearDown()
    }

    @MainActor
    private func makeState() -> AppNavigationState {
        AppNavigationState(defaults: defaults, now: { [unowned self] in self.clock })
    }

    @MainActor
    func testEachActionSavesOnce() {
        let state = makeState()

        defaults.writes = 0
        state.startNewAdventure()
        XCTAssertEqual(defaults.writes, 1, "startNewAdventure")

        defaults.writes = 0
        state.navigate(to: .plot2)
        XCTAssertEqual(defaults.writes, 1, "navigate")

        defaults.writes = 0
        state.markEndingReached("page2-death")
        XCTAssertEqual(defaults.writes, 1, "markEndingReached")

        defaults.writes = 0
        state.resetToMainMenu()
        XCTAssertEqual(defaults.writes, 1, "resetToMainMenu")
    }

    @MainActor
    func testQuickSecondTapIsIgnored() {
        let state = makeState()
        state.startNewAdventure()

        state.navigate(to: .page(1))
        clock += 0.1
        state.navigate(to: .page(2))
        XCTAssertEqual(state.path, [.plot1, .page(1)])

        clock += AppNavigationState.navigationLockout
        state.navigate(to: .page(2))
        XCTAssertEqual(state.path, [.plot1, .page(1), .page(2)])
    }

    @MainActor
    func testReachingAnEndingRecordsItAndEndsTheRun() {
        let state = makeState()
        state.startNewAdventure()
        state.navigate(to: .page(2))

        state.markEndingReached("page2-death")

        XCTAssertTrue(state.completedEndings.contains("page2-death"))
        XCTAssertFalse(state.hasSavedProgress)
        clock += 1
        state.navigate(to: .page(3))
        XCTAssertEqual(state.path.last, .page(2), "No navigating on from an ending")
    }

    @MainActor
    func testProgressSurvivesRelaunch() {
        let first = makeState()
        first.startNewAdventure()
        first.navigate(to: .plot2)

        let relaunched = makeState()
        XCTAssertTrue(relaunched.hasSavedProgress)
        relaunched.continueAdventure()

        XCTAssertEqual(relaunched.path, [.plot2])
    }

    @MainActor
    func testResetClearsEndingsAndDoesNotResave() {
        let state = makeState()
        state.startNewAdventure()
        state.markEndingReached("page13-win")

        state.resetSavedProgress()

        XCTAssertTrue(state.completedEndings.isEmpty)
        XCTAssertFalse(state.hasSavedProgress)
        XCTAssertNil(defaults.data(forKey: "Tales.story.save.v2"))
    }
}
