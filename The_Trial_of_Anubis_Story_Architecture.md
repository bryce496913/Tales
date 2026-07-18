# The Trial of Anubis — Story and Architecture

**Document role:** Canonical narrative and branching-logic source of truth  
**Series:** Tales From the Sphinx V3  
**Story ID:** `trial-of-anubis`  
**Story version:** 1.0  
**Status:** Initial complete story architecture  
**Target length:** 28 core story nodes plus 5 terminal endings  
**Last updated:** 2026-07-16

---

# 1. Story Overview

## Title

**The Trial of Anubis**

## Logline

After discovering a hidden jackal temple beneath the desert, the player is summoned into the Egyptian underworld and tasked with recovering the stolen pieces of Anubis’s sacred scales. Every choice changes the weight of the player’s heart, shaping which paths open and how judgment ultimately ends.

## Core Premise

The scales used by Anubis to judge the dead have been shattered and stolen.

Without them:

- the dead are escaping judgment;
- lost souls are crossing into the living world;
- memories are becoming unstable;
- Ammit is growing hungry and uncontrollable;
- the boundary between life and death is beginning to collapse.

The player is unexpectedly drawn into the underworld. Anubis claims that the player’s heart has been “expected” and demands their help.

The player may:

- willingly help Anubis;
- bargain for power;
- pretend to help while planning escape;
- challenge the gods;
- become corrupted by treasure and fear;
- show mercy to the dead;
- manipulate the final judgment.

The ending is not determined by one final button. It is determined by the cumulative weight of the player’s choices.

---

# 2. Story Identity

## Relationship to Tales From the Sphinx

**Tales From the Sphinx** is primarily about survival, exploration, puzzles, avoiding traps, and finding the correct path.

**The Trial of Anubis** is primarily about judgment, consequence, morality, memory, power, and identity.

The visual and mythological world remains Egyptian, but the emotional tone and gameplay rules are intentionally different.

## Genre

- Choose Your Own Adventure
- Mythological Fantasy
- Dark Adventure
- Moral Decision Game
- Branching Narrative
- Puzzle and Exploration

## Tone

- Mysterious
- Supernatural
- Dark but not relentlessly grim
- Mythological
- Occasionally surreal
- Morally ambiguous

## Themes

- Whether actions matter more than intentions
- Mercy versus self-preservation
- Truth versus survival
- The danger of power without responsibility
- Memory as identity
- Whether divine authority deserves obedience
- The difference between justice and punishment

---

# 3. Core Gameplay System

## Primary Mechanic: Heart Weight

The player’s decisions affect a hidden or partially visible value called `heartWeight`.

Recommended range:

```text
-6 to +6
```

| Heart Weight | Meaning |
|---|---|
| `-6` to `-3` | Light heart: merciful, brave, selfless |
| `-2` to `+2` | Balanced heart: morally mixed |
| `+3` to `+6` | Heavy heart: greedy, cruel, deceptive |

Typical effects:

| Choice type | Effect |
|---|---|
| Show mercy | `heartWeight -= 1` |
| Act bravely for another | `heartWeight -= 1` |
| Tell a costly truth | `heartWeight -= 1` |
| Take treasure | `heartWeight += 1` |
| Betray a soul | `heartWeight += 2` |
| Lie to a god | `heartWeight += 1` |
| Refuse cruelty | `heartWeight -= 1` |
| Use forbidden power | `heartWeight += 1` |
| Accept responsibility | `heartWeight -= 1` |
| Manipulate judgment | `heartWeight += 2` |

Clamp the value:

```swift
heartWeight = min(6, max(-6, heartWeight))
```

---

# 4. Secondary Story State

```swift
struct TrialOfAnubisState {
    var heartWeight: Int = 0
    var allegiance: Allegiance = .undecided
    var savedLostSoul: Bool = false
    var tookGoldenScarab: Bool = false
    var possessesAmmitFang: Bool = false
    var learnedTrueName: Bool = false
    var acceptedUnderworldPower: Bool = false
    var liedToAnubis: Bool = false
    var memoriesRemaining: Int = 3
    var firstScalePieceRecovered: Bool = false
    var secondScalePieceRecovered: Bool = false
    var finalScalePieceRecovered: Bool = false
    var finalEndingID: String? = nil
}

enum Allegiance {
    case undecided
    case anubis
    case rebel
    case self
}
```

