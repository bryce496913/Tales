import SwiftUI

/// End-game hall, reached through HOME once all three gifts are held.
/// Remembered choices add lines, and the Hermes bargain adds a third choice.
struct HDS040View: View {
    @EnvironmentObject
    private var navigationState: DescentToHadesNavigationState

    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS040.png",
            title: "The Throne of Hades",
            text: storyText,
            effects: DescentToHadesPageEffects(
                entryTransition: .bronzeGate,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Plead for Theo",
                    destination: .hds041
                )

                DescentToHadesNavigationButton(
                    title: "Offer your life",
                    destination: .hds046
                )

                if navigationState.hasFlag(.struckHermesBargain) {
                    DescentToHadesNavigationButton(
                        title: "Call on Hermes",
                        destination: .hds047
                    )
                }
            }
        }
    }

    private var storyText: String {
        var result = """
        The judges rise as you approach and step aside without a word. The long black hall leads into a throne room carved from a single dark jewel and lit by the cold fire of the rivers you have crossed. Hades sits on a throne of obsidian, tall and grey-eyed and still as a mountain, and beside him sits Persephone. You lay the gifts before him: the water of forgetting, the ember of punishment and the bough of the blessed. Hades studies them for a long time. “You have walked my whole kingdom,” he says, “to ask me for the one thing I never give. Speak.”
        """

        if navigationState.hasFlag(.liedToCharon) {
            result += " “Charon tells me you lied to him,” Hades adds. “Do not lie to me.”"
        }

        if navigationState.hasFlag(.wokeTheo) {
            result += " Theo stands among the shades at the edge of the hall, watching you. He still remembers your name."
        }

        if navigationState.hasFlag(.struckHermesBargain) {
            result += " In the shadow of a pillar you glimpse a traveller’s hat and a pair of winged sandals. Hermes winks."
        }

        return result
    }
}

struct HDS040View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS040View()
        }
    }
}
