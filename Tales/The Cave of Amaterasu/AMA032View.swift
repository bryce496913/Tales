import SwiftUI

struct AMA032View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA032",
            title: "The Exiled God",
            text: """
            Inside the ruined hut, a huge man sits among broken sake jars with his long hair tangled and his beard full of leaves. Even sitting down, he is as tall as you are standing, and thunder mutters faintly whenever he moves. You know who he is before he says it: Susanoo, the storm god, banished from heaven for what he did to his sister. He squints at you. “You smell of heaven,” he says. “Did they send you to laugh at me?” He drinks and wipes his mouth, and for a moment he looks less like a god than like a boy who has broken something he cannot fix. “I never meant for her to hide,” he says quietly. “I only wanted her to look at me.”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Sit and listen",
                    destination: .ama033,
                    marks: .heardSusanoo
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Leave him to his sake",
                    destination: .ama033
                )
            }
        }
    }
}

struct AMA032View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA032View()
        }
    }
}
