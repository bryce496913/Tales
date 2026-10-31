import SwiftUI

struct HDS022View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS022.png",
            title: "The Water of Lethe",
            text: """
            The flask fills with grey water so cold it numbs your fingers. A wax seal bearing Persephone’s flower closes over the neck by itself. Not a drop can spill, and not a drop can be drunk. The voices in the river fade to a murmur. Whatever you saw in the water, you are still carrying it, and you understand that this is the point. Hades will not hear anyone who came to forget. The grey road leads back toward the crossroads.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Take it",
                    destination: .hds015,
                    collects: .waterOfLethe
                )
            }
        }
    }
}

struct HDS022View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS022View()
        }
    }
}
