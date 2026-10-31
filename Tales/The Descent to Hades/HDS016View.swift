import SwiftUI

struct HDS016View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS016.png",
            title: "The Asphodel Meadows",
            text: """
            The grey road fades into endless fields of pale asphodel. This is where most of the dead go: not good enough for Elysium, not wicked enough for Tartarus. They drift between the flowers like sleepwalkers, never speaking, never quite remembering who they were. Somewhere ahead you can hear running water. Then, among the drifting shades, you see a yellow jacket. Theo is sitting in the flowers with his knees pulled up, staring at nothing.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Go to Theo",
                    destination: .hds017
                )

                DescentToHadesNavigationButton(
                    title: "Follow the water",
                    destination: .hds018
                )
            }
        }
    }
}

struct HDS016View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS016View()
        }
    }
}
