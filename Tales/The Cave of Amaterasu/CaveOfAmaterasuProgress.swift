import Foundation

/// The three sacred treasures the gods need. Collecting all three opens the end-game.
enum CaveOfAmaterasuItem: String, Codable, CaseIterable {
    case eightHandMirror
    case curvedJewels
    case cloudSword
}

/// Choices the story remembers so later pages can react to them.
enum CaveOfAmaterasuStoryFlag: String, Codable, CaseIterable, BranchingStoryFlag {
    case toldFoxYourName
    case defiedSarutahiko
    case savedTheTurtle
    case tookOtohimesBox
    case heardSusanoo

    /// None of these choices rules out another.
    var opposite: CaveOfAmaterasuStoryFlag? { nil }
}
