import SwiftUI

struct AMA000View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA000",
            title: "The Morning Without a Sun",
            text: """
            Long ago, when the gods still walked the islands of Japan, you lived with your grandmother in a rice-farming village at the foot of Mount Takachiho. Three days ago, the sun did not rise. The roosters crowed into the darkness and then fell silent. Frost crept over the young rice, and the river stopped singing. On the second night, people heard wooden clogs and laughter on the mountain road, and the men who went to look did not come back. Now the whole village sits shuttered around its fires, and the only light on the hillside is the lantern at the old shrine, where your grandmother has been praying since the sun went out. Tonight, she has sent for you.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Continue",
                    destination: .ama001
                )
            }
        }
    }
}

struct AMA000View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA000View()
        }
    }
}
