import SwiftUI

@main
struct TalesApp: App {
    @StateObject private var appNavigationState = AppNavigationState()
    @StateObject private var gameOptions = GameOptions()
    @StateObject private var sphinxNavigationState = SphinxNavigationState()
    @StateObject private var anubisNavigationState = TrialOfAnubisNavigationState()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(appNavigationState)
                .environmentObject(gameOptions)
                .environmentObject(sphinxNavigationState)
                .environmentObject(anubisNavigationState)
        }
    }
}
