import SwiftUI

struct ANU014View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU014.png",
            title: "Chamber of Stolen Hearts",
            text: """
            The world tilts and drops away beneath you. When it steadies, you are standing in a red chamber where thousands of human hearts hang from the ceiling in glass containers. Each one is marked with a name and shows flashes of the life it belonged to. Among them you find a container carrying your own name, with a heart inside beating in time with your chest. Behind the platform, a massive broken chain disappears through a doorway and a deep growl answers every heartbeat in the room.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Touch the heart",
                    destination: .anu031
                )

                TrialOfAnubisNavigationButton(
                    title: "Follow the chains",
                    destination: .anu015
                )
            }
        }
    }
}

struct ANU014View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU014View()
        }
    }
}
