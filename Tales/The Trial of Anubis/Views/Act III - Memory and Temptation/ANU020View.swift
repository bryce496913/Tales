import SwiftUI

struct ANU020View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu020) }
}

struct ANU020View_Previews: PreviewProvider {
    static var previews: some View { ANU020View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-020")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-020")!)) }
}
