import SwiftUI

struct ANU032View: View {
    var body: some View {
        TrialOfAnubisOutcomeView(
            endingID: "anubis_devoured_by_ammit",
            outcome: .death,
            title: "Devoured by Ammit",
            classification: "Death",
            imageName: "ANU032.png",
            storyText: """
            Ammit’s patience runs out. She moves faster than anything that size should be able to, and the chamber fills with the sound of iron dragging across stone. Her voice rumbles inside your head. She has seen what your heart holds, she says, and she does not need the scales to weigh it. Her jaws close and your heart is gone before you feel the pain. Your memories disappear next, then your name, followed by every future you might have lived.
            """,
            outcomeText: """
            Ammit judged your heart without the scales.

            The Devourer has consumed your soul, leaving no name, memory or path back to the living world.
            """
        )
    }
}

struct ANU032View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU032View()
        }
    }
}
