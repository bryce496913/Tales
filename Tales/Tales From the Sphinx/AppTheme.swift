import SwiftUI

enum AppTheme {
    static let backgroundTop = Color(hex: "120B18")
    static let backgroundBottom = Color(hex: "2B1A12")
    static let card = Color(hex: "21170F").opacity(0.88)
    static let cardAlt = Color(hex: "342313").opacity(0.82)
    static let gold = Color(hex: "D6A84F")
    static let sand = Color(hex: "E7D1A1")
    static let warmText = Color(hex: "F7E8C5")
    static let mutedText = Color(hex: "CDBB91")
    static let shadow = Color.black.opacity(0.45)

    static let screenPadding: CGFloat = 20
    static let cardPadding: CGFloat = 18
    static let cornerRadius: CGFloat = 24
    static let buttonRadius: CGFloat = 18
    static let imageRadius: CGFloat = 22

    static var background: LinearGradient {
        LinearGradient(colors: [backgroundTop, backgroundBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct EgyptianBackground: View {
    var body: some View {
        ZStack {
            AppTheme.background
            RadialGradient(colors: [AppTheme.gold.opacity(0.20), .clear], center: .top, startRadius: 20, endRadius: 420)
            LinearGradient(colors: [.clear, .black.opacity(0.32)], startPoint: .center, endPoint: .bottom)
        }
        .ignoresSafeArea()
    }
}

struct GoldCardModifier: ViewModifier {
    var padding: CGFloat = AppTheme.cardPadding

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                    .fill(AppTheme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                            .stroke(AppTheme.gold.opacity(0.55), lineWidth: 1)
                    )
                    .shadow(color: AppTheme.shadow, radius: 18, x: 0, y: 10)
            )
    }
}

extension View {
    func goldCard(padding: CGFloat = AppTheme.cardPadding) -> some View {
        modifier(GoldCardModifier(padding: padding))
    }
}

extension Color {
    init(hex: String) {
        let cleanedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&value)

        let alpha: UInt64
        let red: UInt64
        let green: UInt64
        let blue: UInt64

        switch cleanedHex.count {
        case 3:
            alpha = 255
            red = (value >> 8) * 17
            green = ((value >> 4) & 0xF) * 17
            blue = (value & 0xF) * 17
        case 6:
            alpha = 255
            red = value >> 16
            green = (value >> 8) & 0xFF
            blue = value & 0xFF
        case 8:
            alpha = value >> 24
            red = (value >> 16) & 0xFF
            green = (value >> 8) & 0xFF
            blue = value & 0xFF
        default:
            alpha = 255
            red = 0
            green = 0
            blue = 0
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(alpha) / 255
        )
    }
}
