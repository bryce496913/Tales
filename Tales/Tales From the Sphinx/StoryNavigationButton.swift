import SwiftUI

struct StoryNavigationButton: View {
    let title: String
    let route: SphinxRoute
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    @EnvironmentObject private var navigationState: SphinxNavigationState

    var body: some View {
        ChoiceButton(title, width: width, height: height) {
            navigationState.navigate(to: route)
        }
    }
}

struct RandomStoryNavigationButton: View {
    let title: String
    let routes: [SphinxRoute]
    @EnvironmentObject private var navigationState: SphinxNavigationState

    var body: some View {
        ChoiceButton(title) {
            if let route = routes.randomElement() {
                navigationState.navigate(to: route)
            }
        }
    }
}
