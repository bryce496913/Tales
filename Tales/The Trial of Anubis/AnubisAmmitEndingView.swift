import SwiftUI

struct AnubisAmmitEndingView: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_dark_ammit",
            outcome: .death,
            title: "Devoured by Ammit",
            classification: "Death",
            imageName: "ENDAMMIT.png",
            storyText: """
Anubis places your heart on the scales, but it immediately sinks beneath the weight of every lie, betrayal and selfish choice. The feather rises and the sound of the failed judgment echoes through the hall. You try to explain your actions, but Anubis tells you that the scales do not compare you with others; they only reveal what you chose to carry. Ammit opens her jaws and devours your heart in a single bite. Your memories disappear, then your name, followed by every future you might have lived.
            """,
            outcomeText: """
**Devoured by Ammit**

Your heart outweighed the feather.

The Devourer has consumed your soul, leaving no name, memory or path back to the living world.
            """
        )
    }
}

struct AnubisAmmitEndingView_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            AnubisAmmitEndingView()
        }
    }
}
