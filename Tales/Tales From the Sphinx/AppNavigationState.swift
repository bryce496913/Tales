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
    var soundEnabled: Bool
    var hapticsEnabled: Bool
    var reducedEffects: Bool
}

@MainActor
final class AppNavigationState: ObservableObject {
    @Published var path: [StoryRoute] = [] { didSet { persistProgress() } }
    @Published var isAdventureActive = false { didSet { persistProgress() } }
    @Published var hasSavedProgress = false
    @Published var soundEnabled = true { didSet { persistProgress() } }
    @Published var hapticsEnabled = true { didSet { persistProgress() } }
    @Published var reducedEffects = false { didSet { persistProgress() } }
    @Published private(set) var completedEndings: Set<String> = []

    private let saveKey = "Tales.story.save.v2"
    private var isRestoring = false

    init() { loadSavedProgressFlag() }

    var currentRoute: StoryRoute? { path.last }

    func startNewAdventure() {
        completedEndings.removeAll()
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
        soundEnabled = save.soundEnabled
        hapticsEnabled = save.hapticsEnabled
        reducedEffects = save.reducedEffects
        isAdventureActive = save.isInProgress
        path = save.isInProgress ? [save.currentRoute] : []
        isRestoring = false
        hasSavedProgress = save.isInProgress
    }

    func navigate(to route: StoryRoute) {
        guard isAdventureActive else { return }
        path.append(route)
    }

    func completeStory(endingID: String? = nil) {
        if let endingID { completedEndings.insert(endingID) }
        isAdventureActive = false
        path = []
        persistProgress()
    }

    func resetToMainMenu() {
        isAdventureActive = false
        path = []
        persistProgress()
    }

    func restartAdventure() { startNewAdventure() }

    func resetSavedProgress() {
        UserDefaults.standard.removeObject(forKey: saveKey)
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
            completedEndings: completedEndings,
            soundEnabled: soundEnabled,
            hapticsEnabled: hapticsEnabled,
            reducedEffects: reducedEffects
        )
        if let data = try? JSONEncoder().encode(save) {
            UserDefaults.standard.set(soundEnabled, forKey: "Tales.soundEnabled")
            UserDefaults.standard.set(hapticsEnabled, forKey: "Tales.hapticsEnabled")
            UserDefaults.standard.set(reducedEffects, forKey: "Tales.reducedEffects")
            UserDefaults.standard.set(data, forKey: saveKey)
            hasSavedProgress = save.isInProgress
        }
    }

    private func loadSavedProgressFlag() { hasSavedProgress = loadSave()?.isInProgress == true }

    private func loadSave() -> StorySaveState? {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else { return nil }
        return try? JSONDecoder().decode(StorySaveState.self, from: data)
    }
}

struct StoryDestinationView: View {
    let route: StoryRoute

    var body: some View {
        switch route {
        case .options: OptionsView()
        case .plot1: Plot1View()
        case .plot2: Plot2View()
        case .page(let number):
            switch number {
            case 1: Page1View(); case 2: Page2View(); case 3: Page3View(); case 4: Page4View(); case 5: Page5View()
            case 6: Page6View(); case 7: Page7View(); case 8: Page8View(); case 9: Page9View(); case 10: Page10View()
            case 11: Page11View(); case 12: Page12View(); case 13: Page13View(); case 14: Page14View(); case 15: Page15View()
            case 16: Page16View(); case 17: Page17View(); case 18: Page18View(); case 19: Page19View(); case 20: Page20View()
            case 21: Page21View(); case 22: Page22View(); case 24: Page24View(); case 25: Page25View()
            default: Page1View()
            }
        }
    }
}
