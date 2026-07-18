import SwiftUI

struct ANU014View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU014.png",
            title: "Chamber of Stolen Hearts",
            text: """
                The hidden passage leads into a red chamber where thousands of human hearts hang in glass containers from the ceiling. Each one is marked with a name and shows flashes of the life it belonged to. As you move between them, you discover a container carrying your own name, with a heart inside beating in time with your chest. Behind the platform, a massive broken chain disappears through a doorway and a deep growl answers every heartbeat in the room.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Search the suspended hearts",
                    destination: .anu015
                )

                TrialOfAnubisNavigationButton(
                    title: "Cut the chains holding the hearts",
                    destination: .anu016
                )
            }
        }
    }
}
