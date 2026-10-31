import SwiftUI

struct HDS003View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_lost_to_the_sea",
            outcome: .death,
            title: "Lost to the Sea",
            classification: "Death",
            imageName: "HDS003.png",
            storyText: """
            You turn away from the stairs and dive toward the green light. The opening is further away than it looked. You swim until your lungs burn, then a little more, but the light never comes closer. When you finally break the surface, there is no cape, no coastline and no boat, only a flat grey sea beneath a sky without a sun. You float there for a long time, calling Theo’s name, until the cold settles into your bones and the water gently takes you. Far below, a stairway you chose not to climb waits in the dark.
            """,
            outcomeText: """
            You turned back from the doorway, and the sea claimed you instead.

            Theo walks the road of the dead alone.
            """
        )
    }
}

struct HDS003View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS003View()
        }
    }
}
