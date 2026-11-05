import SwiftUI

struct AMA011View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .lose,
            title: "The Endless Loom",
            classification: "Bound",
            imageName: "AMA011",
            storyText: """
            You sit down beside her, and she shows you how to pass the shuttle through the threads. It is soothing work. Click, pull, click. The weaving maiden smiles at you, and you notice that you can see the loom through her smile. The robe never grows, however fast you weave. Every row you finish quietly unravels behind you. You mean to stop after one more row, then one more, then one more. Somewhere out on the plain, the torches move and the gods argue and wait, and the darkness goes on. You will finish the robe soon. You are sure of it. Click, pull, click.
            """,
            outcomeText: """
            You stopped to weave a robe that can never be finished.

            The weaving maiden is glad of the company, and she always will be.
            """
        )
    }
}

struct AMA011View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA011View()
        }
    }
}
