import SwiftUI

struct TalesFromTheSphinxRootView: View {
    let returnToStorySelection: () -> Void

    @StateObject private var navigationState: AppNavigationState

    @MainActor
    init(returnToStorySelection: @escaping () -> Void) {
        self.returnToStorySelection = returnToStorySelection
        _navigationState = StateObject(wrappedValue: AppNavigationState())
    }

    @MainActor
    init(
        returnToStorySelection: @escaping () -> Void,
        navigationState: AppNavigationState
    ) {
        self.returnToStorySelection = returnToStorySelection
        _navigationState = StateObject(wrappedValue: navigationState)
    }

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            MainMenu(returnToStorySelection: returnToStorySelection)
                .environmentObject(navigationState)
                .navigationBarBackButtonHidden(true)
                .navigationDestination(for: StoryRoute.self) { route in
                    StoryDestinationView(route: route)
                        .environmentObject(navigationState)
                        .navigationBarBackButtonHidden(true)
                }
        }
        .environmentObject(navigationState)
    }
}

struct TalesFromTheSphinxRootView_Previews: PreviewProvider {
    static var previews: some View {
        TalesFromTheSphinxRootView(
            returnToStorySelection: {},
            navigationState: AppNavigationState(previewMode: true)
        )
        .environmentObject(GameOptions(defaults: UserDefaults(suiteName: "TalesPreview.SphinxRoot") ?? .standard))
    }
}
