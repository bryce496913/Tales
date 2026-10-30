# The Descent to Hades — Story Map

**Story ID:** `descent-to-hades`  
**Page prefix:** `HDS`  
**Status:** Draft for review. Once the pages are built, the Swift views in this folder become the source of truth and this file must be updated whenever a page, choice or ending changes.

---

# How the Story Works

- A squall capsizes your boat off Cape Tainaron and your younger brother, Theo, drowns. You wake in a sea cave that leads down into the Greek underworld, and you go after him.
- The player starts at `000`. After getting past Hermes, Charon and Cerberus, Persephone tells you that Hades will only hear a living petitioner who brings him three gifts:
  - the **Water of Lethe** (the river of forgetting)
  - the **Ember of Phlegethon** (the river of fire)
  - the **Golden Bough** (from Elysium)
- `015` (**HOME**, the Crossroads of Judgment) is the hub. It shows a road for each gift the player has not collected yet (up to three buttons):
  - Water of Lethe → `016` (the grey road, Asphodel Meadows)
  - Ember of Phlegethon → `024` (the bronze road, Tartarus)
  - Golden Bough → `032` (the white road, Elysium)
- When all three gifts are collected, any route into HOME goes to `040` (The Throne of Hades) instead. This opens the end-game.
- Gifts are collected by the choice buttons marked **[collects …]**.
- Some choices are remembered (**[remembers …]**) and change later pages:
  - **Struck Hermes’ bargain** at `006`: Hermes appears at `040` and a third choice, **Call on Hermes** → `047`, is added.
  - **Lied to Charon** at `009`: Hades calls out the lie at `040`.
  - **Woke Theo** at `017` (told him who he is): drinking from Lethe at `019` leads to `021` (Theo stops you) instead of `023` (death). Theo speaks at `040`, `042`, `043` and `044`.
  - **Left Theo resting** at `017`: `044` gains a different closing line. Cannot be held at the same time as *Woke Theo*.
  - **Helped Sisyphus** at `027`: he tells you the river’s secret at `028`, and `042` and `044` gain extra lines.
- Game-over pages have no choice buttons. They show the shared outcome screen with Restart / Menu controls and record their ending ID.
- Progress (current page, visited pages, collected gifts, remembered choices, completed endings) is saved under `Tales.descent-to-hades.progress.v1`. Restarting clears everything except completed endings.

Page names in conversation use the short number (`004`). In code, the view is `HDS004View` and the route is `.hds004` (`"HDS-004"`).

---

# Route Table

| Page | Title | Choice | Goes to |
|---|---|---|---|
| `000` | The Storm at Tainaron | Continue | `001` The Sea Cave |
| `001` | The Sea Cave | Go deeper | `002` The Road of the Dead |
|  |  | Swim for the light | `003` Lost to the Sea (Game Over) |
| `002` | The Road of the Dead | Chase Theo | `004` The Grasping Shades |
|  |  | Speak to the stranger | `005` The Guide of Souls |
| `003` | Lost to the Sea | — | **Game Over** (Death) |
| `004` | The Grasping Shades | Take his hand | `005` The Guide of Souls |
| `005` | The Guide of Souls | Follow him | `007` The Banks of the Styx |
|  |  | Ask him to bring Theo back | `006` The Messenger’s Price |
| `006` | The Messenger’s Price | Accept the bargain **[remembers: Struck Hermes’ bargain]** | `007` The Banks of the Styx |
|  |  | Refuse | `007` The Banks of the Styx |
| `007` | The Banks of the Styx | Offer your ring | `009` Charon’s Question |
|  |  | Swim across | `008` Taken by the Styx (Game Over) |
| `008` | Taken by the Styx | — | **Game Over** (Death) |
| `009` | Charon’s Question | Tell the truth | `011` The Hound of Hades |
|  |  | Lie **[remembers: Lied to Charon]** | `010` Thrown Ashore |
| `010` | Thrown Ashore | Continue | `011` The Hound of Hades |
| `011` | The Hound of Hades | Sing | `013` Persephone’s Garden |
|  |  | Run past | `012` Torn by Cerberus (Game Over) |
| `012` | Torn by Cerberus | — | **Game Over** (Death) |
| `013` | Persephone’s Garden | Eat the fruit | `014` Bound by the Seeds (Game Over) |
|  |  | Thank her and go | `015` HOME |
| `014` | Bound by the Seeds | — | **Game Over** (Bound) |
| `015` | HOME — The Crossroads of Judgment | The grey road | `016` The Asphodel Meadows |
|  |  | The bronze road | `024` The Gates of Tartarus |
|  |  | The white road | `032` The Fields of Elysium |
| `016` | The Asphodel Meadows | Go to Theo | `017` The Brother Who Forgot |
|  |  | Follow the water | `018` The River of Forgetting |
| `017` | The Brother Who Forgot | Tell him who he is **[remembers: Woke Theo]** | `018` The River of Forgetting |
|  |  | Let him rest **[remembers: Left Theo resting]** | `018` The River of Forgetting |
| `018` | The River of Forgetting | Kneel at the water | `019` The Reflection |
|  |  | Cross to the far bank | `020` Echoes in the Water |
| `019` | The Reflection | Look away | `022` The Water of Lethe |
|  |  | Drink | `023` The Sweet Forgetting (Game Over); if *woke Theo at 017*: **Drink** → `021` The Voice You Woke |
| `020` | Echoes in the Water | Admit it | `022` The Water of Lethe |
|  |  | Blame the sea | `019` The Reflection |
| `021` | The Voice You Woke | Fill the flask | `022` The Water of Lethe |
| `022` | The Water of Lethe | Take it **[collects Water of Lethe]** | `015` HOME (or `040` if all gifts are held) |
| `023` | The Sweet Forgetting | — | **Game Over** (Forgotten) |
| `024` | The Gates of Tartarus | Ask to enter | `025` Tisiphone the Avenger |
|  |  | Climb the wall | `026` The Fury’s Lash |
| `025` | Tisiphone the Avenger | Confess | `027` The Hill of Sisyphus |
|  |  | Refuse | `026` The Fury’s Lash |
| `026` | The Fury’s Lash | Follow the sound | `027` The Hill of Sisyphus |
|  |  | Take the burning stair | `028` The River of Fire |
| `027` | The Hill of Sisyphus | Help him **[remembers: Helped Sisyphus]** | `028` The River of Fire |
|  |  | Walk on | `028` The River of Fire |
| `028` | The River of Fire | Wait for the flames to sink **[collects Ember of Phlegethon]** | `030` The Way Out of Tartarus |
|  |  | Snatch an ember now **[collects Ember of Phlegethon]** | `029` The Furies Wake |
| `029` | The Furies Wake | Run for the bridge | `015` HOME (or `040` if all gifts are held) |
|  |  | Hide in the dark | `031` Chained in Tartarus (Game Over) |
| `030` | The Way Out of Tartarus | Return | `015` HOME (or `040` if all gifts are held) |
| `031` | Chained in Tartarus | — | **Game Over** (Death) |
| `032` | The Fields of Elysium | Join the feast | `033` The Feast of Heroes |
|  |  | Head for the golden tree | `035` The Grove of the Golden Bough |
| `033` | The Feast of Heroes | Stay a while | `034` The Endless Afternoon |
|  |  | Ask about the golden tree | `035` The Grove of the Golden Bough |
| `034` | The Endless Afternoon | Leave now | `035` The Grove of the Golden Bough |
|  |  | Lie down in the grass | `039` The Isles of the Blessed (Game Over) |
| `035` | The Grove of the Golden Bough | Reach for the bough | `037` The Bough Resists |
|  |  | Speak to the Sibyl | `036` The Sibyl’s Riddle |
| `036` | The Sibyl’s Riddle | Answer honestly | `038` The Golden Bough |
|  |  | Promise anything | `037` The Bough Resists |
| `037` | The Bough Resists | Let go | `038` The Golden Bough |
|  |  | Ask the Sibyl | `036` The Sibyl’s Riddle |
| `038` | The Golden Bough | Take the bough **[collects Golden Bough]** | `015` HOME (or `040` if all gifts are held) |
| `039` | The Isles of the Blessed | — | **Game Over** (Peaceful Rest) |
| `040` | The Throne of Hades | Plead for Theo | `041` Hades’ Condition |
|  |  | Offer your life | `046` The Willing Exchange (Game Over) |
|  |  | *Only if struck Hermes’ bargain at 006:* **Call on Hermes** | `047` Thief of the Dead (Game Over) |
| `041` | Hades’ Condition | Begin the climb | `042` The Long Ascent |
| `042` | The Long Ascent | Keep climbing | `043` The Last Stair |
|  |  | Look back | `045` Looked Back (Game Over) |
| `043` | The Last Stair | Step into the light | `044` Out Into the Sun (Game Over) |
|  |  | Turn to help him | `045` Looked Back (Game Over) |
| `044` | Out Into the Sun | — | **Game Over** (Best Ending) |
| `045` | Looked Back | — | **Game Over** (Lost) |
| `046` | The Willing Exchange | — | **Game Over** (Sacrifice) |
| `047` | Thief of the Dead | — | **Game Over** (Dark Ending) |

