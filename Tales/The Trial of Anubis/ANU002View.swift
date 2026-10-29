import SwiftUI

struct ANU002View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU002.png",
            title: "The Black Doorway",
            text: """
            You stop at the doorway and look down a staircase lit by cold blue flames. Carvings on the walls show Anubis standing beside a great set of scales, judging the dead before they pass into the afterlife. The final carving has been smashed, showing the scales broken and a many-jawed creature rising from below. A scraping sound echoes from somewhere deep beneath you before the hidden voice speaks again. “You may enter willingly, or you may enter afraid.”
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Enter",
                    destination: .anu004
                )

                TrialOfAnubisNavigationButton(
                    title: "Call into the darkness",
                    destination: .anu003
                )
            }
        }
    }
}

struct ANU002View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU002View()
        }
    }
}
