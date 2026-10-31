import SwiftUI

/// Game-over controls for The Descent to Hades.
struct DescentToHadesResetButtons: View {
    let restartStory: () -> Void
    let returnToStoryMenu: () -> Void
    let returnToStorySelection: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            DescentToHadesButton("Restart The Descent to Hades", action: restartStory)
            DescentToHadesButton("Return to Hades Menu", action: returnToStoryMenu)
            DescentToHadesButton("Return to Story Selection", action: returnToStorySelection)
        }
        .frame(maxWidth: AppTheme.maximumButtonWidth)
    }
}
