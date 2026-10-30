import SwiftUI

struct ANU019View: View {
    @EnvironmentObject
    private var navigationState: TrialOfAnubisNavigationState

    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU019.png",
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
                    title: "Let it go",
                    destination: .anu020
                )

                if navigationState.progress.storyFlags.contains(.freedSoul) {
                    TrialOfAnubisNavigationButton(
                        title: "Stay",
                        destination: .anu046
                    )
                } else {
                    TrialOfAnubisNavigationButton(
                        title: "Stay",
                        destination: .anu040
                    )
                }
            }
        }
    }
}

struct ANU019View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU019View()
        }
    }
}
