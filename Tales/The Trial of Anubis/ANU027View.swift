import SwiftUI

struct ANU027View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu027) }
}

struct ANU027View_Previews: PreviewProvider {
    static var previews: some View { ANU027View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-027")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-027")!)) }
}
