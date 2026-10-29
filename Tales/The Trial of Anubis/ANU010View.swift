import SwiftUI

struct ANU010View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU010.png",
            title: "Hall of Whispers",
            text: """
            Beyond the river is a maze of stone passages covered in thousands of names. Some are royal, some ordinary and some have been scratched away completely. Whispering voices fill the hall with excuses, confessions and forgotten memories. A golden light shines from behind a sealed door marked with the symbol of the Feather Arm, but from a side passage you hear someone crying and begging for help. The voice says that they still remember their name, but not for much longer.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Follow the crying voice",
                    destination: .anu041
                )

                TrialOfAnubisNavigationButton(
                    title: "Enter the Feather Arm door",
                    destination: .anu012
                )
            }
        }
    }
}

struct ANU010View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU010View()
        }
    }
}
