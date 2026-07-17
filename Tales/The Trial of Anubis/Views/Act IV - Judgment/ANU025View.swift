import SwiftUI

struct ANU025View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu025) }
}

struct ANU025View_Previews: PreviewProvider {
    static var previews: some View { ANU025View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-025")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-025")!)) }
}
