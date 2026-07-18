//
//  Page17View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page17View.swift
import SwiftUI

struct Page17View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Seventeen.png",
            text: "Once you have entered the room, you see a strong but thin beam of light coming from a crack in the ceiling, and reflecting off a silver plate that is attached upright on hinges in the centre of the room. It seems that the angle and rotation of the plate can be adjusted. Also, in the room there are two statues guarding two doors; one is the God Re and the other the God Thorth. Both statues have a square piece of coloured glass in their chests. Maybe we can reflect the beam of light into one of the statue’s chest?"
        ) {

            HStack {
                StoryNavigationButton(title: "Shine the light at Re", route: .page(18))

                Spacer()

                StoryNavigationButton(title: "Shine the light at Thorth", route: .page(10))
            }
            .padding()
        }
    }
}

struct Page17View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page17View()
        }
    }
}
