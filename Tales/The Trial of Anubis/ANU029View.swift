import SwiftUI

struct ANU029View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_released",
            outcome: .released,
            title: "Released",
            classification: "Released",
            imageName: "ANU029.png",
            storyText: """
            You tell Anubis that you cannot do it. For a long moment he says nothing, and the disappointment in his amber eyes is worse than any anger. Then he bows his head. “You returned what was stolen,” he says. “For that, the dead are grateful. Go home.” He touches your forehead and the hall fades to white. You wake to the steady beep of a heart monitor. A nurse tells you that a rescue team found you half-buried in the sand three days after the storm. Nobody believes you about the temple, but on the hospital windowsill a small black jackal sits in the sun, watching you.
            """,
            outcomeText: """
            You helped restore the scales but refused to be weighed.

            Anubis has released you, but you will never know what your heart was truly worth.
            """
        )
    }
}

struct ANU029View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU029View()
        }
    }
}
