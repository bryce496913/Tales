import SwiftUI
import UIKit

enum TrialOfAnubisRoute: String, Codable, Hashable, CaseIterable {
    case anu001 = "ANU-001", anu002 = "ANU-002", anu003 = "ANU-003", anu004 = "ANU-004", anu005 = "ANU-005", anu006 = "ANU-006", anu007 = "ANU-007", anu008 = "ANU-008", anu009 = "ANU-009", anu010 = "ANU-010", anu011 = "ANU-011", anu012 = "ANU-012", anu013 = "ANU-013", anu014 = "ANU-014", anu015 = "ANU-015", anu016 = "ANU-016", anu017 = "ANU-017", anu018 = "ANU-018", anu019 = "ANU-019", anu020 = "ANU-020", anu021 = "ANU-021", anu022 = "ANU-022", anu023 = "ANU-023", anu024 = "ANU-024", anu025 = "ANU-025", anu026 = "ANU-026", anu027 = "ANU-027", anu028 = "ANU-028"
    case endTrue = "END-TRUE", endAmmit = "END-AMMIT", endRebel = "END-REBEL", endTrickster = "END-TRICKSTER", endLost = "END-LOST"
}

enum TrialOfAnubisAllegiance: String, Codable { case undecided, anubis, rebel, `self` }
enum TrialOfAnubisFinalChoice: String, Codable { case honestJudgment, rebel, cheat }
enum TrialOfAnubisEnding: String, Codable, CaseIterable { case trueEnding = "anubis_true_restored", devouredByAmmit = "anubis_dark_ammit", rebel = "anubis_rebel_escape", trickster = "anubis_trickster_cheat", lostSoul = "anubis_lost_soul" }

struct TrialOfAnubisState: Codable, Equatable {
    var heartWeight: Int = 0
    var allegiance: TrialOfAnubisAllegiance = .undecided
    var memoriesRemaining: Int = 3
    var savedLostSoul = false, madeMercyOath = false
    var tookGoldenScarab = false, possessesAmmitFang = false, hasScarabProtection = false
    var learnedTrueName = false, acceptedUnderworldPower = false, liedToAnubis = false
    var learnedAmmitClue = false, learnedOwnHeartTruth = false, learnedConspiracyClue = false
    var firstScalePieceRecovered = false, secondScalePieceRecovered = false, finalScalePieceRecovered = false
    var finalChoice: TrialOfAnubisFinalChoice?
    var finalEndingID: String?
    mutating func clamp() { heartWeight = min(6, max(-6, heartWeight)); memoriesRemaining = min(3, memoriesRemaining) }
}

enum TrialOfAnubisStateEffect: Codable, Hashable { case adjustHeartWeight(Int), loseMemories(Int), setAllegiance(TrialOfAnubisAllegiance), setSavedLostSoul(Bool), setMercyOath(Bool), setGoldenScarab(Bool), setAmmitFang(Bool), setScarabProtection(Bool), setLearnedTrueName(Bool), setUnderworldPower(Bool), setLiedToAnubis(Bool), setAmmitClue(Bool), setOwnHeartTruth(Bool), setConspiracyClue(Bool), setFirstScalePiece(Bool), setSecondScalePiece(Bool), setFinalScalePiece(Bool), setFinalChoice(TrialOfAnubisFinalChoice) }

