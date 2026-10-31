import SwiftUI

struct HDS033View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS033.png",
            title: "The Feast of Heroes",
            text: """
            The heroes make room for you at the table without a word, as if they had been expecting you. Someone pours you wine that tastes of honey. Beside you sits a young warrior with tired eyes, whom the others call Achilles. When you tell him why you are here, he is quiet for a while. “I was offered a short life and endless glory, or a long life and a forgotten name. I chose glory. I’ve had a long time to think about it.” He looks at the sunlight in his cup. “I would rather be a hired hand on a poor man’s farm in the world above than king over all the dead. Don’t stay here too long.”
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Stay a while",
                    destination: .hds034
                )

                DescentToHadesNavigationButton(
                    title: "Ask about the golden tree",
                    destination: .hds035
                )
            }
        }
    }
}

struct HDS033View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS033View()
        }
    }
}
