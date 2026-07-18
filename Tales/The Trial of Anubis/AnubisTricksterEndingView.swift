import SwiftUI

struct AnubisTricksterEndingView: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_trickster_cheat",
            outcome: .lose,
            title: "Cheat the Scales",
            classification: "Secret Lose / Sequel Hook",
            imageName: "ENDTRICKSTER.png",
            storyText: """
                You place your heart on the scales while speaking the forbidden title you learned in the underworld. The Balance Stone turns backwards and the scales falsely declare your heart lighter than the feather. You escape through the gate to the living world before Anubis can stop you. Once you reach the desert, a crack of darkness opens in the air behind you. A tall ancient creature steps through the opening and causes every shadow in the desert to turn toward it.
            """,
            outcomeText: """
                **Cheat the Scales**

                You manipulated the balance and escaped judgment.

                But your deception opened a path for an ancient presence to enter the living world.

                Survival is not always victory.
            """
        )
    }
}

struct AnubisTricksterEndingView_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            AnubisTricksterEndingView()
        }
    }
}
