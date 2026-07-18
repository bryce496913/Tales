//
//  Page21View.swift
//  Tales
//

import SwiftUI

struct Page21View: View {
    var body: some View {
        StoryOutcomeView(
            endingID: "page21-death",
            outcome: .death,
            imageName: "Twenty-One.png",
            storyText: "As you pull the lever for Anubis, you suddenly hear howls of a jackal, and the statue of Anubis stands up. It is time for Anubis to take you. As the God of death, he will be sure to provide you the perfect burial. As Anubis takes you deep into the fallen sands, he too disappears into the sands, and you are left, forever trapped."
        )
    }
}

struct Page21View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page21View()
        }
    }
}
