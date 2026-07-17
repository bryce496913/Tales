import SwiftUI

@main
struct TalesApp: App {
    @StateObject private var appNavigationState = AppNavigationState()
    @StateObject private var gameOptions = GameOptions()
    @StateObject private var sphinxNavigationState = SphinxNavigationState()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(appNavigationState)
                .environmentObject(gameOptions)
                .environmentObject(sphinxNavigationState)
        }
    }
}
