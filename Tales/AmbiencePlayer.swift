import AVFoundation

/// Loops the app-wide background ambience.
///
/// Uses the `.playback` category with `.mixWithOthers`, so the ambience plays even when the
/// ring/silent switch is on silent but still mixes with the player's own music. The Options
/// toggle is how players turn it off. All audio session work happens on a private serial
/// queue, because activating the session can block and must not stall the UI.
final class AmbiencePlayer {
    static let shared = AmbiencePlayer()

    private static let resourceName = "TalesAmbience"
    private static let volume: Float = 0.6
    private static let fadeDuration: TimeInterval = 1.5

    private let queue = DispatchQueue(label: "Tales.AmbiencePlayer")
    private var player: AVAudioPlayer?
    private var wantsPlayback = false
    private var fadeGeneration = 0

    private init() {
        let center = NotificationCenter.default
        center.addObserver(forName: AVAudioSession.interruptionNotification, object: nil, queue: nil) { [weak self] note in
            self?.handleInterruption(note)
        }
        center.addObserver(forName: AVAudioSession.mediaServicesWereResetNotification, object: nil, queue: nil) { [weak self] _ in
            self?.queue.async {
                self?.player = nil
                self?.refresh()
            }
        }
    }

    func setPlaying(_ playing: Bool) {
        queue.async {
            self.wantsPlayback = playing
            self.refresh()
        }
    }

    // MARK: - Queue only

    private func refresh() {
        wantsPlayback ? start() : stop()
    }

    private func start() {
        fadeGeneration += 1
        guard let player = player ?? makePlayer() else { return }

        // Activate every time: the session can be deactivated by the system while we are
        // in the background or after an interruption.
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
        } catch {
            print("AmbiencePlayer: could not activate audio session: \(error)")
            return
        }

        if !player.isPlaying {
            player.volume = 0
            guard player.play() else {
                print("AmbiencePlayer: playback did not start")
                return
            }
        }
        player.setVolume(Self.volume, fadeDuration: Self.fadeDuration)
    }

    private func stop() {
        guard let player, player.isPlaying else { return }
        player.setVolume(0, fadeDuration: Self.fadeDuration)

        fadeGeneration += 1
        let generation = fadeGeneration
        queue.asyncAfter(deadline: .now() + Self.fadeDuration) { [self] in
            guard generation == fadeGeneration, !wantsPlayback else { return }
            player.pause()
            try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        }
    }

    private func makePlayer() -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: Self.resourceName, withExtension: "m4a") else {
            print("AmbiencePlayer: \(Self.resourceName).m4a is missing from the app bundle")
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.prepareToPlay()
            self.player = player
            return player
        } catch {
            print("AmbiencePlayer: could not load \(Self.resourceName).m4a: \(error)")
            return nil
        }
    }

    private func handleInterruption(_ note: Notification) {
        // The system pauses the player when an interruption (call, Siri, alarm) begins;
        // pick the loop back up once it ends.
        guard let rawType = note.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt,
              AVAudioSession.InterruptionType(rawValue: rawType) == .ended else { return }
        queue.async { self.refresh() }
    }
}
