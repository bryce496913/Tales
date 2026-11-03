import SwiftUI

/// Per-page presentation settings. Player-controlled effects live in `GameOptions`.
struct StoryPageEffects {
    var entryTransition: StoryTransitionStyle = .fade
    var choicesWaitForText: Bool = true

    static let standard = StoryPageEffects()
}

/// A story illustration, shown whole (the art is square), or a themed placeholder if it is missing.
struct StoryIllustration: View {
    let imageName: String

    @Environment(\.storyTheme) private var theme

    var body: some View {
        Group {
            if let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous)
                        .fill(LinearGradient(colors: [theme.cardAlt, theme.backgroundBottom], startPoint: .top, endPoint: .bottom))
                    VStack(spacing: 8) {
                        Image(systemName: theme.placeholderSymbol)
                            .font(.system(size: 42, weight: .semibold))
                        Text("Illustration unavailable")
                            .font(.system(.headline, design: .serif))
                        Text(imageName)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(theme.mutedText)
                    }
                    .foregroundColor(theme.accent)
                    .padding()
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
        .frame(maxWidth: AppTheme.maximumStoryContentWidth)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous).stroke(theme.accent.opacity(0.55), lineWidth: 1))
        .shadow(color: theme.shadow, radius: 18, x: 0, y: 10)
        .accessibilityLabel("Story illustration")
    }
}

/// The page every story is built from: illustration, typed-out text and the page's choices.
/// Honours the typewriter, text speed and page-transition settings in Options.
struct StoryPageLayout<Choices: View>: View {
    let imageName: String
    let title: String?
    let text: String
    let effects: StoryPageEffects
    let choices: Choices

    @State private var appeared = false
    @State private var textComplete = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.storyTheme) private var theme
    @EnvironmentObject private var gameOptions: GameOptions

    init(imageName: String, title: String? = nil, text: String, effects: StoryPageEffects = .standard, @ViewBuilder choices: () -> Choices) {
        self.imageName = imageName
        self.title = title
        self.text = text
        self.effects = effects
        self.choices = choices()
    }

    var body: some View {
        StoryTransitionContainer(style: effects.entryTransition) {
            ZStack {
                StoryBackground()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        StoryIllustration(imageName: imageName)

                        VStack(alignment: .leading, spacing: 14) {
                            if let title {
                                Text(title)
                                    .font(.system(.largeTitle, design: .serif).weight(.bold))
                                    .foregroundColor(theme.accent)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .accessibilityAddTraits(.isHeader)
                            }
                            TypewriterText(
                                text: text,
                                speed: gameOptions.typewriterSpeed.speed,
                                startDelay: reduceMotion ? 0 : 0.35,
                                isEnabled: gameOptions.typewriterEnabled
                            ) {
                                textComplete = true
                            }
                        }
                        .frame(maxWidth: AppTheme.maximumTextWidth, alignment: .leading)
                        .storyCard()

                        VStack(spacing: 12) { choices }
                            .frame(maxWidth: AppTheme.maximumButtonWidth)
                            .opacity(choicesVisible ? 1 : 0)
                            .disabled(!choicesVisible)
                            .animation(.easeOut(duration: animated ? 0.3 : 0.05), value: choicesVisible)
                    }
                    .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                    .padding(.horizontal, AppTheme.screenPadding)
                    .padding(.top, 18)
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 10)
                }
            }
        }
        .onAppear {
            textComplete = !effects.choicesWaitForText || !gameOptions.typewriterEnabled || reduceMotion
            withAnimation(.easeOut(duration: animated ? 0.45 : 0.05)) { appeared = true }
        }
        .onDisappear { appeared = false }
    }

    private var animated: Bool {
        gameOptions.pageTransitionsEnabled && !reduceMotion
    }

    private var choicesVisible: Bool {
        textComplete || !effects.choicesWaitForText || !gameOptions.typewriterEnabled || reduceMotion
    }
}

/// Lays choices out side by side when they fit, otherwise stacks them vertically.
struct StoryChoicesStack<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 12) { content }
            VStack(spacing: 12) { content }
        }
    }
}

struct StoryPageLayout_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            StoryPageLayout(imageName: "One", title: "Preview", text: "A normal story page preview with shared environment objects.") {
                StoryNavigationButton(title: "Continue", route: .page(2))
            }
        }
    }
}
