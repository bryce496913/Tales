import SwiftUI

struct HDS045View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_looked_back",
            outcome: .lose,
            title: "Looked Back",
            classification: "Lost",
            imageName: "HDS045.png",
            storyText: """
            You turn around. Theo is right there, one step below you, his hand reaching out, and for a heartbeat you see him clearly: alive, frightened, almost home. Then his face fills with sadness and he begins to fade. “It’s okay,” he whispers. “You came.” He is gone before you can reach him, drawn back down into the dark like smoke. The stairway crumbles beneath you, and you wake on the rocks of Cape Tainaron in the sun, alone, with seawater in your lungs and a fishing crew hauling you onto their boat. You never find the cave again.
            """,
            outcomeText: """
            You looked back, as Orpheus once did.

            You returned to the living, but Theo did not.
            """
        )
    }
}

struct HDS045View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS045View()
        }
    }
}
