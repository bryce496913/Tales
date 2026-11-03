# The Descent to Hades — Test Paths

Device checklist for every path through the story. Each path is a list of button taps from **New Adventure** on the Hades menu. Page numbers (`015`) match the story map.

Each path below was run against the Swift pages by a script that reads every button, destination, remembered choice and gift from the `HDS###View.swift` files. Between them, the paths press every one of the 87 choice buttons and reach all 48 pages and all 11 endings. The script also explored every reachable combination of page, gifts and remembered choices (1,459 states) and found no dead ends: every non-ending page always shows at least one button.

---

## Shortcuts

Reuse these tap sequences to reach the late paths quickly.

| Shortcut | Taps | Ends on |
|---|---|---|
| **OPEN** | Continue → Go deeper → Speak to the stranger → Follow him → Offer your ring → Tell the truth → Sing → Thank her and go | `015` Crossroads (3 roads) |
| **LETHE** | The grey road → Follow the water → Kneel at the water → Look away → Take it | `015` (or `040` if it was the last gift) |
| **EMBER** | The bronze road → Climb the wall → Take the burning stair → Wait for the flames to sink → Return | `015` (or `040`) |
| **BOUGH** | The white road → Head for the golden tree → Speak to the Sibyl → Answer honestly → Take the bough | `015` (or `040`) |

---

## Full playthroughs

### P1 — Every remembered choice → Out Into the Sun (`044`)

Continue → Go deeper → Speak to the stranger → Ask him to bring Theo back → **Accept the bargain** → Offer your ring → **Lie** → Continue → Sing → Thank her and go →
The grey road → Go to Theo → **Tell him who he is** → Kneel at the water → Drink → Fill the flask → Take it →
The bronze road → Ask to enter → Confess → **Help him** → Wait for the flames to sink → Return →
The white road → Join the feast → Stay a while → Leave now → Speak to the Sibyl → Answer honestly → Take the bough →
Plead for Theo → Begin the climb → Keep climbing → Step into the light

Check on the way:

- [ ] `019` **Drink** goes to `021` The Voice You Woke (Theo stops you), not a game over.
- [ ] `015` after the Water of Lethe shows only **The bronze road** and **The white road**.
- [ ] `028` has the extra Sisyphus paragraph (“The river breathes. Wait for the breath.”).
- [ ] `015` after the Ember shows only **The white road**.
- [ ] Taking the bough goes straight to `040` The Throne of Hades, not the Crossroads.
- [ ] `040` shows three extra lines (Charon’s lie, Theo watching, Hermes winking) and **three** buttons, including **Call on Hermes**.
- [ ] `042` has the boulder line and the humming line.
- [ ] `043` has Theo’s “Don’t turn around” line.
- [ ] `044` has Theo’s “I remembered you the whole way up” line and the stone-on-the-hill line, but **not** the “Theo does not remember the underworld” line.

### P2 — Reverse road order, Let him rest → Out Into the Sun (`044`)

Continue → Go deeper → **Chase Theo** → Take his hand → Follow him → Offer your ring → Tell the truth → Sing → Thank her and go →
The white road → **Reach for the bough** → Ask the Sibyl → **Promise anything** → **Let go** → Take the bough →
The bronze road → Climb the wall → Take the burning stair → **Snatch an ember now** → **Run for the bridge** →
The grey road → Go to Theo → **Let him rest** → Cross to the far bank → **Blame the sea** → Look away → Take it →
Plead for Theo → Begin the climb → Keep climbing → Step into the light

Check on the way:

- [ ] `015` after the bough shows only **The grey road** and **The bronze road**.
- [ ] `028` has **no** Sisyphus paragraph.
- [ ] **Run for the bridge** returns to `015`, which now shows only **The grey road**.
- [ ] Taking the Water of Lethe goes straight to `040`.
- [ ] `040` has no extra lines and only **two** buttons (no **Call on Hermes**).
- [ ] `042` and `043` have no extra lines.
- [ ] `044` has only the “Theo does not remember the underworld” line.

---

## Endings

