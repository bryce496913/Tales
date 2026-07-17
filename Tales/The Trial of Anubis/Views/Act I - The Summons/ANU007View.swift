import SwiftUI

struct ANU007View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu007) }
}

struct ANU007View_Previews: PreviewProvider {
    static var previews: some View { ANU007View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-007")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-007")!)) }
}
