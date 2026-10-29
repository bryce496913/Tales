import SwiftUI

struct ANU013View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU013.png",
            title: "Golden Scarab Vault",
            text: """
            The jackal statues turn their heads one by one, guiding you along the wall until the last of them points its muzzle at bare stone. With a deep grinding sound, the wall slides open into a hidden vault filled with gold masks, jewels and statues of forgotten gods. At the centre, a golden scarab rests beneath a beam of white light. It feels warm and beats like a living heart. A whisper tells you that carrying it could change the balance of judgment, but you also sense that something trapped inside the scarab wants to be released.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Take the scarab",
                    destination: .anu014
                )

                TrialOfAnubisNavigationButton(
                    title: "Don’t take it",
                    destination: .anu011
                )
            }
        }
    }
}

struct ANU013View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU013View()
        }
    }
}
