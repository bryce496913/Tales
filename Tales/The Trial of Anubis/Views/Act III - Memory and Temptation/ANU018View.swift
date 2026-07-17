import SwiftUI

struct ANU018View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu018) }
}

struct ANU018View_Previews: PreviewProvider {
    static var previews: some View { ANU018View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-018")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-018")!)) }
}
