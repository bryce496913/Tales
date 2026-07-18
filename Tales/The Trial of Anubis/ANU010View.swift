import SwiftUI

struct ANU010View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu010) }
}

struct ANU010View_Previews: PreviewProvider {
    static var previews: some View { ANU010View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-010")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-010")!)) }
}
