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
    @Published var path: [StoryRoute] = [] { didSet { persistProgress() } }
    @Published var isAdventureActive = false { didSet { persistProgress() } }
    @Published var hasSavedProgress = false
    @Published private(set) var completedEndings: Set<String> = []

    private let saveKey = "Tales.story.save.v2"
    private let defaults: UserDefaults
    private var isRestoring = false

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
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
        path = [.plot1]
        persistProgress()
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
        guard isAdventureActive else { return }
        path.append(route)
    }

    func markEndingReached(_ endingID: String) {
        var endings = completedEndings
        let inserted = endings.insert(endingID).inserted
        if inserted { completedEndings = endings }
        if isAdventureActive { isAdventureActive = false }
        if inserted || hasSavedProgress { persistProgress() }
    }

    func resetToMainMenu() {
        isAdventureActive = false
        path = []
        persistProgress()
    }

    func restartAdventure() { startNewAdventure() }

    func resetSavedProgress() {
        defaults.removeObject(forKey: saveKey)
        hasSavedProgress = false
        completedEndings.removeAll()
        isAdventureActive = false
        path = []
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
