import SwiftUI

enum DescentToHadesOutcome {
    case win
    case darkWin
    case bittersweet
    case lose
    case death

    var presentationTitle: String {
        switch self {
        case .win: return "Victory"
        case .darkWin: return "A Stolen Victory"
        case .bittersweet: return "A Bittersweet End"
        case .lose: return "Defeat"
        case .death: return "You Have Fallen"
        }
    }

    var subtitle: String {
        switch self {
        case .win: return "The sun is warm, and you did not climb alone."
        case .darkWin: return "The living world welcomes you back, but a god keeps count."
        case .bittersweet: return "Something was saved, and something was lost."
        case .lose: return "The underworld keeps what it is given."
        case .death: return "Another shade joins the long grey road."
        }
    }

    var iconName: String {
        switch self {
        case .win: return "sun.max.fill"
        case .darkWin: return "bolt.fill"
        case .bittersweet: return "leaf.fill"
        case .lose: return "cloud.fog.fill"
        case .death: return "xmark.shield.fill"
        }
    }

    var accent: Color {
        switch self {
        case .win: return Color(hex: "E2B866")
        case .darkWin: return Color(hex: "8C6BC2")
        case .bittersweet: return Color(hex: "6F9CC9")
        case .lose: return DescentToHadesTheme.asphodel
        case .death: return DescentToHadesTheme.pomegranate
        }
    }

    var background: Color {
        switch self {
        case .win: return Color(hex: "2A2215").opacity(0.94)
        case .darkWin: return Color(hex: "1D1730").opacity(0.95)
        case .bittersweet: return Color(hex: "142236").opacity(0.94)
        case .lose: return Color(hex: "1B1E26").opacity(0.95)
        case .death: return Color(hex: "1A0C12").opacity(0.97)
        }
    }
}

struct DescentToHadesOutcomeView: View {
    let endingID: String
    let outcome: DescentToHadesOutcome
    let title: String
    let classification: String
    let imageName: String
    let storyText: String
    let outcomeText: String

    @EnvironmentObject private var navigationState: DescentToHadesNavigationState
    @Environment(\.descentToHadesReturnToStorySelection) private var returnToStorySelection
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false
    @State private var shakeOffset: CGFloat = 0

    var body: some View {
        ZStack {
            DescentToHadesBackground()
            if outcome == .death {
                Color.black.opacity(appeared && !reduceMotion ? 0.22 : 0.12)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }

            ScrollView {
                VStack(spacing: 18) {
                    DescentToHadesStaticImage(imageName: imageName)
                        .frame(maxWidth: AppTheme.maximumStoryContentWidth)

                    outcomeCard

                    DescentToHadesResetButtons(
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
                .foregroundColor(DescentToHadesTheme.mutedText)
                .multilineTextAlignment(.center)

            Text(title)
                .font(.system(.title2, design: .serif).weight(.bold))
                .foregroundColor(DescentToHadesTheme.bronze)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)

            Text(classification)
                .font(.system(.headline, design: .serif).weight(.semibold))
                .foregroundColor(outcome.accent)
                .multilineTextAlignment(.center)

            Text(storyText)
                .font(.system(.body, design: .serif))
                .foregroundColor(DescentToHadesTheme.marble)
                .lineSpacing(5)

            Divider().overlay(DescentToHadesTheme.bronze.opacity(0.65))

            Text(outcomeText)
                .font(.system(.body, design: .serif).weight(.medium))
                .foregroundColor(DescentToHadesTheme.asphodel)
                .lineSpacing(5)
        }
        .bronzeCard()
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
        case .darkWin, .bittersweet, .lose: return 1
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
        case .bittersweet:
            withAnimation(.easeOut(duration: 0.8)) { appeared = true }
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

struct DescentToHadesOutcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            preview(.win).previewDisplayName("Win outcome")
            preview(.darkWin).previewDisplayName("Dark Win outcome")
            preview(.bittersweet).previewDisplayName("Bittersweet outcome")
            preview(.lose).previewDisplayName("Lose outcome")
            preview(.death).previewDisplayName("Death outcome")
        }
    }

    private static func preview(_ outcome: DescentToHadesOutcome) -> some View {
        DescentToHadesPreviewContainer {
            DescentToHadesOutcomeView(
                endingID: "preview",
                outcome: outcome,
                title: "Out Into the Sun",
                classification: "Preview Classification",
                imageName: "HDS044.png",
                storyText: "A preview ending narrative remains fully visible for accessibility and small devices.",
                outcomeText: "A preview outcome text remains separate from the narrative."
            )
        }
    }
}
