import SwiftUI

struct ANU028View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_lord_of_the_tomb",
            outcome: .darkWin,
            title: "Lord of the Tomb",
            classification: "Dark Ending",
            imageName: "ANU028.png",
            storyText: """
            You turn from Anubis and run for the glowing passage with the three pieces blazing in your arms. As you cross the threshold, their power pours into you. The passage does not lead home. It leads up into the heart of the tomb, and every torch, statue and stone bends toward you as you pass. Behind you, Anubis’s voice fades into silence. When you finally stop, you are seated on a throne of black stone while the jackal statues kneel before you. The tomb of Anubis is yours now, and so is every soul still waiting inside it.
            """,
            outcomeText: """
            You stole the scales and took the place of a god.

            You rule the tomb of Anubis, but you can never leave it.
            """
        )
    }
}

struct ANU028View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU028View()
        }
    }
}
