import SwiftUI

struct ANU009View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu009) }
}

struct ANU009View_Previews: PreviewProvider {
    static var previews: some View { ANU009View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-009")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-009")!)) }
}
