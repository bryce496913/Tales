import SwiftUI

struct ANU030View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_scales_restored",
            outcome: .win,
            title: "The Scales Restored",
            classification: "Best Ending",
            imageName: "ANU027.png",
            storyText: """
            You nod, and your heart leaves your chest as a sphere of red light. Anubis places it on the restored scales and, after one frightening moment, it balances perfectly with the feather of Ma’at. The gates of judgment open, forgotten souls remember their names and the stolen hearts return to their owners. Anubis tells you that a light heart is not an empty one, but one that accepts fear, failure and responsibility without placing those burdens on others. He thanks you, returns your heart and sends you back to the desert, where you wake beside the expedition trucks with a small golden feather in your hand. As the last of the temple disappears beneath the sand, you hear his voice one final time: “Live as one who has already been weighed.”
            """,
            outcomeText: """
            You restored the scales of judgment and faced them honestly.

            Anubis has returned you to the living world with his blessing.
            """
        )
    }
}

struct ANU030View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU030View()
        }
    }
}
