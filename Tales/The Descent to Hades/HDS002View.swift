import SwiftUI

struct HDS002View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS002.png",
            title: "The Road of the Dead",
            text: """
            The stairs end on a wide road of grey dust that runs downhill into a twilight with no sun. Pale figures walk along it in silence, each one looking straight ahead. They do not see you, and when you brush against one it feels like walking through cold mist. Far ahead in the crowd you see a head of dark, wet hair and the yellow jacket Theo was wearing on the boat. By the side of the road, a young man in a wide traveller’s hat leans against a milestone, turning a coin across his knuckles. His sandals have small wings at the heels. “You’re breathing,” he says. “That’s going to be a problem.”
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Chase Theo",
                    destination: .hds004
                )

                DescentToHadesNavigationButton(
                    title: "Speak to the stranger",
                    destination: .hds005
                )
            }
        }
    }
}

struct HDS002View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS002View()
        }
    }
}
