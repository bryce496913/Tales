import SwiftUI

struct ANU015View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU015.png",
            title: "Ammit Unchained",
            text: """
                You enter a chamber covered in claw marks and come face to face with Ammit. She has the head of a crocodile, the front of a lion and the body of a hippopotamus, with broken chains hanging from her limbs. Ammit tells you that Anubis calls her a monster even though the gods created her to devour hearts that fail judgment. She lowers her huge head toward you and asks why she should not begin with yours.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Calm Ammit and speak without fear",
                    destination: .anu016
                )

                TrialOfAnubisNavigationButton(
                    title: "Attack Ammit and escape",
                    destination: .anu016
                )
            }
        }
    }
}
