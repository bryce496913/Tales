import SwiftUI

struct StorySelectionItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let statusText: String
    let imageName: String?
    let systemImageName: String
    let actionTitle: String
}

struct StorySelectionView: View {
    let openSphinx: () -> Void
    let openAnubis: () -> Void
    let returnToMainMenu: () -> Void

    private let columns = [
        GridItem(
            .adaptive(
                minimum: 250,
                maximum: 360
            ),
            spacing: 18
        )
    ]

    private let stories = [
        StorySelectionItem(
            id: "tales-from-the-sphinx",
            title: "Tales From the Sphinx",
            subtitle: "An Egyptian adventure of mystery, treasure, and danger.",
            statusText: "Available",
            imageName: "Title-Screen-Art.png",
            systemImageName: "pyramid.fill",
            actionTitle: "Open Story"
        ),
        StorySelectionItem(
            id: "the-trial-of-anubis",
            title: "The Trial of Anubis",
            subtitle: "Enter the underworld and face the judgment of Anubis.",
            statusText: "Coming Soon",
            imageName: nil,
            systemImageName: "scalemass.fill",
            actionTitle: "View Story"
        )
    ]

    var body: some View {
        ZStack {
            EgyptianBackground()

            ScrollView {
                VStack(spacing: 24) {
                    header

                    LazyVGrid(columns: columns, alignment: .center, spacing: 18) {
                        ForEach(stories) { story in
                            StorySelectionCard(
                                title: story.title,
                                subtitle: story.subtitle,
                                statusText: story.statusText,
                                imageName: story.imageName,
                                systemImageName: story.systemImageName,
                                actionTitle: story.actionTitle
                            ) {
                                if story.id == "tales-from-the-sphinx" {
                                    openSphinx()
                                } else if story.id == "the-trial-of-anubis" {
                                    openAnubis()
                                }
                            }
                        }
                    }

                    MenuButton(title: "Main Menu") {
                        returnToMainMenu()
                    }
                    .accessibilityLabel("Main Menu")
                    .accessibilityHint("Returns to the Tales main menu.")
                    .padding(.top, 8)
                }
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            Text("Pick a Story")
                .font(.system(size: 40, weight: .bold, design: .serif))
                .foregroundColor(AppTheme.gold)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.75)

            Text("Every story offers a different journey, set of choices, and ending.")
                .font(.system(.body, design: .serif).weight(.medium))
                .foregroundColor(AppTheme.mutedText)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .goldCard()
        .frame(maxWidth: AppTheme.maximumTextWidth)
    }
}

struct StorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StorySelectionView(openSphinx: {}, openAnubis: {}, returnToMainMenu: {})
                .previewDevice("iPhone SE (3rd generation)")
            StorySelectionView(openSphinx: {}, openAnubis: {}, returnToMainMenu: {})
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
