# The Cave of Amaterasu — Story Map

**Story ID:** `cave-of-amaterasu`  
**Page prefix:** `AMA`  
**Status:** Pages built (`AMA000View` … `AMA047View`) on the shared story engine. The Swift views in this folder are now the source of truth, and this file must be updated whenever a page, choice or ending changes. Page art is placeholder for now (each image shows its page number and title); replace each image set in `Assets.xcassets/Amaterasu/` with the final art under the same name. See `The_Cave_of_Amaterasu_Test_Paths.md` for the on-device test paths.

---

# How the Story Works

- Long ago, when the gods still walked the islands of Japan, the sun fails to rise. Amaterasu, goddess of the sun, has shut herself inside the Heavenly Rock Cave after her brother Susanoo, the storm god, wrecked her rice fields and her weaving hall. Your grandmother, the old priestess of your village shrine, gives you her shrine bell and sends you up Mount Takachiho to the Floating Bridge of Heaven.
- The player starts at `000`. After getting past the Night Parade of One Hundred Demons, a white fox, Sarutahiko (god of the crossing) and a ghostly weaving maiden, Omoikane (god of wisdom) tells you that the gods can coax Amaterasu out, but only with the three sacred treasures, which were scattered across the dark earth:
  - the **Eight-Hand Mirror** (held by Sōjōbō, King of the Tengu, on Mount Kurama)
  - the **Curved Jewels** (claimed by Ryūjin, the Dragon King, under the sea)
  - the **Sword of the Gathering Clouds** (inside the tail of Yamata no Orochi, the eight-headed serpent of Izumo)
- `014` (**HOME**, the Heavenly Rock Cave) is the hub. It shows a path for each treasure the player has not collected yet (up to three buttons):
  - Eight-Hand Mirror → `015` (the mountain path, Mount Kurama)
  - Curved Jewels → `022` (the sea path, the Dragon Palace)
  - Sword of the Gathering Clouds → `031` (the river path, Izumo)
- When all three treasures are collected, any route into HOME goes to `039` (The Festival at the Rock) instead. This opens the end-game.
- Treasures are collected by the choice buttons marked **[collects …]**.
- Some choices are remembered (**[remembers …]**) and change later pages:
  - **Told the fox your name** at `005`: the fox leaves you at the bridge (`009`), appears at `039` with a third choice, **Let the fox speak for you** → `047`, and teases you at `043`.
  - **Defied Sarutahiko** at `007`: he answers differently at `009`, watches coldly at `039` and grumbles at `042`.
  - **Saved the turtle** at `022`: choosing **Stay one more day** at `027` leads to `028` (the turtle warns you) instead of `030` (game over).
  - **Took Otohime’s box** at `029`: a third choice, **Offer her Otohime’s box** → `046`, is added at `041`, and the box is mentioned at `043`.
  - **Heard Susanoo out** at `032`: Susanoo meets you at `037`, stands among the gods at `039`, and makes peace with his sister at `043`.
- Game-over pages have no choice buttons. They show the shared outcome screen with Restart / Menu controls and record their ending ID.
- Progress (current page, visited pages, collected treasures, remembered choices, completed endings) is saved under `Tales.cave-of-amaterasu.progress.v1`. Restarting clears everything except completed endings.

Page names in conversation use the short number (`004`). In code, the view is `AMA004View` and the route is `.ama004` (`"AMA-004"`).

**Swift names:**

| Type | Name | Values |
|---|---|---|
| Story | `CaveOfAmaterasu` | short name `Amaterasu` |
| Route | `CaveOfAmaterasuRoute` | `start = .ama000`, `home = .ama014`, `endGame = .ama039` |
| Item | `CaveOfAmaterasuItem` | `eightHandMirror`, `curvedJewels`, `cloudSword` |
| Flag | `CaveOfAmaterasuStoryFlag` | `toldFoxYourName`, `defiedSarutahiko`, `savedTheTurtle`, `tookOtohimesBox`, `heardSusanoo` (none has an opposite) |
| Outcome | `CaveOfAmaterasuOutcome` | `win`, `darkWin`, `bittersweet`, `lose`, `death` |

---

# Route Table

| Page | Title | Choice | Goes to |
|---|---|---|---|
| `000` | The Morning Without a Sun | Continue | `001` Grandmother’s Shrine |
| `001` | Grandmother’s Shrine | Climb the mountain | `002` The Night Parade |
|  |  | Stay with her | `003` The Endless Night (Game Over) |
| `002` | The Night Parade | Hide and shut your eyes | `005` The White Fox |
|  |  | Watch them pass | `004` Joined the Night Parade (Game Over) |
| `003` | The Endless Night | — | **Game Over** (Lost) |
| `004` | Joined the Night Parade | — | **Game Over** (Taken) |
| `005` | The White Fox | Tell it your name **[remembers: Told the fox your name]** | `007` The God of the Crossing |
|  |  | Keep your name to yourself | `006` The Foxfire Trail |
| `006` | The Foxfire Trail | Ring Grandmother’s bell | `007` The God of the Crossing |
|  |  | Follow the brightest light | `008` Led Astray by Foxfire (Game Over) |
| `007` | The God of the Crossing | Bow and ask his leave | `009` The Floating Bridge of Heaven |
|  |  | Say you need no one’s leave **[remembers: Defied Sarutahiko]** | `009` The Floating Bridge of Heaven |
| `008` | Led Astray by Foxfire | — | **Game Over** (Death) |
| `009` | The Floating Bridge of Heaven | Continue | `010` The Ruined Weaving Hall |
| `010` | The Ruined Weaving Hall | Sit at the loom | `011` The Endless Loom (Game Over) |
|  |  | Go on toward the torches | `012` The Council of the Gods |
| `011` | The Endless Loom | — | **Game Over** (Bound) |
| `012` | The Council of the Gods | Accept the task | `014` HOME |
|  |  | Peek through the crack | `013` Looked Upon the Sun (Game Over) |
| `013` | Looked Upon the Sun | — | **Game Over** (Death) |
| `014` | HOME — The Heavenly Rock Cave | The mountain path | `015` The Cedars of Kurama |
|  |  | The sea path | `022` The Shore of Night |
|  |  | The river path | `031` The Chopsticks in the River |
| `015` | The Cedars of Kurama | Climb the stone stair | `016` The Crow-Tengu |
|  |  | Take the path through the roots | `017` The Hollow of the Hidden |
| `016` | The Crow-Tengu | Bow to them | `018` The Hall of Sōjōbō |
|  |  | Boast that you crossed the Bridge of Heaven | `017` The Hollow of the Hidden |
| `017` | The Hollow of the Hidden | Ring Grandmother’s bell | `018` The Hall of Sōjōbō |
|  |  | Sit down and rest | `021` Hidden by the Tengu (Game Over) |
| `018` | The Hall of Sōjōbō | Look into the mirror | `019` The Mirror’s Truth |
|  |  | Challenge him for it | `021` Hidden by the Tengu (Game Over) |
| `019` | The Mirror’s Truth | Keep looking | `020` The Eight-Hand Mirror |
|  |  | Look away | `018` The Hall of Sōjōbō |
| `020` | The Eight-Hand Mirror | Take the mirror **[collects Eight-Hand Mirror]** | `014` HOME (or `039` if all treasures are held) |
| `021` | Hidden by the Tengu | — | **Game Over** (Hidden) |
| `022` | The Shore of Night | Save the turtle **[remembers: Saved the turtle]** | `023` The Turtle’s Back |
|  |  | Row out in the fishing boat | `024` The Sea Monk |
| `023` | The Turtle’s Back | Hold on tight | `025` The Dragon Palace |
| `024` | The Sea Monk | Give it the ladle with no bottom | `025` The Dragon Palace |
|  |  | Give it your bucket | `027` The Feast Beneath the Waves |
| `025` | The Dragon Palace | Ask for the jewels | `026` The Dragon King |
|  |  | Join the feast | `027` The Feast Beneath the Waves |
| `026` | The Dragon King | Tell him what the night has done | `029` The Curved Jewels |
|  |  | Promise to stay as his guest | `027` The Feast Beneath the Waves |
| `027` | The Feast Beneath the Waves | Remember why you came | `026` The Dragon King |
|  |  | Stay one more day | `030` Three Hundred Years (Game Over); if *saved the turtle at 022*: **Stay one more day** → `028` The Turtle Remembers |
| `028` | The Turtle Remembers | Go to the Dragon King | `026` The Dragon King |
| `029` | The Curved Jewels | Take the jewels and the box **[collects Curved Jewels]** **[remembers: Took Otohime’s box]** | `014` HOME (or `039` if all treasures are held) |
|  |  | Take only the jewels **[collects Curved Jewels]** | `014` HOME (or `039` if all treasures are held) |
| `030` | Three Hundred Years | — | **Game Over** (Lost in Time) |
| `031` | The Chopsticks in the River | Follow them upstream | `033` The Weeping House |
|  |  | Follow the singing | `032` The Exiled God |
| `032` | The Exiled God | Sit and listen **[remembers: Heard Susanoo out]** | `033` The Weeping House |
|  |  | Leave him to his sake | `033` The Weeping House |
| `033` | The Weeping House | Brew eight vats of sake | `034` The Eight Gates |
|  |  | Face the serpent alone | `035` The Eight-Headed Serpent |
| `034` | The Eight Gates | Wait until every head sleeps | `036` The Serpent Sleeps |
|  |  | Strike now | `035` The Eight-Headed Serpent |
| `035` | The Eight-Headed Serpent | Run back to the house | `034` The Eight Gates |
|  |  | Fight on | `038` Swallowed by Orochi (Game Over) |
| `036` | The Serpent Sleeps | Cut open the glowing tail | `037` The Sword of the Gathering Clouds |
| `037` | The Sword of the Gathering Clouds | Take the sword **[collects Sword of the Gathering Clouds]** | `014` HOME (or `039` if all treasures are held) |
| `038` | Swallowed by Orochi | — | **Game Over** (Death) |
| `039` | The Festival at the Rock | Begin the festival | `040` The Dance of Ame-no-Uzume |
|  |  | Go into the cave yourself | `045` The Sun’s Companion (Game Over) |
|  |  | *Only if told the fox your name at 005:* **Let the fox speak for you** | `047` The Fox’s Wedding (Game Over) |
| `040` | The Dance of Ame-no-Uzume | Raise the mirror to the crack | `041` Her Own Light |
|  |  | Throw your weight against the rock | `044` The Rock Stays Shut (Game Over) |
| `041` | Her Own Light | Signal Tajikarao | `042` The Sacred Rope |
|  |  | Reach in and pull her out yourself | `044` The Rock Stays Shut (Game Over) |
|  |  | *Only if took Otohime’s box at 029:* **Offer her Otohime’s box** | `046` The Opened Box (Game Over) |
| `042` | The Sacred Rope | Stretch the rope across the cave | `043` Dawn Returns (Game Over) |
| `043` | Dawn Returns | — | **Game Over** (Best Ending) |
| `044` | The Rock Stays Shut | — | **Game Over** (Eternal Night) |
| `045` | The Sun’s Companion | — | **Game Over** (Sacrifice) |
| `046` | The Opened Box | — | **Game Over** (Aged) |
| `047` | The Fox’s Wedding | — | **Game Over** (Dark Ending) |

