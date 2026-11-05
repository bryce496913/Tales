import SwiftUI

/// How a page arrives. Stories use their own names for the same three effects.
enum StoryTransitionStyle: Equatable {
    case fade
    case torchReveal
    case doors

    static var sandFade: StoryTransitionStyle { .fade }
    static var mistFade: StoryTransitionStyle { .fade }
    static var stoneDoor: StoryTransitionStyle { .doors }
    static var bronzeGate: StoryTransitionStyle { .doors }
    static var inkFade: StoryTransitionStyle { .fade }
    static var shojiSlide: StoryTransitionStyle { .doors }
}

/// Plays a page's entry effect in the current story's colours. Skipped when Page Transitions is
/// off in Options; reduced to a brief dim when Reduce Motion is on.
struct StoryTransitionContainer<Content: View>: View {
    let style: StoryTransitionStyle
    @ViewBuilder let content: Content

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.storyTheme) private var theme
    @EnvironmentObject private var gameOptions: GameOptions
    @State private var progress: CGFloat = 0
    @State private var animationTask: Task<Void, Never>?

    var body: some View {
        ZStack {
            content
                .opacity(contentOpacity)
                .offset(y: contentOffset)

            if gameOptions.pageTransitionsEnabled {
                overlay
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }
        }
        .onAppear { runEntrance() }
        .onDisappear {
            animationTask?.cancel()
            animationTask = nil
            progress = 1
        }
        .onChange(of: style) { _ in runEntrance() }
    }

    private var contentOpacity: Double {
        guard gameOptions.pageTransitionsEnabled else { return 1 }
        return reduceMotion ? Double(max(0.65, progress)) : Double(max(0.2, progress))
    }

    private var contentOffset: CGFloat {
        guard gameOptions.pageTransitionsEnabled, !reduceMotion, style == .fade, progress < 1 else { return 0 }
        return theme.fadeTransitionOffset * (1 - progress)
    }

    @ViewBuilder private var overlay: some View {
        if progress < 1 {
            if reduceMotion {
                Color.black.opacity(Double(1 - progress) * 0.18)
                    .ignoresSafeArea()
            } else {
                switch style {
                case .fade:
                    LinearGradient(colors: theme.fadeTransitionColors, startPoint: .bottom, endPoint: .top)
                        .opacity(Double(1 - progress) * theme.fadeTransitionOpacity)
                        .ignoresSafeArea()
                case .torchReveal:
                    GeometryReader { proxy in
                        let endRadius = max(proxy.size.width, proxy.size.height) * (0.18 + 0.9 * progress)
                        Rectangle()
                            .fill(.black.opacity(Double(1 - progress) * 0.76))
                            .ignoresSafeArea()
                        RadialGradient(colors: theme.torchTransitionColors, center: .center, startRadius: 6, endRadius: endRadius)
                            .blendMode(.screen)
                            .ignoresSafeArea()
                    }
                case .doors:
                    GeometryReader { proxy in
                        HStack(spacing: 0) {
                            doorPanel
                                .frame(width: proxy.size.width / 2)
                                .offset(x: -proxy.size.width * 0.55 * progress)
                            doorPanel
                                .frame(width: proxy.size.width / 2)
                                .offset(x: proxy.size.width * 0.55 * progress)
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        Rectangle()
                            .fill(.black.opacity(Double(1 - progress) * 0.28))
                            .frame(width: 5)
                            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }

    private var doorPanel: some View {
        LinearGradient(colors: theme.doorTransitionColors, startPoint: .topLeading, endPoint: .bottomTrailing)
            .shadow(color: .black.opacity(0.45), radius: 12)
    }

    private var duration: TimeInterval {
        if reduceMotion { return 0.12 }
        switch style {
        case .fade: return theme.fadeTransitionDuration
        case .torchReveal: return 0.65
        case .doors: return 0.75
        }
    }

    private func runEntrance() {
        animationTask?.cancel()
        guard gameOptions.pageTransitionsEnabled else {
            progress = 1
            return
        }

        progress = 0
        let duration = duration
        withAnimation(.easeInOut(duration: duration)) { progress = 1 }
        animationTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            guard !Task.isCancelled else { return }
            progress = 1
            animationTask = nil
        }
    }
}
