import SwiftUI

struct ANU040View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_peaceful_death",
            outcome: .death,
            title: "A Peaceful Death",
            classification: "Peaceful Death",
            imageName: "ANU040.png",
            storyText: """
            You take their hand and sit down beside them. The light stays warm, the voices stay familiar and nothing asks anything of you anymore. Days pass, or perhaps years. You stop noticing that the walls flicker or that the shadows point the wrong way. The scales, your quest and finally your own name fade like a dream after waking. One evening you close your eyes in the soft light of home and simply do not open them again. It is a gentle ending, but it is still an ending.
            """,
            outcomeText: """
            You chose a beautiful memory over the truth.

            You rest forever inside it, peaceful and forgotten.
            """
        )
    }
}

struct ANU040View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU040View()
        }
    }
}
