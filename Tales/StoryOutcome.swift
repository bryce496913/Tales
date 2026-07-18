import SwiftUI

enum StoryOutcome { case win, lose, death
    var title: String { switch self { case .win: return "Victory"; case .lose: return "Defeat"; case .death: return "You Have Fallen" } }
    var subtitle: String { switch self { case .win: return "The sands shine on your triumph."; case .lose: return "Your adventure ends, but the legend remains."; case .death: return "The tomb grows quiet around you." } }
    var iconName: String { switch self { case .win: return "crown.fill"; case .lose: return "exclamationmark.triangle.fill"; case .death: return "xmark.shield.fill" } }
    var accent: Color { switch self { case .win: return AppTheme.gold; case .lose: return Color(hex: "C47A2C"); case .death: return Color(hex: "9F2E2E") } }
    var background: Color { switch self { case .win: return Color(hex: "3A2811").opacity(0.92); case .lose: return Color(hex: "2B2117").opacity(0.94); case .death: return Color(hex: "1B0F12").opacity(0.96) } }
    func playHaptic() { switch self { case .win: HapticManager.shared.playWin(); case .lose: HapticManager.shared.playLose(); case .death: HapticManager.shared.playDeath() } }
}

struct StoryOutcomeView: View {
    let endingID: String
    let outcome: StoryOutcome
    let imageName: String
    let storyText: String
    @EnvironmentObject private var gameOptions: GameOptions
    @EnvironmentObject private var navigationState: AppNavigationState
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false
    @State private var hapticPlayed = false
    @State private var textComplete = false

    var body: some View {
        ZStack {
            EgyptianBackground()
            if outcome == .death { Color.black.opacity(animationsEnabled && appeared ? 0.18 : 0).ignoresSafeArea() }
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    StaticStoryImage(imageName: imageName)
                    outcomeCard
                    AdventureResetButtons().padding(.horizontal)
                }
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                .padding(.horizontal, AppTheme.screenPadding)
                .padding(.top, 18)
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            textComplete = !gameOptions.typewriterEnabled || reduceMotion
            guard !appeared else { return }
            navigationState.markEndingReached(endingID)
            if animationsEnabled { runEntrance() } else { appeared = true }
            if !hapticPlayed { outcome.playHaptic(); hapticPlayed = true }
        }
        .accessibilityElement(children: .contain)
    }

    private var outcomeCard: some View {
        VStack(spacing: 14) {
            ZStack {
                if outcome == .win && animationsEnabled && appeared { winSparkles.accessibilityHidden(true) }
                Image(systemName: outcome.iconName)
                    .font(.system(size: 46, weight: .bold))
                    .foregroundColor(outcome.accent)
                    .shadow(color: outcome.accent.opacity(outcome == .win ? 0.65 : 0.35), radius: outcome == .win ? 14 : 7)
                    .accessibilityHidden(true)
            }
            .scaleEffect(iconScale)
            .opacity(appeared ? 1 : (animationsEnabled ? 0 : 1))

            Text(outcome.title).font(.system(.largeTitle, design: .serif).weight(.bold)).foregroundColor(outcome.accent).accessibilityAddTraits(.isHeader)
            Text(outcome.subtitle).font(.system(.subheadline, design: .serif).weight(.medium)).foregroundColor(AppTheme.mutedText).multilineTextAlignment(.center)
            TypewriterText(text: storyText, speed: gameOptions.typewriterSpeed.speed, startDelay: animationsEnabled ? 0.25 : 0, isEnabled: gameOptions.typewriterEnabled && !reduceMotion) { textComplete = true }
        }
        .frame(maxWidth: AppTheme.maximumTextWidth)
        .padding(AppTheme.cardPadding)
        .background(RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous).fill(outcome.background).overlay(RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous).stroke(outcome.accent.opacity(0.75), lineWidth: 1.25)).shadow(color: outcome.accent.opacity(0.22), radius: 18, x: 0, y: 10))
        .offset(x: shakeOffset, y: animationsEnabled && !appeared ? 12 : 0)
        .opacity(appeared ? 1 : (animationsEnabled ? 0 : 1))
        .accessibilityLabel("\(outcome.title). \(outcome.subtitle). \(storyText)")
    }

    private var animationsEnabled: Bool { gameOptions.outcomeAnimationsEnabled && !reduceMotion }
    private var iconScale: CGFloat { !animationsEnabled ? 1 : (appeared ? 1 : 0.75) }
    private var shakeOffset: CGFloat { outcome == .lose && animationsEnabled && appeared ? 0 : 0 }

    private var winSparkles: some View {
        ZStack {
            ForEach(0..<6) { i in Circle().fill(outcome.accent.opacity(0.75)).frame(width: 4 + CGFloat(i % 2) * 3, height: 4 + CGFloat(i % 2) * 3).offset(x: CGFloat([-42,-24,28,46,-8,12][i]), y: CGFloat([-18,24,-28,12,-38,34][i])) }
        }
    }

    private func runEntrance() {
        switch outcome {
        case .win, .death:
            withAnimation(.easeOut(duration: 0.55)) { appeared = true }
        case .lose:
            withAnimation(.easeOut(duration: 0.25)) { appeared = true }
        }
    }
}


struct StoryOutcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PreviewContainer {
                StoryOutcomeView(endingID: "preview-win", outcome: .win, imageName: "Thirteen.png", storyText: "A preview victory ending demonstrates the shared outcome screen.")
            }
            PreviewContainer {
                StoryOutcomeView(endingID: "preview-lose", outcome: .lose, imageName: "Seven.png", storyText: "A preview defeat ending demonstrates the shared outcome screen.")
            }
            PreviewContainer {
                StoryOutcomeView(endingID: "preview-death", outcome: .death, imageName: "Two.png", storyText: "A preview death ending demonstrates the shared outcome screen.")
            }
        }
    }
}
