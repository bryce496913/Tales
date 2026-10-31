import SwiftUI

struct DescentToHadesNavigationButton: View {
    let title: String
    let destination: DescentToHadesRoute
    var collects: DescentToHadesItem? = nil
    var marks: DescentToHadesStoryFlag? = nil

    @EnvironmentObject
    private var navigationState: DescentToHadesNavigationState

    var body: some View {
        DescentToHadesButton(title) {
            navigationState.navigate(to: destination, collecting: collects, marking: marks)
        }
    }
}
