import SwiftUI

struct ANU035View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_taken_by_the_river",
            outcome: .death,
            title: "Taken by the River",
            classification: "Death",
            imageName: "ANU035.png",
            storyText: """
            You lower yourself into the black water and begin to swim. It is colder than ice and heavier than it looks, as if the river itself is pulling at your clothes. Halfway across, the faces beneath the surface open their eyes. Hands rise around you, gripping your arms and ankles while voices whisper that they have waited so long for someone to stay with them. The ferryman’s boat glides past without stopping. You sink slowly, and the last thing you see is the blue fire on the far bank shrinking to a single spark.
            """,
            outcomeText: """
            You tried to cross the River of the Dead without paying its price.

            The drowned souls have claimed you as one of their own.
            """
        )
    }
}

struct ANU035View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU035View()
        }
    }
}