A script that reads every button from the `AMA###View.swift` files walks every reachable combination of page, treasures and remembered choices (1,666 states): all 48 pages, all 13 endings and all 66 choice buttons can be reached, and every non-ending page always shows at least one button.

---

# Endings

| Page | Ending | Classification | Outcome style | Ending ID | Reached from |
|---|---|---|---|---|---|
| `003` | The Endless Night | Lost | `lose` | `amaterasu_endless_night` | `001` |
| `004` | Joined the Night Parade | Taken | `lose` | `amaterasu_joined_the_night_parade` | `002` |
| `008` | Led Astray by Foxfire | Death | `death` | `amaterasu_led_astray_by_foxfire` | `006` |
| `011` | The Endless Loom | Bound | `lose` | `amaterasu_endless_loom` | `010` |
| `013` | Looked Upon the Sun | Death | `death` | `amaterasu_looked_upon_the_sun` | `012` |
| `021` | Hidden by the Tengu | Hidden | `lose` | `amaterasu_hidden_by_the_tengu` | `017`, `018` |
| `030` | Three Hundred Years | Lost in Time | `bittersweet` | `amaterasu_three_hundred_years` | `027` |
| `038` | Swallowed by Orochi | Death | `death` | `amaterasu_swallowed_by_orochi` | `035` |
| `043` | Dawn Returns | Best Ending | `win` | `amaterasu_dawn_returns` | `042` |
| `044` | The Rock Stays Shut | Eternal Night | `lose` | `amaterasu_rock_stays_shut` | `040`, `041` |
| `045` | The Sun’s Companion | Sacrifice | `bittersweet` | `amaterasu_suns_companion` | `039` |
| `046` | The Opened Box | Aged | `lose` | `amaterasu_opened_box` | `041` |
| `047` | The Fox’s Wedding | Dark Ending | `darkWin` | `amaterasu_fox_wedding` | `039` |

---

# Presentation

**Colour theme** (sumi ink, indigo night, vermilion lacquer and gold leaf):

| Token | Hex | Use |
|---|---|---|
| Background top | `0E0C10` | Sumi-ink night |
| Background bottom | `171A2E` | Indigo (ai) shadow |
| Background glow | `C8402A` at 18% | Lantern light |
| Card | `17151C` at 88% | Text cards |
| Card alt | `231F2C` at 85% | Secondary cards |
| Accent (vermilion) | `D9553B` | Titles, borders (torii lacquer) |
| Washi | `F2EADB` | Body text |
| Muted text | `B4AFA6` | Subtitles |
| Secondary text | `D8C9A8` | Captions |
| Button gradient | `F0A35E` → `D9553B` | Choice buttons |
| Button pressed | `D9553B` → `A63A26` | Pressed buttons |
| Button text | `1A0C08` | Button labels |
| Gold leaf | `E3B85C` | Button glow, win ending |

**Placeholder symbol:** `sun.haze.fill`.

**Page transitions** (Japanese versions of the three shared styles):

- `inkFade` — a wash of sumi ink (the shared `fade`; colours `4A4650`, `2A2630`, `121016`)
- `torchReveal` — lantern light (kept as is; colours gold `E3B85C` and vermilion `C8402A`)
- `shojiSlide` — paper screens sliding apart (the shared `doors`; colours `E9DFC8`, `B9A57E`, `5A4632`)

Pages that list no transition use `inkFade`.

**Outcome styles:**

| Style | Title | Subtitle | Icon | Accent |
|---|---|---|---|---|
| `win` | Victory | The sun is up, and the whole world is warm again. | `sun.max.fill` | `E8B04A` |
| `darkWin` | A Stolen Victory | The dawn has come, but someone else has been paid for it. | `moon.stars.fill` | `B9A5E0` |
| `bittersweet` | A Bittersweet End | The light came back, but not everything came with it. | `leaf.fill` | `E3A3B5` (sakura) |
| `lose` | Defeat | The dark keeps what wanders into it. | `cloud.fog.fill` | `B8B2A7` |
| `death` | You Have Fallen | Another lantern goes out on the mountain. | `xmark.shield.fill` | `C8402A` |

**Images:** every page uses its own illustration named after its number (`AMA000` … `AMA047`), plus `AMA-Icon` and `AMA-Title-Screen-Art`, added to `Assets.xcassets/Amaterasu/` as JPEG image sets. Each page below has an **Art** note to help keep the illustrations consistent: a painted, ukiyo-e–inspired look, deep indigo and ink-black nights, with warm lantern, gold and vermilion light.

- **Icon (`AMA-Icon`):** a vermilion torii gate in front of a great boulder, with a thin line of gold light leaking around the boulder’s edge.
- **Title art (`AMA-Title-Screen-Art`):** the Heavenly Rock Cave at night, with gods holding torches before it, a sakaki tree hung with a mirror and jewels, and a single small human figure with a bell standing in front of them all.

**Story selection blurb:** “Climb to the gods, recover the three sacred treasures, and coax the sun out of hiding before the night lasts forever.”

---

# Pages

## 000 — The Morning Without a Sun

**Image:** `AMA000`  
**Transition:** `inkFade`  
**Art:** A rice-farming village of thatched houses under a black sky, frost on the paddies, and one lantern glowing at a small shrine on the hillside above.

