import SwiftUI

struct ANU003View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_lost_in_desert",
            outcome: .death,
            title: "Lost in the Sand",
            classification: "Death",
            imageName: "ANU001.png",
            storyText: """
            The black doorway sinks back beneath the dune as if it had never been there, and the voice falls silent. You walk toward where you think the expedition camp should be, but every dune looks the same and the stars never appear to guide you. Your footprints vanish almost as soon as you make them. Hours pass, then what feels like days. Your lips crack, your legs give way and the cold sand slowly pulls you down. The last thing you hear is a jackal calling somewhere in the dark, patient and unhurried, as if it always knew you would return.
            """,
            outcomeText: """
            The doorway closed, and the desert claimed you instead.

            Your journey ends beneath the sand, never judged by the dead and never found by the living.
            """
        )
    }
}

struct ANU003View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU003View()
        }
    }
}
