import SwiftUI

struct AMA029View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA029",
            title: "The Curved Jewels",
            text: """
            You tell the Dragon King about the night. The rice is dying in the fields. The fish have fled to the deepest water, and the fishermen’s nets come up empty. Even the coral in his own gardens is turning grey without light from above. Ryūjin is silent for a long time, and the water in the hall grows cold. Then he lifts the string of jewels from his neck. “Beauty kept in the dark is not beauty,” he says. “Take them up into the light.” As you leave, Otohime runs after you with a small lacquered box tied with a red cord. “A gift, so you remember us,” she says. “But promise me you will never open it.”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Take the jewels and the box",
                    destination: .ama014,
                    collects: .curvedJewels,
                    marks: .tookOtohimesBox
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Take only the jewels",
                    destination: .ama014,
                    collects: .curvedJewels
                )
            }
        }
    }
}

struct AMA029View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA029View()
        }
    }
}
