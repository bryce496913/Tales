import SwiftUI

struct AMA004View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .lose,
            title: "Joined the Night Parade",
            classification: "Taken",
            imageName: "AMA004",
            storyText: """
            You can’t help it. You peer through the bamboo as the procession passes, and for a moment it is the most wonderful thing you have ever seen: lanterns glowing like coals, drums thumping, monsters dancing in the dark. Then a paper lantern at the end of the line stops. Its single eye rolls toward you. One by one, every head in the parade turns. The long-necked woman smiles and reaches down a hand that is not cold at all. “Come along,” she says. “There is always room for one more.” Someone puts a lantern in your hand. Your feet start walking. By the time you remember you had somewhere to be, you no longer remember your name.
            """,
            outcomeText: """
            You watched the Night Parade, and the Night Parade took you in.

            On the darkest nights, your lantern bobs along at the very end of the line.
            """
        )
    }
}

struct AMA004View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA004View()
        }
    }
}
