import SwiftUI

struct ANU006View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu006) }
}

struct ANU006View_Previews: PreviewProvider {
    static var previews: some View { ANU006View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-006")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-006")!)) }
}
