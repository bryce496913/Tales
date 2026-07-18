import SwiftUI

struct TypewriterText: View {
    let text: String
    var speed: TypewriterSpeed = .normal
    var startDelay: TimeInterval = 0.25
    var isEnabled: Bool = true
    var onComplete: (() -> Void)? = nil
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var visible = ""
    @State private var task: Task<Void, Never>?
    @State private var didComplete = false

    var body: some View {
        Text(displayText)
            .font(.system(.body, design: .serif))
            .foregroundColor(AppTheme.warmText)
            .lineSpacing(6)
            .fixedSize(horizontal: false, vertical: true)
            .contentShape(Rectangle())
            .accessibilityLabel(Text(text))
            .accessibilityValue(Text(""))
            .onTapGesture { completeNow() }
            .onAppear { start() }
            .onDisappear { task?.cancel(); task = nil }
            .onChange(of: text) { _ in start() }
            .onChange(of: reduceMotion) { _ in start() }
    }
    private var displayText: String { (reduceMotion || !isEnabled) ? text : visible }
    private func start() {
        task?.cancel()
        didComplete = false
        if reduceMotion || !isEnabled {
            visible = text
            completeOnce()
            return
        }
        visible = ""
        task = Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(startDelay * 1_000_000_000))
            let chars = Array(text); var index = 0
            while index < chars.count && !Task.isCancelled {
                index = min(chars.count, index + speed.batch)
                visible = String(chars.prefix(index))
                try? await Task.sleep(nanoseconds: speed.delay)
            }
            if !Task.isCancelled {
                visible = text
                completeOnce()
            }
        }
    }

    private func completeNow() {
        task?.cancel()
        task = nil
        visible = text
        completeOnce()
    }

    private func completeOnce() {
        guard !didComplete else { return }
        didComplete = true
        onComplete?()
    }
}
