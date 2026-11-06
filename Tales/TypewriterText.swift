import SwiftUI

/// Story text that types itself out. Tap (or use the accessibility action) to reveal it all at once.
/// Shows the full text immediately when the typewriter is off or Reduce Motion is on.
struct TypewriterText: View {
    let text: String
    var speed: TypewriterSpeed = .normal
    var startDelay: TimeInterval = 0.25
    var isEnabled: Bool = true
    var onComplete: (() -> Void)? = nil

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.storyTheme) private var theme
    @State private var visibleText = ""
    @State private var typingTask: Task<Void, Never>?
    @State private var didComplete = false

    var body: some View {
        Text(showsFullText ? text : visibleText)
            .font(.system(.body, design: .serif))
            .foregroundColor(theme.text)
            .lineSpacing(6)
            .fixedSize(horizontal: false, vertical: true)
            .contentShape(Rectangle())
            .accessibilityLabel(Text(text))
            .accessibilityAction(named: Text("Reveal full text")) { complete(showing: text) }
            .onTapGesture { complete(showing: text) }
            .onAppear { start(text: text, isEnabled: isEnabled, reduceMotion: reduceMotion) }
            .onDisappear { cancelTyping() }
            // Pass each new value along: inside these closures the view's own properties can
            // still hold the values from before the change.
            .onChange(of: text) { newText in start(text: newText, isEnabled: isEnabled, reduceMotion: reduceMotion) }
            .onChange(of: reduceMotion) { newValue in start(text: text, isEnabled: isEnabled, reduceMotion: newValue) }
            .onChange(of: isEnabled) { newValue in start(text: text, isEnabled: newValue, reduceMotion: reduceMotion) }
    }

    private var showsFullText: Bool {
        reduceMotion || !isEnabled || didComplete
    }

    private func start(text: String, isEnabled: Bool, reduceMotion: Bool) {
        cancelTyping()
        didComplete = false
        visibleText = ""

        guard isEnabled, !reduceMotion else {
            complete(showing: text)
            return
        }

        let characters = Array(text)
        let speed = speed
        let startDelay = startDelay
        typingTask = Task { @MainActor in
            if startDelay > 0 {
                try? await Task.sleep(nanoseconds: UInt64(startDelay * 1_000_000_000))
            }
            var index = 0
            while index < characters.count && !Task.isCancelled {
                index = min(characters.count, index + speed.batch)
                visibleText = String(characters.prefix(index))
                try? await Task.sleep(nanoseconds: speed.delay)
            }
            guard !Task.isCancelled else { return }
            complete(showing: text)
        }
    }

    private func cancelTyping() {
        typingTask?.cancel()
        typingTask = nil
    }

    private func complete(showing text: String) {
        cancelTyping()
        visibleText = text
        guard !didComplete else { return }
        didComplete = true
        onComplete?()
    }
}
