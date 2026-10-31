import SwiftUI

struct HDS044View: View {
    @EnvironmentObject
    private var navigationState: DescentToHadesNavigationState

    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_out_into_the_sun",
            outcome: .win,
            title: "Out Into the Sun",
            classification: "Best Ending",
            imageName: "HDS044.png",
            storyText: storyText,
            outcomeText: """
            You walked through the underworld and did not look back.

            Theo lives, and you brought him home.
            """
        )
    }

    private var storyText: String {
        var result = """
        You keep your eyes on the light and step out of the cave into the afternoon sun. The sea is calm and the air is warm. You stand on the rocks of Cape Tainaron and count to three, and only then do you turn around. Theo is standing behind you, soaked and shivering and squinting at the sun. He is breathing. For a long moment neither of you can say anything. Then he grabs you in a hug so hard it hurts. Out on the water, a fishing boat is heading toward you, its crew waving and shouting. Behind you, the cave has gone, as though there was only ever rock.
        """

        if navigationState.hasFlag(.wokeTheo) {
            result += " “You came to get me,” Theo says into your shoulder. “I remembered you the whole way up.”"
        }

        if navigationState.hasFlag(.leftTheoResting) {
            result += " Theo does not remember the underworld. He remembers the wave, and then your face. You decide that is enough."
        }

        if navigationState.hasFlag(.helpedSisyphus) {
            result += " Far away, so faint you might have imagined it, you hear a great stone come to rest at the top of a hill."
        }

        return result
    }
}

struct HDS044View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS044View()
        }
    }
}
