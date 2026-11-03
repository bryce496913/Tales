import SwiftUI

/// The Trial of Anubis: its content types, menu copy, theme and save slot. Everything else
/// (navigation, pages, endings, menus) comes from the shared story engine.
enum TrialOfAnubis: BranchingStory {
    typealias Route = TrialOfAnubisRoute
    typealias Item = TrialOfAnubisItem
    typealias Flag = TrialOfAnubisStoryFlag
    typealias Outcome = TrialOfAnubisOutcome

    static let title = "The Trial of Anubis"
    static let shortName = "Anubis"
    static let subtitle = "Enter the Egyptian underworld, recover the sacred scales, and face the final judgment of your heart."
    static let titleImageName = "ANU-Title-Screen-Art"
    static let theme = StoryTheme.egyptian
    static let saveKey = "Tales.trial-of-anubis.progress.v2"

    static func destination(for route: TrialOfAnubisRoute) -> some View {
        TrialOfAnubisDestinationView(route: route)
    }
}

// Story-named entry points used by the page files.
typealias TrialOfAnubisRootView = BranchingStoryRootView<TrialOfAnubis>
typealias TrialOfAnubisNavigationState = BranchingStoryState<TrialOfAnubis>
typealias TrialOfAnubisNavigationButton = BranchingNavigationButton<TrialOfAnubis>
typealias TrialOfAnubisOutcomeView = BranchingOutcomeView<TrialOfAnubis>
typealias TrialOfAnubisPreviewContainer<Content: View> = BranchingPreviewContainer<TrialOfAnubis, Content>
typealias TrialOfAnubisPageLayout<Choices: View> = StoryPageLayout<Choices>
typealias TrialOfAnubisChoicesStack<Content: View> = StoryChoicesStack<Content>
typealias TrialOfAnubisPageEffects = StoryPageEffects
