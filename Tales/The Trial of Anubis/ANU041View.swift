import SwiftUI

struct ANU041View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU011.png",
            title: "The Crying Soul",
            text: """
            You find a trapped soul pinned beneath a heavy stone tablet. Their body flickers between a child, an old woman and a wounded soldier as the hall steals pieces of who they were. They tell you that they were waiting for judgment when the scales broke and that soon they will forget their own name. Freeing them will take time, but they promise to show you the safest way to the Feather Arm if you help them.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Free them",
                    destination: .anu012,
                    marks: .freedSoul
                )

                TrialOfAnubisNavigationButton(
                    title: "Leave them",
                    destination: .anu012,
                    marks: .abandonedSoul
                )
            }
        }
    }
}

struct ANU041View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU041View()
        }
    }
}
