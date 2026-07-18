import SwiftUI

struct AnubisLostSoulEndingView: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_lost_soul",
            outcome: .lose,
            title: "Lost Soul",
            classification: "Lose",
            imageName: "ENDLOST.png",
            storyText: """
You continue walking through the fog, knowing that there was once a task you needed to complete, but you can no longer remember what it was. Memories of home have become empty rooms, faceless people and warmth without a source. Other forgotten souls walk beside you, each trying and failing to remember their own name. The ferryman waits beside the black river, but he asks for no payment because you have nothing left to give. Somewhere in the distance, Anubis calls for the living traveller who entered his temple, but you no longer understand that he means you.
            """,
            outcomeText: """
**Lost Soul**

The underworld took your final memory.

Without a name, a past or a purpose, you have joined the procession of forgotten souls.
            """
        )
    }
}

struct AnubisLostSoulEndingView_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            AnubisLostSoulEndingView()
        }
    }
}
