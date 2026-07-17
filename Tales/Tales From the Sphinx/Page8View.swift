//
//  Page8View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page8View.swift
import SwiftUI

struct Page8View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Eight.png",
            text: "As you walk down the corridor, things get darker and darker. You think to yourself “I don’t like all this darkness.” And just like that, with each footstep sound, you see a little light glow. You walk closer to one of these little lights and notice it is a scarab beetle, resting on the ground. “What is that?” you mumble to yourself; again, a path of small glowing beetles appears and continues into the distance. With these little extra lights, you also notice a door to your right."
        ) {

            HStack {
                StoryNavigationButton(title: "Follow the beetle's light", route: .page(17)).padding()

                Spacer()

                StoryNavigationButton(title: "Enter the door", route: .page(9)).padding()
            }
        }
    }
}

struct Page8View_Previews: PreviewProvider {
    static var previews: some View {
        Page8View()
    }
}
