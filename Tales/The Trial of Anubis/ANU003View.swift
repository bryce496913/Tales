import SwiftUI

struct ANU003View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU003.png",
            title: "The Jackal Temple",
            text: """
                The staircase leads into an ancient temple lined with black jackal statues. Their golden collars remain bright despite the dust, and each statue slowly turns its head to watch you. A narrow path leads toward a circular opening in the floor, while a side room glitters with masks, ceremonial blades and piles of gold. Behind you, the staircase has disappeared and the wall now shows a carving shaped exactly like you. The voice below asks, “What did you come here seeking?”
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Follow the jackal statues",
                    destination: .anu004
                )

                TrialOfAnubisNavigationButton(
                    title: "Search the temple for treasure",
                    destination: .anu013
                )
            }
        }
    }
}
