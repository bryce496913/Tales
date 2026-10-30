import SwiftUI

enum TypewriterSpeedOption: String, CaseIterable, Identifiable {
    case slow, normal, fast
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var speed: TypewriterSpeed { switch self { case .slow: return .slow; case .normal: return .normal; case .fast: return .fast } }
}

@MainActor
final class GameOptions: ObservableObject {
    private enum Key {
        static let typewriterEnabled = "Tales.typewriterEnabled"
        static let typewriterSpeed = "Tales.typewriterSpeed"
        static let hapticsEnabled = "Tales.hapticsEnabled"
        static let pageTransitionsEnabled = "Tales.pageTransitionsEnabled"
        static let buttonGlowEnabled = "Tales.buttonGlowEnabled"
        static let outcomeAnimationsEnabled = "Tales.outcomeAnimationsEnabled"
        static let backgroundMusicEnabled = "Tales.backgroundMusicEnabled"
    }

    @Published var typewriterEnabled: Bool { didSet { defaults.set(typewriterEnabled, forKey: Key.typewriterEnabled) } }
    @Published var typewriterSpeed: TypewriterSpeedOption { didSet { defaults.set(typewriterSpeed.rawValue, forKey: Key.typewriterSpeed) } }
    @Published var hapticsEnabled: Bool { didSet { defaults.set(hapticsEnabled, forKey: Key.hapticsEnabled) } }
    @Published var pageTransitionsEnabled: Bool { didSet { defaults.set(pageTransitionsEnabled, forKey: Key.pageTransitionsEnabled) } }
    @Published var buttonGlowEnabled: Bool { didSet { defaults.set(buttonGlowEnabled, forKey: Key.buttonGlowEnabled) } }
    @Published var outcomeAnimationsEnabled: Bool { didSet { defaults.set(outcomeAnimationsEnabled, forKey: Key.outcomeAnimationsEnabled) } }
    @Published var backgroundMusicEnabled: Bool { didSet { defaults.set(backgroundMusicEnabled, forKey: Key.backgroundMusicEnabled) } }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        typewriterEnabled = defaults.object(forKey: Key.typewriterEnabled) as? Bool ?? true
        typewriterSpeed = TypewriterSpeedOption(rawValue: defaults.string(forKey: Key.typewriterSpeed) ?? "") ?? .normal
        hapticsEnabled = defaults.object(forKey: Key.hapticsEnabled) as? Bool ?? true
        pageTransitionsEnabled = defaults.object(forKey: Key.pageTransitionsEnabled) as? Bool ?? true
        buttonGlowEnabled = defaults.object(forKey: Key.buttonGlowEnabled) as? Bool ?? true
        outcomeAnimationsEnabled = defaults.object(forKey: Key.outcomeAnimationsEnabled) as? Bool ?? true
        backgroundMusicEnabled = defaults.object(forKey: Key.backgroundMusicEnabled) as? Bool ?? true
    }

    func resetToDefaults() {
        typewriterEnabled = true
        typewriterSpeed = .normal
        hapticsEnabled = true
        pageTransitionsEnabled = true
        buttonGlowEnabled = true
        outcomeAnimationsEnabled = true
        backgroundMusicEnabled = true
    }
}
