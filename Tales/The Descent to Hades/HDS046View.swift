import SwiftUI

struct HDS046View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_willing_exchange",
            outcome: .bittersweet,
            title: "The Willing Exchange",
            classification: "Sacrifice",
            imageName: "HDS046.png",
            storyText: """
            You tell Hades that you will stay in Theo’s place. The words are out before you can be afraid of them. Hades looks at you for a long time, and something in his grey eyes changes. “A life for a life,” he says. “That is a debt I accept.” Theo is brought before the throne, blinking and confused, and as you watch, the colour returns to his face. You do not get to say goodbye. Persephone takes your hand and leads you out into her garden, while far above, a boy wakes on the rocks of Cape Tainaron with the sun on his face and a feeling he cannot explain that somebody saved him.
            """,
            outcomeText: """
            You gave your life so Theo could live.

            He will grow old in the sunlight, and he will never forget you.
            """
        )
    }
}

struct HDS046View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS046View()
        }
    }
}
