import SwiftUI

struct DescentToHadesChoiceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: AppTheme.buttonRadius, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: configuration.isPressed
                                ? [DescentToHadesTheme.bronze, DescentToHadesTheme.bronzeDark]
                                : [DescentToHadesTheme.bronzeLight, DescentToHadesTheme.bronze],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.buttonRadius, style: .continuous)
                    .stroke(DescentToHadesTheme.marble.opacity(0.55), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .shadow(color: DescentToHadesTheme.aegean.opacity(configuration.isPressed ? 0.35 : 0.45), radius: configuration.isPressed ? 4 : 12, x: 0, y: configuration.isPressed ? 2 : 6)
    }
}

/// A bronze button used for story choices, menus and game-over controls in The Descent to Hades.
struct DescentToHadesButton: View {
    let title: String
    let action: () -> Void

    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.headline, design: .serif).weight(.semibold))
                .foregroundColor(DescentToHadesTheme.buttonText)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, minHeight: 54)
        }
        .buttonStyle(DescentToHadesChoiceButtonStyle())
    }
}
