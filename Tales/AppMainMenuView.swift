import SwiftUI

struct AppMainMenuView: View {
    let pickAStory: () -> Void

    @State private var appeared = false

    var body: some View {
        ZStack {
            EgyptianBackground()

            VStack(spacing: 26) {
                Spacer(minLength: 24)

                VStack(spacing: 12) {
                    Image(systemName: "book.pages.fill")
                        .font(.system(size: 54, weight: .semibold, design: .serif))
                        .foregroundColor(AppTheme.gold)
                        .accessibilityHidden(true)

                    Text("Tales")
                        .font(.system(size: 48, weight: .bold, design: .serif))
                        .foregroundColor(AppTheme.gold)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.7)

                    Text("Choose your story. Shape your journey.")
                        .font(.system(.title3, design: .serif).weight(.medium))
                        .foregroundColor(AppTheme.mutedText)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .goldCard()
                .frame(maxWidth: AppTheme.maximumTextWidth)

                MenuButton(title: "Pick a Story") {
                    pickAStory()
                }
                .accessibilityLabel("Pick a Story")
                .accessibilityHint("Opens the story selection screen.")

                Spacer(minLength: 32)
            }
            .padding(AppTheme.screenPadding)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 18)
        }
        .onAppear { withAnimation(.easeOut(duration: 0.55)) { appeared = true } }
    }
}

struct AppMainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AppMainMenuView {}
    }
}
