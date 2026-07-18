import SwiftUI
import UIKit

struct TrialOfAnubisPageLayout<Choices: View>: View {
    let imageName: String
    let title: String
    let text: String
    @ViewBuilder let choices: Choices

    var body: some View {
        ZStack {
            EgyptianBackground()

            ScrollView {
                VStack(spacing: 18) {
                    TrialOfAnubisStaticImage(imageName: imageName)
                        .frame(maxWidth: AppTheme.maximumStoryContentWidth)

                    VStack(alignment: .leading, spacing: 14) {
                        Text(title)
                            .font(.system(.largeTitle, design: .serif).weight(.bold))
                            .foregroundColor(AppTheme.gold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)

                        Text(text)
                            .font(.system(.body, design: .serif))
                            .foregroundColor(AppTheme.warmText)
                            .lineSpacing(5)
                    }
                    .goldCard()
                    .frame(maxWidth: AppTheme.maximumTextWidth)

                    choices
                        .frame(maxWidth: AppTheme.maximumButtonWidth)
                }
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct TrialOfAnubisChoicesStack<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 12) { content }
            VStack(spacing: 12) { content }
        }
    }
}

struct TrialOfAnubisStaticImage: View {
    let imageName: String

    var body: some View {
        Group {
            if let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous)
                        .fill(AppTheme.cardAlt)
                    VStack(spacing: 8) {
                        Image(systemName: "scalemass.fill")
                            .font(.system(size: 42, weight: .semibold))
                        Text("Anubis image unavailable")
                            .font(.system(.headline, design: .serif))
                        Text(imageName)
                            .font(.system(.caption, design: .monospaced))
                    }
                    .foregroundColor(AppTheme.gold)
                    .padding()
                }
                .aspectRatio(16 / 9, contentMode: .fit)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous).stroke(AppTheme.gold.opacity(0.55), lineWidth: 1))
        .shadow(color: AppTheme.shadow, radius: 18, x: 0, y: 10)
    }
}

struct TrialOfAnubisPageLayout_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            TrialOfAnubisPageLayout(
                imageName: "ANU001.png",
                title: "The Silent Desert",
                text: "The desert is completely silent."
            ) {
                TrialOfAnubisChoicesStack {
                    TrialOfAnubisNavigationButton(title: "Approach the black doorway", destination: .anu002)
                    TrialOfAnubisNavigationButton(title: "Walk away into the desert", destination: .anu003)
                }
            }
        }
    }
}
