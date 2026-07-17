# Tales

A multi-story choose-your-own-adventure app.

Tales is the V3 SwiftUI shell for hosting independent interactive adventures behind a shared story library, app-level menu, global options, and per-story progress storage.

## Current stories

| Story | Story ID | Status | Canonical architecture |
| --- | --- | --- | --- |
| Tales From the Sphinx | `tales-from-the-sphinx` | Available and playable | `Tales_From_the_Sphinx_Story.md` |
| The Trial of Anubis | `trial-of-anubis` | Architecture complete; implementation coming soon | `The_Trial_of_Anubis_Story_Architecture.md` |

## High-level structure

The current Xcode project still keeps many Swift files under the existing `Tales/Tales From the Sphinx/` group to avoid unsafe file-reference churn during the V3 menu pass, but the code is separated conceptually into these boundaries:

```text
Tales/
├── App/                      AppRootView, TalesApp, AppRoute, AppNavigationState, TalesSplashView
├── Features/
│   ├── MainMenu/             AppMainMenuView
│   ├── StoryLibrary/         StoryLibraryView, StoryCardView, StoryDetailView, ComingSoonStoryView
│   └── Options/              OptionsView and global app preferences
├── Shared/
│   ├── Models/               StoryID, StoryDescriptor, StoryAvailability
│   ├── Catalog/              StoryCatalog
│   ├── DesignSystem/         AppTheme, EgyptianBackground
│   ├── Components/           MenuButton, ChoiceButton, shared story UI
│   └── Settings/             GameOptions
└── Stories/
    ├── TalesFromTheSphinx/   SphinxStoryRootView, SphinxStoryMenuView, SphinxNavigationState, SphinxRoute, pages
    └── TrialOfAnubis/        TrialOfAnubisPlaceholderView and architecture documentation
```

## Story identity and saves

Story IDs are stable persistence identifiers and must not be changed without a migration:

- `tales-from-the-sphinx`
- `trial-of-anubis`

Tales From the Sphinx progress is isolated under:

```text
Tales.story.tales-from-the-sphinx.save.v3
```

A safe one-time migration copies compatible legacy data from:

```text
Tales.story.save.v2
```

The legacy value is not deleted after a successful copy. Global `GameOptions` remain app-wide and are not migrated into story saves.

## Asset naming requirements

Existing Tales From the Sphinx art includes generic bundle names such as `One.png`, `Two.png`, and `Plot1.png`. Do not add new assets with similarly generic names. Future story assets must use a unique prefix, for example:

```text
anubis_cover.png
anubis_node_01.png
anubis_ending_mercy.png
```

## Adding another story

1. Add a case to `StoryID` using a stable raw-value persistence key.
2. Add a `StoryDescriptor` in `StoryCatalog`.
3. Add uniquely prefixed assets; never collide with existing generic Sphinx image names.
4. Add a story module with its own root view, menu, routes, and navigation/progress state.
5. Register the story in `StoryHostView`.
6. Add story-specific progress storage and migrations as needed.
7. Add canonical architecture documentation.
8. Add route, graph, catalog, navigation, and persistence tests.

## The Trial of Anubis

`The_Trial_of_Anubis_Story_Architecture.md` is the canonical design source for the future implementation. The V3 app shell only exposes it as a coming-soon preview and does not implement the 28 story nodes or 5 endings yet.
