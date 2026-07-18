import SwiftUI

struct ANU008View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu008) }
}

struct ANU008View_Previews: PreviewProvider {
    static var previews: some View { ANU008View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-008")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-008")!)) }
}
