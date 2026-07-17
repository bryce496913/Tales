//
//  Page12View.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

// Page12View.swift
import SwiftUI

struct Page12View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Twelve.png",
            text: "Every room so far has felt ancient and so does this one, besides the large modern metal door, that looks like something out of a sci-fi movie. So out of place in here! The only other way to go is a bejewelled archway leading to a brightly light corridor."
        ) {

            HStack {
                StoryNavigationButton(title: "Inspect the metal door", route: .page(14)).padding()

                StoryNavigationButton(title: "Enter the bright corridor", route: .page(13)).padding()
            }
        }
    }
}

struct Page12View_Previews: PreviewProvider {
    static var previews: some View {
        Page12View()
    }
}
