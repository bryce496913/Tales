# Tales From the Sphinx — Story Tree and Screen Map

**Document role:** Canonical story-flow source of truth  
**Repository:** `bryce496913/Tales-From-the-Sphynx-iOS-App`  
**Reviewed branch:** `main`  
**Last verified:** 2026-07-16  
**Story version:** V2 code-aligned map

---

## 1. Purpose

This file defines the implemented branching structure for **Tales From the Sphinx**.

Codex and contributors must use this document when:

- changing a page destination;
- adding or removing a choice;
- adding a new story screen;
- changing an ending classification;
- replacing numbered SwiftUI views with a data-driven story engine;
- checking that all branches remain reachable;
- checking that no route points to a missing page.

The Swift code remains the runtime implementation. This document is the human-readable story architecture reference and must be updated whenever that implementation changes.

---

## 2. Core Story Rules

- The opening sequence is linear:
  - `Plot1View`
  - `Plot2View`
  - `Page1View`
- Standard story screens normally present two choices.
- A standard choice uses `StoryNavigationButton`.
- A random outcome uses `RandomStoryNavigationButton`.
- Terminal screens use `StoryOutcomeView`.
- Terminal classifications are:
  - `win`
  - `lose`
  - `death`
- A terminal page does not continue to another numbered story node.
- Restart and return-to-menu behavior is controlled by the shared outcome/navigation system rather than by page-specific story routes.

---

## 3. Screen Inventory

| Node ID | SwiftUI file | Runtime type | Classification |
|---|---|---|---|
| `PLOT-01` | `Plot1View.swift` | Story page | Opening |
| `PLOT-02` | `Plot2View.swift` | Story page | Opening |
| `NODE-01` | `Page1View.swift` | Story page | Choice |
| `NODE-02` | `Page2View.swift` | Outcome | Death |
| `NODE-03` | `Page3View.swift` | Story page | Choice |
| `NODE-04` | `Page4View.swift` | Story page | Choice |
| `NODE-05` | `Page5View.swift` | Story page | Choice |
| `NODE-06` | `Page6View.swift` | Story page | Choice |
| `NODE-07` | `Page7View.swift` | Outcome | Lose |
| `NODE-08` | `Page8View.swift` | Story page | Choice |
| `NODE-09` | `Page9View.swift` | Story page | Choice |
| `NODE-10` | `Page10View.swift` | Story page | Choice + random branch |
| `NODE-11` | `Page11View.swift` | Outcome | Death |
| `NODE-12` | `Page12View.swift` | Story page | Choice |
| `NODE-13` | `Page13View.swift` | Outcome | Win |
| `NODE-14` | `Page14View.swift` | Outcome | Death |
| `NODE-15` | `Page15View.swift` | Outcome | Lose |
| `NODE-16` | `Page16View.swift` | Story page | Choice + random branch |
| `NODE-17` | `Page17View.swift` | Story page | Choice |
| `NODE-18` | `Page18View.swift` | Story page | Choice + random branch |
| `NODE-19` | `Page19View.swift` | Story page | Choice |
| `NODE-20` | `Page20View.swift` | Outcome | Lose |
| `NODE-21` | `Page21View.swift` | Outcome | Death |
| `NODE-22` | `Page22View.swift` | Outcome | Lose |
| `NODE-24` | `Page24View.swift` | Outcome | Death |
| `NODE-25` | `Page25View.swift` | Outcome | Death |

### Missing Number

`Page23View.swift` does not exist in the reviewed repository.

- No implemented choice routes to `.page(23)`.
- Page 23 is therefore not a broken destination.
- The number should remain reserved unless a future story node is intentionally added.

---

## 4. Canonical Node-to-Node Route Table

