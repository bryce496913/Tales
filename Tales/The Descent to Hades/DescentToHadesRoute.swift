import SwiftUI

enum DescentToHadesRoute: String, Codable, Hashable, CaseIterable {
    case hds000 = "HDS-000"
    case hds001 = "HDS-001"
    case hds002 = "HDS-002"
    case hds003 = "HDS-003"
    case hds004 = "HDS-004"
    case hds005 = "HDS-005"
    case hds006 = "HDS-006"
    case hds007 = "HDS-007"
    case hds008 = "HDS-008"
    case hds009 = "HDS-009"
    case hds010 = "HDS-010"
    case hds011 = "HDS-011"
    case hds012 = "HDS-012"
    case hds013 = "HDS-013"
    case hds014 = "HDS-014"
    case hds015 = "HDS-015"
    case hds016 = "HDS-016"
    case hds017 = "HDS-017"
    case hds018 = "HDS-018"
    case hds019 = "HDS-019"
    case hds020 = "HDS-020"
    case hds021 = "HDS-021"
    case hds022 = "HDS-022"
    case hds023 = "HDS-023"
    case hds024 = "HDS-024"
    case hds025 = "HDS-025"
    case hds026 = "HDS-026"
    case hds027 = "HDS-027"
    case hds028 = "HDS-028"
    case hds029 = "HDS-029"
    case hds030 = "HDS-030"
    case hds031 = "HDS-031"
    case hds032 = "HDS-032"
    case hds033 = "HDS-033"
    case hds034 = "HDS-034"
    case hds035 = "HDS-035"
    case hds036 = "HDS-036"
    case hds037 = "HDS-037"
    case hds038 = "HDS-038"
    case hds039 = "HDS-039"
    case hds040 = "HDS-040"
    case hds041 = "HDS-041"
    case hds042 = "HDS-042"
    case hds043 = "HDS-043"
    case hds044 = "HDS-044"
    case hds045 = "HDS-045"
    case hds046 = "HDS-046"
    case hds047 = "HDS-047"

    /// HOME hub (the Crossroads of Judgment) that links to the three gift roads.
    static let home: DescentToHadesRoute = .hds015

    /// HOME once the Water of Lethe, Ember of Phlegethon and Golden Bough are all collected.
    static let endGame: DescentToHadesRoute = .hds040

    var isEnding: Bool { endingID != nil }

    /// Stable ID recorded when a game-over page is reached.
    var endingID: String? {
        switch self {
        case .hds003: return "hades_lost_to_the_sea"
        case .hds008: return "hades_taken_by_the_styx"
        case .hds012: return "hades_torn_by_cerberus"
        case .hds014: return "hades_bound_by_the_seeds"
        case .hds023: return "hades_sweet_forgetting"
        case .hds031: return "hades_chained_in_tartarus"
        case .hds039: return "hades_isles_of_the_blessed"
        case .hds044: return "hades_out_into_the_sun"
        case .hds045: return "hades_looked_back"
        case .hds046: return "hades_willing_exchange"
        case .hds047: return "hades_thief_of_the_dead"
        default: return nil
        }
    }
}

struct DescentToHadesDestinationView: View {
    let route: DescentToHadesRoute

    var body: some View {
        switch route {
        case .hds000:
            HDS000View()
        case .hds001:
            HDS001View()
        case .hds002:
            HDS002View()
        case .hds003:
            HDS003View()
        case .hds004:
            HDS004View()
        case .hds005:
            HDS005View()
        case .hds006:
            HDS006View()
        case .hds007:
            HDS007View()
        case .hds008:
            HDS008View()
        case .hds009:
            HDS009View()
        case .hds010:
            HDS010View()
        case .hds011:
            HDS011View()
        case .hds012:
            HDS012View()
        case .hds013:
            HDS013View()
        case .hds014:
            HDS014View()
        case .hds015:
            HDS015View()
        case .hds016:
            HDS016View()
        case .hds017:
            HDS017View()
        case .hds018:
            HDS018View()
        case .hds019:
            HDS019View()
        case .hds020:
            HDS020View()
        case .hds021:
            HDS021View()
        case .hds022:
            HDS022View()
        case .hds023:
            HDS023View()
        case .hds024:
            HDS024View()
        case .hds025:
            HDS025View()
        case .hds026:
            HDS026View()
        case .hds027:
            HDS027View()
        case .hds028:
            HDS028View()
        case .hds029:
            HDS029View()
        case .hds030:
            HDS030View()
        case .hds031:
            HDS031View()
        case .hds032:
            HDS032View()
        case .hds033:
            HDS033View()
        case .hds034:
            HDS034View()
        case .hds035:
            HDS035View()
        case .hds036:
            HDS036View()
        case .hds037:
            HDS037View()
        case .hds038:
            HDS038View()
        case .hds039:
            HDS039View()
        case .hds040:
            HDS040View()
        case .hds041:
            HDS041View()
        case .hds042:
            HDS042View()
        case .hds043:
            HDS043View()
        case .hds044:
            HDS044View()
        case .hds045:
            HDS045View()
        case .hds046:
            HDS046View()
        case .hds047:
            HDS047View()
        }
    }
}
