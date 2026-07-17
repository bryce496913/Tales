//
//  Page24View.swift
//  Tales
//

import SwiftUI

struct Page24View: View {
    var body: some View {
        StoryOutcomeView(
            outcome: .death,
            imageName: "Twenty-Four.png",
            storyText: "You make it to the ladder and start to climb, yet your success is blanked by you slipping on one of the ladder’s steps, resulting in you falling into the blackness."
        )
    }
}

struct Page24View_Previews: PreviewProvider {
    static var previews: some View {
        Page24View()
            .environmentObject(AppNavigationState())
            .environmentObject(GameOptions())
    }
}
