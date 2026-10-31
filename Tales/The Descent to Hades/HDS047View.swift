import SwiftUI

struct HDS047View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_thief_of_the_dead",
            outcome: .darkWin,
            title: "Thief of the Dead",
            classification: "Dark Ending",
            imageName: "HDS047.png",
            storyText: """
            You whisper Hermes’ name. In an instant he is beside you, grinning, and the throne room goes black as he throws the Helm of Darkness over your heads, stolen from Hades’ own armoury. “Run,” he laughs. You grab Theo’s hand and run: past the judges, past the sleeping hound, across the Styx in a stolen boat and up into the blinding sunlight of Cape Tainaron. You made it. Theo is alive. But beneath your feet the earth rumbles with the fury of a god who has been robbed. That night, Hermes appears at the foot of your bed and tells you it is time to pay back the favour.
            """,
            outcomeText: """
            You stole Theo from the underworld with a god’s help.

            You are both alive, but you owe Hermes, and Hades never forgets a theft.
            """
        )
    }
}

struct HDS047View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS047View()
        }
    }
}