### Allegiance Meaning

- `undecided`: the player has not committed.
- `anubis`: the player intends to restore order.
- `rebel`: the player intends to challenge divine authority.
- `self`: the player primarily seeks escape, treasure, or personal survival.

---

# 5. Story Resources

## Memories

The player begins with:

```text
memoriesRemaining = 3
```

Certain choices cause a memory to be lost. At `0`, route to the **Lost Soul Ending**.

## Scale Pieces

The player must recover:

1. Feather Arm
2. Heart Pan
3. Balance Stone

## Optional Items

### Golden Scarab

- Makes the heart heavier.
- Helps unlock the cheat-the-scales ending.
- May be sacrificed later to lighten the heart.

### Fang of Ammit

- Enables the strongest rebel ending route.
- Makes the heart heavier.
- Shows willingness to challenge divine order.

---

# 6. Ending Registry

## True Ending — The Scales Restored

**Ending ID:** `anubis_true_restored`

Recommended requirements:

```text
all three scale pieces recovered
heartWeight <= 0
savedLostSoul == true
allegiance == anubis
final choice == honest judgment
```

Outcome: The scales are restored, the player passes judgment honestly, and Anubis returns them to the living world with his blessing.

Classification: Win / best ending.

## Dark Ending — Devoured by Ammit

**Ending ID:** `anubis_dark_ammit`

Triggered when:

```text
heartWeight >= 4
player submits to judgment
no valid cheat or rebellion override applies
```

Outcome: The heart outweighs the feather. Ammit devours it and erases the player’s soul.

Classification: Death.

## Rebel Ending — Defy the Gods

**Ending ID:** `anubis_rebel_escape`

Recommended requirements:

```text
possessesAmmitFang == true
acceptedUnderworldPower == true
allegiance == rebel
final choice == challenge
```

Outcome: The player rejects judgment, damages the sacred mechanism, and escapes with stolen underworld power.

Classification: Dark win / sequel hook.

## Trickster Ending — Cheat the Scales

**Ending ID:** `anubis_trickster_cheat`

Recommended requirements:

```text
tookGoldenScarab == true
learnedTrueName == true
final choice == manipulate
```

Outcome: The player alters the balance and survives, but something ancient escapes into the living world.

Classification: Secret lose ending / sequel hook.

## Lost Soul Ending

**Ending ID:** `anubis_lost_soul`

Requirement:

```text
memoriesRemaining <= 0
```

Outcome: The player forgets their name, life, and purpose, joining the procession of forgotten souls.

Classification: Lose.

---

# 7. High-Level Structure

```text
Act I — The Summons
1. Desert discovery
2. Hidden jackal temple
3. First meeting with Anubis
4. Choose allegiance or intent

Act II — The Broken Underworld
5. Cross the river
6. Enter the Hall of Whispers
7. Recover the first scale piece
8. Choose mercy or treasure
9. Enter the Chamber of Stolen Hearts
10. Encounter Ammit

Act III — Memory and Temptation
11. Enter the Maze of False Memories
12. Recover the second scale piece
13. Learn the truth behind the theft
14. Accept or reject forbidden power
15. Recover the final scale piece

Act IV — Judgment
16. Return to Anubis
17. Submit, rebel, or cheat
18. Resolve ending from accumulated state
```

---

# 8. Canonical Node Inventory

