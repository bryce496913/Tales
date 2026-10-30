import SwiftUI

struct ANU030View: View {
    @EnvironmentObject
    private var navigationState: TrialOfAnubisNavigationState

    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_scales_restored",
            outcome: .win,
            title: "The Scales Restored",
            classification: "Best Ending",
            imageName: "ANU030.png",
            storyText: storyText,
            outcomeText: """
            You restored the scales of judgment and faced them honestly.

            Anubis has returned you to the living world with his blessing.
            """
        )
    }

    private var storyText: String {
        var result = """
        You nod, and your heart leaves your chest as a sphere of red light. Anubis places it on the restored scales and, after one frightening moment, it balances perfectly with the feather of Ma’at. The gates of judgment open, forgotten souls remember their names and the stolen hearts return to their owners. Anubis tells you that a light heart is not an empty one, but one that accepts fear, failure and responsibility without placing those burdens on others. He thanks you, returns your heart and sends you back to the desert, where you wake beside the expedition trucks with a small golden feather in your hand. As the last of the temple disappears beneath the sand, you hear his voice one final time: “Live as one who has already been weighed.”
        """

        if navigationState.progress.storyFlags.contains(.freedSoul) {
            result += " As you leave, the soul you freed in the Hall of Whispers steps forward, speaks their own name aloud for the first time in centuries and thanks you before passing through the gate."
        }

        if navigationState.progress.storyFlags.contains(.abandonedSoul) {
            result += " As you leave, you see the soul you left beneath the stone tablet among those passing through the gate. Their name has come back to them, but they do not look at you."
        }

        return result
    }
}

struct ANU030View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU030View()
        }
    }
}
