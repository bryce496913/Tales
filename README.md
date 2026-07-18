# Tales From the Sphinx

## Creator
Bryce Cameron

## Game Name
Tales From the Sphinx

## Story
Embark on a thrilling adventure through the mysteries of the Sphinx in "Tales From the Sphinx." As the protagonist, you find yourself entangled in a surreal journey filled with unexpected twists and turns. From exploring ancient corridors to encountering mythical creatures, every decision you make shapes your destiny. Uncover the secrets of the Sphinx as you navigate through the enigmatic passages, making choices that lead to different outcomes. Will you escape unscathed, or will the Sphinx's riddles prove to be your ultimate challenge?

## About
"Tales From the Sphinx" is an engaging text-based choose-your-own-adventure game that transports players into a mysterious world inspired by Egyptian mythology. Immerse yourself in a captivating narrative where every decision influences the unfolding story. Navigate through beautifully illustrated scenarios, encountering various challenges, characters, and unexpected events. The game offers a unique and immersive experience, allowing players to shape their destiny by making crucial choices at every juncture.

## Tech Information
**Build Settings:** Build the .ipa file from the Xcode project and install it on your iOS device directly from Xcode.  
**Game Requires:** iOS 16.0+.  
**Supported Devices:** iPhone and iPad.  
**Game Tested On:** iPhone 14 Pro. iPad layout support was reviewed in code with adaptive maximum content widths for story content, text cards, and buttons; simulator execution still requires an Xcode/iOS Simulator host.

## Release Readiness Notes

- Ending progress is recorded when shared outcome screens appear. Completed endings are stored as stable IDs, persist across launches, and do not force immediate navigation away from the visible outcome screen.
- Completed outcome screens are not restored as unfinished adventures after relaunch. Reaching an ending marks the persisted adventure as no longer in progress, while the current in-memory screen remains visible until the player chooses Restart Adventure or Return to Main Menu.
- Restart Adventure and Return to Main Menu preserve completed-ending history. Reset Story Progress clears completed endings along with the saved route.
- `StoryPageEffects` contains only active page-specific presentation fields: `entryTransition` and `choicesWaitForText`.
- `GameOptions` remains the source of truth for player-controlled effects, including typewriter enablement, typewriter speed, page transitions, haptics, button glow, outcome animations, and sound-effect preference.
- SwiftUI previews use a shared `PreviewContainer` with isolated preview `UserDefaults` and required `GameOptions` and `AppNavigationState` environment objects.

## Ending ID Mapping

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

Feel the suspense, make strategic decisions, and explore the world of "Tales From the Sphinx" – an interactive adventure that puts you in control of your destiny.
