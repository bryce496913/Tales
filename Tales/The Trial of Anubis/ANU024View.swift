import SwiftUI

struct ANU024View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU024.png",
            title: "Balance Stone Chamber",
            text: """
The final piece floats above a machine of turning stone rings. The Balance Stone is small enough to fit in your hand, but the entire room leans around it. A giant guardian made from stone and linen stands beside the mechanism with a ceremonial blade. Its face has been erased and it warns that only the judged may carry balance. You can either carefully unlock the mechanism or tear the stone free before the guardian attacks.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Take the Balance Stone carefully",
                    destination: .anu025
                )

                TrialOfAnubisNavigationButton(
                    title: "Rip it from the guardian mechanism",
                    destination: .anu025
                )
            }
        }
    }
}
