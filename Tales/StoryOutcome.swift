import SwiftUI

/// Tales From the Sphinx's three kinds of ending.
enum StoryOutcome: StoryOutcomeStyle {
    case win, lose, death

    var title: String {
        switch self {
        case .win: return "Victory"
        case .lose: return "Defeat"
        case .death: return "You Have Fallen"
        }
    }

    var subtitle: String {
        switch self {
        case .win: return "The sands shine on your triumph."
        case .lose: return "Your adventure ends, but the legend remains."
        case .death: return "The tomb grows quiet around you."
        }
    }

    var iconName: String {
        switch self {
        case .win: return "crown.fill"
        case .lose: return "exclamationmark.triangle.fill"
        case .death: return "xmark.shield.fill"
        }
    }

    var accent: Color {
        switch self {
        case .win: return AppTheme.gold
        case .lose: return Color(hex: "C47A2C")
        case .death: return Color(hex: "9F2E2E")
        }
    }

    var background: Color {
        switch self {
        case .win: return Color(hex: "3A2811").opacity(0.92)
        case .lose: return Color(hex: "2B2117").opacity(0.94)
        case .death: return Color(hex: "1B0F12").opacity(0.96)
        }
    }

    var entrance: OutcomeEntrance {
        switch self {
        case .win: return .triumph
        case .lose: return .shake
        case .death: return .fall
        }
    }
}

/// A Tales From the Sphinx game-over page. Records the ending when it first appears.
struct StoryOutcomeView: View {
    let endingID: String
    let outcome: StoryOutcome
    let imageName: String
    let storyText: String

    @EnvironmentObject private var navigationState: AppNavigationState

    var body: some View {
        StoryEndingView(
            outcome: outcome,
            imageName: imageName,
            storyText: storyText,
            onFirstAppear: { navigationState.markEndingReached(endingID) }
        ) {
            AdventureResetButtons()
        }
    }
}

struct StoryOutcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PreviewContainer {
                StoryOutcomeView(endingID: "preview-win", outcome: .win, imageName: "Thirteen", storyText: "A preview victory ending demonstrates the shared outcome screen.")
            }
            PreviewContainer {
                StoryOutcomeView(endingID: "preview-lose", outcome: .lose, imageName: "Seven", storyText: "A preview defeat ending demonstrates the shared outcome screen.")
            }
            PreviewContainer {
                StoryOutcomeView(endingID: "preview-death", outcome: .death, imageName: "Two", storyText: "A preview death ending demonstrates the shared outcome screen.")
            }
        }
    }
}
