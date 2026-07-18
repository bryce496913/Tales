import SwiftUI

struct AnubisTrueEndingView: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_true_restored",
            outcome: .win,
            title: "The Scales Restored",
            classification: "Win / Best Ending",
            imageName: "ENDTRUE.png",
            storyText: """
Your heart leaves your chest and appears in Anubis’s hand as a sphere of red light. He places it on the restored scales and, after one frightening moment, it balances perfectly with the feather of Ma’at. The gates of judgment open, forgotten souls remember their names and the stolen hearts return to their owners. Anubis tells you that a light heart is not empty, but one that accepts fear, failure and responsibility without placing those burdens on others. He returns your heart and sends you back to the desert, where a small golden feather remains in your hand. As the temple disappears beneath the sand, his voice tells you, “Live as one who has already been weighed.”
            """,
            outcomeText: """
**The Scales Restored**

You returned all three sacred pieces, faced judgment honestly and proved that mercy and responsibility can outweigh fear.

Anubis has returned you to the living world with his blessing.
            """
        )
    }
}

struct AnubisTrueEndingView_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            AnubisTrueEndingView()
        }
    }
}
