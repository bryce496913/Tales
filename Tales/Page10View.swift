//
//  Page10View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page10View.swift
import SwiftUI

struct Page10View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Ten.png",
            text: "After a few steps into the room, you hear a click under your foot. You take a step back, just in time as the floor tile that was under your foot, disintegrates away to reveal a pit of darkness. Do you try making a run for it to reach the ladder at the other end, or would it be better to take it slowly."
        ) {

            HStack {
                RandomStoryNavigationButton(title: "Make a run for it", routes: [.page(12), .page(11)])
                .padding()

                Spacer()

                StoryNavigationButton(title: "Take it slowly", route: .page(11))
                .padding()
            }
        }
    }
}

struct Page10View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page10View()
        }
    }
}
