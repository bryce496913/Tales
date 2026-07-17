import SwiftUI

struct AnubisAmmitEndingView: View {
    var body: some View {
        TrialOfAnubisEndingView(title: "Devoured by Ammit", classification: "Death", ending: .devouredByAmmit, outcome: .death, narrative: """
Your heart appears in Anubis’s hand.

It is darker than you expected.

Gold clings to it. Broken promises circle it like chains. Every lie has become a mark upon its surface. Every act of cruelty has weight. Every moment you chose power without responsibility presses downward.

Anubis places it on the scale.

The pan falls.

The feather rises.

The sound of the imbalance travels through the hall like a funeral bell.

Ammit stands.

You try to speak.

Perhaps you offer an explanation. Perhaps you insist that your intentions were misunderstood. Perhaps you remind Anubis that others have done worse.

But the scale does not measure comparison.

It measures what you carried here.

Anubis closes his eyes.

“Judgment is not punishment,” he says. “It is revelation.”

Ammit’s jaws open.

Inside them is a darkness deeper than death.

She devours your heart in a single bite.

There is no pain.

Pain requires a self to experience it.

Your memories vanish first. Then your name. Then the shape of everything you might have become.

The last thing you hear is the restored scale settling into balance.
""", outcomeText: """
**Devoured by Ammit**

Your heart outweighed the feather.

The Devourer has consumed your soul, leaving no name, memory, or path back to the living world.
""")
    }
}

struct AnubisAmmitEndingView_Previews: PreviewProvider { static var previews: some View { AnubisAmmitEndingView().environmentObject(TrialOfAnubisNavigationState(defaults: UserDefaults(suiteName: "preview-AnubisAmmitEndingView")!)).environmentObject(AppNavigationState()).environmentObject(GameOptions(defaults: UserDefaults(suiteName: "preview-options-AnubisAmmitEndingView")!)) } }
