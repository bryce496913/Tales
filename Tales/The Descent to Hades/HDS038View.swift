import SwiftUI

struct HDS038View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS038.png",
            title: "The Golden Bough",
            text: """
            The golden branch breaks away from the tree with a sound like a small bell and drops gently into your hands. It is warm, and lighter than it looks. “The Fates do not want heroes,” the Sibyl says behind you. “They want people who are honest about what they cannot do. Take it to the Queen.” When you look back, the bench is empty, and the white road is waiting.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Take the bough",
                    destination: .hds015,
                    collects: .goldenBough
                )
            }
        }
    }
}

struct HDS038View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS038View()
        }
    }
}
