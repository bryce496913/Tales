//
//  Page19View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page19View.swift
import SwiftUI

struct Page19View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Nineteen.png",
            text: "This room is clearly light, and you are able to have a good look around. The room is lacking anything but two upright sarcophagi. On the floor in front of each sarcophagus is a set of hieroglyphics. You think to yourself, “This is just like those dumb emoji puzzles on Facebook; I am sure I can figure out which is the correct way to go.\""
        ) {

            HStack {
                VStack {
                    Image(uiImage: #imageLiteral(resourceName: "hieroglyphics_(Left).png"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

                    StoryNavigationButton(title: "Open the left sarcophagus", route: .page(18))
                }

                Spacer()

                VStack {
                    Image(uiImage: #imageLiteral(resourceName: "hieroglyphics_(Right).png"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

                    StoryNavigationButton(title: "Open the right sarcophagus", route: .page(22))
                }
            }
            .padding()
        }
    }
}

struct Page19View_Previews: PreviewProvider {
    static var previews: some View {
        Page19View()
    }
}
