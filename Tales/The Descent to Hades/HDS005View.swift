import SwiftUI

struct HDS005View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS005.png",
            title: "The Guide of Souls",
            text: """
            The stranger introduces himself as Hermes, messenger of the gods and guide of the dead. Theo’s soul has already gone down toward the river Styx, he says, and the living are not permitted to follow. People have tried, though. Heracles came down to drag out the three-headed hound. Orpheus came down with nothing but a lyre, sang his way past Cerberus and almost brought his wife home. “Almost,” Hermes repeats, and he does not explain. He offers to walk you as far as the river, because he is curious, and because it has been a slow century.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Follow him",
                    destination: .hds007
                )

                DescentToHadesNavigationButton(
                    title: "Ask him to bring Theo back",
                    destination: .hds006
                )
            }
        }
    }
}

struct HDS005View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS005View()
        }
    }
}
