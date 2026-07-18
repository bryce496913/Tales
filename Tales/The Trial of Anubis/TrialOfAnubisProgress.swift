import Foundation

struct TrialOfAnubisProgress: Codable {
    var currentNodeID: String
    var visitedNodeIDs: Set<String>
    var completedEndingIDs: Set<String>

    static let initial = TrialOfAnubisProgress(
        currentNodeID: TrialOfAnubisRoute.anu001.rawValue,
        visitedNodeIDs: [
            TrialOfAnubisRoute.anu001.rawValue
        ],
        completedEndingIDs: []
    )
}
