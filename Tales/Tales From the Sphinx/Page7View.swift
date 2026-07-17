//
//  Page7View.swift
//  Tales
//

import SwiftUI

struct Page7View: View {
    var body: some View {
        StoryOutcomeView(
            outcome: .lose,
            imageName: "Seven.png",
            storyText: "Even with your little internal voice protesting, you push the thick wooden door open. As the door slowly opens, the mumbles become clearer….\n\n“This room was discovered in the late 1980’s by archaeologists….”\n\nSeems you have stumbled across a tour group. They introduce themselves as The Tomb Raider Tours. You explain your situation, and they invite you to finish the tour with them, which after, they will bring you back to the city. All is good!"
        )
    }
}

struct Page7View_Previews: PreviewProvider {
    static var previews: some View {
        Page7View()
            .environmentObject(AppNavigationState())
            .environmentObject(GameOptions())
    }
}
