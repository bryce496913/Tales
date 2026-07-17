import SwiftUI

struct ANU011View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu011) }
}

struct ANU011View_Previews: PreviewProvider {
    static var previews: some View { ANU011View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-011")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-011")!)) }
}
