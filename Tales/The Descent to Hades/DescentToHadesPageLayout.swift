import SwiftUI
import UIKit

enum DescentToHadesTransitionStyle: CaseIterable {
    case mistFade
    case torchReveal
    case bronzeGate
}

struct DescentToHadesPageEffects {
    let entryTransition: DescentToHadesTransitionStyle
    let choicesWaitForText: Bool

    static let standard = DescentToHadesPageEffects(
        entryTransition: .mistFade,
        choicesWaitForText: true
    )
}

struct DescentToHadesPageLayout<Choices: View>: View {
    let imageName: String
    let title: String
    let text: String
    var effects: DescentToHadesPageEffects = .standard
    @ViewBuilder let choices: Choices

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var textComplete = false

    init(
        imageName: String,
        title: String,
        text: String,
        effects: DescentToHadesPageEffects = .standard,
        @ViewBuilder choices: () -> Choices
    ) {
        self.imageName = imageName
        self.title = title
        self.text = text
        self.effects = effects
        self.choices = choices()
    }

    var body: some View {
        DescentToHadesTransitionContainer(style: effects.entryTransition) {
            ZStack {
                DescentToHadesBackground()

                ScrollView {
                    VStack(spacing: 18) {
                        DescentToHadesStaticImage(imageName: imageName)
                            .frame(maxWidth: AppTheme.maximumStoryContentWidth)

                        VStack(alignment: .leading, spacing: 14) {
                            Text(title)
                                .font(.system(.largeTitle, design: .serif).weight(.bold))
                                .foregroundColor(DescentToHadesTheme.bronze)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .multilineTextAlignment(.center)
                                .accessibilityAddTraits(.isHeader)

                            DescentToHadesTypewriterText(text: text, startDelay: reduceMotion ? 0 : 0.25) {
                                textComplete = true
                            }
                        }
                        .bronzeCard()
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

struct DescentToHadesChoicesStack<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 12) { content }
            VStack(spacing: 12) { content }
        }
    }
}

/// Shows a page illustration, or a placeholder until the art for that page has been added.
struct DescentToHadesStaticImage: View {
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
                        .fill(
                            LinearGradient(
                                colors: [DescentToHadesTheme.cardAlt, DescentToHadesTheme.backgroundBottom],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    VStack(spacing: 8) {
                        Image(systemName: "building.columns.fill")
                            .font(.system(size: 42, weight: .semibold))
                        Text("Illustration coming soon")
                            .font(.system(.headline, design: .serif))
                        Text(imageName)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(DescentToHadesTheme.mutedText)
                    }
                    .foregroundColor(DescentToHadesTheme.bronze)
                    .padding()
                }
                .aspectRatio(16 / 9, contentMode: .fit)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous).stroke(DescentToHadesTheme.bronze.opacity(0.55), lineWidth: 1))
        .shadow(color: DescentToHadesTheme.shadow, radius: 18, x: 0, y: 10)
        .accessibilityLabel("Story illustration")
    }
}

struct DescentToHadesPageLayout_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DescentToHadesPreviewContainer {
                DescentToHadesPageLayout(
                    imageName: "HDS001.png",
                    title: "The Sea Cave",
                    text: "You wake on a shelf of black stone inside a cave.",
                    effects: DescentToHadesPageEffects(entryTransition: .mistFade, choicesWaitForText: true)
                ) {
                    DescentToHadesChoicesStack {
                        DescentToHadesNavigationButton(title: "Go deeper", destination: .hds002)
                        DescentToHadesNavigationButton(title: "Swim for the light", destination: .hds003)
                    }
                }
            }
            .previewDisplayName("Before text completion")

            DescentToHadesPreviewContainer {
                DescentToHadesPageLayout(
                    imageName: "HDS001.png",
                    title: "The Sea Cave",
                    text: "You wake on a shelf of black stone inside a cave.",
                    effects: DescentToHadesPageEffects(entryTransition: .mistFade, choicesWaitForText: false)
                ) {
                    DescentToHadesChoicesStack {
                        DescentToHadesNavigationButton(title: "Go deeper", destination: .hds002)
                        DescentToHadesNavigationButton(title: "Swim for the light", destination: .hds003)
                    }
                }
            }
            .previewDisplayName("After text completion")
        }
    }
}
