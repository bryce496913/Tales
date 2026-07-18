import SwiftUI

struct ANU001View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU001.png",
            title: "The Silent Desert",
            text: """
The desert is completely silent. There is no wind, no stars and no sound apart from the slow beat of your own heart. You do not remember how you got here, but a trail of footprints follows you across the cold sand. Ahead, half-buried beneath a dune, stands a black stone doorway carved with golden-eyed jackals. As you move closer, the doorway slowly opens by itself and a voice calls from the darkness, “Your heart has been expected.”
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Approach the black doorway",
                    destination: .anu002
                )

                TrialOfAnubisNavigationButton(
                    title: "Walk away into the desert",
                    destination: .anu003
                )
            }
        }
    }
}

struct ANU001View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU001View()
        }
    }
}
