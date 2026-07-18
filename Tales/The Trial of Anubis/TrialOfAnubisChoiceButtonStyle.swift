import SwiftUI

struct TrialOfAnubisChoiceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: AppTheme.buttonRadius, style: .continuous)
                    .fill(configuration.isPressed ? AppTheme.sand.opacity(0.82) : AppTheme.gold)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.buttonRadius, style: .continuous)
                    .stroke(AppTheme.sand.opacity(0.75), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .shadow(color: AppTheme.shadow, radius: configuration.isPressed ? 4 : 10, x: 0, y: configuration.isPressed ? 2 : 6)
    }
}
