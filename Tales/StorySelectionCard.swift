import SwiftUI
import UIKit

struct StorySelectionCard: View {
    let story: StorySelectionItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                StorySelectionArtworkImage(
                    imageName: story.iconImageName,
                    contentMode: .fill,
                    fallbackSystemImageName: "book.closed.fill"
                )
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: 190)
                .clipped()
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 22,
                        style: .continuous
                    )
                )
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 22,
                        style: .continuous
                    )
                    .stroke(
                        AppTheme.gold.opacity(0.55),
                        lineWidth: 1
                    )
                )
                .shadow(color: AppTheme.shadow, radius: 8, x: 0, y: 5)
                .accessibilityHidden(true)

                Text(story.title)
                    .font(
                        .system(
                            .subheadline,
                            design: .serif
                        )
                        .weight(.semibold)
                    )
                    .foregroundColor(AppTheme.gold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                Text(story.statusText)
                    .font(.caption2.weight(.bold))
                    .foregroundColor(AppTheme.mutedText)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(
                        Capsule()
                            .stroke(AppTheme.gold.opacity(0.35), lineWidth: 1)
                    )
            }
            .frame(
                maxWidth: .infinity,
                alignment: .top
            )
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(
            "\(story.title), \(story.statusText)"
        )
        .accessibilityHint(
            "Opens story details."
        )
    }
}

struct StorySelectionArtworkImage: View {
    let imageName: String
    let contentMode: ContentMode
    let fallbackSystemImageName: String

    var body: some View {
        if let image = UIImage.storySelectionImage(named: imageName) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } else {
            fallback
                .onAppear {
                    assertionFailure("Missing story selection image: \(imageName)")
                }
        }
    }

    private var fallback: some View {
        ZStack {
            LinearGradient(
                colors: [AppTheme.cardAlt, AppTheme.backgroundTop, AppTheme.backgroundBottom],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(systemName: fallbackSystemImageName)
                .font(.system(size: 42, weight: .semibold))
                .foregroundColor(AppTheme.gold)
        }
    }
}

private extension UIImage {
    static func storySelectionImage(named imageName: String) -> UIImage? {
        if let image = UIImage(named: imageName) {
            return image
        }

        let nameWithoutExtension = (imageName as NSString).deletingPathExtension
        guard nameWithoutExtension != imageName else {
            return nil
        }

        return UIImage(named: nameWithoutExtension)
    }
}

struct StorySelectionCard_Previews: PreviewProvider {
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
            preview(for: sphinxStory)
                .previewDisplayName("Sphinx icon tile")
                .previewDevice("iPhone SE (3rd generation)")

            preview(for: anubisStory)
                .previewDisplayName("Anubis icon tile")
                .previewDevice("iPhone 15 Pro Max")
        }
    }

    private static func preview(for story: StorySelectionItem) -> some View {
        ZStack {
            EgyptianBackground()
            StorySelectionCard(story: story) {}
                .frame(width: 150)
                .padding()
        }
    }
}
