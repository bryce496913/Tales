import SwiftUI

struct ANU003View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu003) }
}

struct ANU003View_Previews: PreviewProvider {
    static var previews: some View { ANU003View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-003")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-003")!)) }
}
