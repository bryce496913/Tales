import SwiftUI

struct HDS018View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS018.png",
            title: "The River of Forgetting",
            text: """
            The sound of water leads you to the river Lethe. It runs slow and milky through the fields, and the shades who kneel to drink from it rise with blank, contented faces. As you take out Persephone’s clay flask, the water seems to notice you. It begins to murmur in voices you recognise: your mother, your friends, Theo. The near bank is low and easy to reach. A line of stepping stones crosses to the far bank, where the water runs deeper and clearer.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Kneel at the water",
                    destination: .hds019
                )

                DescentToHadesNavigationButton(
                    title: "Cross to the far bank",
                    destination: .hds020
                )
            }
        }
    }
}

struct HDS018View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS018View()
        }
    }
}
