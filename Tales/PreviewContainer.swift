import SwiftUI

#if DEBUG
struct PreviewContainer<Content: View>: View {
    @StateObject private var gameOptions: GameOptions
    @StateObject private var navigationState: AppNavigationState

    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        let suiteName = "TalesPreview.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName) ?? .standard
        defaults.removePersistentDomain(forName: suiteName)
        _gameOptions = StateObject(wrappedValue: GameOptions(defaults: defaults))
        _navigationState = StateObject(wrappedValue: AppNavigationState(defaults: defaults))
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            content
        }
        .environmentObject(gameOptions)
        .environmentObject(navigationState)
    }
}
#endif
