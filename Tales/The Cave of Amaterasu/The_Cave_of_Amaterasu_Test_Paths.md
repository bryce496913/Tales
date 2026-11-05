# The Cave of Amaterasu — Test Paths

Device checklist for every path through the story. Each path is a list of button taps from **New Adventure** on the Amaterasu menu. Page numbers (`014`) match the story map. Every page shows placeholder art with its page number in large type (for example `AMA-014`), so you can always check which page you are on.

Each path below was replayed against the Swift pages by a script that reads every button, destination, remembered choice and treasure from the `AMA###View.swift` files. Between them, the paths press every one of the 66 choice buttons and reach all 48 pages and all 13 endings. The script also explored every reachable combination of page, treasures and remembered choices (1,666 states) and found no dead ends: every non-ending page always shows at least one button.

Taps in **bold** are the remembered choices.

---

## Shortcuts

Reuse these tap sequences to reach the late paths quickly.

| Shortcut | Taps | Ends on |
|---|---|---|
| **OPEN** | Continue → Climb the mountain → Hide and shut your eyes → Keep your name to yourself → Ring Grandmother’s bell → Bow and ask his leave → Continue → Go on toward the torches → Accept the task | `014` Heavenly Rock Cave (3 paths) |
| **MIRROR** | The mountain path → Climb the stone stair → Bow to them → Look into the mirror → Keep looking → Take the mirror | `014` (or `039` if it was the last treasure) |
| **JEWELS** | The sea path → Row out in the fishing boat → Give it the ladle with no bottom → Ask for the jewels → Tell him what the night has done → Take only the jewels | `014` (or `039`) |
| **SWORD** | The river path → Follow them upstream → Brew eight vats of sake → Wait until every head sleeps → Cut open the glowing tail → Take the sword | `014` (or `039`) |
| **FINISH** | Begin the festival → Raise the mirror to the crack → Signal Tajikarao → Stretch the rope across the cave | `043` Dawn Returns |

---

## Full playthroughs

### P1 — Every remembered choice → Dawn Returns (`043`)

Continue → Climb the mountain → Hide and shut your eyes → **Tell it your name** → **Say you need no one’s leave** → Continue → Go on toward the torches → Accept the task →
The mountain path → Take the path through the roots → Ring Grandmother’s bell → Look into the mirror → Look away → Look into the mirror → Keep looking → Take the mirror →
The sea path → **Save the turtle** → Hold on tight → Join the feast → Stay one more day → Go to the Dragon King → Promise to stay as his guest → Remember why you came → Tell him what the night has done → **Take the jewels and the box** →
The river path → Follow the singing → **Sit and listen** → Face the serpent alone → Run back to the house → Strike now → Run back to the house → Wait until every head sleeps → Cut open the glowing tail → Take the sword →
FINISH

Check on the way:

- [ ] `009` opens with Sarutahiko laughing (“No one’s leave! Good.”) and has the fox’s “Foxes don’t cross” line.
- [ ] **Look away** at `019` returns to `018`, and you can look again.
- [ ] `014` after the mirror shows only **The sea path** and **The river path**.
- [ ] `027` **Stay one more day** goes to `028` The Turtle Remembers, not a game over.
- [ ] `014` after the jewels shows only **The river path**.
- [ ] `037` has Susanoo waiting at the river (“It was always meant to be my apology”).
- [ ] Taking the sword goes straight to `039` The Festival at the Rock, not the Heavenly Rock Cave.
- [ ] `039` has three extra lines (Sarutahiko not smiling, Susanoo with his head bowed, the fox saying your name) and **three** buttons, including **Let the fox speak for you**.
- [ ] `041` has **three** buttons, including **Offer her Otohime’s box**.
- [ ] `042` has Sarutahiko’s “Rudeness is forgiven at dawn” line.
- [ ] `043` has Susanoo kneeling with the sword, the fox’s-wedding rain line and the unopened box line, but **not** “Susanoo does not come”.
- [ ] The Endings button on the Amaterasu menu shows 1/13, with Dawn Returns unlocked.

### P2 — No remembered choices, reverse path order → Dawn Returns (`043`)

OPEN →
The river path → Follow the singing → Leave him to his sake → Brew eight vats of sake → Wait until every head sleeps → Cut open the glowing tail → Take the sword →
The sea path → Row out in the fishing boat → Give it your bucket → Remember why you came → Tell him what the night has done → Take only the jewels →
The mountain path → Climb the stone stair → Boast that you crossed the Bridge of Heaven → Ring Grandmother’s bell → Look into the mirror → Keep looking → Take the mirror →
FINISH

