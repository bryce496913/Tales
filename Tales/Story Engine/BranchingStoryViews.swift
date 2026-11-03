import SwiftUI

private struct ReturnToStorySelectionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    /// Leaves the current story and goes back to the story selection screen.
    var returnToStorySelection: () -> Void {
        get { self[ReturnToStorySelectionKey.self] }
        set { self[ReturnToStorySelectionKey.self] = newValue }
    }
}

/// Hosts a branching story: its menu, its pages and its theme.
struct BranchingStoryRootView<Story: BranchingStory>: View {
    let returnToStorySelection: () -> Void

    @StateObject private var navigationState = BranchingStoryState<Story>()

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            BranchingStoryMenuView<Story>()
                .navigationDestination(for: Story.Route.self) { route in
                    Story.destination(for: route)
                        .environmentObject(navigationState)
                        .environment(\.storyTheme, Story.theme)
                        .environment(\.returnToStorySelection, returnToStorySelection)
                        .navigationBarBackButtonHidden(true)
                }
        }
        .environmentObject(navigationState)
        .environment(\.storyTheme, Story.theme)
        .environment(\.returnToStorySelection, returnToStorySelection)
    }
}

/// A story's own main menu: title art, Continue / New Adventure, Options and the way back out.
struct BranchingStoryMenuView<Story: BranchingStory>: View {
    @EnvironmentObject private var navigationState: BranchingStoryState<Story>
    @Environment(\.storyTheme) private var theme
    @Environment(\.returnToStorySelection) private var returnToStorySelection
    @State private var confirmingNewAdventure = false
    @State private var showingOptions = false
    @State private var showingEndings = false

    var body: some View {
        ZStack {
            StoryBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    StoryIllustration(imageName: Story.titleImageName)

                    VStack(spacing: 10) {
                        Text(Story.title)
                            .font(.system(size: 38, weight: .bold, design: .serif))
                            .foregroundColor(theme.accent)
                            .multilineTextAlignment(.center)
                            .accessibilityAddTraits(.isHeader)

                        Text(Story.subtitle)
                            .font(.system(.title3, design: .serif).weight(.medium))
                            .foregroundColor(theme.mutedText)
                            .multilineTextAlignment(.center)
                    }
                    .storyCard()
                    .frame(maxWidth: AppTheme.maximumTextWidth)

                    VStack(spacing: 12) {
                        if navigationState.hasSavedProgress {
                            ChoiceButton("Continue Adventure") {
                                navigationState.continueAdventure()
                            }
                        }

                        ChoiceButton("New Adventure") {
                            if navigationState.hasSavedProgress {
                                confirmingNewAdventure = true
                            } else {
                                navigationState.startNewAdventure()
                            }
                        }

                        ChoiceButton("Endings (\(foundEndingCount)/\(Story.endings.count))") {
                            showingEndings = true
                        }
                        .accessibilityLabel(EndingsGalleryView.summary(found: foundEndingCount, total: Story.endings.count))

                        ChoiceButton("Options") {
                            showingOptions = true
                        }

                        ChoiceButton("Back to Story Selection") {
                            returnToStorySelection()
                        }
                    }
                    .frame(maxWidth: 280)
                }
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .confirmationDialog(
            "Start a new \(Story.shortName) adventure?",
            isPresented: $confirmingNewAdventure,
            titleVisibility: .visible
        ) {
            Button("Start New Adventure", role: .destructive) {
                navigationState.startNewAdventure()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This replaces your unfinished \(Story.shortName) run but keeps completed \(Story.shortName) endings.")
        }
        .optionsSheet(isPresented: $showingOptions)
        .endingsGallery(
            isPresented: $showingEndings,
            storyTitle: Story.title,
            endings: Story.endings,
            found: navigationState.progress.completedEndingIDs,
            theme: theme
        )
    }

    private var foundEndingCount: Int {
        Story.endings.filter { navigationState.progress.completedEndingIDs.contains($0.id) }.count
    }
}

/// A story choice: navigates to `destination`, optionally collecting an item or remembering a flag.
struct BranchingNavigationButton<Story: BranchingStory>: View {
    let title: String
    let destination: Story.Route
    var collects: Story.Item? = nil
    var marks: Story.Flag? = nil

    @EnvironmentObject private var navigationState: BranchingStoryState<Story>

    var body: some View {
        ChoiceButton(title) {
            navigationState.navigate(to: destination, collecting: collects, marking: marks)
        }
    }
}

/// A branching story's game-over page. The ending itself is recorded by `BranchingStoryState.navigate`.
struct BranchingOutcomeView<Story: BranchingStory>: View {
    let outcome: Story.Outcome
    let title: String
    let classification: String
    let imageName: String
    let storyText: String
    let outcomeText: String

    @EnvironmentObject private var navigationState: BranchingStoryState<Story>
    @Environment(\.returnToStorySelection) private var returnToStorySelection

    var body: some View {
        StoryEndingView(
            outcome: outcome,
            title: title,
            classification: classification,
            imageName: imageName,
            storyText: storyText,
            outcomeText: outcomeText
        ) {
            ChoiceButton("Restart \(Story.title)") {
                navigationState.restartAdventure()
            }
            ChoiceButton("Return to \(Story.shortName) Menu") {
                navigationState.returnToStoryMenu()
            }
            ChoiceButton("Return to Story Selection") {
                navigationState.returnToStoryMenu()
                returnToStorySelection()
            }
        }
    }
}

/// Supplies isolated GameOptions and story state, plus the story's theme, for SwiftUI previews.
struct BranchingPreviewContainer<Story: BranchingStory, Content: View>: View {
    private let content: Content
    @StateObject private var gameOptions: GameOptions
    @StateObject private var navigationState: BranchingStoryState<Story>

    init(@ViewBuilder content: () -> Content) {
        let defaults = UserDefaults(suiteName: "TalesPreview.\(Story.saveKey).\(UUID().uuidString)") ?? .standard
        _gameOptions = StateObject(wrappedValue: GameOptions(defaults: defaults))
        _navigationState = StateObject(wrappedValue: BranchingStoryState<Story>(defaults: defaults))
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            content
        }
        .environmentObject(gameOptions)
        .environmentObject(navigationState)
        .environment(\.storyTheme, Story.theme)
    }
}
