import SwiftUI

enum TrialOfAnubisRoute: String, Codable, Hashable, CaseIterable {
    case anu000 = "ANU-000"
    case anu001 = "ANU-001"
    case anu002 = "ANU-002"
    case anu003 = "ANU-003"
    case anu004 = "ANU-004"
    case anu005 = "ANU-005"
    case anu006 = "ANU-006"
    case anu007 = "ANU-007"
    case anu008 = "ANU-008"
    case anu009 = "ANU-009"
    case anu010 = "ANU-010"
    case anu011 = "ANU-011"
    case anu012 = "ANU-012"
    case anu013 = "ANU-013"
    case anu014 = "ANU-014"
    case anu015 = "ANU-015"
    case anu016 = "ANU-016"
    case anu017 = "ANU-017"
    case anu018 = "ANU-018"
    case anu019 = "ANU-019"
    case anu020 = "ANU-020"
    case anu021 = "ANU-021"
    case anu022 = "ANU-022"
    case anu023 = "ANU-023"
    case anu024 = "ANU-024"
    case anu025 = "ANU-025"
    case anu026 = "ANU-026"
    case anu027 = "ANU-027"
    case anu028 = "ANU-028"
    case anu029 = "ANU-029"
    case anu030 = "ANU-030"
    case anu031 = "ANU-031"
    case anu032 = "ANU-032"
    case anu033 = "ANU-033"
    case anu034 = "ANU-034"
    case anu035 = "ANU-035"
    case anu036 = "ANU-036"
    case anu037 = "ANU-037"
    case anu038 = "ANU-038"
    case anu039 = "ANU-039"
    case anu040 = "ANU-040"
    case anu041 = "ANU-041"
    case anu042 = "ANU-042"
    case anu043 = "ANU-043"
    case anu044 = "ANU-044"
    case anu045 = "ANU-045"
    case anu046 = "ANU-046"
    case anu047 = "ANU-047"

    /// HOME hub that links to the three item paths.
    static let home: TrialOfAnubisRoute = .anu011

    /// HOME once the Feather Arm, Heart Pan and Balance Stone are all collected.
    static let endGame: TrialOfAnubisRoute = .anu026

    var isEnding: Bool { endingID != nil }

    /// Stable ID recorded when a game-over page is reached.
    var endingID: String? {
        switch self {
        case .anu003: return "anubis_lost_in_desert"
        case .anu017: return "anubis_swallowed_by_fog"
        case .anu028: return "anubis_lord_of_the_tomb"
        case .anu029: return "anubis_released"
        case .anu030: return "anubis_scales_restored"
        case .anu032: return "anubis_devoured_by_ammit"
        case .anu035: return "anubis_taken_by_the_river"
        case .anu038: return "anubis_buried_with_the_stone"
        case .anu040: return "anubis_peaceful_death"
        case .anu047: return "anubis_defy_the_gods"
        default: return nil
        }
    }
}

struct TrialOfAnubisDestinationView: View {
    let route: TrialOfAnubisRoute

    var body: some View {
        switch route {
        case .anu000:
            ANU000View()
        case .anu001:
            ANU001View()
        case .anu002:
            ANU002View()
        case .anu003:
            ANU003View()
        case .anu004:
            ANU004View()
        case .anu005:
            ANU005View()
        case .anu006:
            ANU006View()
        case .anu007:
            ANU007View()
        case .anu008:
            ANU008View()
        case .anu009:
            ANU009View()
        case .anu010:
            ANU010View()
        case .anu011:
            ANU011View()
        case .anu012:
            ANU012View()
        case .anu013:
            ANU013View()
        case .anu014:
            ANU014View()
        case .anu015:
            ANU015View()
        case .anu016:
            ANU016View()
        case .anu017:
            ANU017View()
        case .anu018:
            ANU018View()
        case .anu019:
            ANU019View()
        case .anu020:
            ANU020View()
        case .anu021:
            ANU021View()
        case .anu022:
            ANU022View()
        case .anu023:
            ANU023View()
        case .anu024:
            ANU024View()
        case .anu025:
            ANU025View()
        case .anu026:
            ANU026View()
        case .anu027:
            ANU027View()
        case .anu028:
            ANU028View()
        case .anu029:
            ANU029View()
        case .anu030:
            ANU030View()
        case .anu031:
            ANU031View()
        case .anu032:
            ANU032View()
        case .anu033:
            ANU033View()
        case .anu034:
            ANU034View()
        case .anu035:
            ANU035View()
        case .anu036:
            ANU036View()
        case .anu037:
            ANU037View()
        case .anu038:
            ANU038View()
        case .anu039:
            ANU039View()
        case .anu040:
            ANU040View()
        case .anu041:
            ANU041View()
        case .anu042:
            ANU042View()
        case .anu043:
            ANU043View()
        case .anu044:
            ANU044View()
        case .anu045:
            ANU045View()
        case .anu046:
            ANU046View()
        case .anu047:
            ANU047View()
        }
    }
}
