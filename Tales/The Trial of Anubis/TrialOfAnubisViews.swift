import SwiftUI

struct TrialOfAnubisStoryRootView: View {
    @EnvironmentObject private var navigationState: TrialOfAnubisNavigationState
    var body: some View { NavigationStack(path: $navigationState.path) { TrialOfAnubisStoryMenuView().navigationBarBackButtonHidden(true).navigationDestination(for: TrialOfAnubisRoute.self) { TrialOfAnubisDestinationView(route: $0).navigationBarBackButtonHidden(true) } } }
}

struct TrialOfAnubisStoryMenuView: View {
    @EnvironmentObject private var appNavigationState: AppNavigationState
    @EnvironmentObject private var nav: TrialOfAnubisNavigationState
    @State private var confirm = false
    var body: some View { ZStack { EgyptianBackground(); ScrollView { VStack(spacing: 18) { StoryCoverView(story: StoryCatalog.trialOfAnubis).frame(height: 260); Text("The Trial of Anubis").font(.system(.largeTitle, design: .serif).weight(.bold)).foregroundColor(AppTheme.gold); Text(StoryCatalog.trialOfAnubis.summary).foregroundColor(AppTheme.warmText).multilineTextAlignment(.center).goldCard(); Text("\(nav.completedEndings.count) of \(TrialOfAnubisEnding.allCases.count) Endings Discovered").foregroundColor(AppTheme.mutedText); if nav.hasSavedProgress { MenuButton(title: "Continue Adventure") { nav.continueAdventure() } }; MenuButton(title: nav.hasSavedProgress ? "New Adventure" : "New Adventure") { nav.hasSavedProgress ? (confirm = true) : nav.startNewAdventure() }; MenuButton(title: "Return to Story Library") { nav.returnToStoryMenu(); appNavigationState.showStoryLibrary() }; MenuButton(title: "Tales Main Menu") { nav.returnToStoryMenu(); appNavigationState.returnToMainMenu() } }.frame(maxWidth: 720).padding(AppTheme.screenPadding) } }.confirmationDialog("Start a new adventure? Current Trial of Anubis progress will be overwritten, but discovered endings remain.", isPresented: $confirm) { Button("Start New Adventure", role: .destructive) { nav.startNewAdventure() }; Button("Cancel", role: .cancel) {} } }
}

struct TrialOfAnubisDestinationView: View { let route: TrialOfAnubisRoute
    var body: some View { switch route {
    case .anu001: ANU001View(); case .anu002: ANU002View(); case .anu003: ANU003View(); case .anu004: ANU004View(); case .anu005: ANU005View(); case .anu006: ANU006View(); case .anu007: ANU007View(); case .anu008: ANU008View(); case .anu009: ANU009View(); case .anu010: ANU010View(); case .anu011: ANU011View(); case .anu012: ANU012View(); case .anu013: ANU013View(); case .anu014: ANU014View(); case .anu015: ANU015View(); case .anu016: ANU016View(); case .anu017: ANU017View(); case .anu018: ANU018View(); case .anu019: ANU019View(); case .anu020: ANU020View(); case .anu021: ANU021View(); case .anu022: ANU022View(); case .anu023: ANU023View(); case .anu024: ANU024View(); case .anu025: ANU025View(); case .anu026: ANU026View(); case .anu027: ANU027View(); case .anu028: ANU028View(); case .endTrue: AnubisTrueEndingView(); case .endAmmit: AnubisAmmitEndingView(); case .endRebel: AnubisRebelEndingView(); case .endTrickster: AnubisTricksterEndingView(); case .endLost: AnubisLostSoulEndingView() } }
}

struct TrialOfAnubisPageView: View {
    let nodeID: TrialOfAnubisRoute
    @EnvironmentObject private var nav: TrialOfAnubisNavigationState
    @EnvironmentObject private var gameOptions: GameOptions
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false
    @State private var textComplete = false

    var body: some View {
        StoryTransitionContainer(style: transitionStyle) {
            ZStack(alignment: .top) {
                EgyptianBackground().ignoresSafeArea()

                if let node = TrialOfAnubisStoryContent.node(for: nodeID) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 18) {
                            StaticStoryImage(imageName: node.imageName)
                            TrialOfAnubisStatusView(state: nav.state)
                            VStack(alignment: .leading, spacing: 12) {
                                Text(node.id.rawValue)
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(AppTheme.mutedText)
                                Text(node.title)
                                    .font(.system(.title2, design: .serif).weight(.bold))
                                    .foregroundColor(AppTheme.gold)
                                    .accessibilityAddTraits(.isHeader)
                                TypewriterText(
                                    text: node.narrative,
                                    speed: gameOptions.typewriterSpeed.speed,
                                    startDelay: reduceMotion ? 0 : 0.45,
                                    isEnabled: gameOptions.typewriterEnabled && !reduceMotion
                                ) { textComplete = true }
                                .accessibilityIdentifier(typewriterReadinessIdentifier)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .goldCard()
                            .contentShape(Rectangle())

                            if choicesVisible {
                                VStack(spacing: 12) {
                                    ForEach(node.choices.filter { $0.requirement?.isSatisfied(by: nav.state) ?? true }) {
                                        TrialOfAnubisChoiceButton(nodeID: nodeID, choice: $0)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .transition(
                                    .opacity.combined(
                                        with: .move(edge: .bottom)
                                    )
                                )
                                .accessibilityIdentifier("anubis-choice-container-ready")
                            }
                        }
                        .padding(.horizontal, AppTheme.screenPadding)
                        .padding(.top, 18)
                        .padding(.bottom, 24)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 10)
                    }
                    .zIndex(1)
                    .accessibilityIdentifier("anubis-node-\(nodeID.rawValue)")
                } else {
                    Text("Missing Anubis route: \(nodeID.rawValue)")
                        .foregroundColor(AppTheme.gold)
                        .goldCard()
                        .onAppear { assertionFailure("Invalid Anubis route \(nodeID.rawValue)") }
                }

                if let feedback = nav.feedback {
                    TrialOfAnubisFeedbackBanner(feedback: feedback)
                        .padding(.top, 8)
                        .allowsHitTesting(false)
                        .zIndex(2)
                }
            }
        }
        .onAppear {
            textComplete = reduceMotion || !gameOptions.typewriterEnabled
            withAnimation(.easeOut(duration: gameOptions.pageTransitionsEnabled && !reduceMotion ? 0.45 : 0.05)) { appeared = true }
        }
        .onDisappear { appeared = false; textComplete = false }
    }

    private var transitionStyle: StoryTransitionStyle { (reduceMotion || !gameOptions.pageTransitionsEnabled) ? .sandFade : StoryPageEffects.standard.entryTransition }
    private var typewriterReadinessIdentifier: String { choicesVisible ? "anubis-typewriter-complete" : "anubis-typewriter-pending" }
    private var choicesVisible: Bool { textComplete || reduceMotion || !gameOptions.typewriterEnabled }
}

