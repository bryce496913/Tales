//
//  AdventureResetButtons.swift
//  Tales
//
//  Shared ending controls for returning to the menu or restarting safely.
//

import SwiftUI

struct AdventureResetButtons: View {
    @EnvironmentObject private var navigationState: AppNavigationState

    var body: some View {
        VStack(spacing: 12) {
            ChoiceButton("Return to Main Menu", width: nil, height: nil, action: {
                navigationState.resetToMainMenu()
            })

            ChoiceButton("Restart Adventure", width: nil, height: nil, action: {
                navigationState.restartAdventure()
            })
        }
    }
}
