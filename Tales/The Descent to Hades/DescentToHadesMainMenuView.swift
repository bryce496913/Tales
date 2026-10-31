import SwiftUI

struct DescentToHadesMainMenuView: View {
    let returnToStorySelection: () -> Void

    @EnvironmentObject private var navigationState: DescentToHadesNavigationState
    @State private var showsNewAdventureConfirmation = false

    var body: some View {
        ZStack {
            DescentToHadesBackground()

            ScrollView {
                VStack(spacing: 22) {
                    DescentToHadesStaticImage(imageName: "HDS-Title-Screen-Art.png")

                    VStack(spacing: 10) {
                        Text("The Descent to Hades")
                            .font(.system(size: 38, weight: .bold, design: .serif))
                            .foregroundColor(DescentToHadesTheme.bronze)
                            .multilineTextAlignment(.center)

                        Text("Cross the river Styx, win the favour of the gods of the dead, and bring your brother home without looking back.")
                            .font(.system(.title3, design: .serif).weight(.medium))
                            .foregroundColor(DescentToHadesTheme.mutedText)
                            .multilineTextAlignment(.center)
                    }
                    .bronzeCard()
                    .frame(maxWidth: AppTheme.maximumTextWidth)

                    VStack(spacing: 12) {
                        if navigationState.hasSavedProgress {
                            DescentToHadesButton("Continue Adventure") {
                                navigationState.continueAdventure()
                            }
                        }

                        DescentToHadesButton("New Adventure") {
                            if navigationState.hasSavedProgress {
                                showsNewAdventureConfirmation = true
                            } else {
                                navigationState.startNewAdventure()
                            }
                        }

                        DescentToHadesButton("Back to Story Selection") {
                            returnToStorySelection()
                        }
                    }
                    .frame(maxWidth: 280)
                }
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                .frame(maxWidth: .infinity)
            }
        }
        .confirmationDialog(
            "Start a new Hades adventure?",
            isPresented: $showsNewAdventureConfirmation,
            titleVisibility: .visible
        ) {
            Button("Start New Adventure", role: .destructive) {
                navigationState.startNewAdventure()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This replaces your unfinished Hades run but keeps completed Hades endings.")
        }
    }
}

struct DescentToHadesMainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            DescentToHadesMainMenuView(returnToStorySelection: {})
        }
    }
}
