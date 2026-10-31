import SwiftUI

/// HOME hub. Shows a road for each gift the player has not collected yet.
/// Once all three gifts are collected, navigation sends the player to HDS-040 instead.
struct HDS015View: View {
    @EnvironmentObject
    private var navigationState: DescentToHadesNavigationState

    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS015.png",
            title: "The Crossroads of Judgment",
            text: """
            You stand where three roads meet beneath an enormous black cypress. Here the three judges of the dead, Minos, Rhadamanthus and Aeacus, sit on stone seats and send each soul down one of the roads. To the left, a grey road winds into the Asphodel Meadows, where the river Lethe whispers. Straight ahead, a road of cracked bronze descends toward the red glow of Tartarus and the burning river Phlegethon. To the right, a road of white stone climbs toward a golden light and the fields of Elysium. Beyond the judges, at the end of a long black hall, stands the palace of Hades, its doors sealed until you carry all three gifts. Any road whose gift you already hold is blocked by a silent line of shades.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .bronzeGate,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                ForEach(openRoads, id: \.item) { road in
                    DescentToHadesNavigationButton(
                        title: road.title,
                        destination: road.destination
                    )
                }
            }
        }
    }

    private var openRoads: [HomeRoad] {
        Self.roads.filter { !navigationState.progress.collectedItems.contains($0.item) }
    }

    private static let roads: [HomeRoad] = [
        HomeRoad(item: .waterOfLethe, title: "The grey road", destination: .hds016),
        HomeRoad(item: .emberOfPhlegethon, title: "The bronze road", destination: .hds024),
        HomeRoad(item: .goldenBough, title: "The white road", destination: .hds032)
    ]
}

private struct HomeRoad {
    let item: DescentToHadesItem
    let title: String
    let destination: DescentToHadesRoute
}

struct HDS015View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS015View()
        }
    }
}