struct TrialOfAnubisChoiceButton: View {
    let nodeID: TrialOfAnubisRoute
    let choice: TrialOfAnubisChoice
    @EnvironmentObject private var nav: TrialOfAnubisNavigationState

    var body: some View {
        ChoiceButton(accessibilityTitle, action: {
            nav.selectChoice(choice)
        })
        .accessibilityLabel(accessibilityTitle)
        .accessibilityIdentifier("anubis-choice-\(nodeID.rawValue)-\(choice.title.slugifiedAccessibilityID)")
    }

    private var accessibilityTitle: String {
        [choice.title, choice.detail].compactMap { $0 }.joined(separator: ". ")
    }
}
struct TrialOfAnubisStatusView: View { let state: TrialOfAnubisState; var body: some View { VStack(alignment: .leading, spacing: 6) { Text("Heart: \(heart)"); Text("Memories: \(max(0,state.memoriesRemaining)) / 3"); Text("Sacred Scale Pieces: \(pieces) / 3"); if !items.isEmpty { Text("Items: \(items.joined(separator: ", "))") } }.font(.caption.weight(.semibold)).foregroundColor(AppTheme.sand).frame(maxWidth: .infinity, alignment: .leading).goldCard(padding: 10).accessibilityLabel("\(heart). Memories \(max(0,state.memoriesRemaining)) of 3. Sacred Scale Pieces \(pieces) of 3. \(items.isEmpty ? "No major items held" : "Items: \(items.joined(separator: ", "))")") }
    private var heart: String { state.heartWeight <= -3 ? "Light Heart" : (state.heartWeight >= 3 ? "Heavy Heart" : "Balanced Heart") }
    private var pieces: Int { [state.firstScalePieceRecovered,state.secondScalePieceRecovered,state.finalScalePieceRecovered].filter{$0}.count }
    private var items: [String] { var a:[String]=[]; if state.tookGoldenScarab { a.append("Golden Scarab") }; if state.possessesAmmitFang { a.append("Fang of Ammit") }; if state.acceptedUnderworldPower { a.append("Underworld Power") }; if state.learnedTrueName { a.append("Hidden Title of Anubis") }; return a }
}
struct TrialOfAnubisFeedbackBanner: View { let feedback: TrialOfAnubisFeedback; var body: some View { Text(feedback.message).font(.callout.weight(.semibold)).foregroundColor(Color(hex: "1E140B")).padding(12).background(Capsule().fill(AppTheme.gold)).accessibilityAddTraits(.updatesFrequently).accessibilityLabel(feedback.message) } }
struct TrialOfAnubisPlaceholderCard: View {
    let imageName: String
    let title: String

    var body: some View {
        ZStack {
            if let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                LinearGradient(colors: [Color(hex: "1A120C"), Color(hex: "3A2811")], startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack(spacing: 10) {
                    Image(systemName: "scalemass.fill")
                        .font(.system(size: 42))
                        .foregroundColor(AppTheme.gold)
                    Text(imageName)
                        .font(.caption.weight(.semibold))
                        .foregroundColor(AppTheme.mutedText)
                    Text(title)
                        .font(.system(.headline, design: .serif))
                        .foregroundColor(AppTheme.gold)
                }
            }
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.imageRadius))
        .overlay(RoundedRectangle(cornerRadius: AppTheme.imageRadius).stroke(AppTheme.gold.opacity(0.55), lineWidth: 1))
        .accessibilityHidden(true)
    }
}

struct ANU028View: View { @EnvironmentObject private var nav: TrialOfAnubisNavigationState; var body: some View { ZStack { EgyptianBackground(); VStack(spacing: 16) { Image(systemName: "scalemass.fill").font(.system(size: 58)).foregroundColor(AppTheme.gold); Text("Judgment Begins").font(.system(.largeTitle, design: .serif).weight(.bold)).foregroundColor(AppTheme.gold); Text("The restored scales read the full weight of your journey.").foregroundColor(AppTheme.warmText).multilineTextAlignment(.center).goldCard() }.padding(AppTheme.screenPadding) }.task { nav.resolveEndingIfNeeded() }.accessibilityLabel("Judgment begins. The restored scales read the full weight of your journey.") } }
