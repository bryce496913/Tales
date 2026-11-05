import SwiftUI

struct AMA035View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA035",
            title: "The Eight-Headed Serpent",
            text: """
            You run at the serpent with the old man’s rusty sword. One head turns to look at you, then another, then all of them: sixteen red eyes in the dark. The nearest head snaps, and you dive aside as its teeth close on the air where you were standing. Your sword bounces off its scales like a stick off a rock. A tail as thick as a cedar trunk sweeps across the ground and knocks you flat. Somewhere behind you, Kushinada is screaming at you to run back to the house.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Run back to the house",
                    destination: .ama034
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Fight on",
                    destination: .ama038
                )
            }
        }
    }
}

struct AMA035View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA035View()
        }
    }
}
