import SwiftUI

struct ANU009View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU009.png",
            title: "The Ferryman’s Price",
            text: """
                The ferryman reaches the dock without disturbing the water. He is wrapped in wet linen and has no face, but the empty spaces where his eyes should be reflect moments from your past. He tells you that passage requires a memory, a promise or fear. In his hand appears a bright memory of sunlight, laughter and safety that you immediately recognise as your own. Nearby, a trapped soul presses against the river’s surface and reaches toward the boat.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Give the ferryman a memory",
                    destination: .anu010
                )

                TrialOfAnubisNavigationButton(
                    title: "Threaten the ferryman",
                    destination: .anu010
                )
            }
        }
    }
}

struct ANU009View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU009View()
        }
    }
}
