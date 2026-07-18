import SwiftUI

struct ANU017View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU017.png",
            title: "Maze of False Memories",
            text: """
                The passage disappears into thick white fog and the walls begin changing whenever you look away. Doors open onto places from your past, including your childhood home, crowded streets and rooms containing people you once knew. Anubis warns from somewhere far away that names disappear first, then faces and finally purpose. Two paths form ahead: one leads toward a warm memory of home, while the other leads toward the memory of your greatest failure.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Follow the memory of home",
                    destination: .anu018
                )

                TrialOfAnubisNavigationButton(
                    title: "Follow the memory of your greatest failure",
                    destination: .anu019
                )
            }
        }
    }
}