---

# Endings

| Page | Ending | Classification | Outcome style | Ending ID | Reached from |
|---|---|---|---|---|---|
| `003` | Lost to the Sea | Death | `death` | `hades_lost_to_the_sea` | `001` |
| `008` | Taken by the Styx | Death | `death` | `hades_taken_by_the_styx` | `007` |
| `012` | Torn by Cerberus | Death | `death` | `hades_torn_by_cerberus` | `011` |
| `014` | Bound by the Seeds | Bound | `lose` | `hades_bound_by_the_seeds` | `013` |
| `023` | The Sweet Forgetting | Forgotten | `lose` | `hades_sweet_forgetting` | `019` |
| `031` | Chained in Tartarus | Death | `death` | `hades_chained_in_tartarus` | `029` |
| `039` | The Isles of the Blessed | Peaceful Rest | `bittersweet` | `hades_isles_of_the_blessed` | `034` |
| `044` | Out Into the Sun | Best Ending | `win` | `hades_out_into_the_sun` | `043` |
| `045` | Looked Back | Lost | `lose` | `hades_looked_back` | `042`, `043` |
| `046` | The Willing Exchange | Sacrifice | `bittersweet` | `hades_willing_exchange` | `040` |
| `047` | Thief of the Dead | Dark Ending | `darkWin` | `hades_thief_of_the_dead` | `040` |

---

# Presentation

**Colour theme** (replaces the Egyptian gold and sand for this story only):

| Token | Hex | Use |
|---|---|---|
| Background top | `0B1220` | Night of the underworld |
| Background bottom | `1C1630` | Deep violet shadow |
| Card | `141B2B` at 88% | Text cards |
| Accent (bronze) | `C08A4A` | Titles, borders, buttons |
| Marble | `EDE8DF` | Body text |
| Muted text | `A9B3C4` | Subtitles |
| Aegean blue | `3E6E9E` | Highlights, button glow |
| Pomegranate | `9E2B3A` | Death endings |
| Asphodel | `C9C3B0` | Lost / forgotten endings |

**Page transitions** (Greek versions of the three Anubis styles):

- `mistFade` — grey river mist (replaces `sandFade`)
- `torchReveal` — kept as is
- `bronzeGate` — bronze doors parting (replaces `stoneDoor`)

**Outcome styles:** `win`, `darkWin`, `bittersweet`, `lose`, `death`.

**Images:** every page uses its own illustration named after its number (`HDS000.png` … `HDS047.png`), plus `HDS-Icon.png` and `HDS-Title-Screen-Art.png`. Until the art exists, pages show a placeholder.

**Story selection blurb:** “Cross the river Styx, win the favour of the gods of the dead, and bring your brother home without looking back.”

---

# Pages

## 000 — The Storm at Tainaron

