import SwiftUI

struct ANU042View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU019.png",
            title: "Memory of Failure",
            text: """
            The maze forces you to relive a moment when you failed someone, acted out of fear or allowed another person to carry the cost of your choice. The scene repeats until everyone in it turns to face you. A voice asks whose fault it was, while the maze offers you several people to blame. Behind them, the path forward begins to close.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Admit it",
                    destination: .anu020
                )

                TrialOfAnubisNavigationButton(
                    title: "Blame others",
                    destination: .anu019
                )
            }
        }
    }
}

struct ANU042View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU042View()
        }
    }
}
