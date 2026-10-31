import SwiftUI

struct HDS021View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS021.png",
            title: "The Voice You Woke",
            text: """
            You cup your hands, and the water is almost at your lips when someone grabs your wrist. It is Theo, out of breath, his face no longer blank. “Don’t,” he says. “You told me my name. If you forget, who’s going to remember me?” He is shaking. The river hisses and falls quiet. Theo helps you hold the flask beneath the surface until it is full, then sits down on the bank to wait. “I’ll stay here,” he says. “Just come back for me.”
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Fill the flask",
                    destination: .hds022
                )
            }
        }
    }
}

struct HDS021View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS021View()
        }
    }
}