**Image:** `HDS000.png`  
**Transition:** `mistFade`

**Text:**  
You and your younger brother, Theo, hired a small boat to see the sea caves at Cape Tainaron, at the southern tip of mainland Greece, where the old stories say there is a doorway to the underworld. The guide laughed about it over breakfast. By the afternoon nobody was laughing. A squall came off the open sea without warning, the boat rolled and the water closed over you both. You remember Theo’s hand in yours, the cold, the dark and the moment his fingers slipped away. Then a wave threw you against rock, and the roar of the sea went quiet.

### Choices

- **Continue** → `001` The Sea Cave

---

## 001 — The Sea Cave

**Image:** `HDS001.png`  
**Reached from:** `000`

**Text:**  
You wake on a shelf of black stone inside a cave. Behind you, the sea glows green through a narrow opening, and the storm has gone as if it never happened. There is no sign of the boat, or of Theo. Ahead, a stairway has been cut into the rock, worn smooth by feet that were not human, and it leads down into a darkness that smells of earth and cold iron. Carved above the first step, in letters older than any you know, are the words: *Here the living do not pass.* Somewhere far below, someone calls your name. It sounds like Theo.

### Choices

- **Go deeper** → `002` The Road of the Dead
- **Swim for the light** → `003` Lost to the Sea (Game Over)

---

## 002 — The Road of the Dead

**Image:** `HDS002.png`  
**Reached from:** `001`

**Text:**  
The stairs end on a wide road of grey dust that runs downhill into a twilight with no sun. Pale figures walk along it in silence, each one looking straight ahead. They do not see you, and when you brush against one it feels like walking through cold mist. Far ahead in the crowd you see a head of dark, wet hair and the yellow jacket Theo was wearing on the boat. By the side of the road, a young man in a wide traveller’s hat leans against a milestone, turning a coin across his knuckles. His sandals have small wings at the heels. “You’re breathing,” he says. “That’s going to be a problem.”

### Choices

- **Chase Theo** → `004` The Grasping Shades
- **Speak to the stranger** → `005` The Guide of Souls

---

## 003 — Lost to the Sea (Game Over)

**Image:** `HDS003.png`  
**Outcome:** `death` · Death · `hades_lost_to_the_sea`  
**Reached from:** `001`

**Text:**  
You turn away from the stairs and dive toward the green light. The opening is further away than it looked. You swim until your lungs burn, then a little more, but the light never comes closer. When you finally break the surface, there is no cape, no coastline and no boat, only a flat grey sea beneath a sky without a sun. You float there for a long time, calling Theo’s name, until the cold settles into your bones and the water gently takes you. Far below, a stairway you chose not to climb waits in the dark.

**Outcome text:**  
You turned back from the doorway, and the sea claimed you instead.  
Theo walks the road of the dead alone.

---

## 004 — The Grasping Shades

**Image:** `HDS004.png`  
**Reached from:** `002`

**Text:**  
You push into the crowd, shouting Theo’s name. The dead stop walking. One by one they turn toward you, drawn by the warmth of your skin and the sound of your heartbeat. Cold hands close on your arms, your face, your throat. They are not cruel. They are hungry for the feeling of being alive, and they are taking it from you one breath at a time. Your vision greys at the edges. Then a hand as warm as your own grabs your wrist and pulls you out of the crush. It is the stranger with the winged sandals. “Rule one,” he says. “Never run at the dead.”

### Choices

- **Take his hand** → `005` The Guide of Souls

---

## 005 — The Guide of Souls

**Image:** `HDS005.png`  
**Reached from:** `002`, `004`

**Text:**  
The stranger introduces himself as Hermes, messenger of the gods and guide of the dead. Theo’s soul has already gone down toward the river Styx, he says, and the living are not permitted to follow. People have tried, though. Heracles came down to drag out the three-headed hound. Orpheus came down with nothing but a lyre, sang his way past Cerberus and almost brought his wife home. “Almost,” Hermes repeats, and he does not explain. He offers to walk you as far as the river, because he is curious, and because it has been a slow century.

### Choices

- **Follow him** → `007` The Banks of the Styx
- **Ask him to bring Theo back** → `006` The Messenger’s Price

---

## 006 — The Messenger’s Price

**Image:** `HDS006.png`  
**Reached from:** `005`

**Text:**  
Hermes laughs, but not unkindly. He cannot simply bring Theo back, he says. His uncle Hades keeps strict accounts, and a soul that leaves without permission is a debt someone has to pay. But Hermes is also the god of thieves, and thieves always know another way out. “Here’s my offer. If it all goes wrong down there, call my name and I’ll get you both out. In return, you’ll owe me a favour. A god’s favour, collected whenever I like.” He holds out his hand. His smile is friendly. His eyes are not.

### Choices

- **Accept the bargain** **[remembers: Struck Hermes’ bargain]** → `007` The Banks of the Styx
- **Refuse** → `007` The Banks of the Styx

---

## 007 — The Banks of the Styx

**Image:** `HDS007.png`  
**Reached from:** `005`, `006`  
**Transition:** `mistFade`

**Text:**  
The road ends at a black river so wide you cannot see the other side. Its water does not move, and it reflects nothing. Hundreds of souls wait silently on the shore. A long, flat boat slides out of the mist, steered by a tall old man in a hooded cloak whose eyes burn like coals. This is Charon, the ferryman. Each soul places a coin on his palm before stepping aboard. Hermes has vanished. You turn out your pockets and find only seawater and sand, and on your finger, the silver ring your grandmother left you. Charon stops the boat in front of you and holds out his hand.

### Choices

- **Offer your ring** → `009` Charon’s Question
- **Swim across** → `008` Taken by the Styx (Game Over)

---

## 008 — Taken by the Styx (Game Over)

**Image:** `HDS008.png`  
**Outcome:** `death` · Death · `hades_taken_by_the_styx`  
**Reached from:** `007`

