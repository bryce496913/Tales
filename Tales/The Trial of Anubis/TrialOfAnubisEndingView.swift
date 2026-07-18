import SwiftUI

struct TrialOfAnubisEndingView: View {
    let title: String
    let classification: String
    let ending: TrialOfAnubisEnding
    let outcome: StoryOutcome
    let narrative: String
    let outcomeText: String
    @EnvironmentObject private var nav: TrialOfAnubisNavigationState
    @EnvironmentObject private var appNavigationState: AppNavigationState
    @EnvironmentObject private var gameOptions: GameOptions
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false

    var body: some View {
        ZStack { EgyptianBackground(); ScrollView { VStack(spacing: 16) {
            Image(systemName: outcome.iconName).font(.system(size: 54, weight: .bold)).foregroundColor(outcome.accent)
            VStack(spacing: 12) { Text(title).font(.system(.largeTitle, design: .serif).weight(.bold)).foregroundColor(outcome.accent).accessibilityAddTraits(.isHeader); Text(classification).font(.headline).foregroundColor(AppTheme.mutedText); Text(narrative).foregroundColor(AppTheme.warmText); Divider().background(AppTheme.gold.opacity(0.5)); Text(outcomeText).foregroundColor(AppTheme.sand).font(.headline) }.frame(maxWidth: .infinity, alignment: .leading).goldCard()
            MenuButton(title: "Restart The Trial of Anubis") { nav.restartAdventure() }
            MenuButton(title: "Return to Story Menu") { nav.returnToStoryMenu(); nav.path = [] }
            MenuButton(title: "Return to Tales Main Menu") { nav.returnToStoryMenu(); appNavigationState.returnToMainMenu() }
        }.frame(maxWidth: 760).padding(AppTheme.screenPadding).opacity(appeared ? 1 : 0.01) } }
        .onAppear { if gameOptions.hapticsEnabled { outcome.playHaptic() }; withAnimation((gameOptions.outcomeAnimationsEnabled && !reduceMotion) ? .easeOut(duration: 0.4) : nil) { appeared = true } }
        .accessibilityLabel("Ending. \(title). \(classification). \(narrative) \(outcomeText)")
    }
}
