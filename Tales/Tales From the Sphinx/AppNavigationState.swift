import SwiftUI

enum StoryID: String, Codable, CaseIterable, Identifiable {
    case talesFromTheSphinx = "tales-from-the-sphinx"
    case trialOfAnubis = "trial-of-anubis"

    var id: String { rawValue }
}

enum StoryAvailability: String, Codable {
    case available
    case comingSoon
    case locked

    var title: String {
        switch self {
        case .available: return "Available"
        case .comingSoon: return "Coming Soon"
        case .locked: return "Locked"
        }
    }
}

struct StoryDescriptor: Identifiable, Hashable {
    let id: StoryID
    let title: String
    let subtitle: String
    let summary: String
    let availability: StoryAvailability
    let coverImageName: String?
    let iconSystemName: String?
    let estimatedLength: String?
    let endingCount: Int?
    let sortOrder: Int
}

enum StoryCatalog {
    static let talesFromTheSphinx = StoryDescriptor(
        id: .talesFromTheSphinx,
        title: "Tales From the Sphinx",
        subtitle: "Escape the Sphinx through puzzles, danger, and difficult choices.",
        summary: "An Egyptian adventure of mystery, treasure, and danger. Explore ancient passages, solve riddles, and survive the Sphinx's trials through choices that shape your fate.",
        availability: .available,
        coverImageName: SphinxAssets.titleScreenArt,
        iconSystemName: "pyramid.fill",
        estimatedLength: "Short adventure",
        endingCount: nil,
        sortOrder: 10
    )

    static let trialOfAnubis = StoryDescriptor(
        id: .trialOfAnubis,
        title: "The Trial of Anubis",
        subtitle: "Enter the underworld, recover the sacred scales, and determine the weight of your heart.",
        summary: "The scales of Anubis have been shattered. Journey through the Egyptian underworld, recover their stolen pieces, and face choices shaped by morality, memory, power, mercy, and truth.",
        availability: .comingSoon,
        coverImageName: nil,
        iconSystemName: "scalemass.fill",
        estimatedLength: "28 Story Nodes",
        endingCount: 5,
        sortOrder: 20
    )

    static let stories: [StoryDescriptor] = [talesFromTheSphinx, trialOfAnubis].sorted { $0.sortOrder < $1.sortOrder }

    static func story(for id: StoryID) -> StoryDescriptor? { stories.first { $0.id == id } }
}

enum AppRoute: Hashable {
    case storyLibrary
    case storyDetail(StoryID)
    case options
    case playStory(StoryID)
}

@MainActor
final class AppNavigationState: ObservableObject {
    @Published var path: [AppRoute] = []
    @Published var lastSelectedStoryID: StoryID?
    @Published var hasShownLaunchSplash = false

    func showStoryLibrary() { path = [.storyLibrary] }
    func showStoryDetail(_ storyID: StoryID) { lastSelectedStoryID = storyID; path.append(.storyDetail(storyID)) }
    func playStory(_ storyID: StoryID) {
        guard StoryCatalog.story(for: storyID)?.availability == .available else {
            showStoryDetail(storyID)
            return
        }
        lastSelectedStoryID = storyID
        path.append(.playStory(storyID))
    }
    func showOptions() { path.append(.options) }
    func returnToMainMenu() { path = [] }
}

enum SphinxRoute: Hashable, Codable {
    case plot1
    case plot2
    case page(Int)
}

struct SphinxSaveState: Codable {
    var currentRoute: SphinxRoute
    var isInProgress: Bool
    var completedEndings: Set<String>
}

enum SphinxAssets {
    static let titleScreenArt = "Title-Screen-Art.png"
    static let icon = "Icon.png"
}

@MainActor
final class SphinxNavigationState: ObservableObject {
    static let saveKey = "Tales.story.tales-from-the-sphinx.save.v3"
    static let legacySaveKey = "Tales.story.save.v2"

    @Published var path: [SphinxRoute] = [] { didSet { persistProgress() } }
    @Published var isAdventureActive = false { didSet { persistProgress() } }
    @Published var hasSavedProgress = false
    @Published private(set) var completedEndings: Set<String> = []

