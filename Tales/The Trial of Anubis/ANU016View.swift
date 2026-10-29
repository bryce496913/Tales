import SwiftUI

struct ANU016View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU016.png",
            title: "The Broken Chain",
            text: """
            You tell Ammit that you will help her. She lowers her huge head and shows you the last chain still fastened around her neck, anchored deep in the chamber wall. The other links were cut cleanly, proving that someone released her on purpose. When you grip the chain, you see a vision of an underworld scribe lifting the Heart Pan from the scales while a hidden figure watches from the shadows. The final link is already cracked and would break with one hard strike. Ammit watches you closely, waiting to see what you will do.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Free her",
                    destination: .anu034
                )

                TrialOfAnubisNavigationButton(
                    title: "Leave her",
                    destination: .anu032
                )
            }
        }
    }
}

struct ANU016View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU016View()
        }
    }
}
