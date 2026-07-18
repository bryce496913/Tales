import SwiftUI

struct ANU004View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu004) }
}

struct ANU004View_Previews: PreviewProvider {
    static var previews: some View { ANU004View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-004")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-004")!)) }
}
