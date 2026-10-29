import SwiftUI

struct ANU008View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU008.png",
            title: "River of the Dead",
            text: """
            The first gate grinds open on stone hinges and cold air rolls out to meet you. Beyond it lies a river of black water. Faces, hands and broken objects drift beneath the surface, while the opposite bank glows beneath an archway of blue fire. A bronze bell hangs beside an empty dock, and far downstream a thin boat approaches. A faceless ferryman stands at the back, guiding it with a long black pole. As the boat gets closer, the water begins whispering in voices you recognise.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Call out",
                    destination: .anu009
                )

                TrialOfAnubisNavigationButton(
                    title: "Swim",
                    destination: .anu035
                )
            }
        }
    }
}

struct ANU008View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU008View()
        }
    }
}