**Text:**  
You wade into the river while Charon watches without moving. The water is not cold. It is nothing at all. Every step takes something away with it: the feel of sunlight, the taste of salt, the sound of your own voice. By the time it reaches your chest you have forgotten why you are swimming, and soon after that, which way the far shore was. The souls on the bank watch you drift slowly into the mist. The ferryman pushes off without you. He has crossed this river for ten thousand years, and nobody has ever swum it.

**Outcome text:**  
You tried to cross the Styx without paying the ferryman.  
The river kept you, and Theo never knew you came.

---

## 009 — Charon’s Question

**Image:** `HDS009.png`  
**Reached from:** `007`

**Text:**  
Charon closes his fingers over the ring and gestures you aboard. The boat moves without a sound. Halfway across, the souls around you fade into the mist until you are alone with the ferryman. Without turning his head, he speaks in a voice like stones grinding together. “You are warm. You are breathing. The living do not cross my river unless they are heroes, fools or thieves. Which are you, and why have you come?”

### Choices

- **Tell the truth** → `011` The Hound of Hades
- **Lie** **[remembers: Lied to Charon]** → `010` Thrown Ashore

---

## 010 — Thrown Ashore

**Image:** `HDS010.png`  
**Reached from:** `009`

**Text:**  
You tell Charon that Zeus himself sent you on an errand. The ferryman is silent for a long moment. Then he laughs, a terrible creaking sound, and tips the boat. You roll over the side into the shallows of the far shore, gasping, as the river drags at your legs and tries to pull your memories away. You crawl out onto black sand with your heart pounding. Behind you, Charon’s voice drifts out of the mist: “Every lie told down here is heard. Remember that when you stand before my master.” Ahead of you, something very large begins to growl.

### Choices

- **Continue** → `011` The Hound of Hades

---

## 011 — The Hound of Hades

**Image:** `HDS011.png`  
**Reached from:** `009`, `010`  
**Transition:** `bronzeGate`

**Text:**  
Beyond the river stands a gate of black iron, and in front of it lies Cerberus, the hound who guards the underworld. He is bigger than a horse, with three heads, a mane of hissing serpents and a tail that ends in a snake’s head. The souls walking past him go through untouched, but all three heads lift at once and turn toward you, smelling living blood. The middle head bares teeth the size of daggers. You remember what Hermes said about Orpheus and his lyre. You have no lyre. You have only your voice, and it is shaking.

### Choices

- **Sing** → `013` Persephone’s Garden
- **Run past** → `012` Torn by Cerberus (Game Over)

---

## 012 — Torn by Cerberus (Game Over)

**Image:** `HDS012.png`  
**Outcome:** `death` · Death · `hades_torn_by_cerberus`  
**Reached from:** `011`

**Text:**  
You sprint for the gate. You are fast, but Cerberus has three heads and has been guarding this gate since before the first city was built. The left head catches your jacket, the right head catches your arm, and the middle head does not need to catch anything at all. The last thing you hear is the iron gate swinging shut and, somewhere beyond it, very faintly, Theo calling your name.

**Outcome text:**  
You tried to run past the hound of Hades.  
Cerberus does not let the living through his gate.

---

## 013 — Persephone’s Garden

**Image:** `HDS013.png`  
**Reached from:** `011`

**Text:**  
You sing the only song you know by heart, the one your mother sang when Theo could not sleep. Your voice cracks on the first line, but you keep going, and one by one the three great heads sink to the ground. You slip through the gate into a garden of pale asphodel and silver poplars, where a woman in a crown of dark flowers is waiting. She is Persephone, Queen of the Underworld. She heard the song, she says, and she knows who you have come for. Hades will hear a living petitioner only if they bring him three gifts: water from Lethe, the river of forgetting; an ember from Phlegethon, the river of fire; and a branch of the Golden Bough from Elysium. She gives you a clay flask and a bronze bowl for the journey, then holds out a split pomegranate, its seeds glittering like rubies. “You’ve come such a long way. Eat something.”

### Choices

- **Eat the fruit** → `014` Bound by the Seeds (Game Over)
- **Thank her and go** → `015` HOME

---

## 014 — Bound by the Seeds (Game Over)

**Image:** `HDS014.png`  
**Outcome:** `lose` · Bound · `hades_bound_by_the_seeds`  
**Reached from:** `013`

**Text:**  
The seeds are sweet and sharp and taste of every summer you have ever known. You have eaten six before you notice Persephone’s sad smile. “I ate six once,” she says quietly, “and that is why I spend half of every year down here.” The colour drains from the world. Your heartbeat slows to match the stillness of the garden, and you understand that the food of the underworld has made you its own. You will never climb back to the sunlight. Sometimes, from the edge of the garden, you see Theo pass along the road with the other souls. You can never quite catch up with him.

**Outcome text:**  
You ate the food of the dead.  
You belong to the underworld now, as surely as its queen.

---

## 015 — HOME — The Crossroads of Judgment

**Image:** `HDS015.png`  
**Reached from:** `013`, `022`, `029`, `030`, `038`  
**Transition:** `bronzeGate`  
**Notes:** HOME hub. Only the roads for gifts you have not collected are shown. Once all three gifts are collected, any route to HOME goes to `040` instead.

**Text:**  
You stand where three roads meet beneath an enormous black cypress. Here the three judges of the dead, Minos, Rhadamanthus and Aeacus, sit on stone seats and send each soul down one of the roads. To the left, a grey road winds into the Asphodel Meadows, where the river Lethe whispers. Straight ahead, a road of cracked bronze descends toward the red glow of Tartarus and the burning river Phlegethon. To the right, a road of white stone climbs toward a golden light and the fields of Elysium. Beyond the judges, at the end of a long black hall, stands the palace of Hades, its doors sealed until you carry all three gifts. Any road whose gift you already hold is blocked by a silent line of shades.

### Choices

- **The grey road** → `016` The Asphodel Meadows *(hidden once the Water of Lethe is held)*
- **The bronze road** → `024` The Gates of Tartarus *(hidden once the Ember of Phlegethon is held)*
- **The white road** → `032` The Fields of Elysium *(hidden once the Golden Bough is held)*