**Text:**  
Long ago, when the gods still walked the islands of Japan, you lived with your grandmother in a rice-farming village at the foot of Mount Takachiho. Three days ago, the sun did not rise. The roosters crowed into the darkness and then fell silent. Frost crept over the young rice, and the river stopped singing. On the second night, people heard wooden clogs and laughter on the mountain road, and the men who went to look did not come back. Now the whole village sits shuttered around its fires, and the only light on the hillside is the lantern at the old shrine, where your grandmother has been praying since the sun went out. Tonight, she has sent for you.

### Choices

- **Continue** → `001` Grandmother’s Shrine

---

## 001 — Grandmother’s Shrine

**Image:** `AMA001`  
**Reached from:** `000`  
**Art:** An old shrine priestess in white and red robes kneeling at a lantern-lit altar, holding out a cluster of brass bells on a red cord.

**Text:**  
Your grandmother kneels before the shrine’s little altar in her white and red robes, her breath smoking in the cold. She has served this shrine for sixty years, and she tells you the story the way she told it when you were small. Susanoo, the storm god, ran wild in heaven. He smashed the dikes of his sister’s rice fields and tore down her weaving hall, and Amaterasu, goddess of the sun, was so frightened and so ashamed that she shut herself inside the Heavenly Rock Cave. While she hides, there is no day. “The gods are many,” your grandmother says, “but sometimes the gods are waiting for us.” She presses her shrine bell into your hand, a cluster of small brass bells on a red cord. “Ring it when you cannot tell the truth from a trick. Climb to the summit. Long ago, the bridge to heaven came down there.”

### Choices

- **Climb the mountain** → `002` The Night Parade
- **Stay with her** → `003` The Endless Night (Game Over)

---

## 002 — The Night Parade

**Image:** `AMA002`  
**Reached from:** `001`  
**Transition:** `torchReveal`  
**Art:** A procession of yokai on a mountain path through bamboo: paper lanterns with tongues and single eyes, hopping one-legged umbrellas, a long-necked woman, red oni carrying a palanquin.

**Text:**  
Halfway up the mountain path, the bamboo goes silent. Then you hear it: wooden clogs, the thump of drums and a hundred voices laughing at nothing. Lights bob through the trees toward you. It is the Night Parade of One Hundred Demons, the procession of yokai that walks on the darkest nights. Paper lanterns with lolling tongues and single rolling eyes. Old umbrellas hopping on one leg. A woman whose long neck lifts her head high above the crowd. Red-faced oni carrying a palanquin hung with bones. Your grandmother’s voice comes back to you from your childhood: “If the parade passes, hide and do not look. Whoever watches it, joins it.” The procession is almost on top of you.

### Choices

- **Hide and shut your eyes** → `005` The White Fox
- **Watch them pass** → `004` Joined the Night Parade (Game Over)

---

## 003 — The Endless Night (Game Over)

**Image:** `AMA003`  
**Outcome:** `lose` · Lost · `amaterasu_endless_night`  
**Reached from:** `001`  
**Art:** A lone figure ringing a bell on the steps of a dark shrine, the lantern beside them burnt out, the village below empty and frozen.

**Text:**  
You cannot leave her alone in the dark. You sit beside your grandmother and help her keep the lantern burning, and together you pray for the sun. Days pass that are not days. The oil runs low, and then it runs out. The rice dies in the frozen fields, the neighbours leave for the lowlands one by one, and the laughter on the mountain road comes a little closer every night. Your grandmother grows quieter, and one morning that is not a morning, she does not wake. You ring her bell into the darkness until your arm aches. Nobody in heaven answers, because nobody climbed up to ask.

**Outcome text:**  
You stayed where it was safe, and the sun never came back.  
The bridge to heaven waited for a climber who never came.

---

## 004 — Joined the Night Parade (Game Over)

**Image:** `AMA004`  
**Outcome:** `lose` · Taken · `amaterasu_joined_the_night_parade`  
**Reached from:** `002`  
**Art:** The tail of the yokai procession disappearing into the dark forest, with a human figure at the very end holding a paper lantern, eyes blank.

**Text:**  
You can’t help it. You peer through the bamboo as the procession passes, and for a moment it is the most wonderful thing you have ever seen: lanterns glowing like coals, drums thumping, monsters dancing in the dark. Then a paper lantern at the end of the line stops. Its single eye rolls toward you. One by one, every head in the parade turns. The long-necked woman smiles and reaches down a hand that is not cold at all. “Come along,” she says. “There is always room for one more.” Someone puts a lantern in your hand. Your feet start walking. By the time you remember you had somewhere to be, you no longer remember your name.

**Outcome text:**  
You watched the Night Parade, and the Night Parade took you in.  
On the darkest nights, your lantern bobs along at the very end of the line.

---

## 005 — The White Fox

**Image:** `AMA005`  
**Reached from:** `002`  
**Art:** A white fox sitting on a mossy stone path, a small blue flame floating above the tip of its tail, its golden eyes amused.

**Text:**  
You crouch in the bamboo with your eyes squeezed shut while the parade thunders past, so close you can smell incense and wet fur. When the noise has faded completely, you open your eyes. A white fox is sitting on the path in front of you. A small blue flame floats above the tip of its tail, lighting up the stones. “Well done,” it says, in a voice like a young man’s. “Most people peek.” It tells you it is a messenger of Inari, the god of rice, and that it knows the quickest way to the summit, where the Floating Bridge of Heaven comes down. “I’ll guide you, gladly. But it’s rude to travel with a stranger. Tell me your name.”

### Choices

- **Tell it your name** **[remembers: Told the fox your name]** → `007` The God of the Crossing
- **Keep your name to yourself** → `006` The Foxfire Trail

---

## 006 — The Foxfire Trail

**Image:** `AMA006`  
**Reached from:** `005`  
**Art:** A fork in a dark mountain path around an ancient cedar; one dim, flickering blue light drifts to the left, one bright, warm light floats to the right.

**Text:**  
The fox’s eyes narrow, and then it laughs. “Clever, clever. Your grandmother taught you something.” It trots ahead into the trees, and you follow its light up the mountain. Near the summit, the path splits around an ancient cedar. The fox stops, and its flame splits in two. One light drifts to the left, dim and flickering. The other floats to the right, bright and steady and warm, and it seems to be calling you. When you turn to ask the fox which one to follow, it has gone, and two more lights are dancing in the dark behind you. Your grandmother’s bell is cold in your fist.

### Choices

- **Ring Grandmother’s bell** → `007` The God of the Crossing
- **Follow the brightest light** → `008` Led Astray by Foxfire (Game Over)

---

## 007 — The God of the Crossing

**Image:** `AMA007`  
**Reached from:** `005`, `006`  
**Transition:** `shojiSlide`  
**Art:** A giant red-faced god with a long nose and shining eyes, arms folded, standing before a bridge of mist and pale rainbow light that climbs from a mountaintop shrine into the night sky.

**Text:**  
The path ends at the summit of Mount Takachiho, where an old wooden shrine leans in the wind. Beyond it, a bridge of mist and pale rainbow light rises from the rock and climbs into the dark sky. In front of the bridge stands a giant of a man with his arms folded. His face is red, his nose is as long as your forearm, and his eyes shine like mirrors. This is Sarutahiko, god of crossroads and guardian of the way between heaven and earth. He looks down at you for a long time. “The Floating Bridge of Heaven is for gods,” he says. “Little human, who gave you leave to climb it?”

### Choices

- **Bow and ask his leave** → `009` The Floating Bridge of Heaven
- **Say you need no one’s leave** **[remembers: Defied Sarutahiko]** → `009` The Floating Bridge of Heaven

---

## 008 — Led Astray by Foxfire (Game Over)

**Image:** `AMA008`  
**Outcome:** `death` · Death · `amaterasu_led_astray_by_foxfire`  
**Reached from:** `006`  
**Art:** A warm light floating over the edge of a cliff in the dark, ferns and loose stones at the brink, a fox’s silhouette watching from the trees.

**Text:**  
You follow the bright light. It is warm and kind and always just a few steps ahead, and you are so tired of the dark. It leads you off the path, through wet ferns, over roots and across a slope of loose stones. You never quite catch up with it. Somewhere behind you, you hear laughter, high and delighted, and you turn to look, and the ground is no longer there. You fall for a long time. Foxfire, your grandmother used to say, is the prettiest light in the mountains, and it has never once led anybody home.

**Outcome text:**  
You followed the foxfire, and it led you off the edge of the mountain.  
The fox still laughs about it on cold nights.

