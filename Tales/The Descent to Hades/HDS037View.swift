import SwiftUI

struct HDS037View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS037.png",
            title: "The Bough Resists",
            text: """
            You grab the branch and pull. It does not bend. You pull harder, bracing your feet against the trunk, until the golden leaves cut your palms and your arms shake. The bough does not move by so much as a hair. Behind you, the Sibyl sighs. “Everyone pulls,” she says. “Nobody can force the Fates.” Your hands are bleeding onto the gold.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Let go",
                    destination: .hds038
                )

                DescentToHadesNavigationButton(
                    title: "Ask the Sibyl",
                    destination: .hds036
                )
            }
        }
    }
}

struct HDS037View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS037View()
        }
    }
}