---

## 016 — The Asphodel Meadows

**Image:** `HDS016.png`  
**Reached from:** `015`  
**Transition:** `mistFade`

**Text:**  
The grey road fades into endless fields of pale asphodel. This is where most of the dead go: not good enough for Elysium, not wicked enough for Tartarus. They drift between the flowers like sleepwalkers, never speaking, never quite remembering who they were. Somewhere ahead you can hear running water. Then, among the drifting shades, you see a yellow jacket. Theo is sitting in the flowers with his knees pulled up, staring at nothing.

### Choices

- **Go to Theo** → `017` The Brother Who Forgot
- **Follow the water** → `018` The River of Forgetting

---

## 017 — The Brother Who Forgot

**Image:** `HDS017.png`  
**Reached from:** `016`

**Text:**  
You kneel beside him and say his name. Theo looks at you politely, the way he would look at a stranger on a train. He does not know you. He says it is peaceful here, that nothing hurts, and that he thinks he used to be afraid of the sea, though he cannot remember why. His hands are cold and pale. When you hold them, a flicker of something crosses his face and is gone. You could tell him who he is and make him remember. It would hurt him. Or you could leave him in peace until you have a way to bring him home.

### Choices

- **Tell him who he is** **[remembers: Woke Theo]** → `018` The River of Forgetting
- **Let him rest** **[remembers: Left Theo resting]** → `018` The River of Forgetting

---

## 018 — The River of Forgetting

**Image:** `HDS018.png`  
**Reached from:** `016`, `017`

**Text:**  
The sound of water leads you to the river Lethe. It runs slow and milky through the fields, and the shades who kneel to drink from it rise with blank, contented faces. As you take out Persephone’s clay flask, the water seems to notice you. It begins to murmur in voices you recognise: your mother, your friends, Theo. The near bank is low and easy to reach. A line of stepping stones crosses to the far bank, where the water runs deeper and clearer.

### Choices

- **Kneel at the water** → `019` The Reflection
- **Cross to the far bank** → `020` Echoes in the Water

---

## 019 — The Reflection

**Image:** `HDS019.png`  
**Reached from:** `018`, `020`  
**Notes:** Remembered choice changes where **Drink** leads.

**Text:**  
You kneel and lower the flask. The surface goes still, and in it you see the boat, the storm and Theo’s hand slipping out of yours. Then the picture changes. This time you hold on. You pull him up, you both reach the shore, and you sit together on the warm rocks, laughing in the sun. The water whispers that this is how it should have been. All you have to do is drink, and the grief will go, and the other memory with it. Your mouth is so dry. It would be so easy.

### Choices

- **Look away** → `022` The Water of Lethe
- **Drink** → `023` The Sweet Forgetting (Game Over)
  - *If woke Theo at 017:* **Drink** → `021` The Voice You Woke

---

## 020 — Echoes in the Water

**Image:** `HDS020.png`  
**Reached from:** `018`

**Text:**  
You start across the stepping stones. Halfway over, they begin to sink, and the river rises to your knees and pours memories into you. It shows you the boat again, but this time it does not lie. You see yourself in the moment before the wave hit, letting go of Theo’s hand to grab the rail. It lasted a single second, made of pure fear, and it is the one thing you have never allowed yourself to remember. The river waits, as if to see what you will do with it.

### Choices

- **Admit it** → `022` The Water of Lethe
- **Blame the sea** → `019` The Reflection

---

## 021 — The Voice You Woke

**Image:** `HDS021.png`  
**Reached from:** `019` (only if woke Theo at `017`)

**Text:**  
You cup your hands, and the water is almost at your lips when someone grabs your wrist. It is Theo, out of breath, his face no longer blank. “Don’t,” he says. “You told me my name. If you forget, who’s going to remember me?” He is shaking. The river hisses and falls quiet. Theo helps you hold the flask beneath the surface until it is full, then sits down on the bank to wait. “I’ll stay here,” he says. “Just come back for me.”

### Choices

- **Fill the flask** → `022` The Water of Lethe

---

## 022 — The Water of Lethe

**Image:** `HDS022.png`  
**Reached from:** `019`, `020`, `021`

**Text:**  
The flask fills with grey water so cold it numbs your fingers. A wax seal bearing Persephone’s flower closes over the neck by itself. Not a drop can spill, and not a drop can be drunk. The voices in the river fade to a murmur. Whatever you saw in the water, you are still carrying it, and you understand that this is the point. Hades will not hear anyone who came to forget. The grey road leads back toward the crossroads.

### Choices

- **Take it** **[collects Water of Lethe]** → `015` HOME (or `040` if all gifts are held)

---

## 023 — The Sweet Forgetting (Game Over)

**Image:** `HDS023.png`  
**Outcome:** `lose` · Forgotten · `hades_sweet_forgetting`  
**Reached from:** `019`

**Text:**  
You drink. The water tastes of nothing at all, and then of nothing at all forever. The storm goes. The boat goes. Theo’s face blurs, then his name, then the fact that there was ever anyone to look for. It does not hurt. That is the strangest part. You stand up, smile at nothing and wander into the asphodel with the other shades, and you never once wonder why you came. A few fields away, a boy in a yellow jacket sits among the flowers. Neither of you looks up as you pass.

**Outcome text:**  
You drank from Lethe to escape your grief.  
You have forgotten everything, even the one you came to save.

---

## 024 — The Gates of Tartarus

**Image:** `HDS024.png`  
**Reached from:** `015`  
**Transition:** `bronzeGate`

**Text:**  
The bronze road drops steeply into a canyon glowing red, where the river Phlegethon flows in a ring of liquid fire around a fortress of bronze walls. This is Tartarus, the prison of the Titans and of the worst of the dead. Its gates stand open, but on the tower above them sits a woman with wings like a bat’s, serpents in her hair and a whip of flame in her hand. She is Tisiphone, one of the Furies, the punishers of the guilty. She has already seen you. Further along, the fortress wall is lower, cracked and climbable.

