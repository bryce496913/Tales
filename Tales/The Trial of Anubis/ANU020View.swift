import SwiftUI

struct ANU020View: View {
    @EnvironmentObject
    private var navigationState: TrialOfAnubisNavigationState

    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU020.png",
            title: "The Heart Pan",
            text: storyText,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                if navigationState.progress.collectedItems.contains(.heart) {
                    TrialOfAnubisNavigationButton(
                        title: "Return",
                        destination: .anu011,
                        collects: .heart
                    )
                } else {
                    TrialOfAnubisNavigationButton(
                        title: "Take",
                        destination: .anu011,
                        collects: .heart
                    )
                }
            }
        }
    }

    private var storyText: String {
        var result = """
        The fog clears and reveals a chamber shaped like the inside of a giant heart. The missing Heart Pan hangs at the centre, held above thousands of names carved into the floor. Some of the names belong to the dead, while others belong to people who have not yet been born. Your own name appears beneath your feet beside the name of an underworld scribe, suggesting that your arrival was recorded long before the scales were broken.
        """

        if navigationState.progress.collectedItems.contains(.heart) {
            result += " But as you step closer, it fades like a reflection. The real Heart Pan is already with you, warm against your chest, as if it remembers this place."
        }

        return result
    }
}

struct ANU020View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU020View()
        }
    }
}
