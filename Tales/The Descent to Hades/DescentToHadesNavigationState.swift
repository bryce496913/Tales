import Foundation

@MainActor
final class DescentToHadesNavigationState: ObservableObject {
    static let saveKey = "Tales.descent-to-hades.progress.v1"

    @Published var path: [DescentToHadesRoute] = []
    @Published private(set) var progress: DescentToHadesProgress
    @Published private(set) var hasSavedProgress: Bool

    private let defaults: UserDefaults
    private var isNavigating = false

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        let saved = Self.loadProgress(from: defaults)
        self.progress = saved ?? .initial
        self.hasSavedProgress = saved.map(Self.canContinue) ?? false
    }

    func hasFlag(_ flag: DescentToHadesStoryFlag) -> Bool {
        progress.storyFlags.contains(flag)
    }

    func startNewAdventure() {
        let completed = progress.completedEndingIDs
        progress = DescentToHadesProgress(
            currentNodeID: DescentToHadesRoute.hds000.rawValue,
            visitedNodeIDs: [DescentToHadesRoute.hds000.rawValue],
            collectedItems: [],
            storyFlags: [],
            completedEndingIDs: completed
        )
        path = [.hds000]
        persist()
    }

    func continueAdventure() {
        guard let saved = Self.loadProgress(from: defaults),
              saved.currentNodeID.hasPrefix("HDS-"),
              let route = DescentToHadesRoute(rawValue: saved.currentNodeID),
              !route.isEnding else { return }

        progress = saved
        hasSavedProgress = Self.canContinue(saved)
        path = [route]
    }

    func navigate(
        to destination: DescentToHadesRoute,
        collecting item: DescentToHadesItem? = nil,
        marking flag: DescentToHadesStoryFlag? = nil
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

        // HOME becomes the throne of Hades once every gift has been collected.
        let route: DescentToHadesRoute = destination == .home && progress.hasAllItems ? .endGame : destination

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

    func recordEnding(_ route: DescentToHadesRoute) {
        guard route.isEnding else { return }
        progress.currentNodeID = route.rawValue
        progress.visitedNodeIDs.insert(route.rawValue)
        progress.completedEndingIDs.insert(route.endingID ?? route.rawValue)
        persist()
    }

    func resetAllHadesProgress() {
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

    private static func loadProgress(from defaults: UserDefaults) -> DescentToHadesProgress? {
        guard let data = defaults.data(forKey: saveKey) else { return nil }
        return try? JSONDecoder().decode(DescentToHadesProgress.self, from: data)
    }

    private static func canContinue(_ progress: DescentToHadesProgress) -> Bool {
        guard let route = DescentToHadesRoute(rawValue: progress.currentNodeID) else { return false }
        return !route.isEnding
    }
}
