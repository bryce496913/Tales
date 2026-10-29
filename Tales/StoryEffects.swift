import SwiftUI

enum StoryTransitionStyle: Equatable { case sandFade, torchReveal, stoneDoor }
enum TypewriterSpeed: Equatable { case slow, normal, fast
    var delay: UInt64 { switch self { case .slow: 70_000_000; case .normal: 42_000_000; case .fast: 24_000_000 } }
    var batch: Int { switch self { case .slow: 1; case .normal: 2; case .fast: 3 } }
}

struct StoryPageEffects {
    var entryTransition: StoryTransitionStyle = .sandFade
    var choicesWaitForText: Bool = true

    static let standard = StoryPageEffects()
}

final class HapticManager {
    static let shared = HapticManager(); private init() {}
    private var hapticsEnabled: Bool { UserDefaults.standard.object(forKey: "Tales.hapticsEnabled") as? Bool ?? true }
    func playChoiceTap() { guard hapticsEnabled else { return }; UIImpactFeedbackGenerator(style: .medium).impactOccurred() }
    func playWin() { guard hapticsEnabled else { return }; UINotificationFeedbackGenerator().notificationOccurred(.success) }
    func playLose() { guard hapticsEnabled else { return }; UINotificationFeedbackGenerator().notificationOccurred(.warning) }
    func playDeath() { guard hapticsEnabled else { return }; UINotificationFeedbackGenerator().notificationOccurred(.error) }
}
