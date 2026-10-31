import SwiftUI

struct HDS028View: View {
    @EnvironmentObject
    private var navigationState: DescentToHadesNavigationState

    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS028.png",
            title: "The River of Fire",
            text: storyText,
            effects: DescentToHadesPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Wait for the flames to sink",
                    destination: .hds030,
                    collects: .emberOfPhlegethon
                )

                DescentToHadesNavigationButton(
                    title: "Snatch an ember now",
                    destination: .hds029,
                    collects: .emberOfPhlegethon
                )
            }
        }
    }

    private var storyText: String {
        var result = """
        The path ends at the bank of the Phlegethon. The river is made of fire that flows like water, and the heat is so fierce that your clothes begin to smoke. Embers drift on its surface like fallen leaves, glowing white-hot. Persephone told you to bring one back in her bronze bowl. Now and then the flames sink low for a few seconds, as though the river is taking a breath, and the embers wash close to the bank. The rest of the time it roars. Behind you, you hear the beat of leathery wings.
        """

        if navigationState.hasFlag(.helpedSisyphus) {
            result += " Your shoulders still ache from the boulder. For one moment at the top of the hill, Sisyphus stood still and laughed, and before the stone rolled away and he went down after it, he told you his secret: “The river breathes. Wait for the breath.”"
        }

        return result
    }
}

struct HDS028View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS028View()
        }
    }
}
