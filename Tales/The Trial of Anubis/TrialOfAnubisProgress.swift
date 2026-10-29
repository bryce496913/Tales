import Foundation

/// The three missing pieces of the scales. Collecting all three opens the end-game.
enum TrialOfAnubisItem: String, Codable, CaseIterable {
    case feather
    case heart
    case balanceStone
}

struct TrialOfAnubisProgress: Codable {
    var currentNodeID: String
    var visitedNodeIDs: Set<String>
    var collectedItems: Set<TrialOfAnubisItem>
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
        completedEndingIDs: []
    )
}
