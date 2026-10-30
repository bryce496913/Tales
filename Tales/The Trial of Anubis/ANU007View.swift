import SwiftUI

struct ANU007View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU007.png",
            title: "Run from the God",
            text: """
            You turn and run back toward the staircase, but the steps have gone. In their place is a corridor of pale fog filled with voices calling your name. Anubis does not chase you. His voice simply follows, calm and close, as though he is walking beside you. He warns you that the broken scales are already reaching into the living world, and the souls drifting past you now wear the faces of people you know, some of whom are still alive. If the balance is not restored soon, even he will be unable to send you home. Ahead, the fog grows darker and the voices grow louder.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Help",
                    destination: .anu006
                )

                TrialOfAnubisNavigationButton(
                    title: "Keep running",
                    destination: .anu017
                )
            }
        }
    }
}

struct ANU007View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU007View()
        }
    }
}
