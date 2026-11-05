import SwiftUI

struct AMA024View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA024",
            title: "The Sea Monk",
            text: """
            You push the boat into the silent water and row out into the dark until the beach disappears behind you. Then the sea in front of you rises into a hill, and the hill opens two enormous eyes. It is an umibōzu, a sea monk: a shadow as big as a temple, with a round, bald head and no mouth that you can see. A voice comes out of the water all around you. “Lend me a bucket. Lend me a bucket.” Your grandmother told you about the umibōzu. Give one a bucket, and it will fill your boat with seawater until it sinks. Give it a ladle with the bottom knocked out, and it will scoop at the sea forever without filling anything, until it gives up and sinks back down, dragging the water with it.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Give it the ladle with no bottom",
                    destination: .ama025
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Give it your bucket",
                    destination: .ama027
                )
            }
        }
    }
}

struct AMA024View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA024View()
        }
    }
}
