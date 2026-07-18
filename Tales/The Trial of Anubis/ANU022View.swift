import SwiftUI

struct ANU022View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu022) }
}

struct ANU022View_Previews: PreviewProvider {
    static var previews: some View { ANU022View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-022")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-022")!)) }
}
