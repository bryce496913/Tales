//
//  Page1View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

import SwiftUI

struct Page1View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "One.png",
            text: "As you stand at the feet of this enormous Sphinx, you notice that the main doorway is open. You think to yourself, head inside to find help or head back in the direction where the road could be."
        ) {
            StoryChoicesStack {
                StoryNavigationButton(title: "Try to enter the sphinx", route: .page(3)).padding()

                StoryNavigationButton(title: "Try to find the road", route: .page(2)).padding()
            }
        }
    }
}

struct Page1View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Page1View()
        }
    }
}
