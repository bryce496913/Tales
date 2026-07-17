//
//  ContentView.swift
//  Tales
//
//  Created by Bryce Cameron on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationState = AppNavigationState()
    @State private var isSplashActive = true

    var body: some View {
        NavigationStack(path: $navigationState.path) {
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
                    MainMenu()
                        .environmentObject(navigationState)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: StoryRoute.self) { route in
                StoryDestinationView(route: route)
                    .environmentObject(navigationState)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .environmentObject(navigationState)
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

struct MainMenu: View {
    @EnvironmentObject private var navigationState: AppNavigationState
    @State private var appeared = false

    var body: some View {
        ZStack {
            EgyptianBackground()
            VStack(spacing: 24) {
                Spacer(minLength: 20)

                Image(uiImage:#imageLiteral(resourceName: "Title-Screen-Art.png"))
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 28, style: .continuous).fill(AppTheme.cardAlt))
                    .overlay(RoundedRectangle(cornerRadius: 28, style: .continuous).stroke(AppTheme.gold.opacity(0.55), lineWidth: 1))
                    .shadow(color: AppTheme.shadow, radius: 22, x: 0, y: 14)

                VStack(spacing: 8) {
                    Text("Tales From the Sphinx")
                        .font(.system(size: 38, weight: .bold, design: .serif))
                        .foregroundColor(AppTheme.gold)
                        .multilineTextAlignment(.center)
                    Text("An Egyptian adventure of mystery, treasure, and danger")
                        .font(.system(.subheadline, design: .serif).weight(.medium))
                        .foregroundColor(AppTheme.mutedText)
                        .multilineTextAlignment(.center)
                }
                .goldCard()

                if navigationState.hasSavedProgress {
                    MenuButton(title: "Continue Adventure") {
                        navigationState.continueAdventure()
                    }
                    .padding(.top, 6)
                }

                MenuButton(title: navigationState.hasSavedProgress ? "New Adventure" : "New Game") {
                    navigationState.startNewAdventure()
                }

                NavigationLink(value: StoryRoute.options) {
                    Text("Options")
                        .font(.system(.headline, design: .serif).weight(.semibold))
                        .foregroundColor(Color(hex: "1E140B"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, minHeight: 54)
                }
                .buttonStyle(StoryChoiceButtonStyle())
                .frame(maxWidth: 280)

                Spacer(minLength: 30)
            }
            .padding(AppTheme.screenPadding)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 18)
        }
        .onAppear { withAnimation(.easeOut(duration: 0.55)) { appeared = true } }
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            .sRGB,
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0,
            opacity: 1.0
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameOptions())
    }
}
