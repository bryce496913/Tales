import SwiftUI

struct TrialOfAnubisPreviewContainer<Content: View>: View {
    private let content: Content
    @StateObject private var navigationState: TrialOfAnubisNavigationState

    init(@ViewBuilder content: () -> Content) {
        let defaults = UserDefaults(suiteName: "TalesPreview.TrialOfAnubis.\(UUID().uuidString)") ?? .standard
        _navigationState = StateObject(wrappedValue: TrialOfAnubisNavigationState(defaults: defaults))
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            content
                .environmentObject(navigationState)
        }
    }
}
