import SwiftUI

struct MenuButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        ChoiceButton(title, action: action)
            .frame(maxWidth: 280)
    }
}
