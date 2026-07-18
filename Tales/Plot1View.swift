import SwiftUI

struct Plot1View: View {

    var body: some View {
        StoryPageLayout(
            imageName: "Plot1.png",
            title: "The Desert Road",
            text: "“What a stunning day in Egypt”, You say to yourself, as you drove along the desert highway. Sadly, Spotify didn’t work as there was no reception out here. The air was dry, rolling sand dunes on all sides of the vehicle and not another soul insight. As you drive along, sudden darkness fell and your vehicle is dramatically launched off the road."
        ) {
            StoryNavigationButton(title: "Continue", route: .plot2)
        }
    }
}

struct Plot1View_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            Plot1View()
        }
    }
}
