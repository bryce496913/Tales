import SwiftUI

struct ANU023View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu023) }
}

struct ANU023View_Previews: PreviewProvider {
    static var previews: some View { ANU023View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-023")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-023")!)) }
}
