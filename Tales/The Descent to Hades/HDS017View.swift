import SwiftUI

struct HDS017View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS017.png",
            title: "The Brother Who Forgot",
            text: """
            You kneel beside him and say his name. Theo looks at you politely, the way he would look at a stranger on a train. He does not know you. He says it is peaceful here, that nothing hurts, and that he thinks he used to be afraid of the sea, though he cannot remember why. His hands are cold and pale. When you hold them, a flicker of something crosses his face and is gone. You could tell him who he is and make him remember. It would hurt him. Or you could leave him in peace until you have a way to bring him home.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Tell him who he is",
                    destination: .hds018,
                    marks: .wokeTheo
                )

                DescentToHadesNavigationButton(
                    title: "Let him rest",
                    destination: .hds018,
                    marks: .leftTheoResting
                )
            }
        }
    }
}

struct HDS017View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS017View()
        }
    }
}
