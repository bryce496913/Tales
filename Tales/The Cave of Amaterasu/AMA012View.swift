import SwiftUI

struct AMA012View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA012",
            title: "The Council of the Gods",
            text: """
            Beside the Heavenly River, the eight hundred myriad gods of heaven have gathered in front of a cliff of black rock, holding torches and arguing at the tops of their voices. At the foot of the cliff is a great boulder, sealed tight, and a thin thread of golden light leaks from the crack around its edge. This is the Heavenly Rock Cave. A thin old god with a long white beard notices you and quiets the crowd. He is Omoikane, the god of wisdom. He has a plan to coax Amaterasu out, he says, but it needs three treasures, and they were scattered across the earth when Susanoo raged through heaven. The Eight-Hand Mirror fell on Mount Kurama, where the King of the Tengu keeps it. The string of Curved Jewels sank into the sea, and the Dragon King has claimed it. And a sword lies in the tail of the eight-headed serpent of Izumo. “Gods who walk the earth in this darkness lose their way,” Omoikane says. “But you found your way here.”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Accept the task",
                    destination: .ama014
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Peek through the crack",
                    destination: .ama013
                )
            }
        }
    }
}

struct AMA012View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA012View()
        }
    }
}
