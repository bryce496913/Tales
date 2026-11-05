import SwiftUI

struct AMA034View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA034",
            title: "The Eight Gates",
            text: """
            You and the old couple work through the night. You brew sake eight times over, until it is strong enough to make your eyes water. You build a fence around the house with eight gates, and in each gate you set a great vat brimming with sake. Kushinada hides inside, and you crouch in the shadow of the fence with the old man’s rusty sword. The ground begins to shake. Over the hill comes Yamata no Orochi: eight heads on eight long necks, eyes as red as winter cherries, cypress trees and moss growing on its back. Each head finds a gate. Each one plunges its snout into a vat and drinks, and the gulping goes on and on.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Wait until every head sleeps",
                    destination: .ama036
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Strike now",
                    destination: .ama035
                )
            }
        }
    }
}

struct AMA034View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA034View()
        }
    }
}
