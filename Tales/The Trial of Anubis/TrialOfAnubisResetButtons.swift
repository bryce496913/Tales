import SwiftUI

struct TrialOfAnubisResetButtons: View {
    let restartStory: () -> Void
    let returnToStoryMenu: () -> Void
    let returnToStorySelection: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Button("Restart The Trial of Anubis", action: restartStory)
                .buttonStyle(TrialOfAnubisChoiceButtonStyle())
            Button("Return to Anubis Menu", action: returnToStoryMenu)
                .buttonStyle(TrialOfAnubisChoiceButtonStyle())
            Button("Return to Story Selection", action: returnToStorySelection)
                .buttonStyle(TrialOfAnubisChoiceButtonStyle())
        }
        .font(.system(.headline, design: .serif).weight(.semibold))
        .foregroundColor(Color(hex: "1E140B"))
        .frame(maxWidth: AppTheme.maximumButtonWidth)
    }
}
