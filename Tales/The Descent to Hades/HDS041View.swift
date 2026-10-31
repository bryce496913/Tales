import SwiftUI

struct HDS041View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS041.png",
            title: "Hades’ Condition",
            text: """
            You tell Hades about the boat and the storm, and about the moment Theo’s hand slipped from yours. You do not make it sound better than it was. When you finish, the hall is silent. Then Persephone lays her hand on her husband’s arm, and Hades sighs like a closing tomb. “Once before, I made this bargain,” he says. “Your brother will follow you up to the living world. You will lead. You will not speak to him, and you will not look back, not once, until you both stand in the sunlight. If you look back, he returns to me, and there will be no second chance.” A door opens behind the throne onto a stairway climbing into darkness.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Begin the climb",
                    destination: .hds042
                )
            }
        }
    }
}

struct HDS041View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS041View()
        }
    }
}
