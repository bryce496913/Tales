import SwiftUI

struct ANU018View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU017.png",
            title: "Maze of False Memories",
            text: """
            The passage disappears into thick white fog and the walls begin changing whenever you look away. Doors open onto places from your past, including your childhood home, crowded streets and rooms containing people you once knew. Anubis warns from somewhere far away that names disappear first, then faces and finally purpose. Two paths form ahead: one leads toward a warm memory of home, while the other leads toward the memory of your greatest failure.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Remember home",
                    destination: .anu019
                )

                TrialOfAnubisNavigationButton(
                    title: "Face your failure",
                    destination: .anu042
                )
            }
        }
    }
}

struct ANU018View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU018View()
        }
    }
}
