import SwiftUI

/// The Cave of Amaterasu: its content types, menu copy, Japanese theme and save slot. Everything
/// else (navigation, pages, endings, menus) comes from the shared story engine.
enum CaveOfAmaterasu: BranchingStory {
    typealias Route = CaveOfAmaterasuRoute
    typealias Item = CaveOfAmaterasuItem
    typealias Flag = CaveOfAmaterasuStoryFlag
    typealias Outcome = CaveOfAmaterasuOutcome

    static let title = "The Cave of Amaterasu"
    static let shortName = "Amaterasu"
    static let subtitle = "Climb to the gods, recover the three sacred treasures, and coax the sun out of hiding before the night lasts forever."
    static let titleImageName = "AMA-Title-Screen-Art"
    static let theme = StoryTheme.japanese
    static let saveKey = "Tales.cave-of-amaterasu.progress.v1"

    static func destination(for route: CaveOfAmaterasuRoute) -> some View {
        CaveOfAmaterasuDestinationView(route: route)
    }
}

extension StoryTheme {
    /// Sumi ink, indigo night, vermilion lacquer and gold leaf for The Cave of Amaterasu.
    static let japanese = StoryTheme(
        backgroundTop: Color(hex: "0E0C10"),
        backgroundBottom: Color(hex: "171A2E"),
        backgroundGlow: Color(hex: "C8402A").opacity(0.18),
        backgroundShade: 0.36,
        card: Color(hex: "17151C").opacity(0.88),
        cardAlt: Color(hex: "231F2C").opacity(0.85),
        accent: Color(hex: "D9553B"),
        text: Color(hex: "F2EADB"),
        mutedText: Color(hex: "B4AFA6"),
        secondaryText: Color(hex: "D8C9A8"),
        shadow: Color.black.opacity(0.5),
        buttonText: Color(hex: "1A0C08"),
        buttonGradient: [Color(hex: "F0A35E"), Color(hex: "D9553B")],
        buttonPressedGradient: [Color(hex: "D9553B"), Color(hex: "A63A26")],
        buttonBorder: Color(hex: "F2EADB").opacity(0.55),
        buttonGlow: Color(hex: "E3B85C"),
        placeholderSymbol: "sun.haze.fill",
        fadeTransitionColors: [Color(hex: "4A4650"), Color(hex: "2A2630"), Color(hex: "121016")],
        fadeTransitionOffset: -10,
        fadeTransitionOpacity: 0.7,
        fadeTransitionDuration: 0.6,
        torchTransitionColors: [Color(hex: "E3B85C").opacity(0.48), Color(hex: "C8402A").opacity(0.22), .clear],
        doorTransitionColors: [Color(hex: "E9DFC8"), Color(hex: "B9A57E"), Color(hex: "5A4632")]
    )
}

// Story-named entry points used by the page files.
typealias CaveOfAmaterasuRootView = BranchingStoryRootView<CaveOfAmaterasu>
typealias CaveOfAmaterasuNavigationState = BranchingStoryState<CaveOfAmaterasu>
typealias CaveOfAmaterasuNavigationButton = BranchingNavigationButton<CaveOfAmaterasu>
typealias CaveOfAmaterasuOutcomeView = BranchingOutcomeView<CaveOfAmaterasu>
typealias CaveOfAmaterasuPreviewContainer<Content: View> = BranchingPreviewContainer<CaveOfAmaterasu, Content>
typealias CaveOfAmaterasuPageLayout<Choices: View> = StoryPageLayout<Choices>
typealias CaveOfAmaterasuChoicesStack<Content: View> = StoryChoicesStack<Content>
typealias CaveOfAmaterasuPageEffects = StoryPageEffects