| Node ID | Working title | Type |
|---|---|---|
| `ANU-001` | The Silent Desert | Story |
| `ANU-002` | The Black Doorway | Choice |
| `ANU-003` | The Jackal Temple | Choice |
| `ANU-004` | The Voice Below | Choice |
| `ANU-005` | Anubis Revealed | Choice |
| `ANU-006` | Terms of Judgment | Choice |
| `ANU-007` | Refuse the God | Choice |
| `ANU-008` | River of the Dead | Choice |
| `ANU-009` | The Ferryman’s Price | Choice |
| `ANU-010` | Hall of Whispers | Choice |
| `ANU-011` | The Crying Soul | Choice |
| `ANU-012` | Feather Arm Chamber | Choice |
| `ANU-013` | Golden Scarab Vault | Choice |
| `ANU-014` | Chamber of Stolen Hearts | Choice |
| `ANU-015` | Ammit Unchained | Choice |
| `ANU-016` | The Broken Chain | Choice |
| `ANU-017` | Maze of False Memories | Choice |
| `ANU-018` | Memory of Home | Choice |
| `ANU-019` | Memory of Failure | Choice |
| `ANU-020` | The Heart Pan | Choice |
| `ANU-021` | The Scribe’s Secret | Choice |
| `ANU-022` | The True Name | Choice |
| `ANU-023` | The Rebel’s Offer | Choice |
| `ANU-024` | Balance Stone Chamber | Choice |
| `ANU-025` | The Final Guardian | Choice |
| `ANU-026` | Return to the Hall | Choice |
| `ANU-027` | The Weighing Begins | Conditional choice |
| `ANU-028` | Final Decision | Ending router |
| `END-TRUE` | The Scales Restored | Win |
| `END-AMMIT` | Devoured by Ammit | Death |
| `END-REBEL` | Defy the Gods | Dark win |
| `END-TRICKSTER` | Cheat the Scales | Secret lose |
| `END-LOST` | Lost Soul | Lose |

---

# 9. Canonical Node-to-Node Route Table

## Opening

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-001` | Approach the black doorway | `ANU-002` | None |
| `ANU-001` | Walk away into the desert | `ANU-003` | `memoriesRemaining -= 1` |
| `ANU-002` | Enter the doorway | `ANU-003` | None |
| `ANU-002` | Call into the darkness | `ANU-004` | None |
| `ANU-003` | Follow the jackal statues | `ANU-004` | None |
| `ANU-003` | Search the temple for treasure | `ANU-013` | `heartWeight += 1` |
| `ANU-004` | Answer honestly | `ANU-005` | `heartWeight -= 1` |
| `ANU-004` | Lie about why you are here | `ANU-005` | `heartWeight += 1`, `liedToAnubis = true` |

## Meeting Anubis

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-005` | Kneel and listen | `ANU-006` | `allegiance = anubis` |
| `ANU-005` | Demand to be released | `ANU-007` | `allegiance = self` |
| `ANU-005` | Ask what power is offered | `ANU-006` | `allegiance = rebel`, `heartWeight += 1` |
| `ANU-006` | Agree to restore the scales | `ANU-008` | `allegiance = anubis`, `heartWeight -= 1` |
| `ANU-006` | Agree only for a reward | `ANU-008` | `allegiance = self`, `heartWeight += 1` |
| `ANU-007` | Accept after Anubis warns you | `ANU-008` | None |
| `ANU-007` | Flee into the darkness | `ANU-017` | `memoriesRemaining -= 1` |

## River of the Dead

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-008` | Call for the ferryman | `ANU-009` | None |
| `ANU-008` | Swim through the black water | `ANU-010` | `memoriesRemaining -= 1`, `heartWeight += 1` |
| `ANU-009` | Give the ferryman a memory | `ANU-010` | `memoriesRemaining -= 1` |
| `ANU-009` | Promise to free a trapped soul | `ANU-010` | Set mercy oath flag |
| `ANU-009` | Threaten the ferryman | `ANU-010` | `heartWeight += 2` |

## Hall of Whispers and First Scale Piece

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-010` | Follow the crying voice | `ANU-011` | None |
| `ANU-010` | Ignore the voices and seek the scales | `ANU-012` | `heartWeight += 1` |
| `ANU-011` | Free the trapped soul | `ANU-012` | `savedLostSoul = true`, `heartWeight -= 2` |
| `ANU-011` | Ask the soul for information first | `ANU-012` | `savedLostSoul = true`, `heartWeight -= 1` |
| `ANU-011` | Leave the soul trapped | `ANU-012` | `heartWeight += 2` |
| `ANU-012` | Lift the Feather Arm | `ANU-013` | `firstScalePieceRecovered = true` |
| `ANU-012` | Inspect the shadows | `ANU-014` | `firstScalePieceRecovered = true`, learn Ammit clue |

