import SwiftUI

struct ANU016View: View {
    var body: some View { TrialOfAnubisPageView(nodeID: .anu016) }
}

struct ANU016View_Previews: PreviewProvider {
    static var previews: some View { ANU016View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-016")!)).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-016")!)) }
}
