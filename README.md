# Tales

An iOS collection of illustrated choose-your-own-adventure stories inspired by Egyptian mythology. Players pick a story from the Tales main menu, and each story keeps its own saved progress and completed endings.

## Creator
Bryce Cameron

## Stories

### Tales From the Sphinx
Embark on a thrilling adventure through the mysteries of the Sphinx in "Tales From the Sphinx." As the protagonist, you find yourself entangled in a surreal journey filled with unexpected twists and turns. From exploring ancient corridors to encountering mythical creatures, every decision you make shapes your destiny. Uncover the secrets of the Sphinx as you navigate through the enigmatic passages, making choices that lead to different outcomes. Will you escape unscathed, or will the Sphinx's riddles prove to be your ultimate challenge?

### The Trial of Anubis
Enter the Egyptian underworld, recover the sacred scales, and face the final judgment of your heart. A branching story across 48 pages (`ANU-000`…`ANU-047`) built around the Hall of Gates hub: recover the Feather Arm, Heart Pan and Balance Stone, then decide what to do with the restored scales. Ten endings, listed below.

## About
"Tales From the Sphinx" is an engaging text-based choose-your-own-adventure game that transports players into a mysterious world inspired by Egyptian mythology. Immerse yourself in a captivating narrative where every decision influences the unfolding story. Navigate through beautifully illustrated scenarios, encountering various challenges, characters, and unexpected events. The game offers a unique and immersive experience, allowing players to shape their destiny by making crucial choices at every juncture.

## Tech Information
**Build Settings:** Build the .ipa file from the Xcode project and install it on your iOS device directly from Xcode.  
**Game Requires:** iOS 16.0+.  
**Supported Devices:** iPhone and iPad.  
**Game Tested On:** iPhone 14 Pro. iPad layout support was reviewed in code with adaptive maximum content widths for story content, text cards, and buttons; simulator execution still requires an Xcode/iOS Simulator host.

## Project Layout

- `Tales/` – shared app shell: main menu, story selection, options, theme, and the shared page/outcome components used by Tales From the Sphinx.
- `Tales/Tales From the Sphinx/` – Sphinx pages (`Plot1View`, `Plot2View`, `Page1View`…`Page25View`), root view, images, and the story script.
- `Tales/The Trial of Anubis/` – Anubis pages (`ANU000View`…`ANU047View`, game-over pages included), its own navigation/progress state and presentation components, images, and the story map.
- `Tales/TalesAmbience.m4a` – looping background ambience, played by `AmbiencePlayer` and toggled under Options > Sound.
- `scripts/audio/generate_ambience.py` – the script that synthesizes the ambience, for regenerating or tweaking it.
- `scripts/release_readiness_checks.py` – static checks run before a release (see below).

## Release Checks

Run from the repository root:

```bash
python3 scripts/release_readiness_checks.py
```

It verifies that every Swift file is in the Xcode project (and vice versa), every referenced image exists and every PNG is added to the Xcode project and bundled, every referenced audio file exists and is bundled, Sphinx ending IDs match the table below, every Anubis route is handled and points somewhere valid, and Anubis ending IDs match the navigation state.

## Release Readiness Notes

- Ending progress is recorded when shared outcome screens appear. Completed endings are stored as stable IDs, persist across launches, and do not force immediate navigation away from the visible outcome screen.
- Completed outcome screens are not restored as unfinished adventures after relaunch. Reaching an ending marks the persisted adventure as no longer in progress, while the current in-memory screen remains visible until the player chooses Restart Adventure or Return to Main Menu.
- Restart Adventure and Return to Main Menu preserve completed-ending history. Reset Story Progress clears completed endings along with the saved route.
- `StoryPageEffects` contains only active page-specific presentation fields: `entryTransition` and `choicesWaitForText`.
- `GameOptions` is the single source of truth for player-controlled effects, including typewriter enablement, typewriter speed, page transitions, haptics, button glow, outcome animations, and sound-effect preference. Story navigation state stores only the route, in-progress flag, and completed endings.
- SwiftUI previews use a shared `PreviewContainer` with isolated preview `UserDefaults` and required `GameOptions` and `AppNavigationState` environment objects.

## Tales From the Sphinx Ending ID Mapping

- `Page2View`: `page2-death`
- `Page7View`: `page7-lose`
- `Page11View`: `page11-death`
- `Page13View`: `page13-win`
- `Page14View`: `page14-death`
- `Page15View`: `page15-lose`
- `Page20View`: `page20-lose`
- `Page21View`: `page21-death`
- `Page22View`: `page22-lose`
- `Page24View`: `page24-death`
- `Page25View`: `page25-death`

## The Trial of Anubis Ending ID Mapping

Game-over pages are numbered story routes. See `Tales/The Trial of Anubis/The_Trial_of_Anubis_Story_Map.md` for the full story map.

- `ANU003View` (`ANU-003`, Lost in the Sand): `anubis_lost_in_desert`
- `ANU017View` (`ANU-017`, Swallowed by the Fog): `anubis_swallowed_by_fog`
- `ANU028View` (`ANU-028`, Lord of the Tomb): `anubis_lord_of_the_tomb`
- `ANU029View` (`ANU-029`, Released): `anubis_released`
- `ANU030View` (`ANU-030`, The Scales Restored): `anubis_scales_restored`
- `ANU032View` (`ANU-032`, Devoured by Ammit): `anubis_devoured_by_ammit`
- `ANU035View` (`ANU-035`, Taken by the River): `anubis_taken_by_the_river`
- `ANU038View` (`ANU-038`, Buried with the Stone): `anubis_buried_with_the_stone`
- `ANU040View` (`ANU-040`, A Peaceful Death): `anubis_peaceful_death`
- `ANU047View` (`ANU-047`, Defy the Gods): `anubis_defy_the_gods`

Feel the suspense, make strategic decisions, and explore the world of "Tales From the Sphinx" – an interactive adventure that puts you in control of your destiny.