---

## 009 — The Floating Bridge of Heaven

**Image:** `AMA009`  
**Reached from:** `007`  
**Transition:** `inkFade`  
**Notes:** The opening depends on the choice at `007`. A line is added if the player told the fox their name.  
**Art:** A small figure crossing a swaying bridge of mist high above a sea of clouds; far below, the islands of Japan lie dark, with one tiny lantern glowing on a hillside.

**Text (if you bowed at 007):**  
You bow low and tell him about your village, your grandmother and the sun. Sarutahiko is quiet for a moment. Then he bows back, very slightly, and steps aside. “Walk in the middle,” he says. “The edges are for birds.”

**Text (if you defied him at 007):**  
Sarutahiko throws back his head and laughs, a sound like falling rocks. “No one’s leave! Good. Then you won’t mind falling.” He steps aside, and you notice that he does not wish you luck.

**Extra line (if you told the fox your name):**  
At the foot of the bridge, the white fox stops. “Foxes don’t cross,” it says. “I’ll find you later. I know your name, after all.”

**Text (always):**  
The bridge is soft underfoot, like walking on cloud, and it sways with every step. Far below, the islands of Japan lie in total darkness. Here and there, the fires of yokai flicker in the forests, and the sea is as black as ink. You look for your village and find a single tiny light on a hillside: your grandmother’s lantern, still burning. You climb for what feels like hours, until the mist thins and you step off onto soft earth beneath a sky full of stars. You are in Takamagahara, the High Plain of Heaven.

### Choices

- **Continue** → `010` The Ruined Weaving Hall

---

## 010 — The Ruined Weaving Hall

**Image:** `AMA010`  
**Reached from:** `009`  
**Art:** A great hall with its roof torn open, smashed looms and trailing silver threads, and a pale, translucent young woman weaving at the one loom still standing.

**Text:**  
The High Plain of Heaven should be bright, but tonight it is as dark as the world below. The first building you come to is a great hall with its roof torn open, where looms lie smashed and threads of silver silk trail across the floor. This was Amaterasu’s weaving hall, the one Susanoo destroyed. One loom is still standing, and at it sits a young woman in a pale robe, weaving in the dark. Her hands move, but no cloth comes from the loom. “The goddess will need a new robe when she comes out,” she says without looking up. “But my hands are so tired. Sit with me and help me finish it. It won’t take long.” Far off across the plain, you can see the torches of a great crowd.

### Choices

- **Sit at the loom** → `011` The Endless Loom (Game Over)
- **Go on toward the torches** → `012` The Council of the Gods

---

## 011 — The Endless Loom (Game Over)

**Image:** `AMA011`  
**Outcome:** `lose` · Bound · `amaterasu_endless_loom`  
**Reached from:** `010`  
**Art:** Two figures weaving side by side at a loom in a ruined hall; behind them the half-finished cloth unravels into loose threads on the floor.

**Text:**  
You sit down beside her, and she shows you how to pass the shuttle through the threads. It is soothing work. Click, pull, click. The weaving maiden smiles at you, and you notice that you can see the loom through her smile. The robe never grows, however fast you weave. Every row you finish quietly unravels behind you. You mean to stop after one more row, then one more, then one more. Somewhere out on the plain, the torches move and the gods argue and wait, and the darkness goes on. You will finish the robe soon. You are sure of it. Click, pull, click.

**Outcome text:**  
You stopped to weave a robe that can never be finished.  
The weaving maiden is glad of the company, and she always will be.

---

## 012 — The Council of the Gods

**Image:** `AMA012`  
**Reached from:** `010`  
**Transition:** `torchReveal`  
**Art:** A crowd of gods with torches before a black cliff, a sealed boulder at its foot with a thread of golden light around its edge, and a thin old god with a long white beard raising his hand.

**Text:**  
Beside the Heavenly River, the eight hundred myriad gods of heaven have gathered in front of a cliff of black rock, holding torches and arguing at the tops of their voices. At the foot of the cliff is a great boulder, sealed tight, and a thin thread of golden light leaks from the crack around its edge. This is the Heavenly Rock Cave. A thin old god with a long white beard notices you and quiets the crowd. He is Omoikane, the god of wisdom. He has a plan to coax Amaterasu out, he says, but it needs three treasures, and they were scattered across the earth when Susanoo raged through heaven. The Eight-Hand Mirror fell on Mount Kurama, where the King of the Tengu keeps it. The string of Curved Jewels sank into the sea, and the Dragon King has claimed it. And a sword lies in the tail of the eight-headed serpent of Izumo. “Gods who walk the earth in this darkness lose their way,” Omoikane says. “But you found your way here.”

### Choices

- **Accept the task** → `014` HOME
- **Peek through the crack** → `013` Looked Upon the Sun (Game Over)

---

## 013 — Looked Upon the Sun (Game Over)

**Image:** `AMA013`  
**Outcome:** `death` · Death · `amaterasu_looked_upon_the_sun`  
**Reached from:** `012`  
**Art:** Blinding white-gold light bursting from a crack in a great boulder, and the shape of a hand scorched on the stone.

**Text:**  
While the gods are talking, you creep to the great boulder and put your eye to the crack. Just one look, you think, at the goddess everyone is waiting for. Inside, the cave is full of a light so pure that it has no colour at all. Amaterasu sits at the centre of it with her face in her hands. She lifts her head. For one heartbeat you see the face of the sun, and it is the most beautiful thing in heaven or on earth. Then there is only white, and warmth, and nothing. When the gods come looking for you, they find only the shape of a hand scorched into the stone.

**Outcome text:**  
You looked upon the face of the sun with mortal eyes.  
Even the gods do not dare to do that.

---

## 014 — HOME — The Heavenly Rock Cave

**Image:** `AMA014`  
**Reached from:** `012`, `020`, `029`, `037`  
**Transition:** `shojiSlide`  
**Notes:** HOME hub. Only the paths for treasures you have not collected are shown. Once all three treasures are collected, any route to HOME goes to `039` instead.  
**Art:** Three roads of cloud unrolling from the edge of heaven down to the dark earth — one toward a forested mountain, one toward a black sea, one toward a river valley — with a goddess sitting on an overturned tub beside the sealed cave.

**Text:**  
The gods have cleared a space before the Heavenly Rock Cave, and Omoikane draws three paths in the dust with his staff. As each one is drawn, a road of cloud unrolls from the edge of heaven down to the dark earth. The mountain path leads to Mount Kurama, where crow-winged tengu guard the Eight-Hand Mirror. The sea path leads down to a black shore and the Dragon King’s palace beneath the waves, where the Curved Jewels lie. The river path leads to the land of Izumo, where the eight-headed serpent sleeps on a stolen sword. Ame-no-Uzume, goddess of dawn and dancing, sits on an overturned tub beside the cave, tapping her feet. “Hurry back,” she says. “I’ve been practising.” Any path whose treasure you have already brought back has faded into mist.

### Choices

Only the paths for treasures not yet collected are shown:

- **The mountain path** → `015` The Cedars of Kurama (hidden once the Eight-Hand Mirror is collected)
- **The sea path** → `022` The Shore of Night (hidden once the Curved Jewels are collected)
- **The river path** → `031` The Chopsticks in the River (hidden once the Sword of the Gathering Clouds is collected)

---

## 015 — The Cedars of Kurama

**Image:** `AMA015`  
**Reached from:** `014`  
**Art:** A steep mossy stone stairway lit by stone lanterns, climbing through giant cedars; beside it a narrow path winds through tangled roots; a silver glint near the summit.

**Text:**  
The cloud road sets you down at the foot of Mount Kurama, where cedars older than any city climb into the dark. Somewhere above, heavy wings beat through the branches, and something laughs in a voice like a crow. A stone stairway runs straight up the mountainside, steep and slick with moss, lit by a few stone lanterns. Beside it, a narrower path winds through the great tangled roots of the cedars, and it looks shorter. Near the top of the mountain, through a gap in the trees, you catch a glint of silver, like moonlight on water. The mirror is up there.

### Choices

- **Climb the stone stair** → `016` The Crow-Tengu
- **Take the path through the roots** → `017` The Hollow of the Hidden

---

## 016 — The Crow-Tengu

**Image:** `AMA016`  
**Reached from:** `015`  
**Art:** A dozen small crow-headed goblins in priests’ robes, holding little wooden swords, hopping on a lantern-lit stone stair and peering at the viewer.

