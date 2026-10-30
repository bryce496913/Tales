import SwiftUI

struct ANU017View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_swallowed_by_fog",
            outcome: .death,
            title: "Swallowed by the Fog",
            classification: "Death",
            imageName: "ANU017.png",
            storyText: """
            You ignore Anubis and run deeper into the fog. The voices calling your name grow closer until they are beside you, then in front of you, then inside your head. The floor disappears and you fall into a pit of grasping shadows. Faces you know appear in the darkness, but their eyes are empty and their hands are cold. Far above, Anubis says your name one last time, quietly, the way someone speaks at a graveside. Then the shadows close over you and there is nothing left to run from.
            """,
            outcomeText: """
            You fled from the god of the dead, and the darkness between worlds caught you first.

            Your name now belongs to the voices in the fog.
            """
        )
    }
}

struct ANU017View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU017View()
        }
    }
}
