import SwiftUI

struct ANU012View: View {
    @EnvironmentObject
    private var navigationState: TrialOfAnubisNavigationState

    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU012.png",
            title: "Feather Arm Chamber",
            text: storyText,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Take the feather",
                    destination: .anu011,
                    collects: .feather
                )

                TrialOfAnubisNavigationButton(
                    title: "Enter the shadow",
                    destination: .anu014
                )
            }
        }
    }

    private var storyText: String {
        var result = """
        The sealed door opens into a circular room where the golden Feather Arm floats above a shaft of blue fire. Painted figures kneel around the walls holding their hearts in their hands, but their shadows move on their own. Deep scratches cross the floor and lead toward a hidden passage behind the murals. A low growl moves through the stone as the Feather Arm slowly turns within reach.
        """

        if navigationState.progress.storyFlags.contains(.freedSoul) {
            result += " The soul you freed drifts to your side and traces a safe path between the scratches, keeping you clear of the moving shadows."
        }

        return result
    }
}

struct ANU012View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU012View()
        }
    }
}
