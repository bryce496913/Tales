import SwiftUI

/// HOME hub. Shows a gate for each scale piece the player has not collected yet.
/// Once all three pieces are collected, navigation sends the player to ANU-026 instead.
struct ANU011View: View {
    @EnvironmentObject
    private var navigationState: TrialOfAnubisNavigationState

    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU026.png",
            title: "The Hall of Gates",
            text: """
            The light folds around you and you find yourself in a round chamber of black stone beneath a ceiling painted with stars. At its centre stands the empty frame of the great scales, with three hollow sockets shaped like a feather, a heart and a smooth round stone. Three gates are set into the walls around it. The first is carved with a feather, the second with a heart and the third with a set of perfectly level scales. The gate of any piece you already carry is sealed behind a curtain of blue fire. Somewhere beyond the empty frame, Anubis waits for the scales to be made whole.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                ForEach(openGates, id: \.item) { gate in
                    TrialOfAnubisNavigationButton(
                        title: gate.title,
                        destination: gate.destination
                    )
                }
            }
        }
    }

    private var openGates: [HomeGate] {
        Self.gates.filter { !navigationState.progress.collectedItems.contains($0.item) }
    }

    private static let gates: [HomeGate] = [
        HomeGate(item: .feather, title: "Enter the first gate", destination: .anu008),
        HomeGate(item: .heart, title: "Enter the second gate", destination: .anu018),
        HomeGate(item: .balanceStone, title: "Enter the third gate", destination: .anu021)
    ]
}

private struct HomeGate {
    let item: TrialOfAnubisItem
    let title: String
    let destination: TrialOfAnubisRoute
}

struct ANU011View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU011View()
        }
    }
}
