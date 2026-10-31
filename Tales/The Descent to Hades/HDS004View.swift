import SwiftUI

struct HDS004View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS004.png",
            title: "The Grasping Shades",
            text: """
            You push into the crowd, shouting Theo’s name. The dead stop walking. One by one they turn toward you, drawn by the warmth of your skin and the sound of your heartbeat. Cold hands close on your arms, your face, your throat. They are not cruel. They are hungry for the feeling of being alive, and they are taking it from you one breath at a time. Your vision greys at the edges. Then a hand as warm as your own grabs your wrist and pulls you out of the crush. It is the stranger with the winged sandals. “Rule one,” he says. “Never run at the dead.”
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Take his hand",
                    destination: .hds005
                )
            }
        }
    }
}

struct HDS004View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS004View()
        }
    }
}
