import SwiftUI

struct AMA047View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .darkWin,
            title: "The Fox’s Wedding",
            classification: "Dark Ending",
            imageName: "AMA047",
            storyText: """
            Before anyone can stop it, the white fox trots up to the boulder and whispers something through the crack. Inside, the sun goddess laughs out loud in surprise, and the rock rolls open by itself. Light pours across heaven, and the gods cheer, and only you notice that, out of a clear and shining sky, it has begun to rain. “A fox’s wedding,” the fox says happily, and when you look down, it is no longer a fox but a young man in white with golden fox eyes. “A name freely given is a promise. I brought out the sun, and now I take my payment.” A procession of foxes carrying paper lanterns is coming across the plain toward you. Somebody has put a white hood over your head. The sun is shining on the whole world, and you will never go home to see it.
            """,
            outcomeText: """
            You gave a fox your name, and the fox kept it.

            The sun is back, and you are walking at the head of a wedding procession into Inari’s mountain.
            """
        )
    }
}

struct AMA047View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA047View()
        }
    }
}