**Text:**  
Halfway up the stairway, a dozen figures drop out of the cedars and land on the steps around you. They have the bodies of small men in priests’ robes and the heads of crows, with sharp black beaks and bright, curious eyes. They are karasu-tengu, the crow goblins of the mountain, and they carry little wooden swords. “A human!” one caws. “A human, climbing our mountain in the dark without being asked.” They hop closer, clacking their beaks. “Tell us, human. What makes you so important that the King of the Tengu should see you?”

### Choices

- **Bow to them** → `018` The Hall of Sōjōbō
- **Boast that you crossed the Bridge of Heaven** → `017` The Hollow of the Hidden

---

## 017 — The Hollow of the Hidden

**Image:** `AMA017`  
**Reached from:** `015`, `016`  
**Art:** A deep hollow among cedar roots where people from every age — a farmer in straw sandals, a samurai in old armour, a child with a kite — sit peacefully with vague, dreamy smiles.

**Text:**  
Without warning, black talons grab your collar and lift you into the air. Crow-tengu carry you, laughing, over the treetops and drop you into a deep hollow among the cedar roots, far from any path. You are not alone. Dozens of people are sitting in the hollow, in clothes from every age: a farmer in straw sandals, a samurai in old-fashioned armour, a child holding a kite. Each of them was spirited away by the tengu, and none of them seems to mind. They smile at you vaguely. “Sit down,” says the farmer. “It’s peaceful here. Nobody ever has to go anywhere again.” Your legs are very tired.

### Choices

- **Ring Grandmother’s bell** → `018` The Hall of Sōjōbō
- **Sit down and rest** → `021` Hidden by the Tengu (Game Over)

---

## 018 — The Hall of Sōjōbō

**Image:** `AMA018`  
**Reached from:** `016`, `017`, `019`  
**Transition:** `shojiSlide`  
**Art:** A towering tengu king with a red face, a long nose, a white beard and a feather fan, seated in a cedar hall; behind him hangs a huge bronze mirror with an eight-petalled rim, shining in the dark.

**Text:**  
The crow-tengu bring you to the very top of Mount Kurama, to a hall of black cedar beams, and lead you inside, hopping and muttering. On a platform at the far end sits Sōjōbō, King of the Tengu. He is as tall as a doorway, with a red face, a nose like a long branch, a white beard down to his belt and a fan of feathers in one hand. Behind him, hanging from a beam, is a bronze mirror as wide as a cartwheel, its rim shaped like a flower with eight petals. Even in the dark, it shines. “The Eight-Hand Mirror shows every face exactly as it is,” Sōjōbō says. “The proud cannot bear to look into it. If you can, you may carry it away. Or you may try to take it from me, if you think you are strong enough.”

### Choices

- **Look into the mirror** → `019` The Mirror’s Truth
- **Challenge him for it** → `021` Hidden by the Tengu (Game Over)

---

## 019 — The Mirror’s Truth

**Image:** `AMA019`  
**Reached from:** `018`  
**Art:** A muddy, scratched young traveller standing before the great bronze mirror; in the reflection, faint scenes swirl — a mountain path, a lantern, an old woman.

**Text:**  
You step in front of the mirror. At first you see only yourself, muddy, scratched and frightened. Then the mirror shows you more. It shows the moment on the mountain when you nearly turned back. It shows every time you were unkind to your grandmother and pretended you hadn’t been. It shows how small you are against the size of the dark, and how badly you want somebody else to fix it. It is not cruel. It is simply true. Your face burns. Behind you, the tengu have gone quiet, waiting to see what you will do.

### Choices

- **Keep looking** → `020` The Eight-Hand Mirror
- **Look away** → `018` The Hall of Sōjōbō

---

## 020 — The Eight-Hand Mirror

**Image:** `AMA020`  
**Reached from:** `019`  
**Art:** The tengu king bowing to the young traveller as crow-tengu lift down the bronze mirror and wrap it in black silk.

**Text:**  
You keep looking. Slowly, the mirror shows you the rest: the climb, the parade you hid from, the bell in your fist, and the lantern still burning on the hillside far below because your grandmother believes you will come back. Small and afraid, but still walking. When at last you turn away, Sōjōbō is standing beside you, and he bows. “Most heroes cannot look for longer than a breath,” he says. “They want to see someone greater than themselves. The sun goddess hides because she cannot bear what she saw in herself. Perhaps she needs to see what you saw.” The crow-tengu lift down the mirror and wrap it in black silk.

### Choices

- **Take the mirror** **[collects Eight-Hand Mirror]** → `014` HOME (or `039` if all treasures are held)

---

## 021 — Hidden by the Tengu (Game Over)

**Image:** `AMA021`  
**Outcome:** `lose` · Hidden · `amaterasu_hidden_by_the_tengu`  
**Reached from:** `017`, `018`  
**Art:** A sleeping traveller curled up on soft moss among the spirited-away people in the cedar hollow; far below, a pair of straw sandals hangs on a village shrine door.

**Text:**  
The tengu have a way of dealing with humans who are too proud or too tired: they hide them. You wake in the hollow among the cedar roots, among the spirited-away, and the mountain is so quiet, and the moss is so soft. Sometimes you remember that you were supposed to be carrying something. Sometimes you remember a bell. The farmer pats your hand and tells you not to worry. Far away, at the foot of a different mountain, the people of a village you once knew hang your sandals by the shrine door and wait for you to come home, the way people always wait for the ones the tengu take.

**Outcome text:**  
The tengu hid you away, as they hide the proud and the weary.  
Mount Kurama keeps its mirror, and its guests.

---

## 022 — The Shore of Night

**Image:** `AMA022`  
**Reached from:** `014`  
**Transition:** `inkFade`  
**Art:** A black-sand beach under a starless sky; children with sticks around an old sea turtle flipped on its back; a small fishing boat pulled up on the sand with oars, a bucket and a ladle inside.

**Text:**  
The cloud road ends on a beach of black sand where the waves come in without a sound. There are no stars over the sea, only a darkness so deep that the horizon has disappeared. Down by the water, a group of children from a fishing village are poking at something with sticks and laughing. It is a sea turtle, small and old, flipped onto its back with its flippers waving helplessly. Further along the beach, a fishing boat is pulled up on the sand, with a pair of oars, a wooden bucket and a long-handled ladle lying in the bottom. Somewhere out under the black water lies Ryūgū-jō, the palace of the Dragon King.

### Choices

- **Save the turtle** **[remembers: Saved the turtle]** → `023` The Turtle’s Back
- **Row out in the fishing boat** → `024` The Sea Monk

---

## 023 — The Turtle’s Back

**Image:** `AMA023`  
**Reached from:** `022`  
**Art:** The traveller riding on the back of a great turtle, diving down through dark water toward the distant glow of coral towers and red lacquer gates.

**Text:**  
You chase the children away and gently turn the turtle back onto its belly. It blinks at you with eyes as old as the sea, and then it speaks. “Kindness on a dark night is a rare thing,” it says. “I serve the Dragon King’s daughter, and I know why you have come. Climb on my back.” You wade out and climb onto its shell, which grows broader as it swims. Then it dives. The water closes over your head, but you find you can breathe it like cool air. Far below, lights appear: towers of coral and pearl, gates of red lacquer, and a palace glowing in the deep.

### Choices

- **Hold on tight** → `025` The Dragon Palace

---

## 024 — The Sea Monk

**Image:** `AMA024`  
**Reached from:** `022`  
**Art:** A tiny fishing boat on a black sea before a colossal, bald, shadowy figure rising from the water with two huge glowing eyes.

**Text:**  
You push the boat into the silent water and row out into the dark until the beach disappears behind you. Then the sea in front of you rises into a hill, and the hill opens two enormous eyes. It is an umibōzu, a sea monk: a shadow as big as a temple, with a round, bald head and no mouth that you can see. A voice comes out of the water all around you. “Lend me a bucket. Lend me a bucket.” Your grandmother told you about the umibōzu. Give one a bucket, and it will fill your boat with seawater until it sinks. Give it a ladle with the bottom knocked out, and it will scoop at the sea forever without filling anything, until it gives up and sinks back down, dragging the water with it.

### Choices

- **Give it the ladle with no bottom** → `025` The Dragon Palace
- **Give it your bucket** → `027` The Feast Beneath the Waves

---

## 025 — The Dragon Palace