| # | Ending | Page | Taps |
|---|---|---|---|
| E1 | Lost to the Sea | `003` | Continue → Swim for the light |
| E2 | Taken by the Styx | `008` | Continue → Go deeper → Speak to the stranger → Follow him → Swim across |
| E3 | Torn by Cerberus | `012` | Continue → Go deeper → Speak to the stranger → Follow him → Offer your ring → Tell the truth → Run past |
| E4 | Bound by the Seeds | `014` | Continue → Go deeper → Speak to the stranger → Follow him → Offer your ring → Tell the truth → Sing → Eat the fruit |
| E5 | The Sweet Forgetting | `023` | OPEN → The grey road → Follow the water → Kneel at the water → Drink |
| E5b | The Sweet Forgetting (after Let him rest) | `023` | OPEN → The grey road → Go to Theo → Let him rest → Kneel at the water → Drink |
| E6 | Chained in Tartarus | `031` | OPEN → The bronze road → Ask to enter → Refuse → Follow the sound → Walk on → Snatch an ember now → Hide in the dark |
| E7 | The Isles of the Blessed | `039` | OPEN → The white road → Join the feast → Stay a while → Lie down in the grass |
| E8 | Looked Back (on the stair) | `045` | OPEN → LETHE → EMBER → BOUGH → Plead for Theo → Begin the climb → Look back |
| E8b | Looked Back (at the last stair) | `045` | OPEN → LETHE → EMBER → BOUGH → Plead for Theo → Begin the climb → Keep climbing → Turn to help him |
| E9 | The Willing Exchange | `046` | OPEN → LETHE → EMBER → BOUGH → Offer your life |
| E10 | Thief of the Dead | `047` | Continue → Go deeper → Speak to the stranger → Ask him to bring Theo back → Accept the bargain → Offer your ring → Tell the truth → Sing → Thank her and go → LETHE → EMBER → BOUGH → Call on Hermes |
| E11 | Out Into the Sun | `044` | P1 or P2 above (shortest: OPEN → LETHE → EMBER → BOUGH → Plead for Theo → Begin the climb → Keep climbing → Step into the light) |

On every ending page, check:

- [ ] The outcome screen shows the right title, classification and illustration.
- [ ] **Restart The Descent to Hades**, **Return to Hades Menu** and **Return to Story Selection** all work.

---

## Extra checks

| # | What | Taps | Expected |
|---|---|---|---|
| X1 | Refusing Hermes hides his button | Continue → Go deeper → Speak to the stranger → Ask him to bring Theo back → **Refuse** → Offer your ring → Tell the truth → Sing → Thank her and go → LETHE → EMBER → BOUGH | `040` shows only **Plead for Theo** and **Offer your life**, and no Hermes line. |
| X2 | Remaining Lethe and Elysium buttons | OPEN → The grey road → Follow the water → Cross to the far bank → **Admit it** → Take it → The white road → Join the feast → **Ask about the golden tree** → Speak to the Sibyl → Answer honestly → Take the bough | Back on `015` with only **The bronze road** left. |
| X3 | Sibyl loop | OPEN → The white road → Head for the golden tree → Reach for the bough → Ask the Sibyl → Promise anything → Ask the Sibyl → Answer honestly | You can bounce between `036` and `037` and still leave with the bough. |
| X4 | Continue Adventure | Start a run, stop mid-way (e.g. on `028`), go back to the Hades menu (or force-quit and relaunch) | **Continue Adventure** appears and returns to the same page. The Crossroads still hides the roads for gifts already collected. |
| X5 | No Continue after an ending | Reach any ending, then go back to the Hades menu | **Continue Adventure** is gone. **New Adventure** starts at `000` without a confirmation. |
| X6 | New Adventure confirmation | With a run in progress, tap **New Adventure** | Confirmation dialog appears. Confirming starts at `000` with no gifts and no remembered choices. |
| X7 | Restart keeps endings | Reach two different endings, restart between them | Both endings stay recorded. Restarting clears gifts and remembered choices. |
| X8 | Story selection | Story selection screen | The Hades card shows `HDS-Icon.png`, and its detail sheet shows `HDS-Title-Screen-Art.png` and opens the Hades menu. |
| X9 | Theme and transitions | Any run | Night-blue and bronze theme throughout. Mist, torch and bronze-gate transitions play. No “Illustration coming soon” placeholders on any page. |
