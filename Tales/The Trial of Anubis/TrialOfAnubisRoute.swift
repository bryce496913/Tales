import SwiftUI

enum TrialOfAnubisRoute: String, Codable, Hashable, CaseIterable {
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

    case endTrue = "END-TRUE"
    case endAmmit = "END-AMMIT"
    case endRebel = "END-REBEL"
    case endTrickster = "END-TRICKSTER"
    case endLost = "END-LOST"

    var isEnding: Bool { rawValue.hasPrefix("END-") }
}

struct TrialOfAnubisDestinationView: View {
    let route: TrialOfAnubisRoute

    var body: some View {
        switch route {
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
        case .endTrue:
            AnubisTrueEndingView()
        case .endAmmit:
            AnubisAmmitEndingView()
        case .endRebel:
            AnubisRebelEndingView()
        case .endTrickster:
            AnubisTricksterEndingView()
        case .endLost:
            AnubisLostSoulEndingView()
        }
    }
}
