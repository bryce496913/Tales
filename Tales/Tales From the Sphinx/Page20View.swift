//
//  Page20View.swift
//  Tales
//

import SwiftUI

struct Page20View: View {
    var body: some View {
        StoryOutcomeView(
            outcome: .lose,
            imageName: "Twenty.png",
            storyText: "You wiggle, crawl, and shimmy your way through the winding path. The cat pauses frequently to be sure that you are still following. After several claustrophobic minutes, you tumble onto a white polished tiled floor. You look up to notice you are on the floor of a gift shop. A lady with the cat in hand walks to you and says, “sorry, we are not open for another hour.” You think to yourself, how cheap it is to exit through the gift shop."
        )
    }
}

struct Page20View_Previews: PreviewProvider {
    static var previews: some View {
        Page20View()
            .environmentObject(AppNavigationState())
            .environmentObject(GameOptions())
    }
}
