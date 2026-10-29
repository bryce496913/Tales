import SwiftUI

struct ANU038View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_buried_with_the_stone",
            outcome: .death,
            title: "Buried with the Stone",
            classification: "Death",
            imageName: "ANU024.png",
            storyText: """
            You throw yourself sideways to dodge the falling slab, but the floor tilts again and you slide straight back into its path. The slab lands with a sound like a door closing. In the silence that follows, the Balance Stone rolls from your hand and comes to rest in the dust, perfectly still, as the chamber settles over you.
            """,
            outcomeText: """
            You destroyed the guardian, and the chamber it protected took its revenge.

            You lie buried with the Balance Stone, far from the scales it belonged to.
            """
        )
    }
}

struct ANU038View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU038View()
        }
    }
}
