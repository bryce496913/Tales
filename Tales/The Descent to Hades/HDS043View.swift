import SwiftUI

struct HDS043View: View {
    @EnvironmentObject
    private var navigationState: DescentToHadesNavigationState

    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS043.png",
            title: "The Last Stair",
            text: storyText,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Step into the light",
                    destination: .hds044
                )

                DescentToHadesNavigationButton(
                    title: "Turn to help him",
                    destination: .hds045
                )
            }
        }
    }

    private var storyText: String {
        var result = """
        Far above, a thin line of daylight appears. You can smell salt air and hear the waves. You climb faster. Then, right behind you, someone stumbles. You hear a sharp gasp of pain and Theo’s voice, the first sound he has made, crying out your name. He has fallen. He might be hurt. Every instinct you have screams at you to turn around and help him, the way you did not help him in the water. The sunlight is only a few steps away.
        """

        if navigationState.hasFlag(.wokeTheo) {
            result += " Then, just as clearly, you hear him again through gritted teeth. “Don’t. Don’t turn around. I’m right behind you. Keep going.”"
        }

        return result
    }
}

struct HDS043View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS043View()
        }
    }
}
