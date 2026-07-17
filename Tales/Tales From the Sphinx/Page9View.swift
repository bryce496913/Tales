//
//  Page9View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page9View.swift
import SwiftUI

struct Page9View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Nine.png",
            text: "On immediate inspection, this new room has nowhere obvious to go to next. Your worrying thought is interrupted by a thunderous sound, followed by rapidly rushing sand filling the room. You need to find a way out before you are buried alive. In the room are two statues, both with levers, one of God Anubis and the other of God Osiris. One of these statues could be the key out of here. If only you had reception, you could Google which each God represents."
        ) {

            HStack {
                StoryNavigationButton(title: "Pick Anubis", route: .page(21)).padding()

                Spacer()

                StoryNavigationButton(title: "Pick Osiris", route: .page(10)).padding()
            }
        }
    }
}

struct Page9View_Previews: PreviewProvider {
    static var previews: some View {
        Page9View()
    }
}
