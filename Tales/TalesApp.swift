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
                .onAppear { updateAmbience() }
                .onChange(of: gameOptions.backgroundMusicEnabled) { _ in updateAmbience() }
                .onChange(of: scenePhase) { _ in updateAmbience() }
        }
    }

    private func updateAmbience() {
        AmbiencePlayer.shared.setPlaying(gameOptions.backgroundMusicEnabled && scenePhase == .active)
    }
}
