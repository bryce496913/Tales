import SwiftUI

/// Game-over controls for The Trial of Anubis, styled like the rest of the app's choice buttons.
struct TrialOfAnubisResetButtons: View {
    let restartStory: () -> Void
    let returnToStoryMenu: () -> Void
    let returnToStorySelection: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            ChoiceButton("Restart The Trial of Anubis", action: restartStory)
            ChoiceButton("Return to Anubis Menu", action: returnToStoryMenu)
            ChoiceButton("Return to Story Selection", action: returnToStorySelection)
        }
        .frame(maxWidth: AppTheme.maximumButtonWidth)
    }
}
