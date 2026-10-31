import SwiftUI

struct DescentToHadesTransitionContainer<Content: View>: View {
    let style: DescentToHadesTransitionStyle
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
        style == .mistFade && progress < 1 ? -10 * (1 - progress) : 0
    }

    @ViewBuilder private var overlay: some View {
        if progress < 1 {
            if reduceMotion {
                Color.black.opacity(Double(1 - progress) * 0.18)
                    .ignoresSafeArea()
            } else {
                switch style {
                case .mistFade:
                    LinearGradient(
                        colors: [Color(hex: "8A96A8"), Color(hex: "4A5468"), Color(hex: "1C2232")],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .opacity(Double(1 - progress) * 0.7)
                    .ignoresSafeArea()
                case .torchReveal:
                    GeometryReader { proxy in
                        let endRadius = max(proxy.size.width, proxy.size.height) * (0.18 + 0.9 * progress)
                        Rectangle()
                            .fill(.black.opacity(Double(1 - progress) * 0.76))
                            .ignoresSafeArea()
                        RadialGradient(
                            colors: [DescentToHadesTheme.bronzeLight.opacity(0.48), DescentToHadesTheme.pomegranate.opacity(0.22), .clear],
                            center: .center,
                            startRadius: 6,
                            endRadius: endRadius
                        )
                        .blendMode(.screen)
                        .ignoresSafeArea()
                    }
                case .bronzeGate:
                    GeometryReader { proxy in
                        HStack(spacing: 0) {
                            bronzePanel
                                .frame(width: proxy.size.width / 2)
                                .offset(x: -proxy.size.width * 0.55 * progress)
                            bronzePanel
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

    private var bronzePanel: some View {
        LinearGradient(
            colors: [Color(hex: "8C6235"), Color(hex: "4E3520"), Color(hex: "2A1D14")],
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

private extension DescentToHadesTransitionStyle {
    var duration: TimeInterval {
        switch self {
        case .mistFade: return 0.6
        case .torchReveal: return 0.65
        case .bronzeGate: return 0.75
        }
    }
}

struct DescentToHadesTransitionContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            transitionPreview(.mistFade).previewDisplayName("Mist Fade")
            transitionPreview(.torchReveal).previewDisplayName("Torch Reveal")
            transitionPreview(.bronzeGate).previewDisplayName("Bronze Gate")
        }
    }

    private static func transitionPreview(_ style: DescentToHadesTransitionStyle) -> some View {
        DescentToHadesTransitionContainer(style: style) {
            ZStack {
                DescentToHadesBackground()
                Text("The banks of the Styx appear beneath the effect.")
                    .font(.system(.title2, design: .serif).weight(.bold))
                    .foregroundColor(DescentToHadesTheme.bronze)
                    .bronzeCard()
                    .padding()
            }
        }
    }
}
