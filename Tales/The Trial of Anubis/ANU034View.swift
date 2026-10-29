import SwiftUI

struct ANU034View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU016.png",
            title: "Ammit Breaks Free",
            text: """
            With one hard strike, the last link shatters. Ammit throws back her head and roars, shaking dust from every surface in the chamber. She turns, not toward you, but toward the far wall, and charges straight through it. Stone explodes into the darkness and she is gone, her broken chains rattling away into the depths. Where the wall once stood, a ragged hole opens onto thick white fog, and somewhere beyond it you hear a heartbeat that sounds exactly like your own.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Go through",
                    destination: .anu020
                )
            }
        }
    }
}

struct ANU034View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU034View()
        }
    }
}
