import SwiftUI

struct HDS012View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_torn_by_cerberus",
            outcome: .death,
            title: "Torn by Cerberus",
            classification: "Death",
            imageName: "HDS012.png",
            storyText: """
            You sprint for the gate. You are fast, but Cerberus has three heads and has been guarding this gate since before the first city was built. The left head catches your jacket, the right head catches your arm, and the middle head does not need to catch anything at all. The last thing you hear is the iron gate swinging shut and, somewhere beyond it, very faintly, Theo calling your name.
            """,
            outcomeText: """
            You tried to run past the hound of Hades.

            Cerberus does not let the living through his gate.
            """
        )
    }
}

struct HDS012View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS012View()
        }
    }
}
