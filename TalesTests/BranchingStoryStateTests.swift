import XCTest
@testable import Tales

final class BranchingStoryStateTests: XCTestCase {
    private var defaults: UserDefaults!
    private var suiteName: String!
    private var clock = Date(timeIntervalSince1970: 1_000)

    override func setUp() {
        super.setUp()
        suiteName = "TalesTests.\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suiteName)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suiteName)
        super.tearDown()
    }

    @MainActor
    private func makeState() -> TrialOfAnubisNavigationState {
        TrialOfAnubisNavigationState(defaults: defaults, now: { [unowned self] in self.clock })
    }

    /// Moves time past the navigation lockout before each step, as a player reading the page would.
    @MainActor
    private func walk(_ state: TrialOfAnubisNavigationState, to route: TrialOfAnubisRoute, collecting item: TrialOfAnubisItem? = nil, marking flag: TrialOfAnubisStoryFlag? = nil) {
        clock += TrialOfAnubisNavigationState.navigationLockout + 0.1
        state.navigate(to: route, collecting: item, marking: flag)
    }

    @MainActor
    func testNewAdventureStartsAtTheStartPage() {
        let state = makeState()
        state.startNewAdventure()

        XCTAssertEqual(state.path, [TrialOfAnubisRoute.start])
        XCTAssertEqual(state.progress.currentNodeID, TrialOfAnubisRoute.start.rawValue)
        XCTAssertTrue(state.hasSavedProgress)
    }

    @MainActor
    func testQuickSecondTapOnADifferentChoiceIsIgnored() {
        let state = makeState()
        state.startNewAdventure()

        state.navigate(to: .anu001)
        clock += 0.1
        state.navigate(to: .anu002)

        XCTAssertEqual(state.path, [.anu000, .anu001])
        XCTAssertEqual(state.progress.currentNodeID, TrialOfAnubisRoute.anu001.rawValue)

        clock += TrialOfAnubisNavigationState.navigationLockout
        state.navigate(to: .anu002)
        XCTAssertEqual(state.path, [.anu000, .anu001, .anu002])
    }

    @MainActor
    func testArrivingAtTheHubStartsAFreshStack() {
        let state = makeState()
        state.startNewAdventure()
        walk(state, to: .anu001)
        walk(state, to: .anu002)
        XCTAssertEqual(state.path.count, 3)

        walk(state, to: TrialOfAnubisRoute.home)

        XCTAssertEqual(state.path, [TrialOfAnubisRoute.home])
    }

    @MainActor
    func testHomeBecomesTheEndGameOnceEveryItemIsCollected() {
        let state = makeState()
        state.startNewAdventure()
        walk(state, to: .anu012, collecting: .feather)
        walk(state, to: .anu013, collecting: .heart)
        walk(state, to: .anu014, collecting: .balanceStone)
        XCTAssertTrue(state.progress.hasAllItems)

        walk(state, to: TrialOfAnubisRoute.home)

        XCTAssertEqual(state.path, [TrialOfAnubisRoute.endGame])
        XCTAssertEqual(state.progress.currentNodeID, TrialOfAnubisRoute.endGame.rawValue)
    }

    @MainActor
    func testReachingAnEndingRecordsItAndEndsTheRun() throws {
        let state = makeState()
        state.startNewAdventure()
        let ending = try XCTUnwrap(TrialOfAnubisRoute.allCases.first { $0.isEnding })

        walk(state, to: ending)

        XCTAssertTrue(state.progress.completedEndingIDs.contains(try XCTUnwrap(ending.endingID)))
        XCTAssertFalse(state.hasSavedProgress, "A finished run can't be continued")
        XCTAssertEqual(state.path.last, ending)
    }

    @MainActor
    func testOppositeFlagsReplaceEachOther() {
        let state = makeState()
        state.startNewAdventure()

        walk(state, to: .anu001, marking: .freedSoul)
        XCTAssertTrue(state.hasFlag(.freedSoul))

        walk(state, to: .anu002, marking: .abandonedSoul)
        XCTAssertTrue(state.hasFlag(.abandonedSoul))
        XCTAssertFalse(state.hasFlag(.freedSoul))
    }

    @MainActor
    func testNewAdventureKeepsCompletedEndings() throws {
        let state = makeState()
        state.startNewAdventure()
        let ending = try XCTUnwrap(TrialOfAnubisRoute.allCases.first { $0.isEnding })
        walk(state, to: ending)

        state.startNewAdventure()

        XCTAssertTrue(state.progress.completedEndingIDs.contains(try XCTUnwrap(ending.endingID)))
        XCTAssertTrue(state.progress.collectedItems.isEmpty)
        XCTAssertTrue(state.progress.storyFlags.isEmpty)
    }

    @MainActor
    func testProgressSurvivesRelaunchAndContinues() {
        let first = makeState()
        first.startNewAdventure()
        walk(first, to: .anu001, collecting: .feather, marking: .acceptedRebel)
        walk(first, to: .anu002)

        let relaunched = makeState()
        XCTAssertTrue(relaunched.hasSavedProgress)
        XCTAssertTrue(relaunched.path.isEmpty)

        relaunched.continueAdventure()

        XCTAssertEqual(relaunched.path, [.anu002])
        XCTAssertTrue(relaunched.progress.collectedItems.contains(.feather))
        XCTAssertTrue(relaunched.hasFlag(.acceptedRebel))
    }

    @MainActor
    func testSavesFromBeforeTheSharedEngineStillLoad() throws {
        let legacy = """
        {"currentNodeID":"ANU-005","visitedNodeIDs":["ANU-000","ANU-005"],"collectedItems":["heart"],"storyFlags":["freedSoul"],"completedEndingIDs":["anubis_released"]}
        """
        defaults.set(Data(legacy.utf8), forKey: TrialOfAnubis.saveKey)

        let state = makeState()
        XCTAssertTrue(state.hasSavedProgress)
        state.continueAdventure()

        XCTAssertEqual(state.path, [.anu005])
        XCTAssertEqual(state.progress.collectedItems, [.heart])
        XCTAssertEqual(state.progress.completedEndingIDs, ["anubis_released"])
    }

    @MainActor
    func testResetClearsTheRunAndEveryEnding() throws {
        let state = makeState()
        state.startNewAdventure()
        walk(state, to: try XCTUnwrap(TrialOfAnubisRoute.allCases.first { $0.isEnding }))

        state.resetAllProgress()

        XCTAssertTrue(state.progress.completedEndingIDs.isEmpty)
        XCTAssertFalse(state.hasSavedProgress)
        XCTAssertNil(defaults.data(forKey: TrialOfAnubis.saveKey))
    }

    @MainActor
    func testEveryEndingAppearsInTheGalleryWithItsPageArt() {
        for story in [TrialOfAnubis.endings, DescentToHades.endings] {
            XCTAssertFalse(story.isEmpty)
            XCTAssertEqual(Set(story.map(\.id)).count, story.count, "Ending IDs must be unique")
        }
        XCTAssertEqual(TrialOfAnubis.endings.count, TrialOfAnubisRoute.allCases.filter(\.isEnding).count)
        XCTAssertEqual(TrialOfAnubisRoute.anu012.imageName, "ANU012")
        XCTAssertEqual(DescentToHadesRoute.hds044.imageName, "HDS044")
    }
}
