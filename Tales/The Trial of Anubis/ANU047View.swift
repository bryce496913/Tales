import SwiftUI

struct ANU047View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_defy_the_gods",
            outcome: .darkWin,
            title: "Defy the Gods",
            classification: "Dark Ending",
            imageName: "ANU027.png",
            storyText: """
            You turn away from Anubis and place the three pieces in the rebel’s hands. Anubis warns you that you have confused power with freedom, but the rebel strikes the Balance Stone against the empty frame and the scales split apart. The hall collapses as souls escape through every gate and Ammit roars somewhere in the dark. The rebel tears open a doorway and pulls you through into the desert beneath a sky filled with red stars. Stolen power remains beneath your skin, your shadow now has the head of a jackal and the dead begin whispering your name as their liberator.
            """,
            outcomeText: """
            You kept your bargain with the rebel and broke the scales of judgment.

            You are free for now, but the dead have followed you home.
            """
        )
    }
}

struct ANU047View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU047View()
        }
    }
}