### Choices

- **Ask to enter** → `025` Tisiphone the Avenger
- **Climb the wall** → `026` The Fury’s Lash

---

## 025 — Tisiphone the Avenger

**Image:** `HDS025.png`  
**Reached from:** `024`

**Text:**  
You walk up to the gate and ask to enter. Tisiphone drops from the tower and lands in front of you, her wings filling the sky. “No one walks into Tartarus,” she says. “They are dragged. But a living heart may pass, if it first confesses something it has never told anyone.” Her serpents taste the air in front of your face. You understand that she already knows what you will say, and only wants to hear whether you will say it.

### Choices

- **Confess** → `027` The Hill of Sisyphus
- **Refuse** → `026` The Fury’s Lash

---

## 026 — The Fury’s Lash

**Image:** `HDS026.png`  
**Reached from:** `024`, `025`

**Text:**  
Tisiphone’s whip cracks against the bronze an inch from your head. You throw yourself over the top of the wall and tumble down a slope of hot ash into Tartarus. All around you, the punished dead suffer: Tantalus stands up to his chin in water that drains away whenever he tries to drink, and Ixion turns forever on a wheel of fire. High above, the Fury circles, screaming. Ahead, the path splits. To one side you hear someone grunting with effort. To the other, steps cut into the rock lead down toward the roar of the burning river.

### Choices

- **Follow the sound** → `027` The Hill of Sisyphus
- **Take the burning stair** → `028` The River of Fire

---

## 027 — The Hill of Sisyphus

**Image:** `HDS027.png`  
**Reached from:** `025`, `026`

**Text:**  
Deep inside Tartarus, a man is pushing an enormous boulder up a steep hill. His shoulders are raw and his legs tremble, and just before he reaches the top, the stone slips and thunders back down to the bottom. He walks down after it without a word and starts again. This is Sisyphus, the king who cheated death twice and was given this task forever. As you pass, he speaks without looking up. “Help me get it to the top, just once. Just once, so I can see what’s on the other side. I’ll tell you the secret of the burning river.”

### Choices

- **Help him** **[remembers: Helped Sisyphus]** → `028` The River of Fire
- **Walk on** → `028` The River of Fire

---

## 028 — The River of Fire

**Image:** `HDS028.png`  
**Reached from:** `026`, `027`  
**Transition:** `torchReveal`

**Text:**  
The path ends at the bank of the Phlegethon. The river is made of fire that flows like water, and the heat is so fierce that your clothes begin to smoke. Embers drift on its surface like fallen leaves, glowing white-hot. Persephone told you to bring one back in her bronze bowl. Now and then the flames sink low for a few seconds, as though the river is taking a breath, and the embers wash close to the bank. The rest of the time it roars. Behind you, you hear the beat of leathery wings.

*If helped Sisyphus at 027, add:* Your shoulders still ache from the boulder. For one moment at the top of the hill, Sisyphus stood still and laughed, and before the stone rolled away and he went down after it, he told you his secret: “The river breathes. Wait for the breath.”

### Choices

- **Wait for the flames to sink** **[collects Ember of Phlegethon]** → `030` The Way Out of Tartarus
- **Snatch an ember now** **[collects Ember of Phlegethon]** → `029` The Furies Wake

---

## 029 — The Furies Wake

**Image:** `HDS029.png`  
**Reached from:** `028`

**Text:**  
You lunge, scoop an ember into the bronze bowl and pull it back, smoking. The river roars as if you have robbed it, and all three Furies rise screaming from the walls of Tartarus: Tisiphone, Alecto and Megaera, their whips trailing fire. Between you and the bronze road lies a narrow bridge over the burning river. To your left, a dark crack in the rock leads underground, cool and silent and out of sight.

### Choices

- **Run for the bridge** → `015` HOME (or `040` if all gifts are held)
- **Hide in the dark** → `031` Chained in Tartarus (Game Over)

---

## 030 — The Way Out of Tartarus

**Image:** `HDS030.png`  
**Reached from:** `028`

**Text:**  
You wait while the river roars and your skin blisters. Then, with a long sigh, the flames sink. An ember rolls to the bank and you lift it into the bronze bowl. It burns without consuming anything. When you turn around, Tisiphone is standing on the path. She looks at the ember, then at you. “Patience,” she says. “Rarer down here than courage.” She steps aside and points her whip toward the bronze road.

### Choices

- **Return** → `015` HOME (or `040` if all gifts are held)

---

## 031 — Chained in Tartarus (Game Over)

**Image:** `HDS031.png`  
**Outcome:** `death` · Death · `hades_chained_in_tartarus`  
**Reached from:** `029`

**Text:**  
You squeeze into the crack and press yourself against the rock as the Furies’ screams pass overhead. It is quiet in here. Then the stone shifts. The crack was never a hiding place. It is a doorway to the deepest pit of Tartarus, where the Titans were chained when the world was young. Bronze chains rise from the dark and close around your wrists and ankles with a sound like a lock turning. A huge voice in the darkness rumbles with something like amusement. “A new neighbour.” The ember in your bowl gutters out. No one will ever come looking for you here.

**Outcome text:**  
You hid from the Furies in the darkest part of Tartarus.  
You are chained beside the Titans until the end of time.

---

## 032 — The Fields of Elysium

**Image:** `HDS032.png`  
**Reached from:** `015`  
**Transition:** `torchReveal`

**Text:**  
The white road climbs through a gate of polished ivory, and suddenly there is sunlight. Real, warm sunlight, falling on green meadows, orchards heavy with fruit and a sea so blue it hurts to look at. These are the Elysian Fields, where heroes and the blessed dead live without pain or sorrow. Music drifts from a long table beneath the olive trees, where warriors in bronze laugh and raise their cups. Far across the fields, on a low hill, a single tree shines like a flame of gold.

### Choices

- **Join the feast** → `033` The Feast of Heroes
- **Head for the golden tree** → `035` The Grove of the Golden Bough

---

