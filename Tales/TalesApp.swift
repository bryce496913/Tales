//
//  TalesApp.swift
//  Tales
//

import SwiftUI

@main
struct TalesApp: App {
    @StateObject private var gameOptions = GameOptions()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameOptions)
        }
    }
}
