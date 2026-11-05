import SwiftUI

/// Susanoo waits at the river if you heard him out at AMA-032.
struct AMA037View: View {
    @EnvironmentObject
    private var navigationState: CaveOfAmaterasuNavigationState

    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA037",
            title: "The Sword of the Gathering Clouds",
            text: storyText,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Take the sword",
                    destination: .ama014,
                    collects: .cloudSword
                )
            }
        }
    }

    private var storyText: String {
        var result = """
        The old man’s rusty sword snaps in two when you strike the tail, but something hidden inside it slices the scales open for you. Out slides a sword of bright steel, cold and straight, humming like a storm far away. This is the Sword of the Gathering Clouds, which people will one day call Kusanagi, the Grass-Cutter. Kushinada and her parents come out of the house and bow to the ground. Orochi will sleep for a hundred years, the old man says, and that is long enough for anyone.
        """

        if navigationState.hasFlag(.heardSusanoo) {
            result += " When you reach the river, Susanoo is waiting on the bank, sober now, with his hair tied back. He looks at the sword in your hands for a long time. “It was always meant to be my apology,” he says. “Carry it to her. I will follow you, if they let me.”"
        } else {
            result += " On your way back down the river, you pass the ruined hut. It is empty now except for broken jars."
        }

        return result
    }
}

struct AMA037View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA037View()
        }
    }
}
