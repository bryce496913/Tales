import SwiftUI

struct DescentToHadesRootView: View {
    let returnToStorySelection: () -> Void

    @StateObject
    private var navigationState = DescentToHadesNavigationState()

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            DescentToHadesMainMenuView(returnToStorySelection: returnToStorySelection)
                .environmentObject(navigationState)
                .environment(\.descentToHadesReturnToStorySelection, returnToStorySelection)
                .navigationDestination(for: DescentToHadesRoute.self) { route in
                    DescentToHadesDestinationView(route: route)
                        .environmentObject(navigationState)
                        .environment(\.descentToHadesReturnToStorySelection, returnToStorySelection)
                        .navigationBarBackButtonHidden(true)
                }
        }
        .environmentObject(navigationState)
        .environment(\.descentToHadesReturnToStorySelection, returnToStorySelection)
    }
}

private struct DescentToHadesReturnToStorySelectionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var descentToHadesReturnToStorySelection: () -> Void {
        get { self[DescentToHadesReturnToStorySelectionKey.self] }
        set { self[DescentToHadesReturnToStorySelectionKey.self] = newValue }
    }
}
