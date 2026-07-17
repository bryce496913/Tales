import SwiftUI

struct AnubisLostSoulEndingView: View {
    var body: some View {
        TrialOfAnubisEndingView(title: "Lost Soul", classification: "Lose", ending: .lostSoul, outcome: .lose, narrative: """
You are walking through fog.

You know there was a task.

Something broken.

Three pieces, perhaps.

A voice once spoke your name, but the name no longer belongs to anyone you recognize.

You try to remember home.

There is a room without a location.

A face without features.

Warmth without a source.

The memories fall apart when you reach for them.

Other souls move beside you.

Some whisper fragments of themselves.

“I had a daughter.”

“I built something.”

“I was afraid.”

“I was called…”

None can finish.

A faceless ferryman waits beside a black river.

He does not ask for payment.

You have nothing left to give.

Across the water, the Hall of Judgment glows with distant gold. Somewhere within it, Anubis calls for the living traveler who entered his temple.

You want to answer.

You cannot remember that he means you.

The procession moves forward.

Your footsteps join the sound of thousands.

Soon, even the desire to remember is gone.
""", outcomeText: """
**Lost Soul**

The underworld took your final memory.

Without a name, a past, or a purpose, you have joined the procession of forgotten souls.
""")
    }
}

struct AnubisLostSoulEndingView_Previews: PreviewProvider { static var previews: some View { AnubisLostSoulEndingView().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-AnubisLostSoulEndingView")!)).environmentObject(AppNavigationState()).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-AnubisLostSoulEndingView")!)) } }
