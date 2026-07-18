import SwiftUI

struct ANU019View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU019.png",
            title: "Memory of Failure",
            text: """
                The maze forces you to relive a moment when you failed someone, acted out of fear or allowed another person to carry the cost of your choice. The scene repeats until everyone turns to face you. A voice asks whose fault it was, while the maze offers you several people to blame. Behind them, the path forward begins closing.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Admit responsibility",
                    destination: .anu020
                )

                TrialOfAnubisNavigationButton(
                    title: "Blame someone else",
                    destination: .anu020
                )
            }
        }
    }
}
