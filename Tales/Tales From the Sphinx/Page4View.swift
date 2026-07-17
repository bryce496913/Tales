//
//  Page4View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page4View.swift
import SwiftUI

struct Page4View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Four.png",
            text: "You wander slowly down the left corridor and find yourself in a small room. In the center of the room, there is a pit that stretches from side to side and seems to be about 1.5 meters in length. On the other side of the pit is a door. Unenthusiastic about wanting to jump over the pit, you look around and notice a door just to your left."
        ) {

            HStack {
                StoryNavigationButton(title: "Enter the door on the left", route: .page(16)).padding()

                Spacer()

                StoryNavigationButton(title: "Jump the pit", route: .page(5)).padding()
            }
        }
    }
}

struct Page4View_Previews: PreviewProvider {
    static var previews: some View {
        Page4View()
    }
}
