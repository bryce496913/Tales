import SwiftUI

/// One ending a story can reach, shown in the endings gallery by its page's illustration.
struct EndingEntry: Identifiable {
    let id: String
    let imageName: String
}

extension BranchingRoute {
    /// The page's illustration, named after its route number (ANU-012 → ANU012).
    var imageName: String { rawValue.replacingOccurrences(of: "-", with: "") }
}

extension BranchingStory {
    /// Every ending in the story, in page order.
    static var endings: [EndingEntry] {
        Route.allCases.compactMap { route in
            route.endingID.map { EndingEntry(id: $0, imageName: route.imageName) }
        }
    }
}

/// A grid of a story's endings: the art of each one found, a locked tile for the rest.
struct EndingsGalleryView: View {
    let storyTitle: String
    let endings: [EndingEntry]
    let found: Set<String>

    @Environment(\.dismiss) private var dismiss
    @Environment(\.storyTheme) private var theme

    private let columns = [GridItem(.adaptive(minimum: 96), spacing: 12)]

    var body: some View {
        ZStack {
            StoryBackground()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    VStack(spacing: 6) {
                        Text(storyTitle)
                            .font(.system(.title2, design: .serif).weight(.bold))
                            .foregroundColor(theme.accent)
                            .multilineTextAlignment(.center)
                            .accessibilityAddTraits(.isHeader)
                        Text(EndingsGalleryView.summary(found: foundCount, total: endings.count))
                            .font(.system(.headline, design: .serif))
                            .foregroundColor(theme.mutedText)
                    }
                    .frame(maxWidth: .infinity)
                    .storyCard()

                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(endings) { ending in
                            tile(for: ending)
                        }
                    }

                    ChoiceButton("Close") { dismiss() }
                        .frame(maxWidth: 280)
                }
                .padding(AppTheme.screenPadding)
                .frame(maxWidth: AppTheme.maximumStoryContentWidth)
                .frame(maxWidth: .infinity)
            }
        }
    }

    static func summary(found: Int, total: Int) -> String {
        "\(found) of \(total) endings found"
    }

    private var foundCount: Int {
        endings.filter { found.contains($0.id) }.count
    }

    @ViewBuilder
    private func tile(for ending: EndingEntry) -> some View {
        let isFound = found.contains(ending.id)
        ZStack {
            if isFound, let image = UIImage(named: ending.imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                theme.cardAlt
                Image(systemName: isFound ? theme.placeholderSymbol : "lock.fill")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(theme.accent.opacity(isFound ? 1 : 0.6))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(theme.accent.opacity(isFound ? 0.7 : 0.3), lineWidth: 1))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(isFound ? "Ending found" : "Ending not found yet")
    }
}

/// Presents a story's endings gallery in that story's colours.
struct EndingsGallerySheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    let storyTitle: String
    let endings: [EndingEntry]
    let found: Set<String>
    let theme: StoryTheme

    @EnvironmentObject private var gameOptions: GameOptions

    func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresented) {
            EndingsGalleryView(storyTitle: storyTitle, endings: endings, found: found)
                .environmentObject(gameOptions)
                .environment(\.storyTheme, theme)
        }
    }
}

extension View {
    func endingsGallery(isPresented: Binding<Bool>, storyTitle: String, endings: [EndingEntry], found: Set<String>, theme: StoryTheme) -> some View {
        modifier(EndingsGallerySheetModifier(isPresented: isPresented, storyTitle: storyTitle, endings: endings, found: found, theme: theme))
    }
}
