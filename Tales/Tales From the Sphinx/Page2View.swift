//
//  Page2View.swift
//  Tales
//

import SwiftUI

struct Page2View: View {
    var body: some View {
        StoryOutcomeView(
            endingID: "page2-death",
            outcome: .death,
            imageName: "Two.png",
            storyText: "After hours of wandering in the desert heat, completely disoriented and unaware of how to get back to the Sphinx, you try to push on. Day turns to night and the heat turns to cold, you collapse in the sand. And as quickly as the night came, darkness takes your soul. Now just another statistic of deaths in the desert."
        )
    }
}

struct Page2View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page2View()
        }
    }
}