Check on the way:

- [ ] `009` opens with Sarutahiko bowing (“Walk in the middle”) and has **no** fox line.
- [ ] `037` has the empty-hut line, not Susanoo.
- [ ] **Give it your bucket** at `024` goes straight to `027` The Feast Beneath the Waves.
- [ ] **Boast** at `016` goes to `017` The Hollow of the Hidden.
- [ ] Taking the mirror goes straight to `039`.
- [ ] `039` has no extra lines and only **two** buttons.
- [ ] `041` has only **two** buttons.
- [ ] `042` has Sarutahiko simply nodding.
- [ ] `043` has “Susanoo does not come” and no fox or box lines.

---

## Endings

Each path starts from **New Adventure**. After each ending, check that the outcome screen shows the right title and classification, that **Restart**, **Return to Amaterasu Menu** and **Return to Story Selection** all work, and that the ending is unlocked in the Endings gallery.

| Path | Ending | Taps |
|---|---|---|
| E1 | `003` The Endless Night (Lost) | Continue → Stay with her |
| E2 | `004` Joined the Night Parade (Taken) | Continue → Climb the mountain → Watch them pass |
| E3 | `008` Led Astray by Foxfire (Death) | Continue → Climb the mountain → Hide and shut your eyes → Keep your name to yourself → Follow the brightest light |
| E4 | `011` The Endless Loom (Bound) | Continue → Climb the mountain → Hide and shut your eyes → Keep your name to yourself → Ring Grandmother’s bell → Bow and ask his leave → Continue → Sit at the loom |
| E5 | `013` Looked Upon the Sun (Death) | Continue → Climb the mountain → Hide and shut your eyes → Keep your name to yourself → Ring Grandmother’s bell → Bow and ask his leave → Continue → Go on toward the torches → Peek through the crack |
| E6 | `021` Hidden by the Tengu (Hidden) | OPEN → The mountain path → Take the path through the roots → Sit down and rest |
| E7 | `021` Hidden by the Tengu (Hidden) | OPEN → The mountain path → Climb the stone stair → Bow to them → Challenge him for it |
| E8 | `030` Three Hundred Years (Lost in Time) | OPEN → The sea path → Row out in the fishing boat → Give it the ladle with no bottom → Join the feast → Stay one more day |
| E9 | `038` Swallowed by Orochi (Death) | OPEN → The river path → Follow them upstream → Face the serpent alone → Fight on |
| E10 | `044` The Rock Stays Shut (Eternal Night) | OPEN → MIRROR → JEWELS → SWORD → Begin the festival → Throw your weight against the rock |
| E11 | `044` The Rock Stays Shut (Eternal Night) | OPEN → MIRROR → JEWELS → SWORD → Begin the festival → Raise the mirror to the crack → Reach in and pull her out yourself |
| E12 | `045` The Sun’s Companion (Sacrifice) | OPEN → MIRROR → JEWELS → SWORD → Go into the cave yourself |
| E13 | `046` The Opened Box (Aged) | OPEN → MIRROR → The sea path → Row out in the fishing boat → Give it the ladle with no bottom → Ask for the jewels → Tell him what the night has done → **Take the jewels and the box** → SWORD → Begin the festival → Raise the mirror to the crack → Offer her Otohime’s box |
| E14 | `047` The Fox’s Wedding (Dark Ending) | Continue → Climb the mountain → Hide and shut your eyes → **Tell it your name** → Bow and ask his leave → Continue → Go on toward the torches → Accept the task → MIRROR → JEWELS → SWORD → Let the fox speak for you |

After all paths, the Endings button should read **Endings (13/13)**.

---

## Saving and menus

- [ ] Leave mid-run (for example at `027`) with **Return to Amaterasu Menu**, then tap **Continue Adventure**: you return to the same page, with the same treasures and remembered choices.
- [ ] Force-quit the app mid-run and relaunch: **Continue Adventure** still works.
- [ ] After any ending, **Continue Adventure** is gone from the Amaterasu menu, but completed endings are kept.
- [ ] **New Adventure** with a run in progress asks for confirmation first.
- [ ] Amaterasu progress does not affect the Sphinx, Anubis or Hades saves, and theirs do not affect it.
- [ ] Options (typewriter, transitions, glow, haptics, ambience) all apply on Amaterasu pages, including the ink fade, lantern and shoji-screen transitions.
