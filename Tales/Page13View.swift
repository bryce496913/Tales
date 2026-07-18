//
//  Page13View.swift
//  Tales
//

import SwiftUI

struct Page13View: View {
    var body: some View {
        StoryOutcomeView(
            endingID: "page13-win",
            outcome: .win,
            imageName: "Thirteen.png",
            storyText: "As you wander down the hallway, torches light alongside you. The hallway opens to a large room. As the torches continue to fill the room with light, you discover the room is full of gold, gems and priceless artifacts. You have found the treasure room.\nWith your pockets and arms full of treasure you make your way to a door labeled exit, valuing to return later for the rest. Once outside, you are able to spot the road and flag down a vehicle to take you to safety, as a very rich person."
        )
    }
}

struct Page13View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page13View()
        }
    }
}
