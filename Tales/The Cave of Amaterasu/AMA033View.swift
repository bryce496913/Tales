import SwiftUI

struct AMA033View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA033",
            title: "The Weeping House",
            text: """
            Upstream, in the clearing the chopsticks came from, stands a farmhouse with every shutter closed. Inside, an old man and an old woman sit weeping on either side of a young woman with a wooden comb in her hair. They are Ashinazuchi and Tenazuchi, and their daughter is Kushinada. Once they had eight daughters. Every year, the eight-headed serpent Yamata no Orochi came down from the mountains and ate one, and tonight it is coming for the last. “It has eight heads and eight tails,” the old man says, “and its body stretches over eight valleys and eight hills. In one of its tails there is something that shines like lightning.” The sword. The old woman wrings her hands. “We have rice,” she says. “We could brew sake.”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Brew eight vats of sake",
                    destination: .ama034
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Face the serpent alone",
                    destination: .ama035
                )
            }
        }
    }
}

struct AMA033View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA033View()
        }
    }
}
