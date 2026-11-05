import SwiftUI

/// End-game hub, reached through HOME once all three treasures are held.
/// Remembered choices add lines, and telling the fox your name adds a third choice.
struct AMA039View: View {
    @EnvironmentObject
    private var navigationState: CaveOfAmaterasuNavigationState

    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA039",
            title: "The Festival at the Rock",
            text: storyText,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Begin the festival",
                    destination: .ama040
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Go into the cave yourself",
                    destination: .ama045
                )

                if navigationState.hasFlag(.toldFoxYourName) {
                    CaveOfAmaterasuNavigationButton(
                        title: "Let the fox speak for you",
                        destination: .ama047
                    )
                }
            }
        }
    }

    private var storyText: String {
        var result = """
        When you bring back the last treasure, heaven bursts into motion. The gods tear up a sakaki tree from the sacred mountain and plant it in front of the Heavenly Rock Cave. On its upper branches they hang the Curved Jewels, which glow red and green. On its middle branches they hang the Eight-Hand Mirror, facing the rock. The sword is laid at its roots. Long-crowing roosters are carried in from the Eternal Land and set along the cliffs. Ame-no-Uzume ties back her sleeves, and Tajikarao, god of strength, a mountain of a god with arms like tree trunks, hides beside the boulder. Omoikane turns to you. “You carried the treasures,” he says. “The first move is yours.”
        """

        if navigationState.hasFlag(.defiedSarutahiko) {
            result += " Sarutahiko has come up from the bridge to watch. He catches your eye and does not smile."
        }

        if navigationState.hasFlag(.heardSusanoo) {
            result += " At the edge of the crowd, Susanoo stands with his head bowed, and the gods leave a wide space around him."
        }

        if navigationState.hasFlag(.toldFoxYourName) {
            result += " Among the gods’ feet, a white fox with a blue flame on its tail sits licking its paw. “I said I’d find you later,” it says, and it says your name."
        }

        return result
    }
}

struct AMA039View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA039View()
        }
    }
}
