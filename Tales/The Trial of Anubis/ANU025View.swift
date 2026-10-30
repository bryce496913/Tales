import SwiftUI

struct ANU025View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU025.png",
            title: "The Final Guardian",
            text: """
            The guardian blocks the exit as cracks spread across its body. It says that it was created to protect the Balance Stone and now has no purpose without it. The room begins collapsing behind you while the guardian lowers its weapon and asks you to judge what should happen to it. You can spare it or destroy it.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Spare",
                    destination: .anu036
                )

                TrialOfAnubisNavigationButton(
                    title: "Destroy",
                    destination: .anu037
                )
            }
        }
    }
}

struct ANU025View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU025View()
        }
    }
}
