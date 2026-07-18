import SwiftUI

struct ANU027View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU027.png",
            title: "The Weighing Begins",
            text: """
                The restored scales rise from the floor with the feather of Ma’at resting on one side and the empty Heart Pan waiting on the other. Anubis stands beside the balance while Ammit watches from the shadows. Every lie, act of mercy, moment of greed and sacrifice returns to your mind as your heart begins burning inside your chest. Anubis reaches out his hand and orders you to place your heart upon the scales.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Submit to Anubis’s judgment",
                    destination: .endAmmit
                )

                TrialOfAnubisNavigationButton(
                    title: "Challenge Anubis and reject judgment",
                    destination: .endRebel
                )
            }
        }
    }
}

struct ANU027View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU027View()
        }
    }
}
