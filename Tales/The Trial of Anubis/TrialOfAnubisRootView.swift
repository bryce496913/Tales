import SwiftUI

struct TrialOfAnubisRootView: View {
    let returnToStorySelection: () -> Void

    @StateObject
    private var navigationState = TrialOfAnubisNavigationState()

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            TrialOfAnubisMainMenuView(returnToStorySelection: returnToStorySelection)
                .environmentObject(navigationState)
                .environment(\.trialOfAnubisReturnToStorySelection, returnToStorySelection)
                .navigationDestination(for: TrialOfAnubisRoute.self) { route in
                    TrialOfAnubisDestinationView(route: route)
                        .environmentObject(navigationState)
                        .environment(\.trialOfAnubisReturnToStorySelection, returnToStorySelection)
                        .navigationBarBackButtonHidden(true)
                }
        }
        .environmentObject(navigationState)
        .environment(\.trialOfAnubisReturnToStorySelection, returnToStorySelection)
    }
}

private struct TrialOfAnubisReturnToStorySelectionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var trialOfAnubisReturnToStorySelection: () -> Void {
        get { self[TrialOfAnubisReturnToStorySelectionKey.self] }
        set { self[TrialOfAnubisReturnToStorySelectionKey.self] = newValue }
    }
}
