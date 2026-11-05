import SwiftUI

/// Best ending. Remembered choices add or change lines.
struct AMA043View: View {
    @EnvironmentObject
    private var navigationState: CaveOfAmaterasuNavigationState

    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .win,
            title: "Dawn Returns",
            classification: "Best Ending",
            imageName: "AMA043",
            storyText: storyText,
            outcomeText: """
            You brought the sun out of the Heavenly Rock Cave.

            Every year since, your village has danced at the shrine to remember the night the sun came back.
            """
        )
    }

    private var storyText: String {
        var result = """
        You and Sarutahiko stretch the sacred rope across the mouth of the cave, and the dark place is closed for good. Amaterasu turns away from it. She looks at the mirror, the jewels and the sword, and last of all at you, a muddy mortal with a bell in your fist. “You climbed all the way up here,” she says, “for me?” “For everyone,” you say. “But yes. For you.” The sun goddess laughs, and the sound is warm on your face like morning.
        """

        if navigationState.hasFlag(.heardSusanoo) {
            result += " Then Susanoo steps forward and kneels with the sword held out in both hands. For a long moment, nobody in heaven breathes. Then Amaterasu takes the sword, and takes her brother’s hand, and the storm and the sun stand together for the first time in a very long while."
        } else {
            result += " Susanoo does not come. The sword lies at the roots of the sakaki tree, and the quarrel between the storm and the sun will have to wait for another day."
        }

        result += " By the time the cloud road sets you down at the foot of Mount Takachiho, the sun is high, the frost is melting off the rice, and your grandmother is standing in the doorway of her shrine with a hand over her eyes, squinting up at the sky as if she has never seen anything so ridiculous and wonderful in her life."

        if navigationState.hasFlag(.toldFoxYourName) {
            result += " As you walk home, rain falls out of a clear blue sky. A fox’s wedding, your grandmother would call it. Somewhere in the trees, something laughs and says your name. It is only teasing. Not today."
        }

        if navigationState.hasFlag(.tookOtohimesBox) {
            result += " Otohime’s box sits on the shrine altar, still tied with its red cord. You never open it."
        }

        return result
    }
}

struct AMA043View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA043View()
        }
    }
}
