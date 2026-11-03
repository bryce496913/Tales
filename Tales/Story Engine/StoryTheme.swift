import SwiftUI

/// Colours and effect palettes that give a story its look. Shared views read the current theme
/// from the environment, so a story only has to supply one of these.
struct StoryTheme {
    var backgroundTop: Color
    var backgroundBottom: Color
    var backgroundGlow: Color
    var backgroundShade: Double
    var card: Color
    var cardAlt: Color
    /// Titles, borders and highlights (gold for Egypt, bronze for Greece).
    var accent: Color
    var text: Color
    var mutedText: Color
    /// Secondary body text, such as the summary under an ending.
    var secondaryText: Color
    var shadow: Color
    var buttonText: Color
    var buttonGradient: [Color]
    var buttonPressedGradient: [Color]
    var buttonBorder: Color
    var buttonGlow: Color
    /// SF Symbol shown when an illustration is missing.
    var placeholderSymbol: String
    var fadeTransitionColors: [Color]
    /// How far the page drifts while fading in; positive rises from below, negative settles from above.
    var fadeTransitionOffset: CGFloat
    var fadeTransitionOpacity: Double
    var fadeTransitionDuration: TimeInterval
    var torchTransitionColors: [Color]
    var doorTransitionColors: [Color]

    var background: LinearGradient {
        LinearGradient(colors: [backgroundTop, backgroundBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension StoryTheme {
    /// The app's default look, used by the app shell, Tales From the Sphinx and The Trial of Anubis.
    static let egyptian = StoryTheme(
        backgroundTop: AppTheme.backgroundTop,
        backgroundBottom: AppTheme.backgroundBottom,
        backgroundGlow: AppTheme.gold.opacity(0.20),
        backgroundShade: 0.32,
        card: AppTheme.card,
        cardAlt: AppTheme.cardAlt,
        accent: AppTheme.gold,
        text: AppTheme.warmText,
        mutedText: AppTheme.mutedText,
        secondaryText: AppTheme.sand,
        shadow: AppTheme.shadow,
        buttonText: AppTheme.buttonText,
        buttonGradient: [Color(hex: "F1D48A"), AppTheme.gold],
        buttonPressedGradient: [AppTheme.gold, Color(hex: "B98229")],
        buttonBorder: AppTheme.sand.opacity(0.85),
        buttonGlow: AppTheme.gold,
        placeholderSymbol: "scalemass.fill",
        fadeTransitionColors: [Color(hex: "3B2A16"), Color(hex: "3B2A16")],
        fadeTransitionOffset: 12,
        fadeTransitionOpacity: 0.62,
        fadeTransitionDuration: 0.5,
        torchTransitionColors: [AppTheme.gold.opacity(0.48), Color(hex: "B36B18").opacity(0.22), .clear],
        doorTransitionColors: [Color(hex: "645847"), Color(hex: "332C25"), Color(hex: "211C18")]
    )
}

private struct StoryThemeKey: EnvironmentKey {
    static let defaultValue = StoryTheme.egyptian
}

extension EnvironmentValues {
    var storyTheme: StoryTheme {
        get { self[StoryThemeKey.self] }
        set { self[StoryThemeKey.self] = newValue }
    }
}

/// Full-screen backdrop in the current story's colours.
struct StoryBackground: View {
    @Environment(\.storyTheme) private var theme

    var body: some View {
        ZStack {
            theme.background
            RadialGradient(colors: [theme.backgroundGlow, .clear], center: .top, startRadius: 20, endRadius: 420)
            LinearGradient(colors: [.clear, .black.opacity(theme.backgroundShade)], startPoint: .center, endPoint: .bottom)
        }
        .ignoresSafeArea()
    }
}

struct StoryCardModifier: ViewModifier {
    var padding: CGFloat = AppTheme.cardPadding
    @Environment(\.storyTheme) private var theme

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                    .fill(theme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                            .stroke(theme.accent.opacity(0.55), lineWidth: 1)
                    )
                    .shadow(color: theme.shadow, radius: 18, x: 0, y: 10)
            )
    }
}

extension View {
    /// A card in the current story's colours.
    func storyCard(padding: CGFloat = AppTheme.cardPadding) -> some View {
        modifier(StoryCardModifier(padding: padding))
    }
}
