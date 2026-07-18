import SwiftUI

struct ANU028View: View {
    @EnvironmentObject private var nav: TrialOfAnubisNavigationState

    var body: some View {
        ZStack {
            EgyptianBackground()

            VStack(spacing: 16) {
                Image(systemName: "scalemass.fill")
                    .font(.system(size: 58))
                    .foregroundColor(AppTheme.gold)
                Text("Judgment Begins")
                    .font(.system(.largeTitle, design: .serif).weight(.bold))
                    .foregroundColor(AppTheme.gold)
                Text("The restored scales read the full weight of your journey.")
                    .foregroundColor(AppTheme.warmText)
                    .multilineTextAlignment(.center)
                    .goldCard()
            }
            .padding(AppTheme.screenPadding)
        }
        .task { nav.resolveEndingIfNeeded() }
        .accessibilityLabel("Judgment begins. The restored scales read the full weight of your journey.")
    }
}

struct ANU028View_Previews: PreviewProvider {
    static var previews: some View {
        ANU028View()
            .environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-028")!))
    }
}