## Treasure Choice

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-013` | Take the Golden Scarab | `ANU-014` | `tookGoldenScarab = true`, `heartWeight += 2` |
| `ANU-013` | Leave the treasure untouched | `ANU-014` | `heartWeight -= 1` |
| `ANU-013` | Break the scarab and release the light | `ANU-014` | `heartWeight -= 1`, gain protection flag |

## Chamber of Stolen Hearts and Ammit

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-014` | Search the suspended hearts | `ANU-015` | Learn that one heart is yours |
| `ANU-014` | Cut the chains holding the hearts | `ANU-016` | `heartWeight -= 1` |
| `ANU-015` | Calm Ammit and speak without fear | `ANU-016` | `heartWeight -= 1` |
| `ANU-015` | Attack Ammit | `ANU-016` | `possessesAmmitFang = true`, `heartWeight += 2` |
| `ANU-015` | Offer the Golden Scarab | `ANU-016` | Requires scarab; remove it; `heartWeight -= 2` |
| `ANU-016` | Repair the broken chain | `ANU-017` | `heartWeight -= 1` |
| `ANU-016` | Take a fragment of underworld power | `ANU-017` | `acceptedUnderworldPower = true`, `heartWeight += 1` |

## Maze of False Memories

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-017` | Follow the memory of home | `ANU-018` | None |
| `ANU-017` | Follow the memory of your greatest failure | `ANU-019` | None |
| `ANU-018` | Accept that the memory may be false | `ANU-020` | `heartWeight -= 1` |
| `ANU-018` | Stay inside the memory | `ANU-019` | `memoriesRemaining -= 1` |
| `ANU-019` | Admit responsibility | `ANU-020` | `heartWeight -= 1` |
| `ANU-019` | Blame someone else | `ANU-020` | `heartWeight += 1`, `memoriesRemaining -= 1` |

After each memory loss:

```text
If memoriesRemaining <= 0:
    route to END-LOST
```

## Second Scale Piece and the Scribe

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-020` | Recover the Heart Pan | `ANU-021` | `secondScalePieceRecovered = true` |
| `ANU-020` | Examine the names beneath it | `ANU-021` | Recover piece; gain conspiracy clue |
| `ANU-021` | Trust the underworld scribe | `ANU-022` | None |
| `ANU-021` | Threaten the scribe | `ANU-022` | `heartWeight += 1` |
| `ANU-021` | Trade a memory for the truth | `ANU-022` | `memoriesRemaining -= 1` |
| `ANU-022` | Speak Anubis’s hidden title | `ANU-023` | `learnedTrueName = true` |
| `ANU-022` | Keep the name secret | `ANU-023` | `learnedTrueName = true`, `heartWeight -= 1` |

