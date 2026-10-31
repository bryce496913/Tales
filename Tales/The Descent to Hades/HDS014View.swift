import SwiftUI

struct HDS014View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_bound_by_the_seeds",
            outcome: .lose,
            title: "Bound by the Seeds",
            classification: "Bound",
            imageName: "HDS014.png",
            storyText: """
            The seeds are sweet and sharp and taste of every summer you have ever known. You have eaten six before you notice Persephone’s sad smile. “I ate six once,” she says quietly, “and that is why I spend half of every year down here.” The colour drains from the world. Your heartbeat slows to match the stillness of the garden, and you understand that the food of the underworld has made you its own. You will never climb back to the sunlight. Sometimes, from the edge of the garden, you see Theo pass along the road with the other souls. You can never quite catch up with him.
            """,
            outcomeText: """
            You ate the food of the dead.

            You belong to the underworld now, as surely as its queen.
            """
        )
    }
}

struct HDS014View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS014View()
        }
    }
}
