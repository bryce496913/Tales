import SwiftUI
// ANU028View is implemented in TrialOfAnubisViews.swift because it performs deterministic ending routing.
struct ANU028View_Previews: PreviewProvider { static var previews: some View { ANU028View().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-anu-028")!)) } }
