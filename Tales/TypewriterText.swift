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
            .accessibilityAction(named: Text("Reveal full text")) { complete() }
            .onTapGesture { complete() }
            .onAppear { start() }
            .onDisappear { cancelTyping() }
            .onChange(of: text) { _ in start() }
            .onChange(of: reduceMotion) { _ in start() }
            .onChange(of: isEnabled) { _ in start() }
    }

    private var showsFullText: Bool {
        reduceMotion || !isEnabled || didComplete
    }

    private func start() {
        cancelTyping()
        didComplete = false
        visibleText = ""

        guard isEnabled, !reduceMotion else {
            complete()
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
            complete()
        }
    }

    private func cancelTyping() {
        typingTask?.cancel()
        typingTask = nil
    }

    private func complete() {
        cancelTyping()
        visibleText = text
        guard !didComplete else { return }
        didComplete = true
        onComplete?()
    }
}
