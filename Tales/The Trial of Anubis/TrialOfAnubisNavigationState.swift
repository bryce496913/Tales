import Foundation

@MainActor
final class TrialOfAnubisNavigationState: ObservableObject {
    static let saveKey = "Tales.trial-of-anubis.progress.v2"

    @Published var path: [TrialOfAnubisRoute] = []
    @Published private(set) var progress: TrialOfAnubisProgress
    @Published private(set) var hasSavedProgress: Bool

    private let defaults: UserDefaults
    private var isNavigating = false

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        let saved = Self.loadProgress(from: defaults)
        self.progress = saved ?? .initial
        self.hasSavedProgress = saved.map(Self.canContinue) ?? false
    }

    func startNewAdventure() {
        let completed = progress.completedEndingIDs
        progress = TrialOfAnubisProgress(
            currentNodeID: TrialOfAnubisRoute.anu000.rawValue,
            visitedNodeIDs: [TrialOfAnubisRoute.anu000.rawValue],
            collectedItems: [],
            storyFlags: [],
            completedEndingIDs: completed
        )
        path = [.anu000]
        persist()
    }

    func continueAdventure() {
        guard let saved = Self.loadProgress(from: defaults),
              saved.currentNodeID.hasPrefix("ANU-"),
              let route = TrialOfAnubisRoute(rawValue: saved.currentNodeID),
              !route.isEnding else { return }

        progress = saved
        hasSavedProgress = Self.canContinue(saved)
        path = [route]
    }

    func navigate(
        to destination: TrialOfAnubisRoute,
        collecting item: TrialOfAnubisItem? = nil,
        marking flag: TrialOfAnubisStoryFlag? = nil
    ) {
        guard !isNavigating, path.last != destination else { return }
        isNavigating = true
        defer { isNavigating = false }

        if let item = item {
            progress.collectedItems.insert(item)
        }

        if let flag = flag {
            progress.storyFlags.insert(flag)
            if let opposite = flag.opposite {
                progress.storyFlags.remove(opposite)
            }
        }

        // HOME becomes the end-game hall once every scale piece has been collected.
        let route: TrialOfAnubisRoute = destination == .home && progress.hasAllItems ? .endGame : destination

        if route.isEnding {
            recordEnding(route)
            path.append(route)
        } else {
            progress.currentNodeID = route.rawValue
            progress.visitedNodeIDs.insert(route.rawValue)
            persist()
            path.append(route)
        }
    }

    func returnToStoryMenu() {
        path = []
        refreshSavedProgressAvailability()
    }

    func restartAdventure() {
        startNewAdventure()
    }

    func recordEnding(_ route: TrialOfAnubisRoute) {
        guard route.isEnding else { return }
        progress.currentNodeID = route.rawValue
        progress.visitedNodeIDs.insert(route.rawValue)
        progress.completedEndingIDs.insert(route.endingID ?? route.rawValue)
        persist()
    }

    func resetAllAnubisProgress() {
        progress = .initial
        path = []
        defaults.removeObject(forKey: Self.saveKey)
        hasSavedProgress = false
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(progress) {
            defaults.set(data, forKey: Self.saveKey)
        }
        refreshSavedProgressAvailability()
    }

    private func refreshSavedProgressAvailability() {
        hasSavedProgress = Self.canContinue(progress)
    }

    private static func loadProgress(from defaults: UserDefaults) -> TrialOfAnubisProgress? {
        guard let data = defaults.data(forKey: saveKey) else { return nil }
        return try? JSONDecoder().decode(TrialOfAnubisProgress.self, from: data)
    }

    private static func canContinue(_ progress: TrialOfAnubisProgress) -> Bool {
        guard let route = TrialOfAnubisRoute(rawValue: progress.currentNodeID) else { return false }
        return !route.isEnding
    }
}
