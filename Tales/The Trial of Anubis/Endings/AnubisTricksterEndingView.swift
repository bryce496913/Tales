import SwiftUI

struct AnubisTricksterEndingView: View {
    var body: some View {
        TrialOfAnubisEndingView(title: "Cheat the Scales", classification: "Secret Lose / Sequel Hook", ending: .trickster, outcome: .lose, narrative: """
You place your heart upon the pan.

At the same moment, you whisper Anubis’s hidden title.

The god freezes.

Not from fear.

From command.

The Golden Scarab opens inside your hand and releases its false heartbeat into the scale.

The Balance Stone turns backward.

Your heart rises.

The feather falls.

For one impossible instant, the scales declare you pure.

The Hall erupts with whispers.

Anubis strains against the power of his true name.

“You do not understand what you have altered.”

“I understand enough.”

The gates to the living world open.

You reclaim your heart and step through before the command breaks.

The desert air feels warm and real. Stars shine overhead. Your body is alive.

You survived.

Then the Golden Scarab splits open.

There was never a spirit trapped inside it.

There was a door.

A thin shape unfolds from the broken shell—too tall, too narrow, wearing a face assembled from pieces of people you remember.

It smiles.

Behind you, Anubis shouts a warning from a world already closing.

The creature touches the sand.

Every shadow in the desert turns toward it.

You cheated the scales.

And something ancient used your lie to pass judgment with you.
""", outcomeText: """
**Cheat the Scales**

You manipulated the balance and escaped judgment.

But your deception opened a path for an ancient presence to enter the living world.

Survival is not always victory.
""")
    }
}

struct AnubisTricksterEndingView_Previews: PreviewProvider { static var previews: some View { AnubisTricksterEndingView().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-AnubisTricksterEndingView")!)).environmentObject(AppNavigationState()).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-AnubisTricksterEndingView")!)) } }
