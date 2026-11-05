import SwiftUI

struct AMA017View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA017",
            title: "The Hollow of the Hidden",
            text: """
            Without warning, black talons grab your collar and lift you into the air. Crow-tengu carry you, laughing, over the treetops and drop you into a deep hollow among the cedar roots, far from any path. You are not alone. Dozens of people are sitting in the hollow, in clothes from every age: a farmer in straw sandals, a samurai in old-fashioned armour, a child holding a kite. Each of them was spirited away by the tengu, and none of them seems to mind. They smile at you vaguely. “Sit down,” says the farmer. “It’s peaceful here. Nobody ever has to go anywhere again.” Your legs are very tired.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Ring Grandmother’s bell",
                    destination: .ama018
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Sit down and rest",
                    destination: .ama021
                )
            }
        }
    }
}

struct AMA017View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA017View()
        }
    }
}
