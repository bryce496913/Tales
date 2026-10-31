import SwiftUI

struct HDS026View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS026.png",
            title: "The Fury’s Lash",
            text: """
            Tisiphone’s whip cracks against the bronze an inch from your head. You throw yourself over the top of the wall and tumble down a slope of hot ash into Tartarus. All around you, the punished dead suffer: Tantalus stands up to his chin in water that drains away whenever he tries to drink, and Ixion turns forever on a wheel of fire. High above, the Fury circles, screaming. Ahead, the path splits. To one side you hear someone grunting with effort. To the other, steps cut into the rock lead down toward the roar of the burning river.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Follow the sound",
                    destination: .hds027
                )

                DescentToHadesNavigationButton(
                    title: "Take the burning stair",
                    destination: .hds028
                )
            }
        }
    }
}

struct HDS026View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS026View()
        }
    }
}
