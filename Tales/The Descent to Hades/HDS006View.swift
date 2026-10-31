import SwiftUI

struct HDS006View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS006.png",
            title: "The Messenger’s Price",
            text: """
            Hermes laughs, but not unkindly. He cannot simply bring Theo back, he says. His uncle Hades keeps strict accounts, and a soul that leaves without permission is a debt someone has to pay. But Hermes is also the god of thieves, and thieves always know another way out. “Here’s my offer. If it all goes wrong down there, call my name and I’ll get you both out. In return, you’ll owe me a favour. A god’s favour, collected whenever I like.” He holds out his hand. His smile is friendly. His eyes are not.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Accept the bargain",
                    destination: .hds007,
                    marks: .struckHermesBargain
                )

                DescentToHadesNavigationButton(
                    title: "Refuse",
                    destination: .hds007
                )
            }
        }
    }
}

struct HDS006View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS006View()
        }
    }
}
