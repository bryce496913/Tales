import SwiftUI

struct AMA020View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA020",
            title: "The Eight-Hand Mirror",
            text: """
            You keep looking. Slowly, the mirror shows you the rest: the climb, the parade you hid from, the bell in your fist, and the lantern still burning on the hillside far below because your grandmother believes you will come back. Small and afraid, but still walking. When at last you turn away, Sōjōbō is standing beside you, and he bows. “Most heroes cannot look for longer than a breath,” he says. “They want to see someone greater than themselves. The sun goddess hides because she cannot bear what she saw in herself. Perhaps she needs to see what you saw.” The crow-tengu lift down the mirror and wrap it in black silk.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Take the mirror",
                    destination: .ama014,
                    collects: .eightHandMirror
                )
            }
        }
    }
}

struct AMA020View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA020View()
        }
    }
}
