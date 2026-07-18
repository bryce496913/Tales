import SwiftUI

struct StoryChoiceButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @EnvironmentObject private var gameOptions: GameOptions
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(background(pressed: configuration.isPressed))
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .offset(y: configuration.isPressed ? 1.5 : 0)
            .shadow(color: AppTheme.gold.opacity(shadowOpacity(pressed: configuration.isPressed)), radius: gameOptions.buttonGlowEnabled ? (configuration.isPressed ? 5 : 11) : 3, x: 0, y: configuration.isPressed ? 2 : 6)
            .animation(.spring(response: 0.22, dampingFraction: 0.78), value: configuration.isPressed)
    }
    private func shadowOpacity(pressed: Bool) -> Double { gameOptions.buttonGlowEnabled ? (pressed ? 0.30 : 0.20) : (pressed ? 0.18 : 0.08) }
    private func background(pressed: Bool) -> some View {
        RoundedRectangle(cornerRadius: AppTheme.buttonRadius, style: .continuous)
            .fill(LinearGradient(colors: pressed ? [AppTheme.gold, Color(hex: "B98229")] : [Color(hex: "F1D48A"), AppTheme.gold], startPoint: .top, endPoint: .bottom))
            .overlay(RoundedRectangle(cornerRadius: AppTheme.buttonRadius, style: .continuous).stroke(AppTheme.sand.opacity(0.85), lineWidth: 1))
            .overlay(RoundedRectangle(cornerRadius: AppTheme.buttonRadius, style: .continuous).stroke(AppTheme.gold.opacity(pressed ? 0.8 : 0.35), lineWidth: pressed ? 2 : 1).blur(radius: (reduceMotion || !gameOptions.buttonGlowEnabled) ? 0 : 1))
    }
}
