import SwiftUI

struct ANU045View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU023.png",
            title: "The Rebel’s Fire",
            text: """
            The rebel’s mask tilts to one side. “Then you are just another servant of the scales,” they say, and sweep a lamp from the table. Fire races across the scrolls. By the time you and the scribe have smothered the flames, the rebel is gone. The scribe, his mask darkened with smoke, points you toward a narrow stair spiralling downward. “The Balance Stone lies below,” he says. “Take it before they do.”
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Take the stairs",
                    destination: .anu024
                )
            }
        }
    }
}

struct ANU045View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU045View()
        }
    }
}
