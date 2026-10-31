import SwiftUI

struct HDS034View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS034.png",
            title: "The Endless Afternoon",
            text: """
            You only mean to stay for one more song. But the afternoon never ends here, and the sun never moves. When you look down, your cup has been refilled more times than you can count, and the clothes you arrived in look strangely faded, as though years have passed. Achilles has gone. In the warm grass beyond the table there is a soft, shady place where you could lie down and close your eyes. You are so tired. You have not slept since the storm.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Leave now",
                    destination: .hds035
                )

                DescentToHadesNavigationButton(
                    title: "Lie down in the grass",
                    destination: .hds039
                )
            }
        }
    }
}

struct HDS034View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS034View()
        }
    }
}
