import SwiftUI

struct ANU018View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU018.png",
            title: "Memory of Home",
            text: """
                You enter a perfect memory of home, complete with familiar light, sounds and the feeling of being safe. Someone you once loved enters the room and tells you that you have finally returned. Everything feels real, except their shadow points in the wrong direction and the walls flicker whenever you stop looking at them. The figure reaches out and asks you not to leave again.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Accept that the memory may be false",
                    destination: .anu020
                )

                TrialOfAnubisNavigationButton(
                    title: "Stay inside the memory",
                    destination: .endLost
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
