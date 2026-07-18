import SwiftUI

struct ANU014View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu014) }
}

struct ANU014View_Previews: PreviewProvider {
    static var previews: some View { ANU014View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-014")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-014")!)) }
}
