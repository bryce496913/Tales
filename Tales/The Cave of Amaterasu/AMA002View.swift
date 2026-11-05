import SwiftUI

struct AMA002View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA002",
            title: "The Night Parade",
            text: """
            Halfway up the mountain path, the bamboo goes silent. Then you hear it: wooden clogs, the thump of drums and a hundred voices laughing at nothing. Lights bob through the trees toward you. It is the Night Parade of One Hundred Demons, the procession of yokai that walks on the darkest nights. Paper lanterns with lolling tongues and single rolling eyes. Old umbrellas hopping on one leg. A woman whose long neck lifts her head high above the crowd. Red-faced oni carrying a palanquin hung with bones. Your grandmother’s voice comes back to you from your childhood: “If the parade passes, hide and do not look. Whoever watches it, joins it.” The procession is almost on top of you.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Hide and shut your eyes",
                    destination: .ama005
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Watch them pass",
                    destination: .ama004
                )
            }
        }
    }
}

struct AMA002View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA002View()
        }
    }
}
