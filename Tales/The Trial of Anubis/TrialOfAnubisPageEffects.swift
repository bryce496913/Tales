import SwiftUI

struct TrialOfAnubisPageEffects {
    let entryTransition: TrialOfAnubisTransitionStyle
    let choicesWaitForText: Bool

    static let standard = TrialOfAnubisPageEffects(
        entryTransition: .sandFade,
        choicesWaitForText: true
    )
}
