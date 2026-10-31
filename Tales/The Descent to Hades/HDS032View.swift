import SwiftUI

struct HDS032View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS032.png",
            title: "The Fields of Elysium",
            text: """
            The white road climbs through a gate of polished ivory, and suddenly there is sunlight. Real, warm sunlight, falling on green meadows, orchards heavy with fruit and a sea so blue it hurts to look at. These are the Elysian Fields, where heroes and the blessed dead live without pain or sorrow. Music drifts from a long table beneath the olive trees, where warriors in bronze laugh and raise their cups. Far across the fields, on a low hill, a single tree shines like a flame of gold.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Join the feast",
                    destination: .hds033
                )

                DescentToHadesNavigationButton(
                    title: "Head for the golden tree",
                    destination: .hds035
                )
            }
        }
    }
}

struct HDS032View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS032View()
        }
    }
}
