import SwiftUI

struct TalesFromTheSphinxRootView: View {
    let returnToStorySelection: () -> Void

    @StateObject private var navigationState: AppNavigationState

    @MainActor
    init(returnToStorySelection: @escaping () -> Void) {
        self.returnToStorySelection = returnToStorySelection
        _navigationState = StateObject(wrappedValue: AppNavigationState())
    }

    @MainActor
    init(
        returnToStorySelection: @escaping () -> Void,
        navigationState: AppNavigationState
    ) {
        self.returnToStorySelection = returnToStorySelection
        _navigationState = StateObject(wrappedValue: navigationState)
    }

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            MainMenu(returnToStorySelection: returnToStorySelection)
                .environmentObject(navigationState)
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

struct MainMenu: View {
    let returnToStorySelection: () -> Void

    @EnvironmentObject private var navigationState: AppNavigationState
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @State private var appeared = false

    init(returnToStorySelection: @escaping () -> Void = {}) {
        self.returnToStorySelection = returnToStorySelection
    }

    var body: some View {
        ZStack {
            EgyptianBackground()
            // The title art shrinks to fit at normal text sizes; accessibility sizes need room to scroll.
            if dynamicTypeSize.isAccessibilitySize {
                ScrollView(showsIndicators: false) { menuContent }
            } else {
                menuContent
            }
        }
        .onAppear { withAnimation(.easeOut(duration: 0.55)) { appeared = true } }
    }

    private var menuContent: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 20)

            Image(uiImage:#imageLiteral(resourceName: "Title-Screen-Art.png"))
                .resizable()
                .scaledToFit()
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 28, style: .continuous).fill(AppTheme.cardAlt))
                .overlay(RoundedRectangle(cornerRadius: 28, style: .continuous).stroke(AppTheme.gold.opacity(0.55), lineWidth: 1))
                .shadow(color: AppTheme.shadow, radius: 22, x: 0, y: 14)
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)

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
            .frame(maxWidth: AppTheme.maximumTextWidth)

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
                    .foregroundColor(AppTheme.buttonText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity, minHeight: 54)
            }
            .buttonStyle(StoryChoiceButtonStyle())
            .frame(maxWidth: 280)

            MenuButton(title: "Back to Story Selection") {
                returnToStorySelection()
            }
            .accessibilityLabel("Back to Story Selection")
            .accessibilityHint("Returns to the story selection screen.")

            Spacer(minLength: 30)
        }
        .padding(AppTheme.screenPadding)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 18)
    }
}

struct StoryDestinationView: View {
    let route: StoryRoute

    var body: some View {
        switch route {
        case .options: OptionsView()
        case .plot1: Plot1View()
        case .plot2: Plot2View()
        case .page(let number):
            switch number {
            case 1: Page1View(); case 2: Page2View(); case 3: Page3View(); case 4: Page4View(); case 5: Page5View()
            case 6: Page6View(); case 7: Page7View(); case 8: Page8View(); case 9: Page9View(); case 10: Page10View()
            case 11: Page11View(); case 12: Page12View(); case 13: Page13View(); case 14: Page14View(); case 15: Page15View()
            case 16: Page16View(); case 17: Page17View(); case 18: Page18View(); case 19: Page19View(); case 20: Page20View()
            case 21: Page21View(); case 22: Page22View(); case 24: Page24View(); case 25: Page25View()
            default: MissingStoryPageView(pageNumber: number)
            }
        }
    }
}

/// Shown instead of guessing a page when a route (for example from an old save) has no matching view.
struct MissingStoryPageView: View {
    let pageNumber: Int

    var body: some View {
        ZStack {
            EgyptianBackground()
            VStack(spacing: 18) {
                Text("This part of the tomb has crumbled away.")
                    .font(.system(.title3, design: .serif).weight(.bold))
                    .foregroundColor(AppTheme.gold)
                    .multilineTextAlignment(.center)
                Text("Page \(pageNumber) could not be found. Restart the adventure or return to the main menu.")
                    .font(.system(.body, design: .serif))
                    .foregroundColor(AppTheme.warmText)
                    .multilineTextAlignment(.center)
                AdventureResetButtons()
            }
            .goldCard()
            .frame(maxWidth: AppTheme.maximumTextWidth)
            .padding(AppTheme.screenPadding)
        }
        .onAppear { assertionFailure("No Tales From the Sphinx view for page \(pageNumber)") }
    }
}

struct TalesFromTheSphinxRootView_Previews: PreviewProvider {
    static var previews: some View {
        TalesFromTheSphinxRootView(
            returnToStorySelection: {},
            navigationState: AppNavigationState(previewMode: true)
        )
        .environmentObject(GameOptions(defaults: UserDefaults(suiteName: "TalesPreview.SphinxRoot") ?? .standard))
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            MainMenu()
        }
    }
}
