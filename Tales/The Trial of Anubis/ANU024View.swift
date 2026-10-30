import SwiftUI

struct ANU024View: View {
    @EnvironmentObject
    private var navigationState: TrialOfAnubisNavigationState

    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU024.png",
            title: "Balance Stone Chamber",
            text: storyText,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Take it",
                    destination: .anu036,
                    collects: .balanceStone
                )

                TrialOfAnubisNavigationButton(
                    title: "Rip it free",
                    destination: .anu025,
                    collects: .balanceStone
                )
            }
        }
    }

    private var storyText: String {
        var result = """
        The final piece floats above a machine of turning stone rings. The Balance Stone is small enough to fit in your hand, but the entire room leans around it. A giant guardian made from stone and linen stands beside the mechanism with a ceremonial blade. Its face has been erased and it warns that only the judged may carry balance. You can either carefully unlock the mechanism or tear the stone free before the guardian attacks.
        """

        if navigationState.progress.storyFlags.contains(.acceptedRebel) {
            result += " On your palm, the rebel’s mark glows faintly, and the guardian’s blank face turns toward it as if it already knows whose side you have chosen."
        }

        return result
    }
}

struct ANU024View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU024View()
        }
    }
}
