import SwiftUI

struct ANU026View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu026) }
}

struct ANU026View_Previews: PreviewProvider {
    static var previews: some View { ANU026View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-026")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-026")!)) }
}
