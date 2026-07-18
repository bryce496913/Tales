//
//  Page3View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page3View.swift
import SwiftUI

struct Page3View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Three.png",
            text: "After climbing the stairs of the Sphinx, you enter the main hall. Though empty, the room is dimly lit, hinting at the chance of more people inside. As your eyes adjust to the change of light, you notice, at the back, the hall splits in two different directions."
        ) {

            HStack {
                StoryNavigationButton(title: "Head down the left", route: .page(4)).padding()

                Spacer()

                StoryNavigationButton(title: "Head down the right", route: .page(6)).padding()
            }
        }
    }
}

struct Page3View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page3View()
        }
    }
}
