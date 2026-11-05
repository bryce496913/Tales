import SwiftUI

struct AMA006View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA006",
            title: "The Foxfire Trail",
            text: """
            The fox’s eyes narrow, and then it laughs. “Clever, clever. Your grandmother taught you something.” It trots ahead into the trees, and you follow its light up the mountain. Near the summit, the path splits around an ancient cedar. The fox stops, and its flame splits in two. One light drifts to the left, dim and flickering. The other floats to the right, bright and steady and warm, and it seems to be calling you. When you turn to ask the fox which one to follow, it has gone, and two more lights are dancing in the dark behind you. Your grandmother’s bell is cold in your fist.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Ring Grandmother’s bell",
                    destination: .ama007
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Follow the brightest light",
                    destination: .ama008
                )
            }
        }
    }
}

struct AMA006View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA006View()
        }
    }
}
