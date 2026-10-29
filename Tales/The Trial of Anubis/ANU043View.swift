import SwiftUI

struct ANU043View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU021.png",
            title: "Ink and Threats",
            text: """
            You grab the scribe by his robes and demand the truth. The words on his mask stop moving. Then every scroll in the room unrolls at once, and lines of black ink crawl across the floor and coil around your ankles. “Force writes its own record,” the scribe says calmly. “Would you like to read what it says about you?” He holds out a scroll with your name at the top, the ink still wet. Behind the shelves, something shifts, as if someone else has been listening.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Apologise",
                    destination: .anu022
                )

                TrialOfAnubisNavigationButton(
                    title: "Search",
                    destination: .anu023
                )
            }
        }
    }
}

struct ANU043View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU043View()
        }
    }
}