| Source node | Choice text | Destination | Route behavior |
|---|---|---|---|
| `PLOT-01` | Continue | `PLOT-02` | Fixed |
| `PLOT-02` | Continue | `NODE-01` | Fixed |
| `NODE-01` | Try to enter the sphinx | `NODE-03` | Fixed |
| `NODE-01` | Try to find the road | `NODE-02` | Fixed → Death |
| `NODE-03` | Head down the left | `NODE-04` | Fixed |
| `NODE-03` | Head down the right | `NODE-06` | Fixed |
| `NODE-04` | Enter the door on the left | `NODE-16` | Fixed |
| `NODE-04` | Jump the pit | `NODE-05` | Fixed |
| `NODE-05` | Follow the cat through the crack | `NODE-20` | Fixed → Lose |
| `NODE-05` | Continue down the hallway | `NODE-19` | Fixed |
| `NODE-06` | Enter the door | `NODE-07` | Fixed → Lose |
| `NODE-06` | Continue down the corridor | `NODE-08` | Fixed |
| `NODE-08` | Follow the beetle's light | `NODE-17` | Fixed |
| `NODE-08` | Enter the door | `NODE-09` | Fixed |
| `NODE-09` | Pick Anubis | `NODE-21` | Fixed → Death |
| `NODE-09` | Pick Osiris | `NODE-10` | Fixed |
| `NODE-10` | Make a run for it | `NODE-12` **or** `NODE-11` | Random |
| `NODE-10` | Take it slowly | `NODE-11` | Fixed → Death |
| `NODE-12` | Inspect the metal door | `NODE-14` | Fixed → Death |
| `NODE-12` | Enter the bright corridor | `NODE-13` | Fixed → Win |
| `NODE-16` | Run between its legs to reach the door | `NODE-19` **or** `NODE-25` | Random |
| `NODE-16` | Talk to the spider and ask nicely to let you in the door | `NODE-17` | Fixed |
| `NODE-17` | Shine the light at Re | `NODE-18` | Fixed |
| `NODE-17` | Shine the light at Thorth | `NODE-10` | Fixed |
| `NODE-18` | Climb the ladder | `NODE-12` **or** `NODE-24` | Random |
| `NODE-18` | Take torch to explore | `NODE-15` | Fixed → Lose |
| `NODE-19` | Open the left sarcophagus | `NODE-18` | Fixed |
| `NODE-19` | Open the right sarcophagus | `NODE-22` | Fixed → Lose |

Terminal nodes have no story-node destination:

- `NODE-02`
- `NODE-07`
- `NODE-11`
- `NODE-13`
- `NODE-14`
- `NODE-15`
- `NODE-20`
- `NODE-21`
- `NODE-22`
- `NODE-24`
- `NODE-25`

---

## 5. Full Story Tree

