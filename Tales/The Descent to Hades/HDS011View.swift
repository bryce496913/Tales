import SwiftUI

struct HDS011View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS011.png",
            title: "The Hound of Hades",
            text: """
            Beyond the river stands a gate of black iron, and in front of it lies Cerberus, the hound who guards the underworld. He is bigger than a horse, with three heads, a mane of hissing serpents and a tail that ends in a snake’s head. The souls walking past him go through untouched, but all three heads lift at once and turn toward you, smelling living blood. The middle head bares teeth the size of daggers. You remember what Hermes said about Orpheus and his lyre. You have no lyre. You have only your voice, and it is shaking.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .bronzeGate,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Sing",
                    destination: .hds013
                )

                DescentToHadesNavigationButton(
                    title: "Run past",
                    destination: .hds012
                )
            }
        }
    }
}

struct HDS011View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS011View()
        }
    }
}