**Image:** `AMA025`  
**Reached from:** `023`, `024`  
**Transition:** `torchReveal`  
**Art:** An undersea palace of coral towers and mother-of-pearl roofs, fish servants in silk robes bowing, four gardens in four seasons, and a princess in sea-foam robes welcoming the traveller.

**Text:**  
The sea closes over you and carries you down and down, through water as warm as a bath, until you come to rest in front of the gates of Ryūgū-jō, the Dragon Palace. Its towers are made of coral, its roofs of mother-of-pearl, and its courtyards are full of fish in silk robes who bow as you pass. Each of its four gardens is in a different season: cherry blossoms in one, summer cicadas in the next, then red maples, then snow. A princess in robes the colour of sea foam comes to greet you. She is Otohime, the Dragon King’s daughter. “A guest from the dry world!” she says. “How wonderful. We’ve prepared a feast. You must be so tired.” From a great hall beyond her come music, laughter and the smell of food.

### Choices

- **Ask for the jewels** → `026` The Dragon King
- **Join the feast** → `027` The Feast Beneath the Waves

---

## 026 — The Dragon King

**Image:** `AMA026`  
**Reached from:** `025`, `027`, `028`  
**Art:** A colossal sea dragon with green-bronze scales and a seaweed beard coiled around the pillars of an undersea hall, a string of glowing green and red curved jewels around its neck.

**Text:**  
Otohime leads you into a hall so tall that its ceiling is lost in the dark water. Coiled around its pillars is Ryūjin, the Dragon King of the sea, with scales of green bronze, a beard like seaweed and eyes as large as rice bowls. Around his neck hangs a string of curved jewels, deep green and red, glowing like coals. These are the Curved Jewels, which fell from heaven into his sea. “What falls into the sea belongs to the sea,” he rumbles. “They are beautiful, and I am old, and there is very little beauty left in the dark. Why should I give them to you?”

### Choices

- **Tell him what the night has done** → `029` The Curved Jewels
- **Promise to stay as his guest** → `027` The Feast Beneath the Waves

---

## 027 — The Feast Beneath the Waves

**Image:** `AMA027`  
**Reached from:** `024`, `025`, `026`  
**Notes:** If the player saved the turtle at `022`, **Stay one more day** goes to `028` instead of `030`.  
**Art:** A lavish undersea banquet with low lacquer tables, fish servants pouring drinks, a princess dancing, and through a round window a garden changing from blossom to autumn leaves.

**Text:**  
You are not quite sure how you came to be sitting at the Dragon King’s feast, but here you are, and it is wonderful. Fish in silk robes fill your bowl with dishes you have never tasted. Otohime dances. The music never stops, and nobody ever seems to grow tired. You eat, and sleep on silk cushions, and wake to another feast. Was that hours, or days? Through the round window, the garden of cherry blossoms has turned to summer, and then to autumn. Somewhere far above, you remember, the world is waiting in the dark. “Stay one more day,” Otohime says, filling your cup. “Just one. What difference can one day make?”

### Choices

- **Remember why you came** → `026` The Dragon King
- **Stay one more day** → `030` Three Hundred Years (Game Over)
  - *If saved the turtle at 022:* **Stay one more day** → `028` The Turtle Remembers

---

## 028 — The Turtle Remembers

**Image:** `AMA028`  
**Reached from:** `027`  
**Art:** An old sea turtle peeking out from under a banquet table, nudging the traveller’s knee, a dropped cup spilling on the floor.

**Text:**  
Just as you lift the cup, something hard bumps against your knee. It is the old turtle from the beach, which has crept under the table. “Do you know how long you have been here?” it whispers. “Only a few hours, though it feels like days. And every day you spend in the Dragon Palace is a hundred years in the world above. Stay one more day, and everyone you love will be dust.” The cup falls from your hand. The turtle nudges you toward the hall of the Dragon King. “Go now. And whatever the princess gives you, keep it closed.”

### Choices

- **Go to the Dragon King** → `026` The Dragon King

---

## 029 — The Curved Jewels

**Image:** `AMA029`  
**Reached from:** `026`  
**Art:** The Dragon King lowering his string of glowing curved jewels into the traveller’s hands, while the princess holds out a small black lacquered box tied with a red cord.

**Text:**  
You tell the Dragon King about the night. The rice is dying in the fields. The fish have fled to the deepest water, and the fishermen’s nets come up empty. Even the coral in his own gardens is turning grey without light from above. Ryūjin is silent for a long time, and the water in the hall grows cold. Then he lifts the string of jewels from his neck. “Beauty kept in the dark is not beauty,” he says. “Take them up into the light.” As you leave, Otohime runs after you with a small lacquered box tied with a red cord. “A gift, so you remember us,” she says. “But promise me you will never open it.”

### Choices

- **Take the jewels and the box** **[collects Curved Jewels]** **[remembers: Took Otohime’s box]** → `014` HOME (or `039` if all treasures are held)
- **Take only the jewels** **[collects Curved Jewels]** → `014` HOME (or `039` if all treasures are held)

---

## 030 — Three Hundred Years (Game Over)

**Image:** `AMA030`  
**Outcome:** `bittersweet` · Lost in Time · `amaterasu_three_hundred_years`  
**Reached from:** `027`  
**Art:** The traveller standing in bright sunlight on a forested hillside before a moss-covered stone carved with writing; in the distance, a town of stone and tile where a fishing village used to be.

**Text:**  
One more day. Then one more, and one more after that. On the third morning, homesick at last, you ask to go home, and Otohime sends you up to the shore on the back of a great silver sea bream, with tears in her eyes. The sun is shining. It is warm on your face, and you laugh out loud, because somebody brought it back after all. But the beach is different. The fishing village is a town of stone and tile. On the hillside where your village stood there is only forest, and where your grandmother’s shrine should be, you find a moss-covered stone with your name carved on it and the words: “Climbed to heaven and never came home.” Three days in the Dragon Palace. Three hundred years above.

**Outcome text:**  
You stayed too long in the Dragon Palace.  
The sun came back without you, three hundred years ago.

---

## 031 — The Chopsticks in the River

**Image:** `AMA031`  
**Reached from:** `014`  
**Transition:** `inkFade`  
**Art:** A fast black river between dark pine mountains, a pair of chopsticks floating on the current, and a ruined hut on the far bank.

**Text:**  
The cloud road brings you down in the land of Izumo, beside the Hii River, which runs black and fast between dark mountains. The air smells of pine and of something else, something rotten and wet, like the skin a snake leaves behind. As you stand on the bank, a pair of chopsticks comes floating down the river toward you. Someone lives upstream. At the same moment, from a ruined hut on the other side of the river, you hear a deep voice singing, loudly and very badly, about the sea.

### Choices

- **Follow them upstream** → `033` The Weeping House
- **Follow the singing** → `032` The Exiled God

---

## 032 — The Exiled God

**Image:** `AMA032`  
**Reached from:** `031`  
**Art:** A huge, wild-haired storm god slumped among broken sake jars in a ruined hut, leaves in his beard, faint lightning flickering around him, his expression lost and ashamed.

**Text:**  
Inside the ruined hut, a huge man sits among broken sake jars with his long hair tangled and his beard full of leaves. Even sitting down, he is as tall as you are standing, and thunder mutters faintly whenever he moves. You know who he is before he says it: Susanoo, the storm god, banished from heaven for what he did to his sister. He squints at you. “You smell of heaven,” he says. “Did they send you to laugh at me?” He drinks and wipes his mouth, and for a moment he looks less like a god than like a boy who has broken something he cannot fix. “I never meant for her to hide,” he says quietly. “I only wanted her to look at me.”

### Choices

- **Sit and listen** **[remembers: Heard Susanoo out]** → `033` The Weeping House
- **Leave him to his sake** → `033` The Weeping House

---

## 033 — The Weeping House

**Image:** `AMA033`  
**Reached from:** `031`, `032`  
**Art:** An old man and an old woman weeping on either side of a young woman with a comb in her hair, inside a shuttered farmhouse lit by a single lamp.

**Text:**  
Upstream, in the clearing the chopsticks came from, stands a farmhouse with every shutter closed. Inside, an old man and an old woman sit weeping on either side of a young woman with a wooden comb in her hair. They are Ashinazuchi and Tenazuchi, and their daughter is Kushinada. Once they had eight daughters. Every year, the eight-headed serpent Yamata no Orochi came down from the mountains and ate one, and tonight it is coming for the last. “It has eight heads and eight tails,” the old man says, “and its body stretches over eight valleys and eight hills. In one of its tails there is something that shines like lightning.” The sword. The old woman wrings her hands. “We have rice,” she says. “We could brew sake.”