## 033 — The Feast of Heroes

**Image:** `HDS033.png`  
**Reached from:** `032`

**Text:**  
The heroes make room for you at the table without a word, as if they had been expecting you. Someone pours you wine that tastes of honey. Beside you sits a young warrior with tired eyes, whom the others call Achilles. When you tell him why you are here, he is quiet for a while. “I was offered a short life and endless glory, or a long life and a forgotten name. I chose glory. I’ve had a long time to think about it.” He looks at the sunlight in his cup. “I would rather be a hired hand on a poor man’s farm in the world above than king over all the dead. Don’t stay here too long.”

### Choices

- **Stay a while** → `034` The Endless Afternoon
- **Ask about the golden tree** → `035` The Grove of the Golden Bough

---

## 034 — The Endless Afternoon

**Image:** `HDS034.png`  
**Reached from:** `033`

**Text:**  
You only mean to stay for one more song. But the afternoon never ends here, and the sun never moves. When you look down, your cup has been refilled more times than you can count, and the clothes you arrived in look strangely faded, as though years have passed. Achilles has gone. In the warm grass beyond the table there is a soft, shady place where you could lie down and close your eyes. You are so tired. You have not slept since the storm.

### Choices

- **Leave now** → `035` The Grove of the Golden Bough
- **Lie down in the grass** → `039` The Isles of the Blessed (Game Over)

---

## 035 — The Grove of the Golden Bough

**Image:** `HDS035.png`  
**Reached from:** `032`, `033`, `034`

**Text:**  
The golden tree stands alone in a quiet grove. Its trunk is ordinary bark, but one low branch is pure gold, leaves and twigs and all, chiming softly in the breeze. Beneath it, on a stone bench, sits a very old woman wrapped in grey, with dry leaves tangled in her hair. She is the Sibyl of Cumae, who once guided the hero Aeneas through the underworld. “The bough breaks only for the one the Fates allow,” she says without opening her eyes. “If you are not that one, all the strength in the world will not move it.”

### Choices

- **Reach for the bough** → `037` The Bough Resists
- **Speak to the Sibyl** → `036` The Sibyl’s Riddle

---

## 036 — The Sibyl’s Riddle

**Image:** `HDS036.png`  
**Reached from:** `035`, `037`

**Text:**  
The Sibyl opens her eyes. They are milky white, but you are certain she can see you. “Aeneas came down for his father,” she says. “You come for a brother. Tell me, what would you give to have him back?” A breeze stirs the grove, and the golden branch chimes softly, as if it is listening too. You would like to say *anything*. You would like to say *my life*. You are not sure either is true.

### Choices

- **Answer honestly** → `038` The Golden Bough
- **Promise anything** → `037` The Bough Resists

---

## 037 — The Bough Resists

**Image:** `HDS037.png`  
**Reached from:** `035`, `036`

**Text:**  
You grab the branch and pull. It does not bend. You pull harder, bracing your feet against the trunk, until the golden leaves cut your palms and your arms shake. The bough does not move by so much as a hair. Behind you, the Sibyl sighs. “Everyone pulls,” she says. “Nobody can force the Fates.” Your hands are bleeding onto the gold.

### Choices

- **Let go** → `038` The Golden Bough
- **Ask the Sibyl** → `036` The Sibyl’s Riddle

---

## 038 — The Golden Bough

**Image:** `HDS038.png`  
**Reached from:** `036`, `037`

**Text:**  
The golden branch breaks away from the tree with a sound like a small bell and drops gently into your hands. It is warm, and lighter than it looks. “The Fates do not want heroes,” the Sibyl says behind you. “They want people who are honest about what they cannot do. Take it to the Queen.” When you look back, the bench is empty, and the white road is waiting.

### Choices

- **Take the bough** **[collects Golden Bough]** → `015` HOME (or `040` if all gifts are held)

---

## 039 — The Isles of the Blessed (Game Over)

**Image:** `HDS039.png`  
**Outcome:** `bittersweet` · Peaceful Rest · `hades_isles_of_the_blessed`  
**Reached from:** `034`

**Text:**  
You lie down in the shade and close your eyes, just for a moment. The grass is soft, the sea whispers somewhere below, and the warmth of the sun sinks into your bones. When you wake it is still afternoon, and it always will be. You have a place at the feast now, and a white house by the sea, and you will never be cold or frightened again. Sometimes you remember that there was someone you were supposed to find. Then the music starts again, and you forget to worry about it.

**Outcome text:**  
You rested in Elysium and never left.  
It is a kind of paradise, but Theo is not in it.

---

## 040 — The Throne of Hades

**Image:** `HDS040.png`  
**Reached from:** HOME (`015` routes) once all three gifts are held  
**Transition:** `bronzeGate`  
**Notes:** End-game hall. Remembered choices add lines and a third button.

**Text:**  
The judges rise as you approach and step aside without a word. The long black hall leads into a throne room carved from a single dark jewel and lit by the cold fire of the rivers you have crossed. Hades sits on a throne of obsidian, tall and grey-eyed and still as a mountain, and beside him sits Persephone. You lay the gifts before him: the water of forgetting, the ember of punishment and the bough of the blessed. Hades studies them for a long time. “You have walked my whole kingdom,” he says, “to ask me for the one thing I never give. Speak.”

*If lied to Charon at 009, add:* “Charon tells me you lied to him,” Hades adds. “Do not lie to me.”

*If woke Theo at 017, add:* Theo stands among the shades at the edge of the hall, watching you. He still remembers your name.

*If struck Hermes’ bargain at 006, add:* In the shadow of a pillar you glimpse a traveller’s hat and a pair of winged sandals. Hermes winks.

### Choices

- **Plead for Theo** → `041` Hades’ Condition
- **Offer your life** → `046` The Willing Exchange (Game Over)
- *If struck Hermes’ bargain at 006:* **Call on Hermes** → `047` Thief of the Dead (Game Over)

---

## 041 — Hades’ Condition

**Image:** `HDS041.png`  
**Reached from:** `040`

