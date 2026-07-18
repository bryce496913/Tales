import SwiftUI

struct StorySelectionDetailView: View {
    let story: StorySelectionItem
    let openStory: () -> Void

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {
        ZStack {
            EgyptianBackground()

            ScrollView {
                VStack(spacing: 18) {
                    StorySelectionArtworkImage(
                        imageName: story.titleImageName,
                        contentMode: .fit,
                        fallbackSystemImageName: "photo.on.rectangle.angled"
                    )
                    .frame(maxHeight: 240)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: AppTheme.imageRadius,
                            style: .continuous
                        )
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: AppTheme.imageRadius,
                            style: .continuous
                        )
                        .stroke(AppTheme.gold.opacity(0.45), lineWidth: 1)
                    )
                    .accessibilityHidden(true)

                    Text(story.title)
                        .font(.system(.title, design: .serif).weight(.bold))
                        .foregroundColor(AppTheme.gold)
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)

                    Text(story.statusText)
                        .font(.system(.caption, design: .serif).weight(.bold))
                        .foregroundColor(Color(hex: "1E140B"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Capsule().fill(AppTheme.gold))
                        .accessibilityLabel("Availability: \(story.statusText)")

                    Text(story.subtitle)
                        .font(.system(.body, design: .serif).weight(.medium))
                        .foregroundColor(AppTheme.warmText)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityLabel(story.subtitle)

                    MenuButton(title: story.actionTitle) {
                        openStory()
                    }
                    .accessibilityLabel("\(story.actionTitle): \(story.title)")
                    .accessibilityHint("Opens the selected story.")
                    .padding(.top, 4)

                    Button("Close") {
                        dismiss()
                    }
                    .font(.system(.headline, design: .serif).weight(.semibold))
                    .foregroundColor(AppTheme.gold)
                    .accessibilityLabel("Close story details")
                    .accessibilityHint("Returns to story selection without opening a story.")
                }
                .frame(maxWidth: 420)
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct StorySelectionDetailView_Previews: PreviewProvider {
    private static let sphinxStory = StorySelectionItem(
        id: "tales-from-the-sphinx",
        title: "Tales From the Sphinx",
        subtitle: "An Egyptian adventure of mystery, treasure, and danger.",
        statusText: "Available",
        iconImageName: "Icon.png",
        titleImageName: "Title-Screen-Art.png",
        actionTitle: "Open Story"
    )

    private static let anubisStory = StorySelectionItem(
        id: "the-trial-of-anubis",
        title: "The Trial of Anubis",
        subtitle: "Enter the Egyptian underworld, recover the sacred scales, and face the final judgment of your heart.",
        statusText: "Coming Soon",
        iconImageName: "ANU-Icon.png",
        titleImageName: "ANU-Title-Screen-Art.png",
        actionTitle: "Open Story"
    )

    static var previews: some View {
        Group {
            StorySelectionDetailView(story: sphinxStory, openStory: {})
                .previewDisplayName("Sphinx detail popout - iPhone SE")
                .previewDevice("iPhone SE (3rd generation)")

            StorySelectionDetailView(story: anubisStory, openStory: {})
                .previewDisplayName("Anubis detail popout - large iPhone")
                .previewDevice("iPhone 15 Pro Max")

            StorySelectionDetailView(story: sphinxStory, openStory: {})
                .previewDisplayName("Sphinx detail popout - iPad portrait")
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewInterfaceOrientation(.portrait)
        }
    }
}
