import SwiftUI

struct ANU021View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu021) }
}

struct ANU021View_Previews: PreviewProvider {
    static var previews: some View { ANU021View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-021")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-021")!)) }
}
