import SwiftUI

struct AMA010View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA010",
            title: "The Ruined Weaving Hall",
            text: """
            The High Plain of Heaven should be bright, but tonight it is as dark as the world below. The first building you come to is a great hall with its roof torn open, where looms lie smashed and threads of silver silk trail across the floor. This was Amaterasu’s weaving hall, the one Susanoo destroyed. One loom is still standing, and at it sits a young woman in a pale robe, weaving in the dark. Her hands move, but no cloth comes from the loom. “The goddess will need a new robe when she comes out,” she says without looking up. “But my hands are so tired. Sit with me and help me finish it. It won’t take long.” Far off across the plain, you can see the torches of a great crowd.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Sit at the loom",
                    destination: .ama011
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Go on toward the torches",
                    destination: .ama012
                )
            }
        }
    }
}

struct AMA010View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA010View()
        }
    }
}
