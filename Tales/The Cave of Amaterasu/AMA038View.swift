import SwiftUI

struct AMA038View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .death,
            title: "Swallowed by Orochi",
            classification: "Death",
            imageName: "AMA038",
            storyText: """
            You fight with everything you have. You slash at one neck, and two more heads swing into view. A tail knocks the sword from your hand. The last thing you see is a red eye as big as a lantern and a mouth opening wide enough to swallow a cart, and then the warm, wet dark. Inside the serpent, it is very quiet. Somewhere nearby, behind a wall of scales, something glows faintly blue. You found the sword after all.
            """,
            outcomeText: """
            You fought the eight-headed serpent alone, without a plan.

            Orochi is sleeping off a hero, and Kushinada is still waiting for one.
            """
        )
    }
}

struct AMA038View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA038View()
        }
    }
}
