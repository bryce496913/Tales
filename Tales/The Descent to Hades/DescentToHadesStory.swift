import SwiftUI

/// The Descent to Hades: its content types, menu copy, Greek theme and save slot. Everything
/// else (navigation, pages, endings, menus) comes from the shared story engine.
enum DescentToHades: BranchingStory {
    typealias Route = DescentToHadesRoute
    typealias Item = DescentToHadesItem
    typealias Flag = DescentToHadesStoryFlag
    typealias Outcome = DescentToHadesOutcome

    static let title = "The Descent to Hades"
    static let shortName = "Hades"
    static let subtitle = "Cross the river Styx, win the favour of the gods of the dead, and bring your brother home without looking back."
    static let titleImageName = "HDS-Title-Screen-Art"
    static let theme = StoryTheme.greek
    static let saveKey = "Tales.descent-to-hades.progress.v1"

    static func destination(for route: DescentToHadesRoute) -> some View {
        DescentToHadesDestinationView(route: route)
    }
}

extension StoryTheme {
    /// Night-sea blues, bronze and marble for The Descent to Hades.
    static let greek = StoryTheme(
        backgroundTop: Color(hex: "0B1220"),
        backgroundBottom: Color(hex: "1C1630"),
        backgroundGlow: Color(hex: "3E6E9E").opacity(0.22),
        backgroundShade: 0.36,
        card: Color(hex: "141B2B").opacity(0.88),
        cardAlt: Color(hex: "1F2840").opacity(0.85),
        accent: Color(hex: "C08A4A"),
        text: Color(hex: "EDE8DF"),
        mutedText: Color(hex: "A9B3C4"),
        secondaryText: Color(hex: "C9C3B0"),
        shadow: Color.black.opacity(0.5),
        buttonText: Color(hex: "1A1208"),
        buttonGradient: [Color(hex: "DDB27A"), Color(hex: "C08A4A")],
        buttonPressedGradient: [Color(hex: "C08A4A"), Color(hex: "9A6A33")],
        buttonBorder: Color(hex: "EDE8DF").opacity(0.55),
        buttonGlow: Color(hex: "3E6E9E"),
        placeholderSymbol: "building.columns.fill",
        fadeTransitionColors: [Color(hex: "8A96A8"), Color(hex: "4A5468"), Color(hex: "1C2232")],
        fadeTransitionOffset: -10,
        fadeTransitionOpacity: 0.7,
        fadeTransitionDuration: 0.6,
        torchTransitionColors: [Color(hex: "DDB27A").opacity(0.48), Color(hex: "9E2B3A").opacity(0.22), .clear],
        doorTransitionColors: [Color(hex: "8C6235"), Color(hex: "4E3520"), Color(hex: "2A1D14")]
    )
}

// Story-named entry points used by the page files.
typealias DescentToHadesRootView = BranchingStoryRootView<DescentToHades>
typealias DescentToHadesNavigationState = BranchingStoryState<DescentToHades>
typealias DescentToHadesNavigationButton = BranchingNavigationButton<DescentToHades>
typealias DescentToHadesOutcomeView = BranchingOutcomeView<DescentToHades>
typealias DescentToHadesPreviewContainer<Content: View> = BranchingPreviewContainer<DescentToHades, Content>
typealias DescentToHadesPageLayout<Choices: View> = StoryPageLayout<Choices>
typealias DescentToHadesChoicesStack<Content: View> = StoryChoicesStack<Content>
typealias DescentToHadesPageEffects = StoryPageEffects
