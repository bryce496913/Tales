import SwiftUI

struct ChoiceButton: View {
    let title: String
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    let action: () -> Void
    @State private var isNavigating = false
    @Environment(\.isEnabled) private var isEnabled

    init(_ title: String, width: CGFloat? = nil, height: CGFloat? = nil, action: @escaping () -> Void) {
        self.title = title; self.width = width; self.height = height; self.action = action
    }

    var body: some View {
        Button {
            guard !isNavigating, isEnabled else { return }
            isNavigating = true
            HapticManager.shared.playChoiceTap()
            action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) { isNavigating = false }
        } label: {
            Text(title)
                .font(.system(.headline, design: .serif).weight(.semibold))
                .foregroundColor(Color(hex: "1E140B"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .minimumScaleFactor(0.82)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .frame(width: width, height: height)
                .frame(maxWidth: width == nil ? .infinity : nil, minHeight: height == nil ? 54 : nil)
        }
        .buttonStyle(StoryChoiceButtonStyle())
        .disabled(isNavigating || !isEnabled)
    }
}