    private var isRestoring = false
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        migrateLegacySaveIfNeeded()
        loadSavedProgressFlag()
    }

    var currentRoute: SphinxRoute? { path.last }

    func startNewAdventure() {
        isAdventureActive = true
        path = [.plot1]
        persistProgress()
    }

    func continueAdventure() {
        guard let save = loadSave() else { startNewAdventure(); return }
        isRestoring = true
        completedEndings = save.completedEndings
        isAdventureActive = save.isInProgress
        path = save.isInProgress ? [save.currentRoute] : []
        isRestoring = false
        hasSavedProgress = save.isInProgress
    }

    func navigate(to route: SphinxRoute) { guard isAdventureActive else { return }; path.append(route) }
    func markEndingReached(_ endingID: String) { completedEndings.insert(endingID); persistProgress() }
    func completeStory(endingID: String? = nil) { if let endingID { markEndingReached(endingID) }; isAdventureActive = false; path = []; persistProgress() }
    func returnToStoryMenu() { isAdventureActive = false; path = []; persistProgress() }
    func restartAdventure() { startNewAdventure() }

    func resetSavedProgress() {
        defaults.removeObject(forKey: Self.saveKey)
        hasSavedProgress = false
        completedEndings.removeAll()
        isAdventureActive = false
        path = []
    }

    private func persistProgress() {
        guard !isRestoring else { return }
        let save = SphinxSaveState(currentRoute: path.last ?? .plot1, isInProgress: isAdventureActive && !path.isEmpty, completedEndings: completedEndings)
        if let data = try? JSONEncoder().encode(save) {
            defaults.set(data, forKey: Self.saveKey)
            hasSavedProgress = save.isInProgress
        }
    }

    private func loadSavedProgressFlag() { hasSavedProgress = loadSave()?.isInProgress == true }

    private func loadSave() -> SphinxSaveState? {
        guard let data = defaults.data(forKey: Self.saveKey) else { return nil }
        return try? JSONDecoder().decode(SphinxSaveState.self, from: data)
    }

    private func migrateLegacySaveIfNeeded() {
        guard defaults.data(forKey: Self.saveKey) == nil,
              let legacyData = defaults.data(forKey: Self.legacySaveKey) else { return }
        if let migrated = SphinxSaveState.migratingLegacyData(legacyData),
           let data = try? JSONEncoder().encode(migrated) {
            defaults.set(data, forKey: Self.saveKey)
        }
    }
}

private enum LegacySphinxRoute: Hashable, Codable { case options, plot1, plot2, page(Int) }
private struct LegacyStorySaveState: Codable {
    var currentRoute: LegacySphinxRoute
    var isInProgress: Bool
    var completedEndings: Set<String>
    var soundEnabled: Bool?
    var hapticsEnabled: Bool?
    var reducedEffects: Bool?
}

private extension SphinxSaveState {
    static func migratingLegacyData(_ data: Data) -> SphinxSaveState? {
        guard let legacy = try? JSONDecoder().decode(LegacyStorySaveState.self, from: data) else { return nil }
        let route: SphinxRoute
        switch legacy.currentRoute {
        case .plot1, .options: route = .plot1
        case .plot2: route = .plot2
        case .page(let number): route = .page(number)
        }
        return SphinxSaveState(currentRoute: route, isInProgress: legacy.isInProgress, completedEndings: legacy.completedEndings)
    }
}

struct SphinxDestinationView: View {
    let route: SphinxRoute

    var body: some View {
        switch route {
        case .plot1: Plot1View()
        case .plot2: Plot2View()
        case .page(let number):
            switch number {
            case 1: Page1View(); case 2: Page2View(); case 3: Page3View(); case 4: Page4View(); case 5: Page5View()
            case 6: Page6View(); case 7: Page7View(); case 8: Page8View(); case 9: Page9View(); case 10: Page10View()
            case 11: Page11View(); case 12: Page12View(); case 13: Page13View(); case 14: Page14View(); case 15: Page15View()
            case 16: Page16View(); case 17: Page17View(); case 18: Page18View(); case 19: Page19View(); case 20: Page20View()
            case 21: Page21View(); case 22: Page22View(); case 24: Page24View(); case 25: Page25View()
            default: InvalidSphinxRouteView(routeDescription: "Page \(number)")
            }
        }
    }
}

struct InvalidSphinxRouteView: View {
    let routeDescription: String
    var body: some View {
        ZStack { EgyptianBackground(); Text("Missing Sphinx route: \(routeDescription)").foregroundColor(AppTheme.gold).goldCard() }
            .onAppear { assertionFailure("Invalid Sphinx route: \(routeDescription)") }
    }
}
