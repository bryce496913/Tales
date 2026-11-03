import SwiftUI

enum DescentToHadesOutcome: StoryOutcomeStyle {
    case win
    case darkWin
    case bittersweet
    case lose
    case death

    var title: String {
        switch self {
        case .win: return "Victory"
        case .darkWin: return "A Stolen Victory"
        case .bittersweet: return "A Bittersweet End"
        case .lose: return "Defeat"
        case .death: return "You Have Fallen"
        }
    }

    var subtitle: String {
        switch self {
        case .win: return "The sun is warm, and you did not climb alone."
        case .darkWin: return "The living world welcomes you back, but a god keeps count."
        case .bittersweet: return "Something was saved, and something was lost."
        case .lose: return "The underworld keeps what it is given."
        case .death: return "Another shade joins the long grey road."
        }
    }

    var iconName: String {
        switch self {
        case .win: return "sun.max.fill"
        case .darkWin: return "bolt.fill"
        case .bittersweet: return "leaf.fill"
        case .lose: return "cloud.fog.fill"
        case .death: return "xmark.shield.fill"
        }
    }

    var accent: Color {
        switch self {
        case .win: return Color(hex: "E2B866")
        case .darkWin: return Color(hex: "8C6BC2")
        case .bittersweet: return Color(hex: "6F9CC9")
        case .lose: return Color(hex: "C9C3B0")
        case .death: return Color(hex: "9E2B3A")
        }
    }

    var background: Color {
        switch self {
        case .win: return Color(hex: "2A2215").opacity(0.94)
        case .darkWin: return Color(hex: "1D1730").opacity(0.95)
        case .bittersweet: return Color(hex: "142236").opacity(0.94)
        case .lose: return Color(hex: "1B1E26").opacity(0.95)
        case .death: return Color(hex: "1A0C12").opacity(0.97)
        }
    }

    var entrance: OutcomeEntrance {
        switch self {
        case .win: return .triumph
        case .darkWin: return .rise
        case .bittersweet: return .gentle
        case .lose: return .shake
        case .death: return .fall
        }
    }
}

struct DescentToHadesOutcome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            preview(.win).previewDisplayName("win outcome")
            preview(.darkWin).previewDisplayName("darkWin outcome")
            preview(.bittersweet).previewDisplayName("bittersweet outcome")
            preview(.lose).previewDisplayName("lose outcome")
            preview(.death).previewDisplayName("death outcome")
        }
    }

    private static func preview(_ outcome: DescentToHadesOutcome) -> some View {
        DescentToHadesPreviewContainer {
            DescentToHadesOutcomeView(
                outcome: outcome,
                title: "Out Into the Sun",
                classification: "Preview Classification",
                imageName: "HDS044",
                storyText: "A preview ending narrative remains fully visible for accessibility and small devices.",
                outcomeText: "A preview outcome text remains separate from the narrative."
            )
        }
    }
}
