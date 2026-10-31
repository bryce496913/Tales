import SwiftUI

struct DescentToHadesPreviewContainer<Content: View>: View {
    private let content: Content
    @StateObject private var gameOptions: GameOptions
    @StateObject private var navigationState: DescentToHadesNavigationState

    init(@ViewBuilder content: () -> Content) {
        let defaults = UserDefaults(suiteName: "TalesPreview.DescentToHades.\(UUID().uuidString)") ?? .standard
        _gameOptions = StateObject(wrappedValue: GameOptions(defaults: defaults))
        _navigationState = StateObject(wrappedValue: DescentToHadesNavigationState(defaults: defaults))
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            content
                .environmentObject(navigationState)
        }
        .environmentObject(gameOptions)
    }
}
