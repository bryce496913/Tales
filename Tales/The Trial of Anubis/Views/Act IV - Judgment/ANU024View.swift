import SwiftUI

struct ANU024View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu024) }
}

struct ANU024View_Previews: PreviewProvider {
    static var previews: some View { ANU024View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-024")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-024")!)) }
}
