import Foundation

@MainActor
final class TrialOfAnubisNavigationState: ObservableObject {
    static let saveKey = "Tales.trial-of-anubis.progress.v1"

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
            currentNodeID: TrialOfAnubisRoute.anu001.rawValue,
            visitedNodeIDs: [TrialOfAnubisRoute.anu001.rawValue],
            completedEndingIDs: completed
        )
        path = [.anu001]
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

    func navigate(to route: TrialOfAnubisRoute) {
        guard !isNavigating, path.last != route else { return }
        isNavigating = true
        defer { isNavigating = false }

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
        progress.completedEndingIDs.insert(Self.endingID(for: route))
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
        progress.currentNodeID.hasPrefix("ANU-")
    }

    private static func endingID(for route: TrialOfAnubisRoute) -> String {
        switch route {
        case .endTrue: return "anubis_true_restored"
        case .endAmmit: return "anubis_dark_ammit"
        case .endRebel: return "anubis_rebel_escape"
        case .endTrickster: return "anubis_trickster_cheat"
        case .endLost: return "anubis_lost_soul"
        default: return route.rawValue
        }
    }
}
