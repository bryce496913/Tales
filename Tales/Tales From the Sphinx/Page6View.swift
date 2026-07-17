//
//  Page6View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page6View.swift
import SwiftUI

struct Page6View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Six.png",
            text: "You wander slowly down the right corridor. Suddenly, you stop and listen. Now in silence, you can hear a faint mumble. You look over to where you think the sound is coming from. You start to slowly head in the direction of the noise and find a door. Though the mumbling has got louder, you are unable to make out if it is human or not."
        ) {

            HStack {
                StoryNavigationButton(title: "Enter the door", route: .page(7)).padding()

                Spacer()

                StoryNavigationButton(title: "Continue down the corridor", route: .page(8)).padding()
            }
        }
    }
}

struct Page6View_Previews: PreviewProvider {
    static var previews: some View {
        Page6View()
    }
}
