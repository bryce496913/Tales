import SwiftUI

struct TrialOfAnubisMainMenuView: View {
    let returnToStorySelection: () -> Void

    @EnvironmentObject private var navigationState: TrialOfAnubisNavigationState
    @State private var showsNewAdventureConfirmation = false

    var body: some View {
        ZStack {
            EgyptianBackground()

            ScrollView {
                VStack(spacing: 22) {
                    TrialOfAnubisStaticImage(imageName: "ANU-Title-Screen-Art.png")

                    VStack(spacing: 10) {
                        Text("The Trial of Anubis")
                            .font(.system(size: 38, weight: .bold, design: .serif))
                            .foregroundColor(AppTheme.gold)
                            .multilineTextAlignment(.center)

                        Text("Enter the Egyptian underworld, recover the sacred scales, and face the final judgment of your heart.")
                            .font(.system(.title3, design: .serif).weight(.medium))
                            .foregroundColor(AppTheme.mutedText)
                            .multilineTextAlignment(.center)
                    }
                    .goldCard()
                    .frame(maxWidth: AppTheme.maximumTextWidth)

                    if navigationState.hasSavedProgress {
                        MenuButton(title: "Continue Adventure") {
                            navigationState.continueAdventure()
                        }
                    }

                    MenuButton(title: "New Adventure") {
                        if navigationState.hasSavedProgress {
                            showsNewAdventureConfirmation = true
                        } else {
                            navigationState.startNewAdventure()
                        }
                    }

                    MenuButton(title: "Back to Story Selection") {
                        returnToStorySelection()
                    }
                }
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                .frame(maxWidth: .infinity)
            }
        }
        .confirmationDialog(
            "Start a new Anubis adventure?",
            isPresented: $showsNewAdventureConfirmation,
            titleVisibility: .visible
        ) {
            Button("Start New Adventure", role: .destructive) {
                navigationState.startNewAdventure()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This replaces your unfinished Anubis run but keeps completed Anubis endings.")
        }
    }
}

struct TrialOfAnubisMainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            TrialOfAnubisMainMenuView(returnToStorySelection: {})
        }
    }
}
