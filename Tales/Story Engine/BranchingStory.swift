import SwiftUI

/// A page in a hub-based branching story (The Trial of Anubis, The Descent to Hades).
protocol BranchingRoute: RawRepresentable, Codable, Hashable, CaseIterable where RawValue == String {
    /// First page of a new adventure.
    static var start: Self { get }
    /// Hub page that links to the item paths.
    static var home: Self { get }
    /// What HOME becomes once every item has been collected.
    static var endGame: Self { get }
    /// Stable ID recorded when this page is a game over; `nil` for ordinary pages.
    var endingID: String? { get }
}

extension BranchingRoute {
    var isEnding: Bool { endingID != nil }
}

/// A choice the story remembers so later pages can react to it.
protocol BranchingStoryFlag: Codable, Hashable {
    /// A flag that cannot be held at the same time as this one.
    var opposite: Self? { get }
}

/// Everything that makes one branching story different from another: its content types,
/// its menu copy and art, its theme and where it saves.
protocol BranchingStory {
    associatedtype Route: BranchingRoute
    associatedtype Item: Codable & Hashable & CaseIterable
    associatedtype Flag: BranchingStoryFlag
    associatedtype Outcome: StoryOutcomeStyle
    associatedtype Destination: View

    static var title: String { get }
    /// Used in labels such as "Return to Anubis Menu".
    static var shortName: String { get }
    static var subtitle: String { get }
    static var titleImageName: String { get }
    static var theme: StoryTheme { get }
    static var saveKey: String { get }

    @MainActor static func destination(for route: Route) -> Destination
}

/// Saved progress through a branching story. The JSON shape matches the saves written by the
/// per-story progress types this replaced, so existing saves keep loading.
struct BranchingProgress<Item: Codable & Hashable & CaseIterable, Flag: BranchingStoryFlag>: Codable {
    var currentNodeID: String
    var visitedNodeIDs: Set<String>
    var collectedItems: Set<Item>
    var storyFlags: Set<Flag>
    var completedEndingIDs: Set<String>

    var hasAllItems: Bool {
        collectedItems.isSuperset(of: Item.allCases)
    }

    static func fresh(startingAt nodeID: String, keepingEndings completedEndingIDs: Set<String> = []) -> Self {
        Self(
            currentNodeID: nodeID,
            visitedNodeIDs: [nodeID],
            collectedItems: [],
            storyFlags: [],
            completedEndingIDs: completedEndingIDs
        )
    }
}

/// Navigation and saved progress for one branching story.
@MainActor
final class BranchingStoryState<Story: BranchingStory>: ObservableObject {
    typealias Route = Story.Route
    typealias Progress = BranchingProgress<Story.Item, Story.Flag>

    /// Minimum time between two navigations, so quick taps on two different choices during the
    /// push animation can't open both pages.
    static var navigationLockout: TimeInterval { 0.6 }

    @Published var path: [Route] = []
    @Published private(set) var progress: Progress
    @Published private(set) var hasSavedProgress: Bool

    private let defaults: UserDefaults
    private let now: () -> Date
    private var navigationUnlocksAt = Date.distantPast

    init(defaults: UserDefaults = .standard, now: @escaping () -> Date = { Date() }) {
        self.defaults = defaults
        self.now = now
        let saved = Self.loadProgress(from: defaults)
        progress = saved ?? .fresh(startingAt: Route.start.rawValue)
        hasSavedProgress = saved.map(Self.canContinue) ?? false
    }

    func hasFlag(_ flag: Story.Flag) -> Bool {
        progress.storyFlags.contains(flag)
    }

    func startNewAdventure() {
        progress = .fresh(startingAt: Route.start.rawValue, keepingEndings: progress.completedEndingIDs)
        navigationUnlocksAt = .distantPast
        path = [Route.start]
        persist()
    }

    func continueAdventure() {
        guard let saved = Self.loadProgress(from: defaults),
              let route = Route(rawValue: saved.currentNodeID),
              !route.isEnding else { return }

        progress = saved
        hasSavedProgress = true
        navigationUnlocksAt = .distantPast
        path = [route]
    }

    func navigate(to destination: Route, collecting item: Story.Item? = nil, marking flag: Story.Flag? = nil) {
        let time = now()
        guard time >= navigationUnlocksAt, path.last != destination else { return }
        navigationUnlocksAt = time.addingTimeInterval(Self.navigationLockout)

        if let item {
            progress.collectedItems.insert(item)
        }
        if let flag {
            progress.storyFlags.insert(flag)
            if let opposite = flag.opposite {
                progress.storyFlags.remove(opposite)
            }
        }

        // HOME becomes the end-game once every item has been collected.
        let route = destination == Route.home && progress.hasAllItems ? Route.endGame : destination

        progress.currentNodeID = route.rawValue
        progress.visitedNodeIDs.insert(route.rawValue)
        if let endingID = route.endingID {
            progress.completedEndingIDs.insert(endingID)
        }
        persist()

        // Arriving at the hub starts a fresh stack, so a long run doesn't keep every page it
        // visited (and its full-size illustration) alive.
        if route == Route.home || route == Route.endGame {
            path = [route]
        } else {
            path.append(route)
        }
    }

    func returnToStoryMenu() {
        path = []
        hasSavedProgress = Self.canContinue(progress)
    }

    func restartAdventure() {
        startNewAdventure()
    }

    /// Clears the unfinished run and every completed ending for this story.
    func resetAllProgress() {
        progress = .fresh(startingAt: Route.start.rawValue)
        path = []
        defaults.removeObject(forKey: Story.saveKey)
        hasSavedProgress = false
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(progress) {
            defaults.set(data, forKey: Story.saveKey)
        }
        hasSavedProgress = Self.canContinue(progress)
    }

    private static func loadProgress(from defaults: UserDefaults) -> Progress? {
        guard let data = defaults.data(forKey: Story.saveKey) else { return nil }
        return try? JSONDecoder().decode(Progress.self, from: data)
    }

    private static func canContinue(_ progress: Progress) -> Bool {
        guard let route = Route(rawValue: progress.currentNodeID) else { return false }
        return !route.isEnding
    }
}
