import SwiftUI

struct AnubisRebelEndingView: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_rebel_escape",
            outcome: .darkWin,
            title: "Defy the Gods",
            classification: "Dark Win / Sequel Hook",
            imageName: "ENDREBEL.png",
            storyText: """
                You refuse to place your heart on the scales as underworld power gathers around the broken Hall of Judgment. Anubis warns that you have confused power with freedom, but you strike the Balance Stone and split the scales apart. The hall collapses as souls escape through every gate and Ammit roars in triumph. You tear open a doorway and return to the desert beneath a sky filled with red stars. The stolen power remains beneath your skin, your shadow now has the head of a jackal and the dead begin whispering your name as their liberator.
            """,
            outcomeText: """
                **Defy the Gods**

                You rejected divine judgment, broke the sacred mechanism and escaped with stolen underworld power.

                You are free for now, but the consequences have followed you home.
            """
        )
    }
}

struct AnubisRebelEndingView_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            AnubisRebelEndingView()
        }
    }
}
