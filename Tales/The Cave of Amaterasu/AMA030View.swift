import SwiftUI

struct AMA030View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .bittersweet,
            title: "Three Hundred Years",
            classification: "Lost in Time",
            imageName: "AMA030",
            storyText: """
            One more day. Then one more, and one more after that. On the third morning, homesick at last, you ask to go home, and Otohime sends you up to the shore on the back of a great silver sea bream, with tears in her eyes. The sun is shining. It is warm on your face, and you laugh out loud, because somebody brought it back after all. But the beach is different. The fishing village is a town of stone and tile. On the hillside where your village stood there is only forest, and where your grandmother’s shrine should be, you find a moss-covered stone with your name carved on it and the words “Climbed to heaven and never came home.” Three days in the Dragon Palace. Three hundred years above.
            """,
            outcomeText: """
            You stayed too long in the Dragon Palace.

            The sun came back without you, three hundred years ago.
            """
        )
    }
}

struct AMA030View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA030View()
        }
    }
}
