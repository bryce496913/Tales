import Foundation

/// The three missing pieces of the scales. Collecting all three opens the end-game.
enum TrialOfAnubisItem: String, Codable, CaseIterable {
    case feather
    case heart
    case balanceStone
}

/// Choices the story remembers so later pages can react to them.
enum TrialOfAnubisStoryFlag: String, Codable, CaseIterable {
    case freedSoul
    case abandonedSoul
    case acceptedRebel

    /// A flag that cannot be held at the same time as this one.
    var opposite: TrialOfAnubisStoryFlag? {
        switch self {
        case .freedSoul: return .abandonedSoul
        case .abandonedSoul: return .freedSoul
        case .acceptedRebel: return nil
        }
    }
}

struct TrialOfAnubisProgress: Codable {
    var currentNodeID: String
    var visitedNodeIDs: Set<String>
    var collectedItems: Set<TrialOfAnubisItem>
    var storyFlags: Set<TrialOfAnubisStoryFlag>
    var completedEndingIDs: Set<String>

    var hasAllItems: Bool {
        collectedItems.isSuperset(of: TrialOfAnubisItem.allCases)
    }

    static let initial = TrialOfAnubisProgress(
        currentNodeID: TrialOfAnubisRoute.anu000.rawValue,
        visitedNodeIDs: [
            TrialOfAnubisRoute.anu000.rawValue
        ],
        collectedItems: [],
        storyFlags: [],
        completedEndingIDs: []
    )
}
