import SwiftUI

struct ANU008View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU008.png",
            title: "River of the Dead",
            text: """
                The first gate opens beside a river of black water. Faces, hands and broken objects drift beneath the surface, while the opposite bank glows beneath an archway of blue fire. A bronze bell hangs beside an empty dock, and far downstream a thin boat approaches. A faceless ferryman stands at the back, guiding it with a long black pole. As the boat gets closer, the water begins whispering in voices you recognise.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Call for the ferryman",
                    destination: .anu009
                )

                TrialOfAnubisNavigationButton(
                    title: "Swim through the black water",
                    destination: .anu010
                )
            }
        }
    }
}
