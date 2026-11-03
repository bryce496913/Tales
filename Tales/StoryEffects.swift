import SwiftUI

enum TypewriterSpeed: Equatable {
    case slow, normal, fast

    var delay: UInt64 {
        switch self {
        case .slow: return 70_000_000
        case .normal: return 42_000_000
        case .fast: return 24_000_000
        }
    }

    var batch: Int {
        switch self {
        case .slow: return 1
        case .normal: return 2
        case .fast: return 3
        }
    }
}

enum StoryHaptic {
    case success, warning, error
}

/// Plays haptics. `GameOptions` keeps `isEnabled` in sync with the Haptics setting, so this
/// never reads preferences itself.
final class HapticManager {
    static let shared = HapticManager()

    var isEnabled = true

    private init() {}

    func playChoiceTap() {
        guard isEnabled else { return }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    func play(_ haptic: StoryHaptic) {
        guard isEnabled else { return }
        let type: UINotificationFeedbackGenerator.FeedbackType
        switch haptic {
        case .success: type = .success
        case .warning: type = .warning
        case .error: type = .error
        }
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
}
