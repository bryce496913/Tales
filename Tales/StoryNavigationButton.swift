import SwiftUI

struct StoryNavigationButton: View {
    let title: String
    let route: StoryRoute
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    @EnvironmentObject private var navigationState: AppNavigationState

    var body: some View {
        ChoiceButton(title, width: width, height: height) {
            navigationState.navigate(to: route)
        }
    }
}

struct RandomStoryNavigationButton: View {
    let title: String
    let routes: [StoryRoute]
    @EnvironmentObject private var navigationState: AppNavigationState

    var body: some View {
        ChoiceButton(title) {
            if let route = routes.randomElement() {
                navigationState.navigate(to: route)
            }
        }
    }
}

struct StoryNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            StoryNavigationButton(title: "Preview Choice", route: .page(1))
                .padding()
        }
    }
}
