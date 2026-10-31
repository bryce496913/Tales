//
//  ContentView.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isSplashActive = true
    @State private var appScreen: AppScreen = .mainMenu

    var body: some View {
        ZStack {
            EgyptianBackground()

            if isSplashActive {
                SplashScreen()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeInOut(duration: 0.45)) {
                                isSplashActive = false
                            }
                        }
                    }
            } else {
                appContent
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
    }

    @ViewBuilder
    private var appContent: some View {
        switch appScreen {
        case .mainMenu:
            AppMainMenuView {
                appScreen = .storySelection
            }

        case .storySelection:
            StorySelectionView(
                openSphinx: {
                    appScreen = .talesFromTheSphinx
                },
                openAnubis: {
                    appScreen = .trialOfAnubis
                },
                openHades: {
                    appScreen = .descentToHades
                },
                returnToMainMenu: {
                    appScreen = .mainMenu
                }
            )

        case .talesFromTheSphinx:
            TalesFromTheSphinxRootView(
                returnToStorySelection: {
                    appScreen = .storySelection
                }
            )

        case .trialOfAnubis:
            TrialOfAnubisRootView(
                returnToStorySelection: {
                    appScreen = .storySelection
                }
            )

        case .descentToHades:
            DescentToHadesRootView(
                returnToStorySelection: {
                    appScreen = .storySelection
                }
            )
        }
    }
}

struct SplashScreen: View {
    @State private var appeared = false

    var body: some View {
        ZStack {
            EgyptianBackground()
            VStack(spacing: 20) {
                Image(uiImage: #imageLiteral(resourceName: "Icon.png"))
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 220)
                    .padding()
                    .goldCard(padding: 12)
                Text("Tales From the Sphinx")
                    .font(.system(.title, design: .serif).weight(.bold))
                    .foregroundColor(AppTheme.gold)
            }
            .opacity(appeared ? 1 : 0)
            .scaleEffect(appeared ? 1 : 0.96)
        }
        .onAppear { withAnimation(.easeOut(duration: 0.55)) { appeared = true } }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameOptions(defaults: UserDefaults(suiteName: "TalesPreview.Content") ?? .standard))
    }
}
