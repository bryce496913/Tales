import SwiftUI

enum TrialOfAnubisTypewriterSpeed {
    case slow
    case normal
    case fast

    var delay: UInt64 {
        switch self {
        case .slow: return 42_000_000
        case .normal: return 25_000_000
        case .fast: return 12_000_000
        }
    }

    var batchSize: Int {
        switch self {
        case .slow: return 1
        case .normal: return 1
        case .fast: return 2
        }
    }
}
