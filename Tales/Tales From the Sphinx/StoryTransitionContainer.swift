import SwiftUI

struct StoryTransitionContainer<Content: View>: View {
    let style: StoryTransitionStyle
    var isPresented: Bool = true
    var onComplete: (() -> Void)? = nil
    @ViewBuilder let content: Content
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @EnvironmentObject private var gameOptions: GameOptions
    @State private var progress: CGFloat = 0

    var body: some View {
        ZStack { content.opacity(contentOpacity).offset(y: reduceMotion ? 0 : (progress < 1 ? 10 : 0)); overlay }
            .onAppear { run() }
            .onChange(of: isPresented) { _ in run() }
    }
    private var contentOpacity: Double { (reduceMotion || !gameOptions.pageTransitionsEnabled) ? 1 : Double(max(0.15, progress)) }
    @ViewBuilder private var overlay: some View {
        if !reduceMotion && gameOptions.pageTransitionsEnabled && progress < 1 {
            switch style {
            case .sandFade:
                AppTheme.sand.opacity(Double(1 - progress) * 0.55).ignoresSafeArea()
            case .torchReveal:
                Rectangle().fill(.black.opacity(Double(1 - progress) * 0.72)).ignoresSafeArea()
                RadialGradient(colors: [AppTheme.gold.opacity(0.42), .clear], center: .center, startRadius: 10, endRadius: 80 + 520 * progress).ignoresSafeArea().blendMode(.screen)
            case .stoneDoor:
                GeometryReader { proxy in
                    HStack(spacing: 0) { stonePanel; stonePanel }
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .offset(x: -proxy.size.width * progress)
                    HStack(spacing: 0) { stonePanel; stonePanel }
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .offset(x: proxy.size.width * progress)
                    Rectangle().fill(.black.opacity(0.35 * Double(1 - progress))).frame(width: 6).position(x: proxy.size.width/2, y: proxy.size.height/2)
                }.ignoresSafeArea()
            }
        }
    }
    private var stonePanel: some View { LinearGradient(colors: [Color(hex:"5B5144"), Color(hex:"2E2924")], startPoint: .topLeading, endPoint: .bottomTrailing).shadow(color: .black.opacity(0.45), radius: 12, x: 0, y: 0) }
    private func run() { progress = (reduceMotion || !gameOptions.pageTransitionsEnabled) ? 1 : 0; let actualDuration = (reduceMotion || !gameOptions.pageTransitionsEnabled) ? 0.05 : duration; withAnimation(.easeInOut(duration: actualDuration)) { progress = 1 }; DispatchQueue.main.asyncAfter(deadline: .now() + actualDuration) { onComplete?() } }
    private var duration: TimeInterval { reduceMotion ? 0.15 : (style == .sandFade ? 0.65 : 0.85) }
}
