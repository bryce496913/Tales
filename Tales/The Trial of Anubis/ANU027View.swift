import SwiftUI

struct ANU027View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU027.png",
            title: "Restoring the Scales",
            text: """
            You walk to Anubis and place the three pieces in his hands. The Feather Arm settles into place, the Heart Pan locks onto its chain and the Balance Stone slides into the centre with a deep, ringing hum. The great scales rise from the floor, whole again, and across the underworld the open gates begin to close. Anubis turns to you. He explains that the scales must be tested before the dead can trust them, and the first heart they weigh will prove them true. He asks whether you will place your heart upon them.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Accept",
                    destination: .anu030
                )

                TrialOfAnubisNavigationButton(
                    title: "Reject",
                    destination: .anu029
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
