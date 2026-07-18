import SwiftUI

struct ANU007View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU007.png",
            title: "Refuse the God",
            text: """
You tell Anubis that you did not choose this and demand to be sent home. He warns you that the doorway only opens for people already standing between important choices. Around you, the wandering souls briefly take the faces of people you know, including some who cannot possibly be dead. Anubis explains that the broken scales have already begun affecting the living world and that soon even he may be unable to return you. A doorway appears behind you, leading into a corridor of pale fog filled with voices calling your name.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Accept after Anubis warns you",
                    destination: .anu008
                )

                TrialOfAnubisNavigationButton(
                    title: "Flee into the darkness",
                    destination: .anu017
                )
            }
        }
    }
}
