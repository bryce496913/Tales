import SwiftUI

struct TrialOfAnubisPlaceholderView: View {
    let returnToStorySelection: () -> Void

    var body: some View {
        ZStack {
            EgyptianBackground()

            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 24)

                    VStack(spacing: 16) {
                        Image(systemName: "scalemass.fill")
                            .font(.system(size: 56, weight: .semibold))
                            .foregroundColor(AppTheme.gold)
                            .accessibilityHidden(true)

                        Text("The Trial of Anubis")
                            .font(.system(size: 38, weight: .bold, design: .serif))
                            .foregroundColor(AppTheme.gold)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)

                        Text("Coming Soon")
                            .font(.system(.title3, design: .serif).weight(.bold))
                            .foregroundColor(Color(hex: "1E140B"))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Capsule().fill(AppTheme.gold))
                            .accessibilityLabel("Status: Coming Soon")

                        Text("Enter the Egyptian underworld, recover the sacred scales, and face the final judgment of your heart.")
                            .font(.system(.title3, design: .serif).weight(.medium))
                            .foregroundColor(AppTheme.mutedText)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .goldCard()
                    .frame(maxWidth: AppTheme.maximumTextWidth)

                    MenuButton(title: "Back to Story Selection") {
                        returnToStorySelection()
                    }
                    .accessibilityLabel("Back to Story Selection")
                    .accessibilityHint("Returns to the story selection screen.")

                    Spacer(minLength: 32)
                }
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct TrialOfAnubisPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPlaceholderView(returnToStorySelection: {})
    }
}
