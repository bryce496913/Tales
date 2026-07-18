//
//  Page18View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page18View.swift
import SwiftUI

struct Page18View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Eighteen.png",
            text: "This is the darkest room you have entered. There is only one torch in this room, just off to your right. The only thing this torch is illuminating is a ladder that leads to an opening in the ceiling. Taking this torch would make exploring the rest of the room easier."
        ) {

            HStack {
                RandomStoryNavigationButton(title: "Climb the ladder", routes: [.page(12), .page(24)])
                Spacer()

                StoryNavigationButton(title: "Take torch to explore", route: .page(15))
                }
            .padding()
        }
    }
}

struct Page18View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page18View()
        }
    }
}
