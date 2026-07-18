import SwiftUI

enum TrialOfAnubisOutcome {
    case win
    case darkWin
    case lose
    case death
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

    var body: some View {
        ZStack {
            EgyptianBackground()

            ScrollView {
                VStack(spacing: 18) {
                    TrialOfAnubisStaticImage(imageName: imageName)

                    VStack(spacing: 12) {
                        Text(title)
                            .font(.system(.largeTitle, design: .serif).weight(.bold))
                            .foregroundColor(AppTheme.gold)
                            .multilineTextAlignment(.center)

                        Text(classification)
                            .font(.system(.headline, design: .serif).weight(.semibold))
                            .foregroundColor(outcomeColor)
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
                    .frame(maxWidth: AppTheme.maximumTextWidth)

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
    }

    private var outcomeColor: Color {
        switch outcome {
        case .win: return Color(hex: "8FD694")
        case .darkWin: return Color(hex: "D68FD6")
        case .lose: return AppTheme.sand
        case .death: return Color(hex: "E66A6A")
        }
    }
}
