import SwiftUI

struct AMA031View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA031",
            title: "The Chopsticks in the River",
            text: """
            The cloud road brings you down in the land of Izumo, beside the Hii River, which runs black and fast between dark mountains. The air smells of pine and of something else, something rotten and wet, like the skin a snake leaves behind. As you stand on the bank, a pair of chopsticks comes floating down the river toward you. Someone lives upstream. At the same moment, from a ruined hut on the other side of the river, you hear a deep voice singing, loudly and very badly, about the sea.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Follow them upstream",
                    destination: .ama033
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Follow the singing",
                    destination: .ama032
                )
            }
        }
    }
}

struct AMA031View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA031View()
        }
    }
}
