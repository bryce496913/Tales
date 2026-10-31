import SwiftUI

struct HDS042View: View {
    @EnvironmentObject
    private var navigationState: DescentToHadesNavigationState

    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS042.png",
            title: "The Long Ascent",
            text: storyText,
            effects: DescentToHadesPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Keep climbing",
                    destination: .hds043
                )

                DescentToHadesNavigationButton(
                    title: "Look back",
                    destination: .hds045
                )
            }
        }
    }

    private var storyText: String {
        var result = """
        The stairway is narrow and endless, and so dark that you have to feel your way along the walls. You cannot hear anyone behind you. No footsteps, no breathing, nothing at all. You remind yourself that the dead make no sound, but the doubt grows with every step. What if Hades lied? What if there is no one behind you, and you are climbing toward the sunlight alone? One look would tell you. Just one.
        """

        if navigationState.hasFlag(.helpedSisyphus) {
            result += " Halfway up, a fallen boulder blocks the stair. You set your shoulder against it the way you did on the hill, and it rolls aside. For a moment you think you hear someone far below, laughing."
        }

        if navigationState.hasFlag(.wokeTheo) {
            result += " Once, very quietly, you think you hear someone humming your mother’s song."
        }

        return result
    }
}

struct HDS042View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS042View()
        }
    }
}
