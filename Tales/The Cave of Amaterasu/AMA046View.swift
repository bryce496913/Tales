import SwiftUI

struct AMA046View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .lose,
            title: "The Opened Box",
            classification: "Aged",
            imageName: "AMA046",
            storyText: """
            You remember the lacquered box from the Dragon Palace. Surely a gift from the sea would please the sun. You untie the red cord and lift the lid. A curl of white smoke rises out of it, and as it touches your face, all the years the Dragon Palace kept from you come rushing out to claim you. Your hair turns white. Your hands wrinkle and shake. The mirror slips from them and cracks against the stone, and the startled face beyond the gap vanishes back into the dark. When the smoke clears, a very old person sits beside the Heavenly Rock Cave with an empty box in their lap, trying to remember what they were waiting for.
            """,
            outcomeText: """
            You opened the box you promised never to open.

            Otohime warned you, and the sea always keeps its promises.
            """
        )
    }
}

struct AMA046View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA046View()
        }
    }
}
