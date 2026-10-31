import SwiftUI

struct HDS031View: View {
    var body: some View {
        DescentToHadesOutcomeView(
            endingID: "hades_chained_in_tartarus",
            outcome: .death,
            title: "Chained in Tartarus",
            classification: "Death",
            imageName: "HDS031.png",
            storyText: """
            You squeeze into the crack and press yourself against the rock as the Furies’ screams pass overhead. It is quiet in here. Then the stone shifts. The crack was never a hiding place. It is a doorway to the deepest pit of Tartarus, where the Titans were chained when the world was young. Bronze chains rise from the dark and close around your wrists and ankles with a sound like a lock turning. A huge voice in the darkness rumbles with something like amusement. “A new neighbour.” The ember in your bowl gutters out. No one will ever come looking for you here.
            """,
            outcomeText: """
            You hid from the Furies in the darkest part of Tartarus.

            You are chained beside the Titans until the end of time.
            """
        )
    }
}

struct HDS031View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS031View()
        }
    }
}
