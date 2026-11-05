import SwiftUI

struct AMA005View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA005",
            title: "The White Fox",
            text: """
            You crouch in the bamboo with your eyes squeezed shut while the parade thunders past, so close you can smell incense and wet fur. When the noise has faded completely, you open your eyes. A white fox is sitting on the path in front of you. A small blue flame floats above the tip of its tail, lighting up the stones. “Well done,” it says, in a voice like a young man’s. “Most people peek.” It tells you it is a messenger of Inari, the god of rice, and that it knows the quickest way to the summit, where the Floating Bridge of Heaven comes down. “I’ll guide you, gladly. But it’s rude to travel with a stranger. Tell me your name.”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Tell it your name",
                    destination: .ama007,
                    marks: .toldFoxYourName
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Keep your name to yourself",
                    destination: .ama006
                )
            }
        }
    }
}

struct AMA005View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA005View()
        }
    }
}