### Choices

- **Brew eight vats of sake** → `034` The Eight Gates
- **Face the serpent alone** → `035` The Eight-Headed Serpent

---

## 034 — The Eight Gates

**Image:** `AMA034`  
**Reached from:** `033`, `035`  
**Transition:** `torchReveal`  
**Art:** A gigantic eight-headed serpent with red eyes, cypress trees and moss growing on its back, each head plunging into a great vat of sake set in one of eight gates in a wooden fence.

**Text:**  
You and the old couple work through the night. You brew sake eight times over, until it is strong enough to make your eyes water. You build a fence around the house with eight gates, and in each gate you set a great vat brimming with sake. Kushinada hides inside, and you crouch in the shadow of the fence with the old man’s rusty sword. The ground begins to shake. Over the hill comes Yamata no Orochi: eight heads on eight long necks, eyes as red as winter cherries, cypress trees and moss growing on its back. Each head finds a gate. Each one plunges its snout into a vat and drinks, and the gulping goes on and on.

### Choices

- **Wait until every head sleeps** → `036` The Serpent Sleeps
- **Strike now** → `035` The Eight-Headed Serpent

---

## 035 — The Eight-Headed Serpent

**Image:** `AMA035`  
**Reached from:** `033`, `034`  
**Art:** A small figure with a rusty sword facing eight serpent heads rearing at once, sixteen red eyes in the dark, a tail as thick as a tree trunk sweeping the ground.

**Text:**  
You run at the serpent with the old man’s rusty sword. One head turns to look at you, then another, then all of them: sixteen red eyes in the dark. The nearest head snaps, and you dive aside as its teeth close on the air where you were standing. Your sword bounces off its scales like a stick off a rock. A tail as thick as a cedar trunk sweeps across the ground and knocks you flat. Somewhere behind you, Kushinada is screaming at you to run back to the house.

### Choices

- **Run back to the house** → `034` The Eight Gates
- **Fight on** → `038` Swallowed by Orochi (Game Over)

---

## 036 — The Serpent Sleeps

**Image:** `AMA036`  
**Reached from:** `034`  
**Art:** The eight-headed serpent asleep, its heads slumped in empty vats; a small figure walking along its back between the cypress trees toward a tail that glows faintly blue from within.

**Text:**  
One by one, the eight heads sway, droop and fall. The serpent’s snoring shakes the leaves from the trees. You wait until the last head has dropped into its empty vat, then you climb over the fence and walk along the serpent’s back, between the cypress trees that grow there, toward its eight tails. One of them is glowing from the inside, faintly blue, like a lantern behind a paper screen.

### Choices

- **Cut open the glowing tail** → `037` The Sword of the Gathering Clouds

---

## 037 — The Sword of the Gathering Clouds

**Image:** `AMA037`  
**Reached from:** `036`  
**Transition:** `torchReveal`  
**Notes:** The ending changes if the player heard Susanoo out at `032`.  
**Art:** A bright, straight steel sword sliding out of the serpent’s cut tail, crackling with faint storm light, as an old couple and their daughter bow in the background.

**Text:**  
The old man’s rusty sword snaps in two when you strike the tail, but something hidden inside it slices the scales open for you. Out slides a sword of bright steel, cold and straight, humming like a storm far away. This is the Sword of the Gathering Clouds, which people will one day call Kusanagi, the Grass-Cutter. Kushinada and her parents come out of the house and bow to the ground. Orochi will sleep for a hundred years, the old man says, and that is long enough for anyone.

**Extra text (if you heard Susanoo out at 032):**  
When you reach the river, Susanoo is waiting on the bank, sober now, with his hair tied back. He looks at the sword in your hands for a long time. “It was always meant to be my apology,” he says. “Carry it to her. I will follow you, if they let me.”

**Extra text (otherwise):**  
On your way back down the river, you pass the ruined hut. It is empty now except for broken jars.

### Choices

- **Take the sword** **[collects Sword of the Gathering Clouds]** → `014` HOME (or `039` if all treasures are held)

---

## 038 — Swallowed by Orochi (Game Over)

**Image:** `AMA038`  
**Outcome:** `death` · Death · `amaterasu_swallowed_by_orochi`  
**Reached from:** `035`  
**Art:** A vast serpent jaw opening over a fallen rusty sword, one red eye as big as a lantern filling the darkness.

**Text:**  
You fight with everything you have. You slash at one neck, and two more heads swing into view. A tail knocks the sword from your hand. The last thing you see is a red eye as big as a lantern and a mouth opening wide enough to swallow a cart, and then the warm, wet dark. Inside the serpent, it is very quiet. Somewhere nearby, behind a wall of scales, something glows faintly blue. You found the sword after all.

**Outcome text:**  
You fought the eight-headed serpent alone, without a plan.  
Orochi is sleeping off a hero, and Kushinada is still waiting for one.

---

## 039 — The Festival at the Rock

**Image:** `AMA039`  
**Reached from:** `014` (once all three treasures are held)  
**Transition:** `torchReveal`  
**Notes:** End-game hub. Lines are added for remembered choices, and a third choice appears if the player told the fox their name.  
**Art:** A sakaki tree planted before the sealed boulder, hung with glowing jewels on its upper branches and the bronze mirror on its middle branches, a sword at its roots; roosters on the cliffs; a giant muscular god hiding beside the rock; the crowd of gods with torches.

**Text:**  
When you bring back the last treasure, heaven bursts into motion. The gods tear up a sakaki tree from the sacred mountain and plant it in front of the Heavenly Rock Cave. On its upper branches they hang the Curved Jewels, which glow red and green. On its middle branches they hang the Eight-Hand Mirror, facing the rock. The sword is laid at its roots. Long-crowing roosters are carried in from the Eternal Land and set along the cliffs. Ame-no-Uzume ties back her sleeves, and Tajikarao, god of strength, a mountain of a god with arms like tree trunks, hides beside the boulder. Omoikane turns to you. “You carried the treasures,” he says. “The first move is yours.”

**Extra lines:**

- *If you defied Sarutahiko at 007:* Sarutahiko has come up from the bridge to watch. He catches your eye and does not smile.
- *If you heard Susanoo out at 032:* At the edge of the crowd, Susanoo stands with his head bowed, and the gods leave a wide space around him.
- *If you told the fox your name at 005:* Among the gods’ feet, a white fox with a blue flame on its tail sits licking its paw. “I said I’d find you later,” it says, and it says your name.

### Choices

- **Begin the festival** → `040` The Dance of Ame-no-Uzume
- **Go into the cave yourself** → `045` The Sun’s Companion (Game Over)
- *Only if told the fox your name at 005:* **Let the fox speak for you** → `047` The Fox’s Wedding (Game Over)

---

## 040 — The Dance of Ame-no-Uzume

**Image:** `AMA040`  
**Reached from:** `039`  
**Art:** A goddess dancing wildly on an overturned wooden tub, sleeves flying, while hundreds of torch-lit gods roar with laughter and roosters crow on the cliffs; the boulder has shifted a crack.

**Text:**  
At your nod, the roosters crow all together, so loudly that the stars shake. Ame-no-Uzume leaps onto her overturned tub and begins to dance, stamping until the tub booms like a drum. She dances wildly and ridiculously, flinging her sleeves and pulling faces, until the eight hundred myriad gods are roaring with laughter, slapping their knees and falling over each other. The noise rolls across heaven. Then a voice speaks through the crack in the rock, small and puzzled. “The world is dark,” says Amaterasu. “Why are you all laughing?” Uzume shouts back, “Because there is someone out here even brighter than you!” The boulder shifts, just a little.

### Choices

- **Raise the mirror to the crack** → `041` Her Own Light
- **Throw your weight against the rock** → `044` The Rock Stays Shut (Game Over)

---

## 041 — Her Own Light

**Image:** `AMA041`  
**Reached from:** `040`  
**Transition:** `torchReveal`  
**Notes:** A third choice appears if the player took Otohime’s box at `029`.  
**Art:** The traveller holding up the bronze mirror to a gap in the boulder; on the other side, a tearful goddess with light pouring from her skin leans toward her own reflection, and golden light spills across the plain.

