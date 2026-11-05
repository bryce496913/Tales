import SwiftUI

struct AMA008View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .death,
            title: "Led Astray by Foxfire",
            classification: "Death",
            imageName: "AMA008",
            storyText: """
            You follow the bright light. It is warm and kind and always just a few steps ahead, and you are so tired of the dark. It leads you off the path, through wet ferns, over roots and across a slope of loose stones. You never quite catch up with it. Somewhere behind you, you hear laughter, high and delighted, and you turn to look, and the ground is no longer there. You fall for a long time. Foxfire, your grandmother used to say, is the prettiest light in the mountains, and it has never once led anybody home.
            """,
            outcomeText: """
            You followed the foxfire, and it led you off the edge of the mountain.

            The fox still laughs about it on cold nights.
            """
        )
    }
}

struct AMA008View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA008View()
        }
    }
}
