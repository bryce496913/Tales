import SwiftUI

enum TrialOfAnubisOutcome {
    case win
    case darkWin
    case lose
    case death

    var presentationTitle: String {
        switch self {
        case .win: return "Victory"
        case .darkWin: return "A Dangerous Victory"
        case .lose: return "Defeat"
        case .death: return "You Have Fallen"
        }
    }

    var subtitle: String {
        switch self {
        case .win: return "The scales shine with restored balance."
        case .darkWin: return "Power answers, but its flame casts a long shadow."
        case .lose: return "The desert keeps another unfinished judgment."
        case .death: return "The temple falls silent around your name."
        }
    }

    var iconName: String {
        switch self {
        case .win: return "crown.fill"
        case .darkWin: return "flame.fill"
        case .lose: return "exclamationmark.triangle.fill"
        case .death: return "xmark.shield.fill"
        }
    }

    var accent: Color {
        switch self {
        case .win: return AppTheme.gold
        case .darkWin: return Color(hex: "B86F22")
        case .lose: return Color(hex: "C47A2C")
        case .death: return Color(hex: "9F2E2E")
        }
    }

    var background: Color {
        switch self {
        case .win: return Color(hex: "3A2811").opacity(0.94)
        case .darkWin: return Color(hex: "30200F").opacity(0.95)
        case .lose: return Color(hex: "2B2117").opacity(0.95)
        case .death: return Color(hex: "1B0F12").opacity(0.97)
        }
    }
}

struct TrialOfAnubisOutcomeView: View {
    let endingID: String
    let outcome: TrialOfAnubisOutcome
    let title: String
    let classification: String
    let imageName: String
    let storyText: String
    let outcomeText: String

    @EnvironmentObject private var navigationState: TrialOfAnubisNavigationState
    @Environment(\.trialOfAnubisReturnToStorySelection) private var returnToStorySelection
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false
    @State private var shakeOffset: CGFloat = 0

    var body: some View {
        ZStack {
            EgyptianBackground()
            if outcome == .death {
                Color.black.opacity(appeared && !reduceMotion ? 0.22 : 0.12)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }

            ScrollView {
                VStack(spacing: 18) {
                    TrialOfAnubisStaticImage(imageName: imageName)

                    outcomeCard

                    TrialOfAnubisResetButtons(
                        restartStory: { navigationState.restartAdventure() },
                        returnToStoryMenu: { navigationState.returnToStoryMenu() },
                        returnToStorySelection: {
                            navigationState.returnToStoryMenu()
                            returnToStorySelection()
                        }
                    )
                }
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear { runEntrance() }
        .navigationBarBackButtonHidden(true)
    }

    private var outcomeCard: some View {
        VStack(spacing: 12) {
            ZStack {
                if outcome == .win && appeared && !reduceMotion {
                    winSparkles
                        .allowsHitTesting(false)
                        .accessibilityHidden(true)
                }

                Image(systemName: outcome.iconName)
                    .font(.system(size: 46, weight: .bold))
                    .foregroundColor(outcome.accent)
                    .shadow(color: outcome.accent.opacity(outcome == .win ? 0.68 : 0.42), radius: outcome == .win ? 14 : 8)
                    .accessibilityHidden(true)
            }
            .scaleEffect(iconScale)
            .offset(x: shakeOffset)

            Text(outcome.presentationTitle)
                .font(.system(.largeTitle, design: .serif).weight(.bold))
                .foregroundColor(outcome.accent)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)

            Text(outcome.subtitle)
                .font(.system(.subheadline, design: .serif).weight(.medium))
                .foregroundColor(AppTheme.mutedText)
                .multilineTextAlignment(.center)

            Text(title)
                .font(.system(.title2, design: .serif).weight(.bold))
                .foregroundColor(AppTheme.gold)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)

            Text(classification)
                .font(.system(.headline, design: .serif).weight(.semibold))
                .foregroundColor(outcome.accent)
                .multilineTextAlignment(.center)

            Text(storyText)
                .font(.system(.body, design: .serif))
                .foregroundColor(AppTheme.warmText)
                .lineSpacing(5)

            Divider().overlay(AppTheme.gold.opacity(0.65))

            Text(outcomeText)
                .font(.system(.body, design: .serif).weight(.medium))
                .foregroundColor(AppTheme.sand)
                .lineSpacing(5)
        }
        .goldCard()
        .background(RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous).fill(outcome.background))
        .overlay(RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous).stroke(outcome.accent.opacity(0.72), lineWidth: 1.2))
        .shadow(color: outcome.accent.opacity(0.22), radius: 18, x: 0, y: 10)
        .frame(maxWidth: AppTheme.maximumTextWidth)
        .opacity(appeared || reduceMotion ? 1 : 0)
        .offset(y: outcome == .darkWin && !reduceMotion && !appeared ? 12 : 0)
        .accessibilityElement(children: .contain)
    }

    private var iconScale: CGFloat {
        guard !reduceMotion else { return 1 }
        switch outcome {
        case .win: return appeared ? 1 : 0.78
        case .death: return appeared ? 1 : 0.92
        case .darkWin, .lose: return 1
        }
    }

    private var winSparkles: some View {
        ZStack {
            ForEach(0..<6) { index in
                Circle()
                    .fill(outcome.accent.opacity(0.78))
                    .frame(width: index.isMultiple(of: 2) ? 4 : 6, height: index.isMultiple(of: 2) ? 4 : 6)
                    .offset(x: sparkleOffsets[index].x, y: sparkleOffsets[index].y)
                    .opacity(appeared ? 1 : 0)
            }
        }
    }

    private let sparkleOffsets: [CGPoint] = [
        CGPoint(x: -42, y: -18),
        CGPoint(x: -24, y: 24),
        CGPoint(x: 28, y: -28),
        CGPoint(x: 46, y: 12),
        CGPoint(x: -8, y: -38),
        CGPoint(x: 12, y: 34)
    ]

    private func runEntrance() {
        guard !appeared else { return }
        guard !reduceMotion else {
            appeared = true
            return
        }

        switch outcome {
        case .win:
            withAnimation(.easeOut(duration: 0.55)) { appeared = true }
        case .darkWin:
            withAnimation(.easeOut(duration: 0.5)) { appeared = true }
        case .lose:
            withAnimation(.easeOut(duration: 0.28)) { appeared = true }
            Task { @MainActor in
                for offset in [-8, 7, -5, 3, 0] {
                    withAnimation(.easeInOut(duration: 0.06)) { shakeOffset = CGFloat(offset) }
                    try? await Task.sleep(nanoseconds: 60_000_000)
                }
            }
        case .death:
            withAnimation(.easeOut(duration: 0.7)) { appeared = true }
        }
    }
}

struct TrialOfAnubisOutcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            preview(.win).previewDisplayName("Win outcome")
            preview(.darkWin).previewDisplayName("Dark Win outcome")
            preview(.lose).previewDisplayName("Lose outcome")
            preview(.death).previewDisplayName("Death outcome")
        }
    }

    private static func preview(_ outcome: TrialOfAnubisOutcome) -> some View {
        TrialOfAnubisPreviewContainer {
            TrialOfAnubisOutcomeView(
                endingID: "preview",
                outcome: outcome,
                title: "The Scales Restored",
                classification: "Preview Classification",
                imageName: "ENDTRUE.png",
                storyText: "A preview ending narrative remains fully visible for accessibility and small devices.",
                outcomeText: "A preview outcome text remains separate from the narrative."
            )
        }
    }
}
