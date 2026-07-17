import SwiftUI

struct AnubisRebelEndingView: View {
    var body: some View {
        TrialOfAnubisEndingView(title: "Defy the Gods", classification: "Dark Win / Sequel Hook", ending: .rebel, outcome: .win, narrative: """
You do not place your heart upon the scale.

Instead, you raise the Fang of Ammit.

Underworld power coils around your arm. The Hall darkens as every stolen fragment you accepted answers your command.

Anubis’s eyes blaze.

“You mistake power for freedom.”

“And you mistake authority for justice.”

You strike the Balance Stone.

The Fang cuts through divine law as though it were flesh.

The scales split.

A shockwave tears across the Hall of Judgment. Pillars crack. Gates burst open. Souls scatter toward every road at once.

Ammit roars—not in hunger, but triumph.

Anubis reaches for you.

You speak the first word of rebellion, and the stolen power tears a doorway into the living world.

You step through.

The desert receives you beneath a sky filled with red stars.

The black doorway collapses behind you, but the power does not remain below.

It lives beneath your skin.

Your shadow now has the head of a jackal.

Far away, dogs begin barking.

Mirrors darken.

The dead whisper your name with hope and fear.

You escaped judgment.

But the boundary between worlds is weaker than before, and something in the underworld has begun calling you its liberator.
""", outcomeText: """
**Defy the Gods**

You rejected divine judgment, broke the sacred mechanism, and escaped with stolen underworld power.

You are free—for now—but the consequences have followed you home.
""")
    }
}

struct AnubisRebelEndingView_Previews: PreviewProvider { static var previews: some View { AnubisRebelEndingView().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-AnubisRebelEndingView")!)).environmentObject(AppNavigationState()).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-AnubisRebelEndingView")!)) } }
