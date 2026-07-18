import SwiftUI

struct ANU013View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu013) }
}

struct ANU013View_Previews: PreviewProvider {
    static var previews: some View { ANU013View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-013")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-013")!)) }
}
