import AVFoundation

/// Loops the app-wide background ambience. Uses the `.ambient` session so it
/// respects the silent switch and mixes with the player's own music.
@MainActor
final class AmbiencePlayer {
    static let shared = AmbiencePlayer()

    private static let resourceName = "TalesAmbience"
    private static let volume: Float = 0.3
    private static let fadeDuration: TimeInterval = 1.5

    private var player: AVAudioPlayer?
    private var stopTask: Task<Void, Never>?

    private init() {}

    func setPlaying(_ playing: Bool) {
        playing ? start() : stop()
    }

    private func start() {
        stopTask?.cancel()
        stopTask = nil
        guard let player = player ?? makePlayer() else { return }
        if !player.isPlaying {
            player.volume = 0
            player.play()
        }
        player.setVolume(Self.volume, fadeDuration: Self.fadeDuration)
    }

    private func stop() {
        guard let player, player.isPlaying, stopTask == nil else { return }
        player.setVolume(0, fadeDuration: Self.fadeDuration)
        stopTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: UInt64(Self.fadeDuration * 1_000_000_000))
            guard !Task.isCancelled else { return }
            self?.player?.pause()
            self?.stopTask = nil
        }
    }

    private func makePlayer() -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: Self.resourceName, withExtension: "m4a") else { return nil }
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.numberOfLoops = -1
        player?.prepareToPlay()
        self.player = player
        return player
    }
}