**Text:**  
You lift the Eight-Hand Mirror toward the gap. A face appears on the other side: a woman with tears on her cheeks and light pouring from her skin. She sees the shining figure in the mirror and gasps. She does not know it is herself. She has not looked at herself since the day her brother tore down her hall, and she has forgotten how bright she is. She leans closer, and closer still, and light spills out through the crack and across the plain of heaven like a sunrise. Beside the boulder, Tajikarao tenses his enormous arms and looks at you, waiting for a signal.

### Choices

- **Signal Tajikarao** → `042` The Sacred Rope
- **Reach in and pull her out yourself** → `044` The Rock Stays Shut (Game Over)
- *Only if took Otohime’s box at 029:* **Offer her Otohime’s box** → `046` The Opened Box (Game Over)

---

## 042 — The Sacred Rope

**Image:** `AMA042`  
**Reached from:** `041`  
**Transition:** `shojiSlide`  
**Notes:** Sarutahiko’s line depends on the choice at `007`.  
**Art:** The giant god of strength rolling the boulder aside as the sun goddess steps out, blinking, into a flood of golden light that pours over the edge of heaven onto the islands below.

**Text:**  
Tajikarao heaves. The great boulder rolls aside with a sound like a mountain clearing its throat, and he takes Amaterasu gently by the hand and draws her out into the open. Light floods heaven. It pours over the edge of the High Plain and down onto the islands below, and far away you hear every rooster in Japan begin to crow at once. Amaterasu stands blinking in her own light, and for a moment she glances back at the cave, as if she might run into it again. Omoikane presses a thick rope of twisted rice straw into your hands.

**Extra line (if you defied Sarutahiko at 007):**  
Sarutahiko steps up and takes the other end. “Rudeness is forgiven at dawn,” he grunts.

**Extra line (otherwise):**  
Sarutahiko steps up, takes the other end and nods to you.

### Choices

- **Stretch the rope across the cave** → `043` Dawn Returns (Game Over)

---

## 043 — Dawn Returns (Game Over)

**Image:** `AMA043`  
**Outcome:** `win` · Best Ending · `amaterasu_dawn_returns`  
**Reached from:** `042`  
**Notes:** Lines are added or changed for remembered choices.  
**Art:** Morning sun over the rice village at the foot of the mountain, frost melting off the paddies, and an old priestess shading her eyes in the shrine doorway as the traveller comes up the path.

**Text:**  
You and Sarutahiko stretch the sacred rope across the mouth of the cave, and the dark place is closed for good. Amaterasu turns away from it. She looks at the mirror, the jewels and the sword, and last of all at you, a muddy mortal with a bell in your fist. “You climbed all the way up here,” she says, “for me?” “For everyone,” you say. “But yes. For you.” The sun goddess laughs, and the sound is warm on your face like morning.

**Susanoo (if you heard him out at 032):**  
Then Susanoo steps forward and kneels with the sword held out in both hands. For a long moment, nobody in heaven breathes. Then Amaterasu takes the sword, and takes her brother’s hand, and the storm and the sun stand together for the first time in a very long while.

**Susanoo (otherwise):**  
Susanoo does not come. The sword lies at the roots of the sakaki tree, and the quarrel between the storm and the sun will have to wait for another day.

**Then (always):**  
By the time the cloud road sets you down at the foot of Mount Takachiho, the sun is high, the frost is melting off the rice, and your grandmother is standing in the doorway of her shrine with a hand over her eyes, squinting up at the sky as if she has never seen anything so ridiculous and wonderful in her life.

**Extra lines:**

- *If you told the fox your name at 005:* As you walk home, rain falls out of a clear blue sky. A fox’s wedding, your grandmother would call it. Somewhere in the trees, something laughs and says your name. It is only teasing. Not today.
- *If you took Otohime’s box at 029:* Otohime’s box sits on the shrine altar, still tied with its red cord. You never open it.

**Outcome text:**  
You brought the sun out of the Heavenly Rock Cave.  
Every year since, your village has danced at the shrine to remember the night the sun came back.

---

## 044 — The Rock Stays Shut (Game Over)

**Image:** `AMA044`  
**Outcome:** `lose` · Eternal Night · `amaterasu_rock_stays_shut`  
**Reached from:** `040`, `041`  
**Art:** The boulder sealed tight with no light at its edges, the goddess of dancing sitting on her tub with her head in her hands, torches guttering among silent gods.

**Text:**  
You can’t wait any longer. You throw yourself at the gap, as if you could drag the sun out by force. Amaterasu cries out in fright. The light vanishes from the crack, and the boulder grinds shut again, tighter than before, and from deep inside the cave you hear another rock rolling into place behind it, and then another. The laughter of the gods dies away. Uzume climbs slowly down from her tub. The roosters will not crow again. The gods will try other festivals and other plans, but the goddess has learned that the world outside is a place where people grab at her, and she will not come out again.

**Outcome text:**  
You tried to force the sun out of hiding.  
The rock is sealed, and the world will have to learn to live in the dark.

---

## 045 — The Sun’s Companion (Game Over)

**Image:** `AMA045`  
**Outcome:** `bittersweet` · Sacrifice · `amaterasu_suns_companion`  
**Reached from:** `039`  
**Art:** Inside a dark cave, a small figure sits with eyes closed, facing a soft glow at the cave mouth as a radiant goddess walks out into the light, the boulder beginning to roll shut behind her.

**Text:**  
While the gods are still tuning their drums, you squeeze through the crack in the rock. Inside, the light is so bright that you have to close your eyes, so you sit down in it with your eyes shut tight and talk. You tell the sun goddess about your grandmother, and the rice, and the Night Parade, and the crow-tengu, and the Dragon King’s beard. After a long time, a voice answers. “It is frightening out there,” Amaterasu says. “Will you stay in here, in the dark, so that it is not empty when I come back?” You say yes. She walks out into the festival, and the world turns gold. The great rock rolls back into place behind her, with you inside. It is not so bad. The dark is warm, and some days she comes back to visit and tells you how the rice is growing.

**Outcome text:**  
You kept the darkness company so the sun could leave it.  
In your village, they ring your grandmother’s bell at the shrine every winter, so you know you are remembered.

---

## 046 — The Opened Box (Game Over)

**Image:** `AMA046`  
**Outcome:** `lose` · Aged · `amaterasu_opened_box`  
**Reached from:** `041`  
**Art:** White smoke curling out of an open black lacquered box; an ancient, white-haired figure sits by the sealed boulder with the empty box in their lap and a cracked mirror at their feet.

**Text:**  
You remember the lacquered box from the Dragon Palace. Surely a gift from the sea would please the sun. You untie the red cord and lift the lid. A curl of white smoke rises out of it, and as it touches your face, all the years the Dragon Palace kept from you come rushing out to claim you. Your hair turns white. Your hands wrinkle and shake. The mirror slips from them and cracks against the stone, and the startled face beyond the gap vanishes back into the dark. When the smoke clears, a very old person sits beside the Heavenly Rock Cave with an empty box in their lap, trying to remember what they were waiting for.

**Outcome text:**  
You opened the box you promised never to open.  
Otohime warned you, and the sea always keeps its promises.

---

## 047 — The Fox’s Wedding (Game Over)

**Image:** `AMA047`  
**Outcome:** `darkWin` · Dark Ending · `amaterasu_fox_wedding`  
**Reached from:** `039`  
**Art:** Sunlight and rain falling together from a clear sky over the High Plain of Heaven; a procession of foxes carrying paper lanterns; a young man in white with golden fox eyes leading a figure in a white hood.

**Text:**  
Before anyone can stop it, the white fox trots up to the boulder and whispers something through the crack. Inside, the sun goddess laughs out loud in surprise, and the rock rolls open by itself. Light pours across heaven, and the gods cheer, and only you notice that, out of a clear and shining sky, it has begun to rain. “A fox’s wedding,” the fox says happily, and when you look down, it is no longer a fox but a young man in white with golden fox eyes. “A name freely given is a promise. I brought out the sun, and now I take my payment.” A procession of foxes carrying paper lanterns is coming across the plain toward you. Somebody has put a white hood over your head. The sun is shining on the whole world, and you will never go home to see it.

**Outcome text:**  
You gave a fox your name, and the fox kept it.  
The sun is back, and you are walking at the head of a wedding procession into Inari’s mountain.
