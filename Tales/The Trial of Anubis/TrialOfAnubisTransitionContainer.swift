import SwiftUI

struct TrialOfAnubisTransitionContainer<Content: View>: View {
    let style: TrialOfAnubisTransitionStyle
    @ViewBuilder let content: Content

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var progress: CGFloat = 0
    @State private var animationTask: Task<Void, Never>?

    var body: some View {
        ZStack {
            content
                .opacity(contentOpacity)
                .offset(y: reduceMotion ? 0 : contentOffset)

            overlay
                .allowsHitTesting(false)
                .accessibilityHidden(true)
        }
        .onAppear { runEntrance() }
        .onDisappear { animationTask?.cancel(); animationTask = nil; progress = 1 }
        .onChange(of: style) { _ in runEntrance() }
    }

    private var contentOpacity: Double {
        reduceMotion ? Double(max(0.65, progress)) : Double(max(0.2, progress))
    }

    private var contentOffset: CGFloat {
        style == .sandFade && progress < 1 ? 12 * (1 - progress) : 0
    }

    @ViewBuilder private var overlay: some View {
        if progress < 1 {
            if reduceMotion {
                Color.black.opacity(Double(1 - progress) * 0.18)
                    .ignoresSafeArea()
            } else {
                switch style {
                case .sandFade:
                    Color(hex: "3B2A16")
                        .opacity(Double(1 - progress) * 0.62)
                        .ignoresSafeArea()
                case .torchReveal:
                    GeometryReader { proxy in
                        let endRadius = max(proxy.size.width, proxy.size.height) * (0.18 + 0.9 * progress)
                        Rectangle()
                            .fill(.black.opacity(Double(1 - progress) * 0.76))
                            .ignoresSafeArea()
                        RadialGradient(
                            colors: [AppTheme.gold.opacity(0.48), Color(hex: "B36B18").opacity(0.22), .clear],
                            center: .center,
                            startRadius: 6,
                            endRadius: endRadius
                        )
                        .blendMode(.screen)
                        .ignoresSafeArea()
                    }
                case .stoneDoor:
                    GeometryReader { proxy in
                        HStack(spacing: 0) {
                            stonePanel
                                .frame(width: proxy.size.width / 2)
                                .offset(x: -proxy.size.width * 0.55 * progress)
                            stonePanel
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

    private var stonePanel: some View {
        LinearGradient(
            colors: [Color(hex: "645847"), Color(hex: "332C25"), Color(hex: "211C18")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .shadow(color: .black.opacity(0.45), radius: 12)
    }

    private func runEntrance() {
        animationTask?.cancel()
        progress = 0
        let duration = reduceMotion ? 0.12 : style.duration
        withAnimation(.easeInOut(duration: duration)) { progress = 1 }
        animationTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            guard !Task.isCancelled else { return }
            progress = 1
            animationTask = nil
        }
    }
}

private extension TrialOfAnubisTransitionStyle {
    var duration: TimeInterval {
        switch self {
        case .sandFade: return 0.5
        case .torchReveal: return 0.65
        case .stoneDoor: return 0.75
        }
    }
}

struct TrialOfAnubisTransitionContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            transitionPreview(.sandFade).previewDisplayName("Sand Fade")
            transitionPreview(.torchReveal).previewDisplayName("Torch Reveal")
            transitionPreview(.stoneDoor).previewDisplayName("Stone Door")
        }
    }

    private static func transitionPreview(_ style: TrialOfAnubisTransitionStyle) -> some View {
        TrialOfAnubisTransitionContainer(style: style) {
            ZStack {
                EgyptianBackground()
                Text("The judgment chamber appears beneath the effect.")
                    .font(.system(.title2, design: .serif).weight(.bold))
                    .foregroundColor(AppTheme.gold)
                    .goldCard()
                    .padding()
            }
        }
    }
}
