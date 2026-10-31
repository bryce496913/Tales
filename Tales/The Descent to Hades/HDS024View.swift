import SwiftUI

struct HDS024View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS024.png",
            title: "The Gates of Tartarus",
            text: """
            The bronze road drops steeply into a canyon glowing red, where the river Phlegethon flows in a ring of liquid fire around a fortress of bronze walls. This is Tartarus, the prison of the Titans and of the worst of the dead. Its gates stand open, but on the tower above them sits a woman with wings like a bat’s, serpents in her hair and a whip of flame in her hand. She is Tisiphone, one of the Furies, the punishers of the guilty. She has already seen you. Further along, the fortress wall is lower, cracked and climbable.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .bronzeGate,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Ask to enter",
                    destination: .hds025
                )

                DescentToHadesNavigationButton(
                    title: "Climb the wall",
                    destination: .hds026
                )
            }
        }
    }
}

struct HDS024View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS024View()
        }
    }
}
