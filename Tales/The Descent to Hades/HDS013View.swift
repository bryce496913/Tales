import SwiftUI

struct HDS013View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS013.png",
            title: "Persephone’s Garden",
            text: """
            You sing the only song you know by heart, the one your mother sang when Theo could not sleep. Your voice cracks on the first line, but you keep going, and one by one the three great heads sink to the ground. You slip through the gate into a garden of pale asphodel and silver poplars, where a woman in a crown of dark flowers is waiting. She is Persephone, Queen of the Underworld. She heard the song, she says, and she knows who you have come for. Hades will hear a living petitioner only if they bring him three gifts: water from Lethe, the river of forgetting; an ember from Phlegethon, the river of fire; and a branch of the Golden Bough from Elysium. She gives you a clay flask and a bronze bowl for the journey, then holds out a split pomegranate, its seeds glittering like rubies. “You’ve come such a long way. Eat something.”
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Eat the fruit",
                    destination: .hds014
                )

                DescentToHadesNavigationButton(
                    title: "Thank her and go",
                    destination: .hds015
                )
            }
        }
    }
}

struct HDS013View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS013View()
        }
    }
}
