import SwiftUI

struct TrialOfAnubisChoiceButton: View {
    let nodeID: TrialOfAnubisRoute
    let choice: TrialOfAnubisChoice
    @EnvironmentObject private var nav: TrialOfAnubisNavigationState

    var body: some View {
        Button(action: {
            nav.selectChoice(choice)
        }) {
            Text(accessibilityTitle)
                .font(.system(.headline, design: .serif).weight(.semibold))
                .foregroundColor(Color(hex: "1E140B"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .minimumScaleFactor(0.82)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, minHeight: 54)
                .contentShape(Rectangle())
        }
        .buttonStyle(StoryChoiceButtonStyle())
        .accessibilityLabel(accessibilityTitle)
        .accessibilityIdentifier("anubis-choice-\(nodeID.rawValue)-\(choice.title.slugifiedAccessibilityID)")
    }

    private var accessibilityTitle: String {
        [choice.title, choice.detail].compactMap { $0 }.joined(separator: ". ")
    }
}
