# Tales

A multi-story choose-your-own-adventure app.

Tales is the V3 SwiftUI shell for hosting independent interactive adventures behind a shared story library, app-level menu, global options, and per-story progress storage.

## Current stories

| Story | Story ID | Status | Canonical architecture |
| --- | --- | --- | --- |
| Tales From the Sphinx | `tales-from-the-sphinx` | Available and playable | `Tales_From_the_Sphinx_Story.md` |
| The Trial of Anubis | `trial-of-anubis` | Available / Playable | `Tales/The Trial of Anubis/Documentation/The_Trial_of_Anubis_Story_Architecture.md` |

## The Trial of Anubis

The Trial of Anubis is the second playable story in Tales.

- **Story ID:** `trial-of-anubis`
- **Story version:** `1.0`
- **Core nodes:** 28 (`ANU-001` through `ANU-028`)
- **Terminal endings:** 5
- **Save key:** `Tales.story.trial-of-anubis.save.v1`
- **Canonical Markdown files:**
  - `Tales/The Trial of Anubis/Documentation/The_Trial_of_Anubis_Full_Story_Views.md`
  - `Tales/The Trial of Anubis/Documentation/The_Trial_of_Anubis_Story_Architecture.md`

### State systems

The Trial of Anubis tracks story-specific state independently from Tales From the Sphinx:

- **Heart Weight:** clamped to `-6...6` and displayed as Light Heart, Balanced Heart, or Heavy Heart rather than as a raw score.
- **Memories:** begin at `3`; memory loss is applied immediately and can route directly to the Lost Soul ending when memories reach zero.
- **Allegiance:** `undecided`, `anubis`, `rebel`, or `self`.
- **Scale pieces:** Feather Arm, Heart Pan, and Balance Stone recovery flags persist through save and continue.
- **Items and knowledge:** Golden Scarab, Fang of Ammit, Underworld Power, and Hidden Title of Anubis are surfaced to the player when held or learned.
- **Conditional choices:** unavailable secret choices are hidden until their requirements are met.

### Ending IDs

Completed endings are recorded once in the Anubis save state as a story-specific `Set<TrialOfAnubisEnding>` and do not affect Tales From the Sphinx progress.

- `anubis_true_restored`
- `anubis_dark_ammit`
- `anubis_rebel_escape`
- `anubis_trickster_cheat`
- `anubis_lost_soul`

Restarting The Trial of Anubis resets only the active Anubis run and preserves discovered Anubis endings. Returning to the app menu and resetting global options do not erase completed-ending history.

> Developer warning: Never change an ANU node ID, ending ID, route destination, or effect without updating both canonical Markdown files and the route tests.

## High-level structure

```text
Tales/
├── Tales From the Sphinx/     Existing Sphinx story, shared app shell, shared components
└── The Trial of Anubis/       Anubis story root, route/state models, content, views, endings, documentation
```

## Story identity and saves

Story IDs are stable persistence identifiers and must not be changed without a migration:

- `tales-from-the-sphinx`
- `trial-of-anubis`

Tales From the Sphinx progress is isolated under:

```text
Tales.story.tales-from-the-sphinx.save.v3
```

The Trial of Anubis progress is isolated under:

```text
Tales.story.trial-of-anubis.save.v1
```

Global `GameOptions` remain app-wide and are not migrated into story saves.

## Asset naming requirements

Existing Tales From the Sphinx art includes generic bundle names such as `One.png`, `Two.png`, and `Plot1.png`. Do not add new assets with similarly generic names. Future story assets must use a unique prefix, for example:

```text
anubis_cover.png
anubis_node_001.png
anubis_end_true.png
```
