import SwiftUI

struct ANU039View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU009.png",
            title: "Taken by Force",
            text: """
            You refuse. The ferryman says nothing. He simply reaches into your chest with a cold, wet hand and draws the memory out himself. Sunlight, laughter and safety slide out of you like thread from a spool, and afterwards you cannot remember whose voices they were. The boat carries you across the river in silence. When you step onto the far bank you feel lighter, but not in a way that feels good.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Continue",
                    destination: .anu010
                )
            }
        }
    }
}

struct ANU039View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU039View()
        }
    }
}
