//
//  TalesApp.swift
//  Tales
//

import SwiftUI

@main
struct TalesApp: App {
    @StateObject private var gameOptions = GameOptions()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameOptions)
                .onAppear {
                    AmbiencePlayer.shared.setEnabled(gameOptions.backgroundMusicEnabled)
                    AmbiencePlayer.shared.setAppActive(scenePhase == .active)
                }
                // Use the new values these hand us: reading `scenePhase` or the option from
                // `self` inside the closure gives the value from before the change, which
                // played the ambience only while the app was in the switcher.
                .onChange(of: gameOptions.backgroundMusicEnabled) { enabled in
                    AmbiencePlayer.shared.setEnabled(enabled)
                }
                .onChange(of: scenePhase) { phase in
                    AmbiencePlayer.shared.setAppActive(phase == .active)
                }
        }
    }
}
