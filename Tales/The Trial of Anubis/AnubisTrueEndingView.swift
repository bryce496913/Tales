import SwiftUI

struct AnubisTrueEndingView: View {
    var body: some View {
        TrialOfAnubisEndingView(title: "The Scales Restored", classification: "Win / Best Ending", ending: .trueEnding, outcome: .win, narrative: """
Your heart leaves your chest without pain. It appears in Anubis’s hand as a sphere of living red light. Within it move every choice you made: the soul you freed, the treasure you refused or surrendered, the truths you accepted, the fear you carried without allowing it to rule you. Anubis places the heart upon the pan. The scales move. For one terrible moment, your heart sinks. Ammit raises her head. Then the feather descends to meet it. The balance becomes still. Across the Hall of Judgment, every gate opens at once. The waiting dead begin to move. Names return to forgotten faces. The stolen hearts rise from their vessels and pass like red stars through the darkness. Anubis studies the balance. “A light heart is not an empty heart,” he says. “It carries grief, failure, fear, and responsibility. It becomes light when it refuses to place those burdens upon others.” He returns your heart. The instant it enters your chest, the Hall fills with dawn. You stand again in the desert before the black doorway. Wind moves across the dunes. Stars burn overhead. In your hand lies a small feather of gold. Behind you, the doorway sinks beneath the sand. Yet just before it disappears, Anubis’s voice reaches you one final time. “Live as one who has already been weighed.”
""", outcomeText: """
You returned all three sacred pieces, faced judgment honestly, and proved that mercy and responsibility can outweigh fear. Anubis has returned you to the living world with his blessing.
""")
    }
}

struct AnubisTrueEndingView_Previews: PreviewProvider { static var previews: some View { AnubisTrueEndingView().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-AnubisTrueEndingView")!)).environmentObject(AppNavigationState()).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-AnubisTrueEndingView")!)) } }
