import SwiftUI

struct StorySelectionCard: View {
    let title: String
    let subtitle: String
    let statusText: String
    let imageName: String?
    let systemImageName: String
    let actionTitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 16) {
                artwork

                VStack(alignment: .leading, spacing: 8) {
                    Text(statusText)
                        .font(.system(.caption, design: .serif).weight(.bold))
                        .foregroundColor(Color(hex: "1E140B"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(AppTheme.gold))
                        .accessibilityLabel("Status: \(statusText)")

                    Text(title)
                        .font(.system(.title2, design: .serif).weight(.bold))
                        .foregroundColor(AppTheme.gold)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(subtitle)
                        .font(.system(.body, design: .serif).weight(.medium))
                        .foregroundColor(AppTheme.mutedText)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)

                Text(actionTitle)
                    .font(.system(.headline, design: .serif).weight(.semibold))
                    .foregroundColor(Color(hex: "1E140B"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity, minHeight: 54)
                    .background(
                        RoundedRectangle(cornerRadius: AppTheme.buttonRadius, style: .continuous)
                            .fill(AppTheme.gold)
                    )
            }
            .padding(AppTheme.cardPadding)
            .frame(maxWidth: .infinity, minHeight: 430, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                    .fill(AppTheme.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                            .stroke(AppTheme.gold.opacity(0.55), lineWidth: 1)
                    )
                    .shadow(color: AppTheme.shadow, radius: 18, x: 0, y: 10)
            )
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title), \(statusText), \(subtitle)")
        .accessibilityHint("Activates \(actionTitle).")
    }

    @ViewBuilder
    private var artwork: some View {
        if let imageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 190)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous)
                        .stroke(AppTheme.gold.opacity(0.45), lineWidth: 1)
                )
                .accessibilityHidden(true)
        } else {
            ZStack {
                LinearGradient(
                    colors: [AppTheme.cardAlt, AppTheme.backgroundTop, AppTheme.backgroundBottom],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                VStack(spacing: 10) {
                    Image(systemName: systemImageName)
                        .font(.system(size: 46, weight: .semibold))
                    Text(title)
                        .font(.system(.headline, design: .serif).weight(.bold))
                        .multilineTextAlignment(.center)
                    Text(statusText)
                        .font(.system(.caption, design: .serif).weight(.bold))
                }
                .foregroundColor(AppTheme.gold)
                .padding()
            }
            .frame(height: 190)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.imageRadius, style: .continuous)
                    .stroke(AppTheme.gold.opacity(0.45), lineWidth: 1)
            )
            .accessibilityHidden(true)
        }
    }
}

struct StorySelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            EgyptianBackground()
            StorySelectionCard(
                title: "The Trial of Anubis",
                subtitle: "Enter the underworld and face the judgment of Anubis.",
                statusText: "Coming Soon",
                imageName: nil,
                systemImageName: "scalemass.fill",
                actionTitle: "View Story"
            ) {}
            .padding()
        }
    }
}
