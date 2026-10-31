import SwiftUI

struct HDS039View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_isles_of_the_blessed",
            outcome: .bittersweet,
            title: "The Isles of the Blessed",
            classification: "Peaceful Rest",
            imageName: "HDS039.png",
            storyText: """
            You lie down in the shade and close your eyes, just for a moment. The grass is soft, the sea whispers somewhere below, and the warmth of the sun sinks into your bones. When you wake it is still afternoon, and it always will be. You have a place at the feast now, and a white house by the sea, and you will never be cold or frightened again. Sometimes you remember that there was someone you were supposed to find. Then the music starts again, and you forget to worry about it.
            """,
            outcomeText: """
            You rested in Elysium and never left.

            It is a kind of paradise, but Theo is not in it.
            """
        )
    }
}

struct HDS039View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS039View()
        }
    }
}
