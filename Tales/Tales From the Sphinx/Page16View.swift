//
//  Page16View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page16View.swift
import SwiftUI

struct Page16View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Sixteen.png",
            text: "The door is slightly stuck but you push harder and it slowly opens enough for you to slip through. The floor is sticky and your face brushes by, what felt like a cobweb. You hear scratching and shuffling. Your gaze is brought to the centre of the room when a deep voice whispers “hello there”. It is at that moment; you realise you are now face to face with a giant talking spider guarding a door."
        ) {

            HStack {
                RandomStoryNavigationButton(title: "Run between its legs to reach the door", routes: [.page(19), .page(25)])
                Spacer()

                StoryNavigationButton(title: "Talk to the spider and ask nicely to let you in the door", route: .page(17))
                }
            .padding()
        }
    }
}

struct Page16View_Previews: PreviewProvider {
    static var previews: some View {
        Page16View()
    }
}
