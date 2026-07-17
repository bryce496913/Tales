import SwiftUI

struct ANU019View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu019) }
}

struct ANU019View_Previews: PreviewProvider {
    static var previews: some View { ANU019View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-019")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-019")!)) }
}
