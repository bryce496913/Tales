import SwiftUI

enum CaveOfAmaterasuOutcome: StoryOutcomeStyle {
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
        case .win: return "The sun is up, and the whole world is warm again."
        case .darkWin: return "The dawn has come, but someone else has been paid for it."
        case .bittersweet: return "The light came back, but not everything came with it."
        case .lose: return "The dark keeps what wanders into it."
        case .death: return "Another lantern goes out on the mountain."
        }
    }

    var iconName: String {
        switch self {
        case .win: return "sun.max.fill"
        case .darkWin: return "moon.stars.fill"
        case .bittersweet: return "leaf.fill"
        case .lose: return "cloud.fog.fill"
        case .death: return "xmark.shield.fill"
        }
    }

    var accent: Color {
        switch self {
        case .win: return Color(hex: "E8B04A")
        case .darkWin: return Color(hex: "B9A5E0")
        case .bittersweet: return Color(hex: "E3A3B5")
        case .lose: return Color(hex: "B8B2A7")
        case .death: return Color(hex: "C8402A")
        }
    }

    var background: Color {
        switch self {
        case .win: return Color(hex: "2A2112").opacity(0.94)
        case .darkWin: return Color(hex: "1C1830").opacity(0.95)
        case .bittersweet: return Color(hex: "2A1822").opacity(0.94)
        case .lose: return Color(hex: "1C1B1F").opacity(0.95)
        case .death: return Color(hex: "1C0C0A").opacity(0.97)
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

struct CaveOfAmaterasuOutcome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            preview(.win).previewDisplayName("win outcome")
            preview(.darkWin).previewDisplayName("darkWin outcome")
            preview(.bittersweet).previewDisplayName("bittersweet outcome")
            preview(.lose).previewDisplayName("lose outcome")
            preview(.death).previewDisplayName("death outcome")
        }
    }

    private static func preview(_ outcome: CaveOfAmaterasuOutcome) -> some View {
        CaveOfAmaterasuPreviewContainer {
            CaveOfAmaterasuOutcomeView(
                outcome: outcome,
                title: "Dawn Returns",
                classification: "Preview Classification",
                imageName: "AMA043",
                storyText: "A preview ending narrative remains fully visible for accessibility and small devices.",
                outcomeText: "A preview outcome text remains separate from the narrative."
            )
        }
    }
}
