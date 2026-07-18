//
//  Page14View.swift
//  Tales
//

import SwiftUI

struct Page14View: View {
    var body: some View {
        StoryOutcomeView(
            endingID: "page14-death",
            outcome: .death,
            imageName: "Fourteen.png",
            storyText: "As you approach the large metal door it slowly starts to open. This room is brightly light and the walls are covered in computer monitors. Your images are all over the monitors showing all the steps you did to get here. They have been studying and tracking you. Was this all some sort of test? As you ponder what just happened, two humanoid figures materialize in the room with you. They are holding some sort of weapons. You hear a voice over a speaker “test 12 complete, clear to neutralize the test subject” The last thing you see is a sudden bright light."
        )
    }
}

struct Page14View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page14View()
        }
    }
}