```text
PLOT-01: The Desert Road
└── Continue
    └── PLOT-02: The Sphinx Appears
        └── Continue
            └── NODE-01: Enter the Sphinx or Find the Road
                ├── Try to find the road
                │   └── NODE-02: DEATH — Lost in the Desert
                │
                └── Try to enter the sphinx
                    └── NODE-03: Left or Right Corridor
                        ├── Head down the left
                        │   └── NODE-04: Pit Room
                        │       ├── Jump the pit
                        │       │   └── NODE-05: The Abyssinian Cat
                        │       │       ├── Follow the cat through the crack
                        │       │       │   └── NODE-20: LOSE — Exit Through the Gift Shop
                        │       │       │
                        │       │       └── Continue down the hallway
                        │       │           └── NODE-19: Sarcophagus Puzzle
                        │       │               ├── Open the left sarcophagus
                        │       │               │   └── NODE-18: Dark Room and Ladder
                        │       │               │       ├── Take torch to explore
                        │       │               │       │   └── NODE-15: LOSE — Sphinx Slide Rescue
                        │       │               │       │
                        │       │               │       └── Climb the ladder
                        │       │               │           ├── RANDOM → NODE-12
                        │       │               │           │   ├── Inspect the metal door
                        │       │               │           │   │   └── NODE-14: DEATH — Test Subject Neutralized
                        │       │               │           │   └── Enter the bright corridor
                        │       │               │           │       └── NODE-13: WIN — Treasure Room
                        │       │               │           │
                        │       │               │           └── RANDOM → NODE-24: DEATH — Fall from Ladder
                        │       │               │
                        │       │               └── Open the right sarcophagus
                        │       │                   └── NODE-22: LOSE — Mummy Recruit
                        │       │
                        │       └── Enter the door on the left
                        │           └── NODE-16: Giant Talking Spider
                        │               ├── Talk to the spider and ask nicely
                        │               │   └── NODE-17: Re and Thorth Light Puzzle
                        │               │       ├── Shine the light at Re
                        │               │       │   └── NODE-18: Dark Room and Ladder
                        │               │       │       ├── Take torch to explore
                        │               │       │       │   └── NODE-15: LOSE
                        │               │       │       └── Climb the ladder
                        │               │       │           ├── RANDOM → NODE-12
                        │               │       │           └── RANDOM → NODE-24: DEATH
                        │               │       │
                        │               │       └── Shine the light at Thorth
                        │               │           └── NODE-10: Crumbling Floor
                        │               │               ├── Take it slowly
                        │               │               │   └── NODE-11: DEATH — Fall into Darkness
                        │               │               └── Make a run for it
                        │               │                   ├── RANDOM → NODE-12
                        │               │                   └── RANDOM → NODE-11: DEATH
                        │               │
                        │               └── Run between its legs
                        │                   ├── RANDOM → NODE-19: Sarcophagus Puzzle
                        │                   └── RANDOM → NODE-25: DEATH — Trapped by Spider Web
                        │
                        └── Head down the right
                            └── NODE-06: Mumbling Door
                                ├── Enter the door
                                │   └── NODE-07: LOSE — Found by Tour Group
                                │
                                └── Continue down the corridor
                                    └── NODE-08: Glowing Scarab Beetles
                                        ├── Follow the beetle's light
                                        │   └── NODE-17: Re and Thorth Light Puzzle
                                        │       ├── Shine the light at Re
                                        │       │   └── NODE-18: Dark Room and Ladder
                                        │       └── Shine the light at Thorth
                                        │           └── NODE-10: Crumbling Floor
                                        │
                                        └── Enter the door
                                            └── NODE-09: Anubis or Osiris
                                                ├── Pick Anubis
                                                │   └── NODE-21: DEATH — Taken by Anubis
                                                │
                                                └── Pick Osiris
                                                    └── NODE-10: Crumbling Floor
                                                        ├── Take it slowly
                                                        │   └── NODE-11: DEATH
                                                        └── Make a run for it
                                                            ├── RANDOM → NODE-12
                                                            └── RANDOM → NODE-11: DEATH
```

---

## 6. Ending Registry

### Win Ending

| Node | SwiftUI file | Ending |
|---|---|---|
| `NODE-13` | `Page13View.swift` | The player discovers the treasure room, escapes, and returns to safety wealthy. |

### Lose Endings

A lose ending means the player survives or reaches safety but does not complete the intended treasure-room victory path.

| Node | SwiftUI file | Ending |
|---|---|---|
| `NODE-07` | `Page7View.swift` | The player finds a tour group and returns to the city. |
| `NODE-15` | `Page15View.swift` | The player exits through the Sphinx and is rescued. |
| `NODE-20` | `Page20View.swift` | The player follows the cat and exits into a gift shop. |
| `NODE-22` | `Page22View.swift` | The player becomes a recruit for the mummies. |

### Death Endings

| Node | SwiftUI file | Ending |
|---|---|---|
| `NODE-02` | `Page2View.swift` | The player becomes lost and dies in the desert. |
| `NODE-11` | `Page11View.swift` | The player falls through the crumbling floor and dies. |
| `NODE-14` | `Page14View.swift` | The player is neutralized after discovering the monitoring room. |
| `NODE-21` | `Page21View.swift` | Anubis takes and traps the player beneath the sands. |
| `NODE-24` | `Page24View.swift` | The player slips from the ladder and falls into darkness. |
| `NODE-25` | `Page25View.swift` | The spider traps the player with its web. |

---

## 7. Random Navigation Rules

The story currently contains three random-choice buttons.

### `NODE-10` — Make a Run for It

```swift
routes: [.page(12), .page(11)]
```

Possible results:

- `NODE-12` — progress toward the final win/death choice;
- `NODE-11` — death.

### `NODE-16` — Run Between the Spider's Legs

```swift
routes: [.page(19), .page(25)]
```

Possible results:

- `NODE-19` — progress to the sarcophagus puzzle;
- `NODE-25` — death.

### `NODE-18` — Climb the Ladder

```swift
routes: [.page(12), .page(24)]
```

Possible results:

- `NODE-12` — progress toward the final win/death choice;
- `NODE-24` — death.

