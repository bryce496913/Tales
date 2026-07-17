//
//  Page5View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page5View.swift
import SwiftUI

struct Page5View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Five.png",
            text: "You make the jump successfully and enter the door. Once inside, you can hear what seems like meowing. From the shadows, an Abyssinian cat emerges. This cat proceeds to walk up to you while continuing to meow. And with an inviting flick of its tail, the cat disappears through a large crack in the wall."
        ) {

            HStack {
                StoryNavigationButton(title: "Follow the cat through the crack", route: .page(20)).padding()

                Spacer()

                StoryNavigationButton(title: "Continue down the hallway", route: .page(19)).padding()
            }
        }
    }
}

struct Page5View_Previews: PreviewProvider {
    static var previews: some View {
        Page5View()
    }
}
