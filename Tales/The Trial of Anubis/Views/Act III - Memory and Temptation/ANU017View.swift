import SwiftUI

struct ANU017View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu017) }
}

struct ANU017View_Previews: PreviewProvider {
    static var previews: some View { ANU017View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-017")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-017")!)) }
}
