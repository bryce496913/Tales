import SwiftUI

struct ANU004View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU004.png",
            title: "The Jackal Temple",
            text: """
            The staircase leads into an ancient temple lined with black jackal statues. Their golden collars remain bright despite the dust, and each statue slowly turns its head to watch you. A narrow path leads toward a circular opening in the floor where a spiral staircase winds down into the dark, while a side room glitters with masks, ceremonial blades and piles of gold. Behind you, the staircase has disappeared and the wall now shows a carving shaped exactly like you. The voice below asks, “What did you come here seeking?”
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Follow the statues",
                    destination: .anu013
                )

                TrialOfAnubisNavigationButton(
                    title: "Take the stairs",
                    destination: .anu005
                )
            }
        }
    }
}

struct ANU004View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU004View()
        }
    }
}
