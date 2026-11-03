import SwiftUI

enum TrialOfAnubisOutcome: StoryOutcomeStyle {
    case win
    case darkWin
    case lose
    case released
    case death

    var title: String {
        switch self {
        case .win: return "Victory"
        case .darkWin: return "A Dangerous Victory"
        case .lose: return "Defeat"
        case .released: return "Home Again"
        case .death: return "You Have Fallen"
        }
    }

    var subtitle: String {
        switch self {
        case .win: return "The scales shine with restored balance."
        case .darkWin: return "Power answers, but its flame casts a long shadow."
        case .lose: return "The desert keeps another unfinished judgment."
        case .released: return "You return to the living, your heart still unweighed."
        case .death: return "The temple falls silent around your name."
        }
    }

    var iconName: String {
        switch self {
        case .win: return "crown.fill"
        case .darkWin: return "flame.fill"
        case .lose: return "exclamationmark.triangle.fill"
        case .released: return "sunrise.fill"
        case .death: return "xmark.shield.fill"
        }
    }

    var accent: Color {
        switch self {
        case .win: return AppTheme.gold
        case .darkWin: return Color(hex: "B86F22")
        case .lose: return Color(hex: "C47A2C")
        case .released: return AppTheme.sand
        case .death: return Color(hex: "9F2E2E")
        }
    }

    var background: Color {
        switch self {
        case .win: return Color(hex: "3A2811").opacity(0.94)
        case .darkWin: return Color(hex: "30200F").opacity(0.95)
        case .lose: return Color(hex: "2B2117").opacity(0.95)
        case .released: return Color(hex: "2E2619").opacity(0.94)
        case .death: return Color(hex: "1B0F12").opacity(0.97)
        }
    }

    var entrance: OutcomeEntrance {
        switch self {
        case .win: return .triumph
        case .darkWin: return .rise
        case .lose: return .shake
        case .released: return .gentle
        case .death: return .fall
        }
    }
}

struct TrialOfAnubisOutcome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            preview(.win).previewDisplayName("win outcome")
            preview(.darkWin).previewDisplayName("darkWin outcome")
            preview(.lose).previewDisplayName("lose outcome")
            preview(.released).previewDisplayName("released outcome")
            preview(.death).previewDisplayName("death outcome")
        }
    }

    private static func preview(_ outcome: TrialOfAnubisOutcome) -> some View {
        TrialOfAnubisPreviewContainer {
            TrialOfAnubisOutcomeView(
                outcome: outcome,
                title: "The Scales Restored",
                classification: "Preview Classification",
                imageName: "ANU030",
                storyText: "A preview ending narrative remains fully visible for accessibility and small devices.",
                outcomeText: "A preview outcome text remains separate from the narrative."
            )
        }
    }
}
