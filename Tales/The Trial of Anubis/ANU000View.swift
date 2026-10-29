import SwiftUI

struct ANU000View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU000.png",
            title: "The Lost Expedition",
            text: """
            Three days ago you joined a small expedition heading deep into the Western Desert to photograph a tomb that appeared on no map. On the final afternoon, the guide stopped the trucks and stared at the horizon, where a wall of red sand was rising into the sky. The storm hit before anyone could turn back. You remember shouting voices, a door torn from your hands and the trucks vanishing into the dust. You ran for shelter, lost your footing and fell. After that, there was nothing but the sound of sand burying the world.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Continue",
                    destination: .anu001
                )
            }
        }
    }
}

struct ANU000View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU000View()
        }
    }
}
