import SwiftUI

struct OptionsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var gameOptions: GameOptions
    @State private var confirmingReset = false

    var body: some View {
        ZStack {
            EgyptianBackground()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Back", systemImage: "chevron.left")
                            .font(.system(.headline, design: .serif).weight(.semibold))
                            .foregroundColor(Color(hex: "1E140B"))
                            .frame(maxWidth: .infinity, minHeight: 54)
                    }
                    .buttonStyle(StoryChoiceButtonStyle())
                    .accessibilityLabel("Back to main menu")

                    optionSection("Story") {
                        OptionToggleRow(title: "Typewriter Text", detail: "Reveal story text gradually.", isOn: $gameOptions.typewriterEnabled)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Text Speed").font(.system(.headline, design: .serif)).foregroundColor(AppTheme.gold)
                            Picker("Text Speed", selection: Binding(get: { gameOptions.typewriterSpeed }, set: { gameOptions.typewriterSpeed = $0 })) {
                                ForEach(TypewriterSpeedOption.allCases) { option in Text(option.title).tag(option) }
                            }
                            .pickerStyle(.segmented)
                            .disabled(!gameOptions.typewriterEnabled)
                            .opacity(gameOptions.typewriterEnabled ? 1 : 0.45)
                            Text("Controls the typewriter reveal speed when enabled.").font(.caption).foregroundColor(AppTheme.mutedText)
                        }
                        .accessibilityElement(children: .combine)
                        OptionToggleRow(title: "Page Transitions", detail: "Use sand, torch, and stone doorway transitions.", isOn: $gameOptions.pageTransitionsEnabled)
                    }
                    optionSection("Feedback") {
                        OptionToggleRow(title: "Haptics", detail: "Play tactile feedback for choices and endings.", isOn: $gameOptions.hapticsEnabled)
                        OptionToggleRow(title: "Button Glow", detail: "Use ambient glow around choice buttons.", isOn: $gameOptions.buttonGlowEnabled)
                        OptionToggleRow(title: "Outcome Animations", detail: "Animate victory, defeat, and death cards.", isOn: $gameOptions.outcomeAnimationsEnabled)
                        OptionToggleRow(title: "Sound Effects", detail: "Saved now for a future sound-effects pass.", isOn: $gameOptions.soundEffectsEnabled)
                    }
                    optionSection("Reset") {
                        ChoiceButton("Reset to Defaults") { confirmingReset = true }
                            .accessibilityLabel("Reset options to defaults")
                    }
                }
                .padding(AppTheme.screenPadding)
            }
        }
        .navigationTitle("Options")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Reset all options to their default values?", isPresented: $confirmingReset, titleVisibility: .visible) {
            Button("Reset to Defaults", role: .destructive) { gameOptions.resetToDefaults() }
            Button("Cancel", role: .cancel) {}
        }
    }

    private func optionSection<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title).font(.system(.title3, design: .serif).weight(.bold)).foregroundColor(AppTheme.gold)
            content()
        }.frame(maxWidth: .infinity, alignment: .leading).goldCard()
    }
}

struct OptionToggleRow: View {
    let title: String
    let detail: String
    @Binding var isOn: Bool
    var body: some View {
        Toggle(isOn: $isOn) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.system(.headline, design: .serif)).foregroundColor(AppTheme.warmText)
                Text(detail).font(.caption).foregroundColor(AppTheme.mutedText)
            }
        }
        .tint(AppTheme.gold)
        .accessibilityLabel(title)
        .accessibilityHint(detail)
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer {
            OptionsView()
        }
    }
}