## Rebellion and Final Scale Piece

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-023` | Reject the rebel’s offer | `ANU-024` | `allegiance = anubis` |
| `ANU-023` | Accept power to challenge Anubis | `ANU-024` | `acceptedUnderworldPower = true`, `allegiance = rebel`, `heartWeight += 1` |
| `ANU-023` | Pretend to accept | `ANU-024` | `allegiance = self`, `heartWeight += 1` |
| `ANU-024` | Take the Balance Stone carefully | `ANU-025` | `finalScalePieceRecovered = true` |
| `ANU-024` | Rip it from the guardian mechanism | `ANU-025` | Recover piece; `heartWeight += 1` |
| `ANU-025` | Spare the final guardian | `ANU-026` | `heartWeight -= 1` |
| `ANU-025` | Destroy the final guardian | `ANU-026` | `heartWeight += 2` |
| `ANU-025` | Command it using the true name | `ANU-026` | Requires `learnedTrueName` |

## Return and Judgment

| Source | Choice | Destination | Effects |
|---|---|---|---|
| `ANU-026` | Return the scale pieces to Anubis | `ANU-027` | None |
| `ANU-026` | Hide one piece and bargain | `ANU-027` | `heartWeight += 1`, `allegiance = self` |
| `ANU-026` | Enter the Hall of Judgment armed | `ANU-027` | Requires Fang or power; `allegiance = rebel` |
| `ANU-027` | Submit to honest judgment | `ANU-028` | Final route evaluation |
| `ANU-027` | Challenge Anubis | `ANU-028` | Final choice `rebel` |
| `ANU-027` | Manipulate the scales | `ANU-028` | Final choice `cheat`; `heartWeight += 2` |

---

# 10. Ending Router Logic

`ANU-028` evaluates state rather than presenting ordinary fixed destinations.

```swift
func resolveEnding(
    state: TrialOfAnubisState,
    finalChoice: FinalChoice
) -> TrialEnding {

    if state.memoriesRemaining <= 0 {
        return .lostSoul
    }

    if finalChoice == .rebel,
       state.allegiance == .rebel,
       state.acceptedUnderworldPower,
       state.possessesAmmitFang {
        return .rebel
    }

    if finalChoice == .cheat,
       state.tookGoldenScarab,
       state.learnedTrueName {
        return .trickster
    }

    if finalChoice == .honestJudgment,
       state.firstScalePieceRecovered,
       state.secondScalePieceRecovered,
       state.finalScalePieceRecovered,
       state.heartWeight <= 0,
       state.savedLostSoul,
       state.allegiance == .anubis {
        return .trueEnding
    }

    if state.heartWeight >= 4 {
        return .devouredByAmmit
    }

    if finalChoice == .rebel,
       state.acceptedUnderworldPower {
        return .rebel
    }

    if finalChoice == .cheat,
       state.learnedTrueName {
        return .trickster
    }

    return state.heartWeight <= 1
        ? .trueEnding
        : .devouredByAmmit
}
```

The thresholds may be tuned during playtesting, but the ending system must never be reduced to a single last-button decision.

---

# 11. Condensed Story Tree

```text
ANU-001 Silent Desert
├── Doorway → ANU-002 → ANU-003/004
└── Walk away → ANU-003 [lose memory]

ANU-003 Jackal Temple
├── Follow statues → ANU-004
└── Search treasure → ANU-013 [heavier heart]

ANU-004 Voice Below
├── Honest → ANU-005 [lighter]
└── Lie → ANU-005 [heavier; lied]

ANU-005 Anubis Revealed
├── Kneel → ANU-006 [Anubis]
├── Demand release → ANU-007 [Self]
└── Ask for power → ANU-006 [Rebel; heavier]

ANU-006/007
├── Accept task → ANU-008
└── Flee → ANU-017 [lose memory]

ANU-008 River
├── Ferryman → ANU-009 → ANU-010
└── Swim → ANU-010 [lose memory; heavier]

ANU-010 Hall of Whispers
├── Follow crying → ANU-011 → ANU-012
└── Ignore → ANU-012 [heavier]

ANU-012 Feather Arm
├── Take piece → ANU-013
└── Search shadows → ANU-014

ANU-013 Golden Scarab
├── Take → ANU-014 [Scarab; heavier]
├── Leave → ANU-014 [lighter]
└── Break → ANU-014 [lighter; protection]

ANU-014/015/016 Stolen Hearts and Ammit
├── Mercy/repair → ANU-017 [lighter]
├── Attack → ANU-017 [Fang; heavier]
├── Sacrifice Scarab → ANU-017 [lighter]
└── Take power → ANU-017 [power; heavier]

ANU-017 Memory Maze
├── Home → ANU-018 → ANU-020
└── Failure → ANU-019 → ANU-020
    └── memories == 0 → END-LOST

ANU-020 Heart Pan → ANU-021 Scribe → ANU-022 True Name
└── ANU-023 Rebel Offer
    ├── Reject → ANU-024 [Anubis]
    ├── Accept → ANU-024 [Rebel; power]
    └── Pretend → ANU-024 [Self]

ANU-024 Balance Stone → ANU-025 Guardian → ANU-026 Return
└── ANU-027 Weighing
    ├── Honest judgment → ANU-028
    ├── Challenge → ANU-028
    └── Cheat → ANU-028

