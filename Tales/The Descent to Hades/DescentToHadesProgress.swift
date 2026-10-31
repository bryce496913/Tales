import Foundation

/// The three gifts Hades asks for. Collecting all three opens the end-game.
enum DescentToHadesItem: String, Codable, CaseIterable {
    case waterOfLethe
    case emberOfPhlegethon
    case goldenBough
}

/// Choices the story remembers so later pages can react to them.
enum DescentToHadesStoryFlag: String, Codable, CaseIterable {
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

struct DescentToHadesProgress: Codable {
    var currentNodeID: String
    var visitedNodeIDs: Set<String>
    var collectedItems: Set<DescentToHadesItem>
    var storyFlags: Set<DescentToHadesStoryFlag>
    var completedEndingIDs: Set<String>

    var hasAllItems: Bool {
        collectedItems.isSuperset(of: DescentToHadesItem.allCases)
    }

    static let initial = DescentToHadesProgress(
        currentNodeID: DescentToHadesRoute.hds000.rawValue,
        visitedNodeIDs: [
            DescentToHadesRoute.hds000.rawValue
        ],
        collectedItems: [],
        storyFlags: [],
        completedEndingIDs: []
    )
}