enum TrialOfAnubisChoiceRequirement: Hashable { case hasGoldenScarab, learnedTrueName, hasWeaponOrUnderworldPower
    func isSatisfied(by state: TrialOfAnubisState) -> Bool { switch self { case .hasGoldenScarab: return state.tookGoldenScarab; case .learnedTrueName: return state.learnedTrueName; case .hasWeaponOrUnderworldPower: return state.possessesAmmitFang || state.acceptedUnderworldPower } }
}
struct TrialOfAnubisChoice: Identifiable, Hashable { let id: String; let source: TrialOfAnubisRoute; let title: String; let detail: String?; let destination: TrialOfAnubisRoute; let effects: [TrialOfAnubisStateEffect]; let requirement: TrialOfAnubisChoiceRequirement?; let feedback: String? }
struct TrialOfAnubisNode: Identifiable {
    let id: TrialOfAnubisRoute
    let imageName: String
    let title: String
    let narrative: String
    let choices: [TrialOfAnubisChoice]
}
struct TrialOfAnubisSaveState: Codable { let schemaVersion: Int; var currentRoute: TrialOfAnubisRoute; var state: TrialOfAnubisState; var isInProgress: Bool; var completedEndings: Set<TrialOfAnubisEnding> }
struct TrialOfAnubisFeedback: Identifiable, Equatable { let id = UUID(); let message: String }
enum TrialOfAnubisAssets { static let cover = "anubis_cover" }

enum TrialOfAnubisEndingResolver {
    static func resolveEnding(state: TrialOfAnubisState) -> TrialOfAnubisEnding {
        if state.memoriesRemaining <= 0 { return .lostSoul }
        if state.finalChoice == .rebel, state.allegiance == .rebel, state.acceptedUnderworldPower, state.possessesAmmitFang { return .rebel }
        if state.finalChoice == .cheat, state.tookGoldenScarab, state.learnedTrueName { return .trickster }
        if state.finalChoice == .honestJudgment, state.firstScalePieceRecovered, state.secondScalePieceRecovered, state.finalScalePieceRecovered, state.heartWeight <= 0, state.savedLostSoul, state.allegiance == .anubis { return .trueEnding }
        if state.heartWeight >= 4 { return .devouredByAmmit }
        if state.finalChoice == .rebel, state.acceptedUnderworldPower { return .rebel }
        if state.finalChoice == .cheat, state.learnedTrueName { return .trickster }
        return state.heartWeight <= 1 ? .trueEnding : .devouredByAmmit
    }
}

