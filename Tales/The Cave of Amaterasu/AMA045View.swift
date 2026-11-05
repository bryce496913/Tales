import SwiftUI

struct AMA045View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .bittersweet,
            title: "The Sun’s Companion",
            classification: "Sacrifice",
            imageName: "AMA045",
            storyText: """
            While the gods are still tuning their drums, you squeeze through the crack in the rock. Inside, the light is so bright that you have to close your eyes, so you sit down in it with your eyes shut tight and talk. You tell the sun goddess about your grandmother, and the rice, and the Night Parade, and the crow-tengu, and the Dragon King’s beard. After a long time, a voice answers. “It is frightening out there,” Amaterasu says. “Will you stay in here, in the dark, so that it is not empty when I come back?” You say yes. She walks out into the festival, and the world turns gold. The great rock rolls back into place behind her, with you inside. It is not so bad. The dark is warm, and some days she comes back to visit and tells you how the rice is growing.
            """,
            outcomeText: """
            You kept the darkness company so the sun could leave it.

            In your village, they ring your grandmother’s bell at the shrine every winter, so you know you are remembered.
            """
        )
    }
}

struct AMA045View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA045View()
        }
    }
}
