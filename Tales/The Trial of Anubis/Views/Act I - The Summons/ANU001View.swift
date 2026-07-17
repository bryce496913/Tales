import SwiftUI

struct ANU001View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu001) }
}

struct ANU001View_Previews: PreviewProvider {
    static var previews: some View { ANU001View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-001")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-001")!)) }
}
