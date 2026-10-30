import SwiftUI

struct ANU033View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU006.png",
            title: "The Price of a Reward",
            text: """
            Anubis’s eyes narrow and the growling behind the pillars falls silent. “You stand in the hall of the dead and ask for payment,” he says. For a moment, you are certain you have made a terrible mistake. Then he laughs, low and dry. “Very well. Restore the scales and you may name your reward. But remember that the scales will weigh the asking too.” He strikes the floor with his staff, and behind you a gate carved with a feather begins to open.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Enter the gate",
                    destination: .anu008
                )
            }
        }
    }
}

struct ANU033View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU033View()
        }
    }
}
