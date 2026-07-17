//
//  Page15View.swift
//  Tales
//

import SwiftUI

struct Page15View: View {
    var body: some View {
        StoryOutcomeView(
            outcome: .lose,
            imageName: "Fithteen.png",
            storyText: "The floor starts to rumble and before you know it, the floor turned to a slide, you lose your footing and slide down into the darkness. As you slide, you look down to your feet and see the light getting closer. Just like that, you pop out the Sphinx’s backside, onto the sand. You stand up and notice a helicopter above. The search and rescue team had been looking for you since someone reported the vehicle crash. You will be saved."
        )
    }
}

struct Page15View_Previews: PreviewProvider {
    static var previews: some View {
        Page15View()
            .environmentObject(AppNavigationState())
            .environmentObject(GameOptions())
    }
}
