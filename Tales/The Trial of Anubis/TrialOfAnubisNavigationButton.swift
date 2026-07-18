import SwiftUI

struct TrialOfAnubisNavigationButton: View {
    let title: String
    let destination: TrialOfAnubisRoute

    @EnvironmentObject
    private var navigationState: TrialOfAnubisNavigationState

    var body: some View {
        Button {
            navigationState.navigate(to: destination)
        } label: {
            Text(title)
                .font(.system(.headline, design: .serif).weight(.semibold))
                .foregroundColor(Color(hex: "1E140B"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, minHeight: 54)
        }
        .buttonStyle(TrialOfAnubisChoiceButtonStyle())
    }
}
