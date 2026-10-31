import SwiftUI

struct HDS027View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS027.png",
            title: "The Hill of Sisyphus",
            text: """
            Deep inside Tartarus, a man is pushing an enormous boulder up a steep hill. His shoulders are raw and his legs tremble, and just before he reaches the top, the stone slips and thunders back down to the bottom. He walks down after it without a word and starts again. This is Sisyphus, the king who cheated death twice and was given this task forever. As you pass, he speaks without looking up. “Help me get it to the top, just once. Just once, so I can see what’s on the other side. I’ll tell you the secret of the burning river.”
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Help him",
                    destination: .hds028,
                    marks: .helpedSisyphus
                )

                DescentToHadesNavigationButton(
                    title: "Walk on",
                    destination: .hds028
                )
            }
        }
    }
}

struct HDS027View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS027View()
        }
    }
}