Unless the shared random-navigation component applies custom weighting, each destination should be treated as an equally possible result.

---

## 8. Merge Points

Several nodes can be entered from more than one earlier branch.

| Merge node | Incoming nodes |
|---|---|
| `NODE-10` | `NODE-09`, `NODE-17` |
| `NODE-12` | Randomly from `NODE-10`, randomly from `NODE-18` |
| `NODE-17` | `NODE-08`, `NODE-16` |
| `NODE-18` | `NODE-17`, `NODE-19` |
| `NODE-19` | `NODE-05`, randomly from `NODE-16` |

These merge points are intentional and must not be treated as duplicate or orphaned content.

---

## 9. Reachability Validation

### Reachable Nodes

All implemented story files are reachable from `PLOT-01`, including nodes that require a random result:

- `PLOT-01`
- `PLOT-02`
- `NODE-01` through `NODE-22`, excluding the nonexistent `NODE-23`
- `NODE-24`
- `NODE-25`

### Orphan Check

- No implemented story page is orphaned.
- No route points to `NODE-23`.
- No route points outside the implemented page set.
- Every non-terminal story node has at least one outgoing destination.
- Every terminal node is implemented using `StoryOutcomeView`.

### Cycle Check

The implemented graph contains no route that returns to an earlier node in the same playthrough.

There are shared merge points, but no infinite loops.

---

## 10. Shortest Known Routes to Outcomes

### Win

```text
PLOT-01
→ PLOT-02
→ NODE-01
→ NODE-03
→ NODE-06
→ NODE-08
→ NODE-09
→ NODE-10
→ RANDOM NODE-12
→ NODE-13
```

The player must receive the successful random result at `NODE-10`.

### Immediate Death Route

```text
PLOT-01
→ PLOT-02
→ NODE-01
→ NODE-02
```

### Short Lose Route

```text
PLOT-01
→ PLOT-02
→ NODE-01
→ NODE-03
→ NODE-06
→ NODE-07
```

---

## 11. Page-by-Page Implementation Reference

### `PLOT-01` — Plot1View

- Image: `Plot1.png`
- Title: `The Desert Road`
- Choice:
  - Continue → `PLOT-02`

### `PLOT-02` — Plot2View

- Image: `Plot2.png`
- Title: `The Sphinx Appears`
- Choice:
  - Continue → `NODE-01`

### `NODE-01` — Page1View

- Image: `One.png`
- Choices:
  - Try to enter the sphinx → `NODE-03`
  - Try to find the road → `NODE-02`

### `NODE-02` — Page2View

- Image: `Two.png`
- Outcome: Death

### `NODE-03` — Page3View

- Image: `Three.png`
- Choices:
  - Head down the left → `NODE-04`
  - Head down the right → `NODE-06`

### `NODE-04` — Page4View

- Image: `Four.png`
- Choices:
  - Enter the door on the left → `NODE-16`
  - Jump the pit → `NODE-05`

### `NODE-05` — Page5View

- Image: `Five.png`
- Choices:
  - Follow the cat through the crack → `NODE-20`
  - Continue down the hallway → `NODE-19`

### `NODE-06` — Page6View

- Image: `Six.png`
- Choices:
  - Enter the door → `NODE-07`
  - Continue down the corridor → `NODE-08`

### `NODE-07` — Page7View

- Image: `Seven.png`
- Outcome: Lose

### `NODE-08` — Page8View

- Image: `Eight.png`
- Choices:
  - Follow the beetle's light → `NODE-17`
  - Enter the door → `NODE-09`

### `NODE-09` — Page9View

- Image: `Nine.png`
- Choices:
  - Pick Anubis → `NODE-21`
  - Pick Osiris → `NODE-10`

### `NODE-10` — Page10View

- Image: `Ten.png`
- Choices:
  - Make a run for it → random `NODE-12` or `NODE-11`
  - Take it slowly → `NODE-11`

### `NODE-11` — Page11View

- Image: `Eleven.png`
- Outcome: Death

### `NODE-12` — Page12View

- Image: `Twelve.png`
- Choices:
  - Inspect the metal door → `NODE-14`
  - Enter the bright corridor → `NODE-13`

### `NODE-13` — Page13View

