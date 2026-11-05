import SwiftUI

/// Taking Otohime's box at AMA-029 adds a third choice.
struct AMA041View: View {
    @EnvironmentObject
    private var navigationState: CaveOfAmaterasuNavigationState

    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA041",
            title: "Her Own Light",
            text: """
            You lift the Eight-Hand Mirror toward the gap. A face appears on the other side: a woman with tears on her cheeks and light pouring from her skin. She sees the shining figure in the mirror and gasps. She does not know it is herself. She has not looked at herself since the day her brother tore down her hall, and she has forgotten how bright she is. She leans closer, and closer still, and light spills out through the crack and across the plain of heaven like a sunrise. Beside the boulder, Tajikarao tenses his enormous arms and looks at you, waiting for a signal.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Signal Tajikarao",
                    destination: .ama042
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Reach in and pull her out yourself",
                    destination: .ama044
                )

                if navigationState.hasFlag(.tookOtohimesBox) {
                    CaveOfAmaterasuNavigationButton(
                        title: "Offer her Otohime’s box",
                        destination: .ama046
                    )
                }
            }
        }
    }
}

struct AMA041View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA041View()
        }
    }
}
