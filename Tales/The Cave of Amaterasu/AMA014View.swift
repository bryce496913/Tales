import SwiftUI

/// HOME hub. Shows a path for each treasure the player has not collected yet.
/// Once all three treasures are collected, navigation sends the player to AMA-039 instead.
struct AMA014View: View {
    @EnvironmentObject
    private var navigationState: CaveOfAmaterasuNavigationState

    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA014",
            title: "The Heavenly Rock Cave",
            text: """
            The gods have cleared a space before the Heavenly Rock Cave, and Omoikane draws three paths in the dust with his staff. As each one is drawn, a road of cloud unrolls from the edge of heaven down to the dark earth. The mountain path leads to Mount Kurama, where crow-winged tengu guard the Eight-Hand Mirror. The sea path leads down to a black shore and the Dragon King’s palace beneath the waves, where the Curved Jewels lie. The river path leads to the land of Izumo, where the eight-headed serpent sleeps on a stolen sword. Ame-no-Uzume, goddess of dawn and dancing, sits on an overturned tub beside the cave, tapping her feet. “Hurry back,” she says. “I’ve been practising.” Any path whose treasure you have already brought back has faded into mist.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .shojiSlide,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                ForEach(openPaths, id: \.item) { path in
                    CaveOfAmaterasuNavigationButton(
                        title: path.title,
                        destination: path.destination
                    )
                }
            }
        }
    }

    private var openPaths: [HomePath] {
        Self.paths.filter { !navigationState.progress.collectedItems.contains($0.item) }
    }

    private static let paths: [HomePath] = [
        HomePath(item: .eightHandMirror, title: "The mountain path", destination: .ama015),
        HomePath(item: .curvedJewels, title: "The sea path", destination: .ama022),
        HomePath(item: .cloudSword, title: "The river path", destination: .ama031)
    ]
}

private struct HomePath {
    let item: CaveOfAmaterasuItem
    let title: String
    let destination: CaveOfAmaterasuRoute
}

struct AMA014View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA014View()
        }
    }
}
