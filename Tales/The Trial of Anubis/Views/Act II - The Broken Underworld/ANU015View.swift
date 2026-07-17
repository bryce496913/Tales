import SwiftUI

struct ANU015View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu015) }
}

struct ANU015View_Previews: PreviewProvider {
    static var previews: some View { ANU015View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-015")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-015")!)) }
}