ANU-028 Ending Router
├── END-TRUE
├── END-AMMIT
├── END-REBEL
├── END-TRICKSTER
└── END-LOST
```

---

# 12. Suggested Opening Text

## `ANU-001` — The Silent Desert

The desert is silent.

No wind. No stars. No sound except the slow beat of your own heart.

The sand beneath your feet is cold, though the air still carries the heat of the day. Behind you, your footprints stretch into darkness. Ahead, half-buried beneath the dunes, a black stone doorway waits.

Its surface is carved with jackal-headed figures. Their eyes are painted gold.

As you step closer, the door cracks open by itself.

A voice speaks from the darkness.

“Your heart has been expected.”

Choices:

- Approach the black doorway.
- Walk away into the desert.

## `ANU-005` — Anubis Revealed

The chamber opens into a hall so vast that its ceiling disappears into darkness.

At its center stands a figure taller than any man. His body is wrapped in black and gold linen. His head is that of a jackal, and his eyes glow like embers beneath a funeral moon.

Behind him rests a broken scale.

One pan lies cracked upon the floor. The other is missing. The central stone has been torn from its frame.

Anubis looks down at you.

“The dead no longer wait for judgment,” he says. “The scales have been stolen. The doors between worlds are opening.”

He steps closer.

“You will return what was taken.”

Choices:

- Kneel and listen.
- Demand to be released.
- Ask what power is offered.

## `ANU-027` — The Weighing Begins

The restored scales rise from the floor.

One pan holds the feather of Ma’at.

The other waits for your heart.

Anubis stands beside the balance, silent and still. Behind him, Ammit watches from the shadows, her jaws slowly opening.

Every promise you made returns to you.

Every lie.

Every act of mercy.

Every moment you chose yourself over another.

Anubis extends one hand.

“Place your heart upon the scales.”

Choices:

- Submit to honest judgment.
- Challenge Anubis.
- Manipulate the scales.

---

# 13. Visual, Audio, and Effect Direction

## Visual Direction

- Black sandstone temples
- Gold-painted carvings
- Deep blue night skies
- Green-blue underworld water
- Red-black chambers of stolen hearts
- Pale memory fog
- Vast judgment halls

## Character Direction

### Anubis

Tall, calm, imposing, with a black jackal head, obsidian-and-gold armor, and eyes that intensify during anger or judgment.

### Ammit

Crocodile head, lion forequarters, hippopotamus hindquarters, initially chained, terrifying but capable of speech.

### Ferryman

A thin faceless figure wrapped in damp linen, carrying a long black pole and speaking in a layered distant voice.

### Lost Souls

Semi-transparent figures with incomplete faces and flickering fragments of memory.

## Audio

Ambient tracks:

- Silent desert with heartbeat
- Deep temple resonance
- Underworld river
- Whispering soul hall
- Memory maze distortion
- Judgment hall drone

Sound effects:

- Stone door opening
- Heartbeat acceleration
- Chains dragging
- Scales creaking
- Whisper swarm
- Water movement
- Memory shatter
- Ammit growl
- Feather landing
- Judgment impact

The heartbeat should become more audible when the player lies, grows morally heavier, approaches Ammit, or begins judgment.

## UI Feedback

Do not show the heart as a plain number by default.

Use:

- subtle heart color changes;
- heavier or lighter pulse animation;
- rising or falling particles;
- a brief scale tilt after major choices;
- accessible feedback such as “Your heart feels lighter” or “A weight settles in your chest.”

Memory loss should briefly blur the screen, remove text fragments, mute sound, and fade a memory symbol.

---

# 14. Save and Resume Architecture

Save after every choice.

```swift
struct StorySessionSave: Codable {
    let storyID: String
    var currentNodeID: String
    var visitedNodeIDs: Set<String>
    var completedEndingIDs: Set<String>
    var trialState: TrialOfAnubisState
}
```

Save after:

- entering a node;
- applying a choice effect;
- recovering a scale piece;
- losing a memory;
- reaching an ending.

On resume:

- restore the exact current node;
- restore all flags;
- restore heart weight and memory count;
- never reapply the choice effect that led to the saved node.

---

# 15. Codex Safeguards

Codex must:

1. Treat this file as the canonical story architecture.
2. Preserve node IDs even if SwiftUI filenames change.
3. Never derive story logic only from page numbers.
4. Apply state effects exactly once per choice.
5. Clamp `heartWeight` between `-6` and `+6`.
6. Check `memoriesRemaining` after every memory-loss event.
7. Route to `END-LOST` immediately at zero memories.
8. Keep scale-piece recovery flags persistent.
9. Never reduce the ending router to a single direct button destination.
10. Evaluate endings in deterministic order.
11. Save story state after every choice.
12. Record reached endings before resetting navigation.
13. Preserve completed endings across app launches.
14. Do not clear global progress when restarting only this story.
15. Validate that every destination exists.
16. Validate that all five endings remain reachable.
17. Update this document whenever a choice, route, effect, node, or ending requirement changes.

---

# 16. Recommended Tests

## Graph Tests

Verify:

- every destination exists;
- every non-opening node is reachable;
- every ending is reachable;
- no accidental infinite loop exists;
- `ANU-028` remains the main ending router;
- all three scale pieces can be recovered;
- judgment can be reached with several moral profiles.

## State Tests

Verify:

```text
heartWeight never exceeds +6
heartWeight never drops below -6
memory loss routes to END-LOST at 0
Golden Scarab can be taken and sacrificed
Ammit Fang comes only from attacking Ammit
true name is required for the strongest cheat route
rebel ending requires rebel state
true ending requires all scale pieces
```

## Ending Tests

### True

```text
heartWeight <= 0
savedLostSoul == true
all scale pieces == true
allegiance == anubis
final choice == honest judgment
```

Expected: `END-TRUE`

### Ammit

```text
heartWeight >= 4
final choice == honest judgment
no valid rebel or cheat override
```

Expected: `END-AMMIT`

### Rebel

```text
allegiance == rebel
acceptedUnderworldPower == true
possessesAmmitFang == true
final choice == challenge
```

Expected: `END-REBEL`

### Trickster

```text
tookGoldenScarab == true
learnedTrueName == true
final choice == manipulate
```

Expected: `END-TRICKSTER`

### Lost Soul

```text
memoriesRemaining == 0
```

Expected: `END-LOST`

---

# 17. Achievements

| Achievement | Requirement |
|---|---|
| Heart as Light as a Feather | Reach the true ending |
| Hunger of Ammit | Reach the dark ending |
| No Gods, No Masters | Reach the rebel ending |
| A Perfect Lie | Reach the trickster ending |
| Forgotten | Reach the lost soul ending |
| Merciful | Save the trapped soul |
| Untouched Treasure | Refuse the Golden Scarab |
| Fang of the Devourer | Take Ammit’s fang |
| Three Pieces, One Judgment | Recover all scale pieces |
| Every Heart Has a Story | Reach all five endings |

---

# 18. V3 Architecture Recommendation

For V3, use a data-driven story engine rather than one SwiftUI file per node.

```text
StoryDefinition
├── Story metadata
├── Node dictionary
├── Ending definitions
├── State schema
└── Ending resolver

StorySession
├── Current node
├── Story-specific state
├── Visited nodes
└── Completed endings

StoryNodeView
├── Artwork
├── Narrative text
├── Choice buttons
└── Effects

StoryOutcomeView
├── Ending art
├── Ending type
├── Restart story
├── Return to story library
└── Ending progress
```

---

# 19. Future Expansion Hooks

- The Trickster Ending releases an unknown entity into the living world.
- Anubis may reference the Sphinx, previous travelers, or the strange monitoring room from the first story.
- Completing the story may unlock an Anubis profile icon, menu background, lore entry, artwork, or ending gallery.

---

# 20. Change Log

## Version 1.0 — 2026-07-16

- Created the complete initial architecture for The Trial of Anubis.
- Added Heart Weight morality.
- Added memory-loss state.
- Added three scale-piece progression flags.
- Added allegiance, treasure, power, mercy, and truth flags.
- Created 28 core nodes and five endings.
- Added the canonical route table and story tree.
- Added deterministic ending-router logic.
- Added Codex safeguards, save rules, tests, effects, and V3 implementation guidance.
