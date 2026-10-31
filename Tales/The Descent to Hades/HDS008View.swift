import SwiftUI

struct HDS008View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_taken_by_the_styx",
            outcome: .death,
            title: "Taken by the Styx",
            classification: "Death",
            imageName: "HDS008.png",
            storyText: """
            You wade into the river while Charon watches without moving. The water is not cold. It is nothing at all. Every step takes something away with it: the feel of sunlight, the taste of salt, the sound of your own voice. By the time it reaches your chest you have forgotten why you are swimming, and soon after that, which way the far shore was. The souls on the bank watch you drift slowly into the mist. The ferryman pushes off without you. He has crossed this river for ten thousand years, and nobody has ever swum it.
            """,
            outcomeText: """
            You tried to cross the Styx without paying the ferryman.

            The river kept you, and Theo never knew you came.
            """
        )
    }
}

struct HDS008View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS008View()
        }
    }
}
