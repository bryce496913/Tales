import SwiftUI

struct AMA022View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA022",
            title: "The Shore of Night",
            text: """
            The cloud road ends on a beach of black sand where the waves come in without a sound. There are no stars over the sea, only a darkness so deep that the horizon has disappeared. Down by the water, a group of children from a fishing village are poking at something with sticks and laughing. It is a sea turtle, small and old, flipped onto its back with its flippers waving helplessly. Further along the beach, a fishing boat is pulled up on the sand, with a pair of oars, a wooden bucket and a long-handled ladle lying in the bottom. Somewhere out under the black water lies Ryūgū-jō, the palace of the Dragon King.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Save the turtle",
                    destination: .ama023,
                    marks: .savedTheTurtle
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Row out in the fishing boat",
                    destination: .ama024
                )
            }
        }
    }
}

struct AMA022View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA022View()
        }
    }
}
