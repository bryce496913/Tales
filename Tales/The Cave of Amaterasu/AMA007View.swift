import SwiftUI

struct AMA007View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA007",
            title: "The God of the Crossing",
            text: """
            The path ends at the summit of Mount Takachiho, where an old wooden shrine leans in the wind. Beyond it, a bridge of mist and pale rainbow light rises from the rock and climbs into the dark sky. In front of the bridge stands a giant of a man with his arms folded. His face is red, his nose is as long as your forearm, and his eyes shine like mirrors. This is Sarutahiko, god of crossroads and guardian of the way between heaven and earth. He looks down at you for a long time. “The Floating Bridge of Heaven is for gods,” he says. “Little human, who gave you leave to climb it?”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .shojiSlide,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Bow and ask his leave",
                    destination: .ama009
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Say you need no one’s leave",
                    destination: .ama009,
                    marks: .defiedSarutahiko
                )
            }
        }
    }
}

struct AMA007View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA007View()
        }
    }
}