- Image: `Thirteen.png`
- Outcome: Win

### `NODE-14` — Page14View

- Image: `Fourteen.png`
- Outcome: Death

### `NODE-15` — Page15View

- Image: `Fithteen.png`
- Outcome: Lose
- Note: the asset spelling is implemented as `Fithteen.png`.

### `NODE-16` — Page16View

- Image: `Sixteen.png`
- Choices:
  - Run between its legs to reach the door → random `NODE-19` or `NODE-25`
  - Talk to the spider and ask nicely to let you in the door → `NODE-17`

### `NODE-17` — Page17View

- Image: `Seventeen.png`
- Choices:
  - Shine the light at Re → `NODE-18`
  - Shine the light at Thorth → `NODE-10`
- Note: the story and button text currently use `Thorth`.

### `NODE-18` — Page18View

- Image: `Eighteen.png`
- Choices:
  - Climb the ladder → random `NODE-12` or `NODE-24`
  - Take torch to explore → `NODE-15`

### `NODE-19` — Page19View

- Image: `Nineteen.png`
- Puzzle assets:
  - `hieroglyphics_(Left).png`
  - `hieroglyphics_(Right).png`
- Choices:
  - Open the left sarcophagus → `NODE-18`
  - Open the right sarcophagus → `NODE-22`

### `NODE-20` — Page20View

- Image: `Twenty.png`
- Outcome: Lose

### `NODE-21` — Page21View

- Image: `Twenty-One.png`
- Outcome: Death

### `NODE-22` — Page22View

- Image: `Twenty-Two.png`
- Outcome: Lose

### `NODE-23`

- No SwiftUI file exists.
- Reserved number.
- No incoming or outgoing routes.

### `NODE-24` — Page24View

- Image: `Twenty-Four.png`
- Outcome: Death

### `NODE-25` — Page25View

- Image: `Twenty-Five.png`
- Outcome: Death

---

## 12. Codex Safeguards

When modifying the story code, Codex must:

1. Preserve every route listed in the canonical node-to-node table unless the task explicitly changes the story.
2. Never infer that page numbers must be sequential.
3. Never create `Page23View.swift` merely because the number is missing.
4. Treat `NODE-10`, `NODE-16`, and `NODE-18` as random branches.
5. Preserve the ending classifications:
   - Win: `NODE-13`
   - Lose: `NODE-07`, `NODE-15`, `NODE-20`, `NODE-22`
   - Death: `NODE-02`, `NODE-11`, `NODE-14`, `NODE-21`, `NODE-24`, `NODE-25`
6. Verify that each `StoryNavigationButton` route points to an implemented destination.
7. Verify every route in each `RandomStoryNavigationButton`.
8. Update this document whenever a route, choice label, page file, random result, or ending changes.
9. Preserve shared merge points unless the task explicitly restructures the narrative.
10. Run a reachability check after any story-flow change.

---

## 13. Recommended Automated Story-Graph Tests

A future test suite should validate:

```text
Plot1 → Plot2
Plot2 → Page1

Page1 → [Page3, Page2]
Page3 → [Page4, Page6]
Page4 → [Page16, Page5]
Page5 → [Page20, Page19]
Page6 → [Page7, Page8]
Page8 → [Page17, Page9]
Page9 → [Page21, Page10]
Page10 → [Page12, Page11]
Page12 → [Page14, Page13]
Page16 → [Page19, Page25, Page17]
Page17 → [Page18, Page10]
Page18 → [Page12, Page24, Page15]
Page19 → [Page18, Page22]
```

The tests should also assert:

- every destination exists;
- every non-opening page is reachable;
- all terminal pages have an ending classification;
- terminal pages have no outgoing story route;
- no `.page(23)` route exists;
- random buttons contain exactly the intended destinations;
- `Page13` remains the only win ending unless deliberately changed.

---

## 14. Change Log

### 2026-07-16

- Replaced the placeholder story tree with the route map extracted from the repository.
- Added all fixed and random node-to-node transitions.
- Corrected the screen inventory.
- Confirmed that `Page23View.swift` does not exist.
- Confirmed there is no route to page 23.
- Added merge-point, reachability, orphan, cycle, and ending validation.
- Added Codex safeguards and recommended graph tests.
