import SwiftUI

struct AppRootView: View {
    @EnvironmentObject private var appNavigationState: AppNavigationState
    @EnvironmentObject private var sphinxNavigationState: SphinxNavigationState
    @EnvironmentObject private var anubisNavigationState: TrialOfAnubisNavigationState
    @State private var isSplashActive = true

    var body: some View {
        NavigationStack(path: $appNavigationState.path) {
            ZStack {
                EgyptianBackground()
                if isSplashActive && !appNavigationState.hasShownLaunchSplash {
                    TalesSplashView()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeInOut(duration: 0.45)) {
                                    isSplashActive = false
                                    appNavigationState.hasShownLaunchSplash = true
                                }
                            }
                        }
                } else {
                    AppMainMenuView().transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .storyLibrary:
                    StoryLibraryView().navigationBarBackButtonHidden(true)
                case .storyDetail(let storyID):
                    if let story = StoryCatalog.story(for: storyID) { StoryDetailView(story: story).navigationBarBackButtonHidden(true) }
                    else { MissingStoryView(storyID: storyID).navigationBarBackButtonHidden(true) }
                case .options:
                    OptionsView()
                case .playStory(let storyID):
                    StoryHostView(storyID: storyID).navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct ContentView: View { var body: some View { AppRootView() } }

struct TalesSplashView: View {
    @State private var appeared = false
    var body: some View {
        ZStack { EgyptianBackground(); VStack(spacing: 20) {
            Image(uiImage: #imageLiteral(resourceName: "Icon.png")).resizable().scaledToFit().frame(maxWidth: 220).padding().goldCard(padding: 12).accessibilityHidden(true)
            Text("Tales").font(.system(.largeTitle, design: .serif).weight(.bold)).foregroundColor(AppTheme.gold)
            Text("Choose your path. Shape your legend.").font(.system(.headline, design: .serif)).foregroundColor(AppTheme.mutedText).multilineTextAlignment(.center)
        }.padding(AppTheme.screenPadding).opacity(appeared ? 1 : 0).scaleEffect(appeared ? 1 : 0.96) }
        .onAppear { withAnimation(.easeOut(duration: 0.55)) { appeared = true } }
    }
}

struct AppMainMenuView: View {
    @EnvironmentObject private var appNavigationState: AppNavigationState
    @EnvironmentObject private var sphinxNavigationState: SphinxNavigationState
    @State private var appeared = false
    var body: some View {
        ZStack { EgyptianBackground(); VStack(spacing: 22) {
            Spacer(minLength: 20)
            Text("Tales").font(.system(size: 54, weight: .bold, design: .serif)).foregroundColor(AppTheme.gold).accessibilityAddTraits(.isHeader)
            Text("Choose your path. Shape your legend.").font(.system(.headline, design: .serif)).foregroundColor(AppTheme.mutedText).multilineTextAlignment(.center)
            VStack(spacing: 12) {
                if sphinxNavigationState.hasSavedProgress { MenuButton(title: "Continue Tales From the Sphinx") { appNavigationState.playStory(.talesFromTheSphinx); sphinxNavigationState.continueAdventure() } }
                MenuButton(title: "Choose a Story") { appNavigationState.showStoryLibrary() }
                MenuButton(title: "Options") { appNavigationState.showOptions() }
            }.goldCard()
            Text("2 stories in the library • 2 available now").font(.caption).foregroundColor(AppTheme.mutedText)
            Spacer(minLength: 30)
        }.padding(AppTheme.screenPadding).opacity(appeared ? 1 : 0).offset(y: appeared ? 0 : 18) }
        .onAppear { withAnimation(.easeOut(duration: 0.55)) { appeared = true } }
    }
}

struct StoryLibraryView: View {
    @EnvironmentObject private var appNavigationState: AppNavigationState
    @EnvironmentObject private var sphinxNavigationState: SphinxNavigationState
    @EnvironmentObject private var anubisNavigationState: TrialOfAnubisNavigationState
    private let columns = [GridItem(.adaptive(minimum: 280, maximum: 360), spacing: 18)]
    var body: some View { ZStack { EgyptianBackground(); ScrollView { VStack(alignment: .leading, spacing: 18) {
        Button { appNavigationState.returnToMainMenu() } label: { Label("Main Menu", systemImage: "chevron.left") }.buttonStyle(StoryChoiceButtonStyle()).frame(maxWidth: 220)
        Text("Story Library").font(.system(.largeTitle, design: .serif).weight(.bold)).foregroundColor(AppTheme.gold)
        LazyVGrid(columns: columns, spacing: 18) { ForEach(StoryCatalog.stories) { story in StoryCardView(story: story, hasSavedProgress: savedProgress(for: story.id)) { appNavigationState.showStoryDetail(story.id) } } }
    }.frame(maxWidth: 820).padding(AppTheme.screenPadding) } } }
    private func savedProgress(for storyID: StoryID) -> Bool { storyID == .talesFromTheSphinx ? sphinxNavigationState.hasSavedProgress : anubisNavigationState.hasSavedProgress }
}

struct StoryCardView: View {
    let story: StoryDescriptor; let hasSavedProgress: Bool; let action: () -> Void
    var body: some View { Button(action: action) { VStack(alignment: .leading, spacing: 12) {
        StoryCoverView(story: story).frame(height: 180)
        HStack { Text(story.availability.title).font(.caption.weight(.bold)).foregroundColor(Color(hex: "1E140B")).padding(8).background(Capsule().fill(story.availability == .available ? AppTheme.gold : AppTheme.mutedText)); Spacer() }
        Text(story.title).font(.system(.title2, design: .serif).weight(.bold)).foregroundColor(AppTheme.gold).multilineTextAlignment(.leading)
        Text(story.subtitle).font(.subheadline).foregroundColor(AppTheme.warmText).multilineTextAlignment(.leading)
        Text(story.availability == .available ? (hasSavedProgress ? "Continue" : "Play") : "Learn More").font(.headline).foregroundColor(AppTheme.sand)
    }.frame(maxWidth: .infinity, alignment: .leading).goldCard() }
    .accessibilityLabel("\(story.title). \(story.availability.title). \(story.subtitle)") }
}

struct StoryDetailView: View {
    let story: StoryDescriptor
    @EnvironmentObject private var appNavigationState: AppNavigationState
    @EnvironmentObject private var sphinxNavigationState: SphinxNavigationState
    @EnvironmentObject private var anubisNavigationState: TrialOfAnubisNavigationState
    @State private var confirmingNewAdventure = false
    var body: some View { ZStack { EgyptianBackground(); ScrollView { VStack(spacing: 18) {
        StoryCoverView(story: story).frame(height: 260)
        VStack(alignment: .leading, spacing: 12) { Text(story.title).font(.system(.largeTitle, design: .serif).weight(.bold)).foregroundColor(AppTheme.gold); Text(story.summary).foregroundColor(AppTheme.warmText); Text(story.availability.title).font(.headline).foregroundColor(AppTheme.gold)
            if let length = story.estimatedLength { Text(length).foregroundColor(AppTheme.mutedText) }
            if let endings = story.endingCount { Text("\(endings) Endings").foregroundColor(AppTheme.mutedText) }
        }.frame(maxWidth: .infinity, alignment: .leading).goldCard()
        if story.availability == .available {
            if hasSavedProgress { MenuButton(title: "Continue Adventure") { appNavigationState.playStory(story.id); continueStory() } }
            MenuButton(title: "New Adventure") { if hasSavedProgress { confirmingNewAdventure = true } else { startNew() } }
        } else { ComingSoonStoryView(story: story) }
        MenuButton(title: "Back to Story Library") { appNavigationState.showStoryLibrary() }
    }.frame(maxWidth: 720).padding(AppTheme.screenPadding) } }
    .confirmationDialog("Start a new adventure? Current in-progress route for this story will be overwritten, but completed endings remain.", isPresented: $confirmingNewAdventure, titleVisibility: .visible) { Button("Start New Adventure", role: .destructive) { startNew() }; Button("Cancel", role: .cancel) {} } }
    private var hasSavedProgress: Bool { story.id == .talesFromTheSphinx ? sphinxNavigationState.hasSavedProgress : anubisNavigationState.hasSavedProgress }
    private func continueStory() { if story.id == .talesFromTheSphinx { sphinxNavigationState.continueAdventure() } else { anubisNavigationState.continueAdventure() } }
    private func startNew() { appNavigationState.playStory(story.id); if story.id == .talesFromTheSphinx { sphinxNavigationState.startNewAdventure() } else { anubisNavigationState.startNewAdventure() } }
}

struct ComingSoonStoryView: View { let story: StoryDescriptor; var body: some View { Text("Coming Soon — preview only. Gameplay is not available yet.").foregroundColor(AppTheme.mutedText).goldCard().accessibilityLabel("\(story.title) is coming soon. No play button is available.") } }

struct StoryCoverView: View {
    let story: StoryDescriptor

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let imageName = story.coverImageName, let image = UIImage(named: imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                } else {
                    LinearGradient(colors: [AppTheme.backgroundTop, AppTheme.cardAlt, AppTheme.backgroundBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
                    VStack(spacing: 8) {
                        Image(systemName: story.iconSystemName ?? "book.closed.fill")
                            .font(.system(size: 64))
                            .foregroundColor(AppTheme.gold)
                        if let imageName = story.coverImageName {
                            Text(imageName)
                                .font(.caption.weight(.semibold))
                                .foregroundColor(AppTheme.mutedText)
                        }
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.imageRadius))
            .overlay(RoundedRectangle(cornerRadius: AppTheme.imageRadius).stroke(AppTheme.gold.opacity(0.55), lineWidth: 1))
        }
        .accessibilityHidden(true)
    }
}

struct StoryHostView: View { let storyID: StoryID; var body: some View { switch storyID { case .talesFromTheSphinx: SphinxStoryRootView(); case .trialOfAnubis: TrialOfAnubisStoryRootView() } } }

struct SphinxStoryRootView: View {
    @EnvironmentObject private var sphinxNavigationState: SphinxNavigationState
    var body: some View { NavigationStack(path: $sphinxNavigationState.path) { SphinxStoryMenuView().navigationBarBackButtonHidden(true).navigationDestination(for: SphinxRoute.self) { route in SphinxDestinationView(route: route).navigationBarBackButtonHidden(true) } } }
}

struct SphinxStoryMenuView: View {
    @EnvironmentObject private var appNavigationState: AppNavigationState
    @EnvironmentObject private var sphinxNavigationState: SphinxNavigationState
    var body: some View { ZStack { EgyptianBackground(); VStack(spacing: 22) { Image(uiImage:#imageLiteral(resourceName: "Title-Screen-Art.png")).resizable().scaledToFit().padding(10).background(RoundedRectangle(cornerRadius: 28).fill(AppTheme.cardAlt)); Text("Tales From the Sphinx").font(.system(size: 38, weight: .bold, design: .serif)).foregroundColor(AppTheme.gold).multilineTextAlignment(.center); Text("An Egyptian adventure of mystery, treasure, and danger").foregroundColor(AppTheme.mutedText).multilineTextAlignment(.center).goldCard(); if sphinxNavigationState.hasSavedProgress { MenuButton(title: "Continue Adventure") { sphinxNavigationState.continueAdventure() } }; MenuButton(title: sphinxNavigationState.hasSavedProgress ? "New Adventure" : "New Game") { sphinxNavigationState.startNewAdventure() }; MenuButton(title: "Back to Story Library") { appNavigationState.showStoryLibrary() }; MenuButton(title: "Tales Main Menu") { sphinxNavigationState.returnToStoryMenu(); appNavigationState.returnToMainMenu() } }.padding(AppTheme.screenPadding) } }
}

struct MissingStoryView: View { let storyID: StoryID; var body: some View { Text("Unknown story: \(storyID.rawValue)") } }

struct AppRootView_Previews: PreviewProvider { static var previews: some View { AppRootView().environmentObject(AppNavigationState()).environmentObject(GameOptions()).environmentObject(SphinxNavigationState(defaults: UserDefaults(suiteName: "preview")!)).environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anubis")!)) } }
