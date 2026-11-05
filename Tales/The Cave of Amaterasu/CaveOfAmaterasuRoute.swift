import SwiftUI

enum CaveOfAmaterasuRoute: String, Codable, Hashable, CaseIterable, BranchingRoute {
    case ama000 = "AMA-000"
    case ama001 = "AMA-001"
    case ama002 = "AMA-002"
    case ama003 = "AMA-003"
    case ama004 = "AMA-004"
    case ama005 = "AMA-005"
    case ama006 = "AMA-006"
    case ama007 = "AMA-007"
    case ama008 = "AMA-008"
    case ama009 = "AMA-009"
    case ama010 = "AMA-010"
    case ama011 = "AMA-011"
    case ama012 = "AMA-012"
    case ama013 = "AMA-013"
    case ama014 = "AMA-014"
    case ama015 = "AMA-015"
    case ama016 = "AMA-016"
    case ama017 = "AMA-017"
    case ama018 = "AMA-018"
    case ama019 = "AMA-019"
    case ama020 = "AMA-020"
    case ama021 = "AMA-021"
    case ama022 = "AMA-022"
    case ama023 = "AMA-023"
    case ama024 = "AMA-024"
    case ama025 = "AMA-025"
    case ama026 = "AMA-026"
    case ama027 = "AMA-027"
    case ama028 = "AMA-028"
    case ama029 = "AMA-029"
    case ama030 = "AMA-030"
    case ama031 = "AMA-031"
    case ama032 = "AMA-032"
    case ama033 = "AMA-033"
    case ama034 = "AMA-034"
    case ama035 = "AMA-035"
    case ama036 = "AMA-036"
    case ama037 = "AMA-037"
    case ama038 = "AMA-038"
    case ama039 = "AMA-039"
    case ama040 = "AMA-040"
    case ama041 = "AMA-041"
    case ama042 = "AMA-042"
    case ama043 = "AMA-043"
    case ama044 = "AMA-044"
    case ama045 = "AMA-045"
    case ama046 = "AMA-046"
    case ama047 = "AMA-047"

    /// First page of a new adventure.
    static let start: CaveOfAmaterasuRoute = .ama000

    /// HOME hub (the Heavenly Rock Cave) that links to the three treasure paths.
    static let home: CaveOfAmaterasuRoute = .ama014

    /// HOME once the mirror, the jewels and the sword are all collected.
    static let endGame: CaveOfAmaterasuRoute = .ama039

    /// Stable ID recorded when a game-over page is reached.
    var endingID: String? {
        switch self {
        case .ama003: return "amaterasu_endless_night"
        case .ama004: return "amaterasu_joined_the_night_parade"
        case .ama008: return "amaterasu_led_astray_by_foxfire"
        case .ama011: return "amaterasu_endless_loom"
        case .ama013: return "amaterasu_looked_upon_the_sun"
        case .ama021: return "amaterasu_hidden_by_the_tengu"
        case .ama030: return "amaterasu_three_hundred_years"
        case .ama038: return "amaterasu_swallowed_by_orochi"
        case .ama043: return "amaterasu_dawn_returns"
        case .ama044: return "amaterasu_rock_stays_shut"
        case .ama045: return "amaterasu_suns_companion"
        case .ama046: return "amaterasu_opened_box"
        case .ama047: return "amaterasu_fox_wedding"
        default: return nil
        }
    }
}

struct CaveOfAmaterasuDestinationView: View {
    let route: CaveOfAmaterasuRoute

    var body: some View {
        switch route {
        case .ama000:
            AMA000View()
        case .ama001:
            AMA001View()
        case .ama002:
            AMA002View()
        case .ama003:
            AMA003View()
        case .ama004:
            AMA004View()
        case .ama005:
            AMA005View()
        case .ama006:
            AMA006View()
        case .ama007:
            AMA007View()
        case .ama008:
            AMA008View()
        case .ama009:
            AMA009View()
        case .ama010:
            AMA010View()
        case .ama011:
            AMA011View()
        case .ama012:
            AMA012View()
        case .ama013:
            AMA013View()
        case .ama014:
            AMA014View()
        case .ama015:
            AMA015View()
        case .ama016:
            AMA016View()
        case .ama017:
            AMA017View()
        case .ama018:
            AMA018View()
        case .ama019:
            AMA019View()
        case .ama020:
            AMA020View()
        case .ama021:
            AMA021View()
        case .ama022:
            AMA022View()
        case .ama023:
            AMA023View()
        case .ama024:
            AMA024View()
        case .ama025:
            AMA025View()
        case .ama026:
            AMA026View()
        case .ama027:
            AMA027View()
        case .ama028:
            AMA028View()
        case .ama029:
            AMA029View()
        case .ama030:
            AMA030View()
        case .ama031:
            AMA031View()
        case .ama032:
            AMA032View()
        case .ama033:
            AMA033View()
        case .ama034:
            AMA034View()
        case .ama035:
            AMA035View()
        case .ama036:
            AMA036View()
        case .ama037:
            AMA037View()
        case .ama038:
            AMA038View()
        case .ama039:
            AMA039View()
        case .ama040:
            AMA040View()
        case .ama041:
            AMA041View()
        case .ama042:
            AMA042View()
        case .ama043:
            AMA043View()
        case .ama044:
            AMA044View()
        case .ama045:
            AMA045View()
        case .ama046:
            AMA046View()
        case .ama047:
            AMA047View()
        }
    }
}
