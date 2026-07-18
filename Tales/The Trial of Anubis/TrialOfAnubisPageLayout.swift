import SwiftUI
import UIKit

struct TrialOfAnubisPageEffects {
    let entryTransition: TrialOfAnubisTransitionStyle
    let choicesWaitForText: Bool

    static let standard = TrialOfAnubisPageEffects(
        entryTransition: .sandFade,
        choicesWaitForText: true
    )
}

struct TrialOfAnubisPageLayout<Choices: View>: View {
    let imageName: String
    let title: String
    let text: String
    var effects: TrialOfAnubisPageEffects = .standard
    @ViewBuilder let choices: Choices

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var textComplete = false

    init(
        imageName: String,
        title: String,
        text: String,
        effects: TrialOfAnubisPageEffects = .standard,
        @ViewBuilder choices: () -> Choices
    ) {
        self.imageName = imageName
        self.title = title
        self.text = text
        self.effects = effects
        self.choices = choices()
    }

    var body: some View {
        TrialOfAnubisTransitionContainer(style: effects.entryTransition) {
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
                                .accessibilityAddTraits(.isHeader)

                            TrialOfAnubisTypewriterText(text: text, startDelay: reduceMotion ? 0 : 0.25) {
                                textComplete = true
                            }
                        }
                        .goldCard()
                        .frame(maxWidth: AppTheme.maximumTextWidth)

                        if choicesVisible {
                            VStack(spacing: 12) {
                                choices
                            }
                            .frame(maxWidth: AppTheme.maximumButtonWidth)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                        }
                    }
                    .padding(AppTheme.screenPadding)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .onAppear { resetPresentationState() }
        .onChange(of: text) { _ in resetPresentationState() }
        .onChange(of: reduceMotion) { _ in resetPresentationState() }
        .onDisappear { textComplete = false }
        .animation(.easeOut(duration: reduceMotion ? 0.05 : 0.25), value: choicesVisible)
    }

    private var choicesVisible: Bool {
        reduceMotion || !effects.choicesWaitForText || textComplete
    }

    private func resetPresentationState() {
        textComplete = reduceMotion || !effects.choicesWaitForText
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
        .accessibilityLabel("Story illustration")
    }
}

struct TrialOfAnubisPageLayout_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TrialOfAnubisPreviewContainer {
                TrialOfAnubisPageLayout(
                    imageName: "ANU001.png",
                    title: "The Silent Desert",
                    text: "The desert is completely silent.",
                    effects: TrialOfAnubisPageEffects(entryTransition: .sandFade, choicesWaitForText: true)
                ) {
                    TrialOfAnubisChoicesStack {
                        TrialOfAnubisNavigationButton(title: "Approach the black doorway", destination: .anu002)
                        TrialOfAnubisNavigationButton(title: "Walk away into the desert", destination: .anu003)
                    }
                }
            }
            .previewDisplayName("Before text completion")

            TrialOfAnubisPreviewContainer {
                TrialOfAnubisPageLayout(
                    imageName: "ANU001.png",
                    title: "The Silent Desert",
                    text: "The desert is completely silent.",
                    effects: TrialOfAnubisPageEffects(entryTransition: .sandFade, choicesWaitForText: false)
                ) {
                    TrialOfAnubisChoicesStack {
                        TrialOfAnubisNavigationButton(title: "Approach the black doorway", destination: .anu002)
                        TrialOfAnubisNavigationButton(title: "Walk away into the desert", destination: .anu003)
                    }
                }
            }
            .previewDisplayName("After text completion")
        }
    }
}
