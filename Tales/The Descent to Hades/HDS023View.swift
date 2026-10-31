import SwiftUI

struct HDS023View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_sweet_forgetting",
            outcome: .lose,
            title: "The Sweet Forgetting",
            classification: "Forgotten",
            imageName: "HDS023.png",
            storyText: """
            You drink. The water tastes of nothing at all, and then of nothing at all forever. The storm goes. The boat goes. Theo’s face blurs, then his name, then the fact that there was ever anyone to look for. It does not hurt. That is the strangest part. You stand up, smile at nothing and wander into the asphodel with the other shades, and you never once wonder why you came. A few fields away, a boy in a yellow jacket sits among the flowers. Neither of you looks up as you pass.
            """,
            outcomeText: """
            You drank from Lethe to escape your grief.

            You have forgotten everything, even the one you came to save.
            """
        )
    }
}

struct HDS023View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS023View()
        }
    }
}