@MainActor
final class TrialOfAnubisNavigationState: ObservableObject {
    static let saveKey = "Tales.story.trial-of-anubis.save.v1"
    @Published var path: [TrialOfAnubisRoute] = [] { didSet { persistProgress() } }
    @Published var state = TrialOfAnubisState() { didSet { persistProgress() } }
    @Published var isAdventureActive = false { didSet { persistProgress() } }
    @Published var hasSavedProgress = false
    @Published private(set) var completedEndings: Set<TrialOfAnubisEnding> = []
    @Published var feedback: TrialOfAnubisFeedback?
    private var isRestoring = false, isProcessingChoice = false
    private let defaults: UserDefaults
    init(defaults: UserDefaults = .standard) { self.defaults = defaults; loadSavedProgressFlag() }
    var currentRoute: TrialOfAnubisRoute? { path.last }
    func startNewAdventure() { isAdventureActive = true; state = TrialOfAnubisState(); path = [.anu001]; persistProgress() }
    func continueAdventure() { guard let save = loadSave(), save.isInProgress else { startNewAdventure(); return }; isRestoring = true; completedEndings = save.completedEndings; state = save.state; isAdventureActive = true; path = [save.currentRoute]; isRestoring = false; hasSavedProgress = true }
    func returnToStoryMenu() { persistProgress() }
    func restartAdventure() { startNewAdventure() }
    func selectChoice(_ choice: TrialOfAnubisChoice) { guard !isProcessingChoice, currentRoute == choice.source, choice.requirement?.isSatisfied(by: state) ?? true else { return }; isProcessingChoice = true; apply(choice.effects); feedback = TrialOfAnubisFeedback(message: choice.feedback ?? genericFeedback(for: choice.effects)); let destination = state.memoriesRemaining <= 0 ? TrialOfAnubisRoute.endLost : choice.destination; if destination == .endLost { record(.lostSoul); state.finalEndingID = TrialOfAnubisEnding.lostSoul.rawValue; isAdventureActive = false }; path.append(destination); isProcessingChoice = false; persistProgress() }
    func apply(_ effects: [TrialOfAnubisStateEffect]) { for effect in effects { switch effect { case .adjustHeartWeight(let v): state.heartWeight += v; case .loseMemories(let v): state.memoriesRemaining -= v; case .setAllegiance(let v): state.allegiance = v; case .setSavedLostSoul(let v): state.savedLostSoul = v; case .setMercyOath(let v): state.madeMercyOath = v; case .setGoldenScarab(let v): state.tookGoldenScarab = v; case .setAmmitFang(let v): state.possessesAmmitFang = v; case .setScarabProtection(let v): state.hasScarabProtection = v; case .setLearnedTrueName(let v): state.learnedTrueName = v; case .setUnderworldPower(let v): state.acceptedUnderworldPower = v; case .setLiedToAnubis(let v): state.liedToAnubis = v; case .setAmmitClue(let v): state.learnedAmmitClue = v; case .setOwnHeartTruth(let v): state.learnedOwnHeartTruth = v; case .setConspiracyClue(let v): state.learnedConspiracyClue = v; case .setFirstScalePiece(let v): state.firstScalePieceRecovered = v; case .setSecondScalePiece(let v): state.secondScalePieceRecovered = v; case .setFinalScalePiece(let v): state.finalScalePieceRecovered = v; case .setFinalChoice(let v): state.finalChoice = v } }; state.clamp() }
    func resolveEndingIfNeeded() { if let id = state.finalEndingID, let ending = TrialOfAnubisEnding(rawValue: id) { route(to: ending); return }; let ending = TrialOfAnubisEndingResolver.resolveEnding(state: state); state.finalEndingID = ending.rawValue; record(ending); isAdventureActive = false; persistProgress(); route(to: ending) }
    private func route(to ending: TrialOfAnubisEnding) { let r: TrialOfAnubisRoute = switch ending { case .trueEnding: .endTrue; case .devouredByAmmit: .endAmmit; case .rebel: .endRebel; case .trickster: .endTrickster; case .lostSoul: .endLost }; if path.last != r { path.append(r) } }
    private func record(_ ending: TrialOfAnubisEnding) { completedEndings.insert(ending) }
    private func genericFeedback(for effects: [TrialOfAnubisStateEffect]) -> String { for e in effects { switch e { case .adjustHeartWeight(let v) where v == -1: return "Your heart feels lighter."; case .adjustHeartWeight(let v) where v <= -2: return "A great burden lifts from your heart."; case .adjustHeartWeight(let v) where v == 1: return "A weight settles in your chest."; case .adjustHeartWeight(let v) where v >= 2: return "Your heart grows dangerously heavy."; case .loseMemories: return "A memory slips beyond your reach."; case .setFirstScalePiece(true), .setSecondScalePiece(true), .setFinalScalePiece(true): return "A piece of the sacred scales has been recovered."; case .setSavedLostSoul(true): return "The soul remembers its name."; case .setGoldenScarab(true): return "The scarab beats with a borrowed pulse."; case .setAmmitFang(true): return "You carry the Fang of the Devourer."; case .setUnderworldPower(true): return "Underworld power now answers you."; case .setLearnedTrueName(true): return "You have learned the hidden title of Anubis."; default: break } }; return "Your choice has been recorded." }
    private func persistProgress() { guard !isRestoring else { return }; let save = TrialOfAnubisSaveState(schemaVersion: 1, currentRoute: path.last ?? .anu001, state: state, isInProgress: isAdventureActive && !(path.last?.rawValue.hasPrefix("END-") ?? false), completedEndings: completedEndings); if let data = try? JSONEncoder().encode(save) { defaults.set(data, forKey: Self.saveKey); hasSavedProgress = save.isInProgress } }
    private func loadSavedProgressFlag() { hasSavedProgress = loadSave()?.isInProgress == true; completedEndings = loadSave()?.completedEndings ?? [] }
    private func loadSave() -> TrialOfAnubisSaveState? { guard let data = defaults.data(forKey: Self.saveKey) else { return nil }; return try? JSONDecoder().decode(TrialOfAnubisSaveState.self, from: data) }
}