**Text:**  
You tell Hades about the boat and the storm, and about the moment Theo’s hand slipped from yours. You do not make it sound better than it was. When you finish, the hall is silent. Then Persephone lays her hand on her husband’s arm, and Hades sighs like a closing tomb. “Once before, I made this bargain,” he says. “Your brother will follow you up to the living world. You will lead. You will not speak to him, and you will not look back, not once, until you both stand in the sunlight. If you look back, he returns to me, and there will be no second chance.” A door opens behind the throne onto a stairway climbing into darkness.

### Choices

- **Begin the climb** → `042` The Long Ascent

---

## 042 — The Long Ascent

**Image:** `HDS042.png`  
**Reached from:** `041`  
**Transition:** `torchReveal`

**Text:**  
The stairway is narrow and endless, and so dark that you have to feel your way along the walls. You cannot hear anyone behind you. No footsteps, no breathing, nothing at all. You remind yourself that the dead make no sound, but the doubt grows with every step. What if Hades lied? What if there is no one behind you, and you are climbing toward the sunlight alone? One look would tell you. Just one.

*If helped Sisyphus at 027, add:* Halfway up, a fallen boulder blocks the stair. You set your shoulder against it the way you did on the hill, and it rolls aside. For a moment you think you hear someone far below, laughing.

*If woke Theo at 017, add:* Once, very quietly, you think you hear someone humming your mother’s song.

### Choices

- **Keep climbing** → `043` The Last Stair
- **Look back** → `045` Looked Back (Game Over)

---

## 043 — The Last Stair

**Image:** `HDS043.png`  
**Reached from:** `042`

**Text:**  
Far above, a thin line of daylight appears. You can smell salt air and hear the waves. You climb faster. Then, right behind you, someone stumbles. You hear a sharp gasp of pain and Theo’s voice, the first sound he has made, crying out your name. He has fallen. He might be hurt. Every instinct you have screams at you to turn around and help him, the way you did not help him in the water. The sunlight is only a few steps away.

*If woke Theo at 017, add:* Then, just as clearly, you hear him again through gritted teeth. “Don’t. Don’t turn around. I’m right behind you. Keep going.”

### Choices

- **Step into the light** → `044` Out Into the Sun (Game Over)
- **Turn to help him** → `045` Looked Back (Game Over)

---

## 044 — Out Into the Sun (Game Over)

**Image:** `HDS044.png`  
**Outcome:** `win` · Best Ending · `hades_out_into_the_sun`  
**Reached from:** `043`

**Text:**  
You keep your eyes on the light and step out of the cave into the afternoon sun. The sea is calm and the air is warm. You stand on the rocks of Cape Tainaron and count to three, and only then do you turn around. Theo is standing behind you, soaked and shivering and squinting at the sun. He is breathing. For a long moment neither of you can say anything. Then he grabs you in a hug so hard it hurts. Out on the water, a fishing boat is heading toward you, its crew waving and shouting. Behind you, the cave has gone, as though there was only ever rock.

*If woke Theo at 017, add:* “You came to get me,” Theo says into your shoulder. “I remembered you the whole way up.”

*If left Theo resting at 017, add:* Theo does not remember the underworld. He remembers the wave, and then your face. You decide that is enough.

*If helped Sisyphus at 027, add:* Far away, so faint you might have imagined it, you hear a great stone come to rest at the top of a hill.

**Outcome text:**  
You walked through the underworld and did not look back.  
Theo lives, and you brought him home.

---

## 045 — Looked Back (Game Over)

**Image:** `HDS045.png`  
**Outcome:** `lose` · Lost · `hades_looked_back`  
**Reached from:** `042`, `043`

**Text:**  
You turn around. Theo is right there, one step below you, his hand reaching out, and for a heartbeat you see him clearly: alive, frightened, almost home. Then his face fills with sadness and he begins to fade. “It’s okay,” he whispers. “You came.” He is gone before you can reach him, drawn back down into the dark like smoke. The stairway crumbles beneath you, and you wake on the rocks of Cape Tainaron in the sun, alone, with seawater in your lungs and a fishing crew hauling you onto their boat. You never find the cave again.

**Outcome text:**  
You looked back, as Orpheus once did.  
You returned to the living, but Theo did not.

---

## 046 — The Willing Exchange (Game Over)

**Image:** `HDS046.png`  
**Outcome:** `bittersweet` · Sacrifice · `hades_willing_exchange`  
**Reached from:** `040`

**Text:**  
You tell Hades that you will stay in Theo’s place. The words are out before you can be afraid of them. Hades looks at you for a long time, and something in his grey eyes changes. “A life for a life,” he says. “That is a debt I accept.” Theo is brought before the throne, blinking and confused, and as you watch, the colour returns to his face. You do not get to say goodbye. Persephone takes your hand and leads you out into her garden, while far above, a boy wakes on the rocks of Cape Tainaron with the sun on his face and a feeling he cannot explain that somebody saved him.

**Outcome text:**  
You gave your life so Theo could live.  
He will grow old in the sunlight, and he will never forget you.

---

## 047 — Thief of the Dead (Game Over)

**Image:** `HDS047.png`  
**Outcome:** `darkWin` · Dark Ending · `hades_thief_of_the_dead`  
**Reached from:** `040` (only if struck Hermes’ bargain at `006`)

**Text:**  
You whisper Hermes’ name. In an instant he is beside you, grinning, and the throne room goes black as he throws the Helm of Darkness over your heads, stolen from Hades’ own armoury. “Run,” he laughs. You grab Theo’s hand and run: past the judges, past the sleeping hound, across the Styx in a stolen boat and up into the blinding sunlight of Cape Tainaron. You made it. Theo is alive. But beneath your feet the earth rumbles with the fury of a god who has been robbed. That night, Hermes appears at the foot of your bed and tells you it is time to pay back the favour.

**Outcome text:**  
You stole Theo from the underworld with a god’s help.  
You are both alive, but you owe Hermes, and Hades never forgets a theft.
