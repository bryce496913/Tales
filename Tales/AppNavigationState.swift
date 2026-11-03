import SwiftUI

enum StoryRoute: Hashable, Codable {
    case options
    case plot1
    case plot2
    case page(Int)
}

struct StorySaveState: Codable {
    var currentRoute: StoryRoute
    var isInProgress: Bool
    var completedEndings: Set<String>
}

@MainActor
final class AppNavigationState: ObservableObject {
    /// Saving happens when the path changes (every navigation), plus explicitly where only
    /// other state changes, so each action writes once.
    @Published var path: [StoryRoute] = [] { didSet { persistProgress() } }
    @Published private(set) var isAdventureActive = false
    @Published var hasSavedProgress = false
    @Published private(set) var completedEndings: Set<String> = []

    private let saveKey = "Tales.story.save.v2"
    private let defaults: UserDefaults
    private let now: () -> Date
    private var isRestoring = false
    private var navigationUnlocksAt = Date.distantPast

    /// Minimum time between two navigations, so quick taps on two different choices during the
    /// push animation can't open both pages.
    static let navigationLockout: TimeInterval = 0.6

    init(defaults: UserDefaults = .standard, now: @escaping () -> Date = { Date() }) {
        self.defaults = defaults
        self.now = now
        loadSavedProgressFlag()
    }

    convenience init(previewMode: Bool) {
        if previewMode {
            let suiteName = "TalesPreview.\(UUID().uuidString)"
            let defaults = UserDefaults(suiteName: suiteName) ?? .standard
            defaults.removePersistentDomain(forName: suiteName)
            self.init(defaults: defaults)
        } else {
            self.init()
        }
    }

    var currentRoute: StoryRoute? { path.last }

    func startNewAdventure() {
        isAdventureActive = true
        navigationUnlocksAt = .distantPast
        path = [.plot1]
    }

    func continueAdventure() {
        guard let save = loadSave() else {
            startNewAdventure()
            return
        }
        isRestoring = true
        completedEndings = save.completedEndings
        isAdventureActive = save.isInProgress
        path = save.isInProgress ? [save.currentRoute] : []
        isRestoring = false
        hasSavedProgress = save.isInProgress
    }

    func navigate(to route: StoryRoute) {
        let time = now()
        guard isAdventureActive, time >= navigationUnlocksAt else { return }
        navigationUnlocksAt = time.addingTimeInterval(Self.navigationLockout)
        path.append(route)
    }

    func markEndingReached(_ endingID: String) {
        var endings = completedEndings
        let inserted = endings.insert(endingID).inserted
        let wasActive = isAdventureActive
        if inserted { completedEndings = endings }
        isAdventureActive = false
        if inserted || wasActive || hasSavedProgress { persistProgress() }
    }

    func resetToMainMenu() {
        isAdventureActive = false
        path = []
    }

    func restartAdventure() { startNewAdventure() }

    func resetSavedProgress() {
        isRestoring = true
        completedEndings.removeAll()
        isAdventureActive = false
        path = []
        isRestoring = false
        defaults.removeObject(forKey: saveKey)
        hasSavedProgress = false
    }

    private func persistProgress() {
        guard !isRestoring else { return }
        let current = path.last ?? .plot1
        let save = StorySaveState(
            currentRoute: current,
            isInProgress: isAdventureActive && !path.isEmpty,
            completedEndings: completedEndings
        )
        if let data = try? JSONEncoder().encode(save) {
            defaults.set(data, forKey: saveKey)
            hasSavedProgress = save.isInProgress
        }
    }

    private func loadSavedProgressFlag() { hasSavedProgress = loadSave()?.isInProgress == true }

    private func loadSave() -> StorySaveState? {
        guard let data = defaults.data(forKey: saveKey) else { return nil }
        return try? JSONDecoder().decode(StorySaveState.self, from: data)
    }
}
