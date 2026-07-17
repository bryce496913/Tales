import SwiftUI

struct ANU002View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu002) }
}

struct ANU002View_Previews: PreviewProvider {
    static var previews: some View { ANU002View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-002")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-002")!)) }
}
