import SwiftUI

struct StorySelectionItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let statusText: String
    let iconImageName: String
    let titleImageName: String
    let actionTitle: String
}

struct StorySelectionView: View {
    let openSphinx: () -> Void
    let openAnubis: () -> Void
    let returnToMainMenu: () -> Void

    @State private var selectedStory: StorySelectionItem?

    private let columns = [
        GridItem(
            .flexible(),
            spacing: 16
        ),
        GridItem(
            .flexible(),
            spacing: 16
        )
    ]

    private let stories = [
        StorySelectionItem(
            id: "tales-from-the-sphinx",
            title: "Tales From the Sphinx",
            subtitle: "An Egyptian adventure of mystery, treasure, and danger.",
            statusText: "Available",
            iconImageName: "Icon.png",
            titleImageName: "Title-Screen-Art.png",
            actionTitle: "Open Story"
        ),
        StorySelectionItem(
            id: "the-trial-of-anubis",
            title: "The Trial of Anubis",
            subtitle: "Enter the Egyptian underworld, recover the sacred scales, and face the final judgment of your heart.",
            statusText: "Coming Soon",
            iconImageName: "ANU-Icon.png",
            titleImageName: "ANU-Title-Screen-Art.png",
            actionTitle: "Open Story"
        )
    ]

    var body: some View {
        ZStack {
            EgyptianBackground()

            ScrollView {
                VStack(spacing: 18) {
                    header
                        .padding(.top, 12)
                        .padding(.horizontal, AppTheme.screenPadding)

                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 20
                    ) {
                        ForEach(stories) { story in
                            StorySelectionCard(story: story) {
                                selectedStory = story
                            }
                        }
                    }
                    .frame(maxWidth: 440)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, AppTheme.screenPadding)

                    MenuButton(title: "Main Menu") {
                        returnToMainMenu()
                    }
                    .accessibilityLabel("Main Menu")
                    .accessibilityHint("Returns to the Tales main menu.")
                    .padding(.top, 2)
                    .padding(.bottom, AppTheme.screenPadding)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .sheet(item: $selectedStory) { story in
            StorySelectionDetailView(
                story: story,
                openStory: {
                    openSelectedStory(story)
                }
            )
            .presentationDetents([
                .medium,
                .large
            ])
            .presentationDragIndicator(.visible)
        }
    }

    private var header: some View {
        VStack(spacing: 6) {
            Text("Pick a Story")
                .font(
                    .system(
                        .largeTitle,
                        design: .serif
                    )
                    .weight(.bold)
                )
                .foregroundColor(AppTheme.gold)

            Text("Choose an adventure to learn more.")
                .font(
                    .system(
                        .subheadline,
                        design: .serif
                    )
                )
                .foregroundColor(AppTheme.mutedText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: AppTheme.maximumTextWidth)
    }

    private func openSelectedStory(
        _ story: StorySelectionItem
    ) {
        selectedStory = nil

        DispatchQueue.main.async {
            switch story.id {
            case "tales-from-the-sphinx":
                openSphinx()

            case "the-trial-of-anubis":
                openAnubis()

            default:
                assertionFailure(
                    "Unknown story selection: \(story.id)"
                )
            }
        }
    }
}

struct StorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StorySelectionView(openSphinx: {}, openAnubis: {}, returnToMainMenu: {})
                .previewDisplayName("Two-column grid - iPhone SE")
                .previewDevice("iPhone SE (3rd generation)")

            StorySelectionView(openSphinx: {}, openAnubis: {}, returnToMainMenu: {})
                .previewDisplayName("Two-column grid - large iPhone")
                .previewDevice("iPhone 15 Pro Max")

            StorySelectionView(openSphinx: {}, openAnubis: {}, returnToMainMenu: {})
                .previewDisplayName("Two-column grid - iPad portrait")
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewInterfaceOrientation(.portrait)
        }
    }
}
