import SwiftUI

/// Sarutahiko's line depends on the choice at AMA-007.
struct AMA042View: View {
    @EnvironmentObject
    private var navigationState: CaveOfAmaterasuNavigationState

    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA042",
            title: "The Sacred Rope",
            text: storyText,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .shojiSlide,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Stretch the rope across the cave",
                    destination: .ama043
                )
            }
        }
    }

    private var storyText: String {
        var result = """
        Tajikarao heaves. The great boulder rolls aside with a sound like a mountain clearing its throat, and he takes Amaterasu gently by the hand and draws her out into the open. Light floods heaven. It pours over the edge of the High Plain and down onto the islands below, and far away you hear every rooster in Japan begin to crow at once. Amaterasu stands blinking in her own light, and for a moment she glances back at the cave, as if she might run into it again. Omoikane presses a thick rope of twisted rice straw into your hands.
        """

        if navigationState.hasFlag(.defiedSarutahiko) {
            result += " Sarutahiko steps up and takes the other end. “Rudeness is forgiven at dawn,” he grunts."
        } else {
            result += " Sarutahiko steps up, takes the other end and nods to you."
        }

        return result
    }
}

struct AMA042View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA042View()
        }
    }
}
