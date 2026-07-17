import SwiftUI

struct ANU005View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu005) }
}

struct ANU005View_Previews: PreviewProvider {
    static var previews: some View { ANU005View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-005")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-005")!)) }
}
