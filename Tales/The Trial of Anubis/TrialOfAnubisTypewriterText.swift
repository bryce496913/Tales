import SwiftUI

struct TrialOfAnubisTypewriterText: View {
    let text: String
    var speed: TrialOfAnubisTypewriterSpeed = .normal
    var startDelay: TimeInterval = 0.25
    var onComplete: (() -> Void)? = nil

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var visibleText = ""
    @State private var typingTask: Task<Void, Never>?
    @State private var didComplete = false
    @State private var currentText = ""

    var body: some View {
        Text(reduceMotion ? text : visibleText)
            .font(.system(.body, design: .serif))
            .foregroundColor(AppTheme.warmText)
            .lineSpacing(5)
            .fixedSize(horizontal: false, vertical: true)
            .contentShape(Rectangle())
            .accessibilityLabel(Text(text))
            .accessibilityValue(Text(didComplete ? "Complete" : "Revealing text"))
            .accessibilityAction(named: Text("Reveal full text")) { completeOnce() }
            .onTapGesture { completeOnce() }
            .onAppear { startIfNeeded(forceRestart: true) }
            .onDisappear { cancelTyping() }
            .onChange(of: text) { _ in startIfNeeded(forceRestart: true) }
            .onChange(of: reduceMotion) { _ in startIfNeeded(forceRestart: true) }
    }

    private func startIfNeeded(forceRestart: Bool = false) {
        if forceRestart || currentText != text {
            currentText = text
            didComplete = false
            visibleText = ""
        }
        typingTask?.cancel()

        guard !reduceMotion else {
            completeOnce()
            return
        }

        typingTask = Task { @MainActor in
            if startDelay > 0 {
                try? await Task.sleep(nanoseconds: UInt64(startDelay * 1_000_000_000))
            }
            guard !Task.isCancelled else { return }

            let characters = Array(text)
            var index = 0
            while index < characters.count && !Task.isCancelled {
                index = min(characters.count, index + speed.batchSize)
                visibleText = String(characters.prefix(index))
                try? await Task.sleep(nanoseconds: speed.delay)
            }

            guard !Task.isCancelled else { return }
            completeOnce()
        }
    }

    private func cancelTyping() {
        typingTask?.cancel()
        typingTask = nil
    }

    private func completeOnce() {
        visibleText = text
        typingTask?.cancel()
        typingTask = nil
        guard !didComplete else { return }
        didComplete = true
        onComplete?()
    }
}

struct TrialOfAnubisTypewriterText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TrialOfAnubisTypewriterText(
                text: "Anubis watches as the sentence slowly appears before judgment.",
                speed: .slow,
                startDelay: 1
            )
            .padding()
            .background(AppTheme.card)
            .previewDisplayName("Partial reveal")

            TrialOfAnubisTypewriterText(text: "Reduce Motion shows the full passage immediately.")
                .padding()
                .background(AppTheme.card)
                .environment(\.accessibilityReduceMotion, true)
                .previewDisplayName("Reduce Motion")
        }
    }
}
