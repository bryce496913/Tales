import SwiftUI

typealias StoryPageView<Content: View> = StoryPageLayout<Content>
typealias StoryImageView = StaticStoryImage
typealias TypewriterTextView = TypewriterText

struct StaticStoryImage: View {
    let imageName: String

    var body: some View {
        storyImage
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .aspectRatio(16/10, contentMode: .fill)
            .clipped()
            .background(AppTheme.cardAlt)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous).stroke(AppTheme.gold.opacity(0.55), lineWidth: 1))
            .shadow(color: AppTheme.shadow, radius: 18, x: 0, y: 10)
            .accessibilityLabel("Story illustration")
    }

    private var storyImage: Image {
        let nameWithoutExtension = (imageName as NSString).deletingPathExtension

        if let uiImage = UIImage(named: imageName) ?? UIImage(named: nameWithoutExtension) {
            return Image(uiImage: uiImage)
        }

        if let imageURL = Bundle.main.url(forResource: nameWithoutExtension, withExtension: "png"),
           let uiImage = UIImage(contentsOfFile: imageURL.path) {
            return Image(uiImage: uiImage)
        }

        return Image(imageName)
    }
}

struct StoryPageLayout<Content: View>: View {
    let imageName: String
    let title: String?
    let text: String
    var effects: StoryPageEffects
    @ViewBuilder let choices: Content
    @State private var appeared = false
    @State private var textComplete = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @EnvironmentObject private var gameOptions: GameOptions

    init(imageName: String, title: String? = nil, text: String, effects: StoryPageEffects = .standard, @ViewBuilder choices: () -> Content) {
        self.imageName = imageName; self.title = title; self.text = text; self.effects = effects; self.choices = choices()
    }

    var body: some View {
        StoryTransitionContainer(style: transitionStyle) {
            ZStack {
                EgyptianBackground().ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        StaticStoryImage(imageName: imageName)
                        VStack(alignment: .leading, spacing: 12) {
                            if let title { Text(title).font(.system(.title2, design: .serif).weight(.bold)).foregroundColor(AppTheme.gold) }
                            TypewriterText(text: text, speed: gameOptions.typewriterSpeed.speed, startDelay: reduceMotion ? 0 : 0.45, isEnabled: gameOptions.typewriterEnabled && !reduceMotion) { textComplete = true }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .goldCard()
                        .contentShape(Rectangle())
                        VStack(spacing: 12) { choices }
                            .frame(maxWidth: .infinity)
                            .opacity(choicesVisible ? 1 : 0)
                            .disabled(!choicesVisible)
                            .animation(.easeOut(duration: gameOptions.pageTransitionsEnabled && !reduceMotion ? 0.3 : 0.05), value: choicesVisible)
                    }
                    .padding(.horizontal, AppTheme.screenPadding).padding(.top, 18).padding(.bottom, 24)
                    .opacity(appeared ? 1 : 0).offset(y: appeared ? 0 : 10)
                }.zIndex(1)
            }
        }
        .onAppear {
            textComplete = reduceMotion || !gameOptions.typewriterEnabled || !effects.choicesWaitForText
            withAnimation(.easeOut(duration: gameOptions.pageTransitionsEnabled && !reduceMotion ? 0.45 : 0.05)) { appeared = true }
        }
        .onDisappear { appeared = false; textComplete = false }
    }
    private var transitionStyle: StoryTransitionStyle { (reduceMotion || !gameOptions.pageTransitionsEnabled) ? .sandFade : effects.entryTransition }
    private var choicesVisible: Bool { !effects.choicesWaitForText || textComplete || reduceMotion || !gameOptions.typewriterEnabled }
}
