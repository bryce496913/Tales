import Foundation

/// The three gifts Hades asks for. Collecting all three opens the end-game.
enum DescentToHadesItem: String, Codable, CaseIterable {
    case waterOfLethe
    case emberOfPhlegethon
    case goldenBough
}

/// Choices the story remembers so later pages can react to them.
enum DescentToHadesStoryFlag: String, Codable, CaseIterable, BranchingStoryFlag {
    case struckHermesBargain
    case liedToCharon
    case wokeTheo
    case leftTheoResting
    case helpedSisyphus

    /// A flag that cannot be held at the same time as this one.
    var opposite: DescentToHadesStoryFlag? {
        switch self {
        case .wokeTheo: return .leftTheoResting
        case .leftTheoResting: return .wokeTheo
        case .struckHermesBargain, .liedToCharon, .helpedSisyphus: return nil
        }
    }
}
