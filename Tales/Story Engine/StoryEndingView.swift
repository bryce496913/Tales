import SwiftUI

/// How an ending's card arrives, and which haptic plays with it.
enum OutcomeEntrance {
    /// A victory: the icon pops in with sparkles.
    case triumph
    /// A darker win: the card rises into place.
    case rise
    /// A quiet or bittersweet ending: a slow fade.
    case gentle
    /// A defeat: the icon shakes.
    case shake
    /// A death: the screen darkens as the card settles.
    case fall

    var haptic: StoryHaptic {
        switch self {
        case .triumph, .rise, .gentle: return .success
        case .shake: return .warning
        case .fall: return .error
        }
    }
}

/// The wording, icon and colours of one kind of ending. Each story lists its own outcomes.
protocol StoryOutcomeStyle {
    var title: String { get }
    var subtitle: String { get }
    var iconName: String { get }
    var accent: Color { get }
    var background: Color { get }
    var entrance: OutcomeEntrance { get }
}

/// The game-over screen shared by every story: illustration, outcome card and the story's own buttons.
struct StoryEndingView<Outcome: StoryOutcomeStyle, Buttons: View>: View {
    let outcome: Outcome
    let title: String?
    let classification: String?
    let imageName: String
    let storyText: String
    let outcomeText: String?
    let onFirstAppear: () -> Void
    let buttons: Buttons

    @EnvironmentObject private var gameOptions: GameOptions
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.storyTheme) private var theme
    @State private var appeared = false
    @State private var shakeOffset: CGFloat = 0

    init(
        outcome: Outcome,
        title: String? = nil,
        classification: String? = nil,
        imageName: String,
        storyText: String,
        outcomeText: String? = nil,
        onFirstAppear: @escaping () -> Void = {},
        @ViewBuilder buttons: () -> Buttons
    ) {
        self.outcome = outcome
        self.title = title
        self.classification = classification
        self.imageName = imageName
        self.storyText = storyText
        self.outcomeText = outcomeText
        self.onFirstAppear = onFirstAppear
        self.buttons = buttons()
    }

    var body: some View {
        ZStack {
            StoryBackground()
            if outcome.entrance == .fall {
                Color.black.opacity(animated && appeared ? 0.22 : 0.12)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    StoryIllustration(imageName: imageName)
                    outcomeCard
                    VStack(spacing: 12) { buttons }
                        .frame(maxWidth: AppTheme.maximumButtonWidth)
                }
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                .padding(.horizontal, AppTheme.screenPadding)
                .padding(.top, 18)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            guard !appeared else { return }
            onFirstAppear()
            HapticManager.shared.play(outcome.entrance.haptic)
            runEntrance()
        }
    }

    private var animated: Bool {
        gameOptions.outcomeAnimationsEnabled && !reduceMotion
    }

    private var outcomeCard: some View {
        VStack(spacing: 12) {
            ZStack {
                if outcome.entrance == .triumph && animated && appeared {
                    sparkles
                        .allowsHitTesting(false)
                        .accessibilityHidden(true)
                }

                Image(systemName: outcome.iconName)
                    .font(.system(size: 46, weight: .bold))
                    .foregroundColor(outcome.accent)
                    .shadow(color: outcome.accent.opacity(outcome.entrance == .triumph ? 0.68 : 0.42), radius: outcome.entrance == .triumph ? 14 : 8)
                    .accessibilityHidden(true)
            }
            .scaleEffect(iconScale)
            .offset(x: shakeOffset)

            Text(outcome.title)
                .font(.system(.largeTitle, design: .serif).weight(.bold))
                .foregroundColor(outcome.accent)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)

            Text(outcome.subtitle)
                .font(.system(.subheadline, design: .serif).weight(.medium))
                .foregroundColor(theme.mutedText)
                .multilineTextAlignment(.center)

            if let title {
                Text(title)
                    .font(.system(.title2, design: .serif).weight(.bold))
                    .foregroundColor(theme.accent)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
            }

            if let classification {
                Text(classification)
                    .font(.system(.headline, design: .serif).weight(.semibold))
                    .foregroundColor(outcome.accent)
                    .multilineTextAlignment(.center)
            }

            TypewriterText(
                text: storyText,
                speed: gameOptions.typewriterSpeed.speed,
                startDelay: animated ? 0.25 : 0,
                isEnabled: gameOptions.typewriterEnabled
            )

            if let outcomeText {
                Divider().overlay(theme.accent.opacity(0.65))

                Text(outcomeText)
                    .font(.system(.body, design: .serif).weight(.medium))
                    .foregroundColor(theme.secondaryText)
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(AppTheme.cardPadding)
        .frame(maxWidth: AppTheme.maximumTextWidth)
        .background(RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous).fill(outcome.background))
        .overlay(RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous).stroke(outcome.accent.opacity(0.72), lineWidth: 1.2))
        .shadow(color: outcome.accent.opacity(0.22), radius: 18, x: 0, y: 10)
        .opacity(appeared || !animated ? 1 : 0)
        .offset(y: outcome.entrance == .rise && animated && !appeared ? 12 : 0)
        .accessibilityElement(children: .contain)
    }

    private var iconScale: CGFloat {
        guard animated, !appeared else { return 1 }
        switch outcome.entrance {
        case .triumph: return 0.78
        case .fall: return 0.92
        case .rise, .gentle, .shake: return 1
        }
    }

    private var sparkles: some View {
        ZStack {
            ForEach(0..<6) { index in
                Circle()
                    .fill(outcome.accent.opacity(0.78))
                    .frame(width: index.isMultiple(of: 2) ? 4 : 6, height: index.isMultiple(of: 2) ? 4 : 6)
                    .offset(x: Self.sparkleOffsets[index].x, y: Self.sparkleOffsets[index].y)
            }
        }
    }

    private static var sparkleOffsets: [CGPoint] {
        [
            CGPoint(x: -42, y: -18),
            CGPoint(x: -24, y: 24),
            CGPoint(x: 28, y: -28),
            CGPoint(x: 46, y: 12),
            CGPoint(x: -8, y: -38),
            CGPoint(x: 12, y: 34)
        ]
    }

    private func runEntrance() {
        guard animated else {
            appeared = true
            return
        }

        switch outcome.entrance {
        case .triumph:
            withAnimation(.easeOut(duration: 0.55)) { appeared = true }
        case .rise:
            withAnimation(.easeOut(duration: 0.5)) { appeared = true }
        case .gentle:
            withAnimation(.easeOut(duration: 0.8)) { appeared = true }
        case .fall:
            withAnimation(.easeOut(duration: 0.7)) { appeared = true }
        case .shake:
            withAnimation(.easeOut(duration: 0.28)) { appeared = true }
            Task { @MainActor in
                for offset in [-8, 7, -5, 3, 0] {
                    withAnimation(.easeInOut(duration: 0.06)) { shakeOffset = CGFloat(offset) }
                    try? await Task.sleep(nanoseconds: 60_000_000)
                }
            }
        }
    }
}
