import SwiftUI

struct HDS025View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS025.png",
            title: "Tisiphone the Avenger",
            text: """
            You walk up to the gate and ask to enter. Tisiphone drops from the tower and lands in front of you, her wings filling the sky. “No one walks into Tartarus,” she says. “They are dragged. But a living heart may pass, if it first confesses something it has never told anyone.” Her serpents taste the air in front of your face. You understand that she already knows what you will say, and only wants to hear whether you will say it.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Confess",
                    destination: .hds027
                )

                DescentToHadesNavigationButton(
                    title: "Refuse",
                    destination: .hds026
                )
            }
        }
    }
}

struct HDS025View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS025View()
        }
    }
}
