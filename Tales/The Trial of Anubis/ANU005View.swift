import SwiftUI

struct ANU005View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU005.png",
            title: "Anubis Revealed",
            text: """
            You descend a spiral staircase that circles a shaft with no visible bottom. As you go, the steps show flashes of your own life: small acts of kindness, lies that were never discovered and moments when fear made your choices for you. At the bottom, the stairs open into a hall so vast that its ceiling disappears into darkness. Anubis stands at its centre, dressed in black and gold, his amber eyes glowing. Behind him lies a shattered set of scales, with one pan cracked on the floor and the central balance stone torn from its frame. Shadowy souls drift through open gates while something enormous growls behind the pillars. Anubis tells you that the scales have been stolen and asks for your help before the boundary between life and death collapses.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Help",
                    destination: .anu006
                )

                TrialOfAnubisNavigationButton(
                    title: "Run",
                    destination: .anu007
                )
            }
        }
    }
}

struct ANU005View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU005View()
        }
    }
}
