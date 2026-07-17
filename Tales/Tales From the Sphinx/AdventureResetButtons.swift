//
//  AdventureResetButtons.swift
//  Tales
//
//  Shared ending controls for returning to the menu or restarting safely.
//

import SwiftUI

struct AdventureResetButtons: View {
    @EnvironmentObject private var navigationState: SphinxNavigationState
    @EnvironmentObject private var appNavigationState: AppNavigationState

    var body: some View {
        VStack(spacing: 12) {
            ChoiceButton("Return to Main Menu", width: nil, height: nil, action: {
                navigationState.returnToStoryMenu()
                appNavigationState.returnToMainMenu()
            })

            ChoiceButton("Restart Adventure", width: nil, height: nil, action: {
                navigationState.restartAdventure()
            })
        }
    }
}
