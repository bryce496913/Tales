//
//  Page25View.swift
//  Tales
//

import SwiftUI

struct Page25View: View {
    var body: some View {
        StoryOutcomeView(
            outcome: .death,
            imageName: "Twenty-Five.png",
            storyText: "You almost make it to the door and turn to see where the spider is. You watch on in shock as the giant spider shoots its web at you, pinning you to the ground. With one of its many legs, the spider pushes the door closed."
        )
    }
}

struct Page25View_Previews: PreviewProvider {
    static var previews: some View {
        Page25View()
            .environmentObject(AppNavigationState())
            .environmentObject(GameOptions())
    }
}
