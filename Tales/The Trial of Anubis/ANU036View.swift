import SwiftUI

struct ANU036View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU036.png",
            title: "The Guardian’s Guidance",
            text: """
            The guardian lowers its blade and bows its erased face toward you. “You have judged fairly,” it says. It leads you through the shaking chamber, holding back falling stone with its own cracked body, until you reach a quiet passage lit by blue fire. At the end, the guardian stops, unable to go any further. It raises one stone hand toward the passage ahead, where you can hear the low hum of the Hall of Gates.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Return",
                    destination: .anu011
                )
            }
        }
    }
}

struct ANU036View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU036View()
        }
    }
}
