import SwiftUI

struct AMA003View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .lose,
            title: "The Endless Night",
            classification: "Lost",
            imageName: "AMA003",
            storyText: """
            You cannot leave her alone in the dark. You sit beside your grandmother and help her keep the lantern burning, and together you pray for the sun. Days pass that are not days. The oil runs low, and then it runs out. The rice dies in the frozen fields, the neighbours leave for the lowlands one by one, and the laughter on the mountain road comes a little closer every night. Your grandmother grows quieter, and one morning that is not a morning, she does not wake. You ring her bell into the darkness until your arm aches. Nobody in heaven answers, because nobody climbed up to ask.
            """,
            outcomeText: """
            You stayed where it was safe, and the sun never came back.

            The bridge to heaven waited for a climber who never came.
            """
        )
    }
}

struct AMA003View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA003View()
        }
    }
}
