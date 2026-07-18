import SwiftUI

struct ANU013View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU013.png",
            title: "Golden Scarab Vault",
            text: """
A hidden wall opens into a vault filled with gold masks, jewels and statues of forgotten gods. At the centre, a golden scarab rests beneath a beam of white light. It feels warm and beats like a living heart. A whisper tells you that carrying it could change the balance of judgment, but you also sense that something trapped inside the scarab wants to be released.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Take the Golden Scarab and continue",
                    destination: .anu014
                )

                TrialOfAnubisNavigationButton(
                    title: "Leave the treasure untouched",
                    destination: .anu014
                )
            }
        }
    }
}
