import SwiftUI

/// Colours for The Descent to Hades. Replaces the Egyptian gold and sand for this story only.
enum DescentToHadesTheme {
    static let backgroundTop = Color(hex: "0B1220")
    static let backgroundBottom = Color(hex: "1C1630")
    static let card = Color(hex: "141B2B").opacity(0.88)
    static let cardAlt = Color(hex: "1F2840").opacity(0.85)
    static let bronze = Color(hex: "C08A4A")
    static let bronzeLight = Color(hex: "DDB27A")
    static let bronzeDark = Color(hex: "9A6A33")
    static let marble = Color(hex: "EDE8DF")
    static let mutedText = Color(hex: "A9B3C4")
    static let aegean = Color(hex: "3E6E9E")
    static let pomegranate = Color(hex: "9E2B3A")
    static let asphodel = Color(hex: "C9C3B0")
    static let buttonText = Color(hex: "1A1208")
    static let shadow = Color.black.opacity(0.5)

    static var background: LinearGradient {
        LinearGradient(colors: [backgroundTop, backgroundBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct DescentToHadesBackground: View {
    var body: some View {
        ZStack {
            DescentToHadesTheme.background
            RadialGradient(colors: [DescentToHadesTheme.aegean.opacity(0.22), .clear], center: .top, startRadius: 20, endRadius: 420)
            LinearGradient(colors: [.clear, .black.opacity(0.36)], startPoint: .center, endPoint: .bottom)
        }
        .ignoresSafeArea()
    }
}

struct DescentToHadesCardModifier: ViewModifier {
    var padding: CGFloat = AppTheme.cardPadding

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                    .fill(DescentToHadesTheme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                            .stroke(DescentToHadesTheme.bronze.opacity(0.55), lineWidth: 1)
                    )
                    .shadow(color: DescentToHadesTheme.shadow, radius: 18, x: 0, y: 10)
            )
    }
}

extension View {
    func bronzeCard(padding: CGFloat = AppTheme.cardPadding) -> some View {
        modifier(DescentToHadesCardModifier(padding: padding))
    }
}
