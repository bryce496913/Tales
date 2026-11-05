import SwiftUI

/// Sarutahiko's answer depends on the choice at AMA-007; the fox takes its leave if it knows your name.
struct AMA009View: View {
    @EnvironmentObject
    private var navigationState: CaveOfAmaterasuNavigationState

    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA009",
            title: "The Floating Bridge of Heaven",
            text: storyText,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Continue",
                    destination: .ama010
                )
            }
        }
    }

    private var storyText: String {
        var result: String

        if navigationState.hasFlag(.defiedSarutahiko) {
            result = "Sarutahiko throws back his head and laughs, a sound like falling rocks. “No one’s leave! Good. Then you won’t mind falling.” He steps aside, and you notice that he does not wish you luck."
        } else {
            result = "You bow low and tell him about your village, your grandmother and the sun. Sarutahiko is quiet for a moment. Then he bows back, very slightly, and steps aside. “Walk in the middle,” he says. “The edges are for birds.”"
        }

        if navigationState.hasFlag(.toldFoxYourName) {
            result += " At the foot of the bridge, the white fox stops. “Foxes don’t cross,” it says. “I’ll find you later. I know your name, after all.”"
        }

        result += " The bridge is soft underfoot, like walking on cloud, and it sways with every step. Far below, the islands of Japan lie in total darkness. Here and there, the fires of yokai flicker in the forests, and the sea is as black as ink. You look for your village and find a single tiny light on a hillside: your grandmother’s lantern, still burning. You climb for what feels like hours, until the mist thins and you step off onto soft earth beneath a sky full of stars. You are in Takamagahara, the High Plain of Heaven."

        return result
    }
}

struct AMA009View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA009View()
        }
    }
}
