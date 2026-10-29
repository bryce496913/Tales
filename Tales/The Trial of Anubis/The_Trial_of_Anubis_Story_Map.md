# The Trial of Anubis — Story Map

**Story ID:** `trial-of-anubis`  
**Source of truth:** the Swift views in this folder. Update this file whenever a page, choice or ending changes.

---

# How the Story Works

- The player starts at `000` and must collect three pieces of the broken scales: the **Feather Arm**, the **Heart Pan** and the **Balance Stone**.
- `011` (**HOME**, the Hall of Gates) is the hub. It shows a gate for each piece the player has not collected yet:
  - Feather Arm → `008`
  - Heart Pan → `018`
  - Balance Stone → `021`
- When all three pieces are collected, any route into HOME goes to `026` instead. This opens the end-game.
- Pieces are collected by the choice buttons marked **[collects …]** below.
- Game-over pages have no choice buttons. They show the shared outcome screen with Restart / Menu controls and record their ending ID.
- Progress (current page, visited pages, collected pieces, completed endings) is saved under `Tales.trial-of-anubis.progress.v2`.

Page names in conversation use the short number (`004`). In code, the view is `ANU004View` and the route is `.anu004` (`"ANU-004"`).

---

# Route Table

| Page | Title | Choice | Goes to |
|---|---|---|---|
| `000` | The Lost Expedition | Continue | `001` The Silent Desert |
| `001` | The Silent Desert | Enter the doorway | `002` The Black Doorway |
|  |  | Turn back | `003` Lost in the Sand (Game Over) |
| `002` | The Black Doorway | Enter | `004` The Jackal Temple |
|  |  | Call into the darkness | `003` Lost in the Sand (Game Over) |
| `003` | Lost in the Sand | — | **Game Over** (Death) |
| `004` | The Jackal Temple | Follow the statues | `013` Golden Scarab Vault |
|  |  | Enter the stairs | `005` Anubis Revealed |
| `005` | Anubis Revealed | Help | `006` Terms of Judgment |
|  |  | Run | `007` Run from the God |
| `006` | Terms of Judgment | Agree | `008` River of the Dead |
|  |  | Ask for a reward | `033` The Price of a Reward |
| `007` | Run from the God | Agree to help | `006` Terms of Judgment |
|  |  | Run | `017` Swallowed by the Fog (Game Over) |
| `008` | River of the Dead | Call out | `009` The Ferryman’s Price |
|  |  | Swim | `035` Taken by the River (Game Over) |
| `009` | The Ferryman’s Price | Pay | `010` Hall of Whispers |
|  |  | Refuse | `039` Taken by Force |
| `010` | Hall of Whispers | Follow the crying voice | `041` The Crying Soul |
|  |  | Enter the Feather Arm door | `012` Feather Arm Chamber |
| `011` | HOME — The Hall of Gates | Enter the first gate | `008` River of the Dead |
|  |  | Enter the second gate | `018` Maze of False Memories |
|  |  | Enter the third gate | `021` The Scribe’s Secret |
| `012` | Feather Arm Chamber | Take the feather **[collects Feather Arm]** | `011` HOME (or `026` if all pieces are held) |
|  |  | Enter the shadow | `014` Chamber of Stolen Hearts |
| `013` | Golden Scarab Vault | Take the scarab | `014` Chamber of Stolen Hearts |
|  |  | Don’t take it | `011` HOME (or `026` if all pieces are held) |
| `014` | Chamber of Stolen Hearts | Touch the heart | `031` Pulled Through the Glass |
|  |  | Follow the chains | `015` Ammit Unchained |
| `015` | Ammit Unchained | Help | `016` The Broken Chain |
|  |  | Fight | `032` Devoured by Ammit (Game Over) |
| `016` | The Broken Chain | Free | `034` Ammit Breaks Free |
|  |  | Leave | `032` Devoured by Ammit (Game Over) |
| `017` | Swallowed by the Fog | — | **Game Over** (Death) |
| `018` | Maze of False Memories | Follow the memory of home | `019` Memory of Home |
|  |  | Follow your failures | `042` Memory of Failure |
| `019` | Memory of Home | Accept that the memory may be false | `020` The Heart Pan |
|  |  | Stay inside the memory | `040` A Peaceful Death (Game Over) |
| `020` | The Heart Pan | Take **[collects Heart Pan]** | `011` HOME (or `026` if all pieces are held) |
| `021` | The Scribe’s Secret | Trust the scribe | `022` The True Name |
|  |  | Threaten the scribe | `043` Ink and Threats |
| `022` | The True Name | Speak Anubis’s hidden title | `023` The Rebel’s Offer |
|  |  | Keep the name secret | `044` A Secret Kept |
| `023` | The Rebel’s Offer | Reject | `045` The Rebel’s Fire |
|  |  | Accept | `024` Balance Stone Chamber |
| `024` | Balance Stone Chamber | Take the Balance Stone **[collects Balance Stone]** | `036` The Guardian’s Guidance |
|  |  | Rip it from the guardian **[collects Balance Stone]** | `025` The Final Guardian |
| `025` | The Final Guardian | Spare the guardian | `036` The Guardian’s Guidance |
|  |  | Destroy the final guardian | `037` The Collapsing Tomb |
| `026` | The Scales Made Whole | Talk to Anubis | `027` Restoring the Scales |
|  |  | Try to escape | `028` Lord of the Tomb (Game Over) |
| `027` | Restoring the Scales | Accept | `030` The Scales Restored (Game Over) |
|  |  | Reject | `029` Released (Game Over) |
| `028` | Lord of the Tomb | — | **Game Over** (Dark Ending) |
| `029` | Released | — | **Game Over** (Released) |
| `030` | The Scales Restored | — | **Game Over** (Best Ending) |
| `031` | Pulled Through the Glass | Heart journey | `020` The Heart Pan |
| `032` | Devoured by Ammit | — | **Game Over** (Death) |
| `033` | The Price of a Reward | Enter the first gate | `008` River of the Dead |
| `034` | Ammit Breaks Free | Enter the broken wall | `020` The Heart Pan |
| `035` | Taken by the River | — | **Game Over** (Death) |
| `036` | The Guardian’s Guidance | Return to the Hall of Gates | `011` HOME (or `026` if all pieces are held) |
| `037` | The Collapsing Tomb | Run for it | `011` HOME (or `026` if all pieces are held) |
|  |  | Try and dodge | `038` Buried with the Stone (Game Over) |
| `038` | Buried with the Stone | — | **Game Over** (Death) |
| `039` | Taken by Force | Continue | `010` Hall of Whispers |
| `040` | A Peaceful Death | — | **Game Over** (Peaceful Death) |
| `041` | The Crying Soul | Free the trapped soul | `012` Feather Arm Chamber |
|  |  | Leave them and go to the Feather Arm door | `012` Feather Arm Chamber |
| `042` | Memory of Failure | Admit responsibility | `020` The Heart Pan |
|  |  | Blame someone else | `019` Memory of Home |
| `043` | Ink and Threats | Apologise and trust the scribe | `022` The True Name |
|  |  | Search behind the shelves | `023` The Rebel’s Offer |
| `044` | A Secret Kept | Follow the masked figure | `023` The Rebel’s Offer |
|  |  | Take the stairs | `024` Balance Stone Chamber |
| `045` | The Rebel’s Fire | Take the stairs | `024` Balance Stone Chamber |

---

# Endings

| Page | Ending | Classification | Ending ID | Reached from |
|---|---|---|---|---|
| `003` | Lost in the Sand | Death | `anubis_lost_in_desert` | `001`, `002` |
| `017` | Swallowed by the Fog | Death | `anubis_swallowed_by_fog` | `007` |
| `028` | Lord of the Tomb | Dark Ending | `anubis_lord_of_the_tomb` | `026` |
| `029` | Released | Released | `anubis_released` | `027` |
| `030` | The Scales Restored | Best Ending | `anubis_scales_restored` | `027` |
| `032` | Devoured by Ammit | Death | `anubis_devoured_by_ammit` | `015`, `016` |
| `035` | Taken by the River | Death | `anubis_taken_by_the_river` | `008` |
| `038` | Buried with the Stone | Death | `anubis_buried_with_the_stone` | `037` |
| `040` | A Peaceful Death | Peaceful Death | `anubis_peaceful_death` | `019` |

---

# Pages

## 000 — The Lost Expedition

**Image:** `ANU001.png`  
**Notes:** New page.

**Text:**  
Three days ago you joined a small expedition heading deep into the Western Desert to photograph a tomb that appeared on no map. On the final afternoon, the guide stopped the trucks and stared at the horizon, where a wall of red sand was rising into the sky. The storm hit before anyone could turn back. You remember shouting voices, a door torn from your hands and the trucks vanishing into the dust. You ran for shelter, lost your footing and fell. After that, there was nothing but the sound of sand burying the world.

### Choices

- **Continue** → `001` The Silent Desert

---

## 001 — The Silent Desert

**Image:** `ANU001.png`  
**Reached from:** `000`  
**Notes:** Story unchanged.

**Text:**  
The desert is completely silent. There is no wind, no stars and no sound apart from the slow beat of your own heart. You do not remember how you got here, but a trail of footprints follows you across the cold sand. Ahead, half-buried beneath a dune, stands a black stone doorway carved with golden-eyed jackals. As you move closer, the doorway slowly opens by itself and a voice calls from the darkness, “Your heart has been expected.”

### Choices

- **Enter the doorway** → `002` The Black Doorway
- **Turn back** → `003` Lost in the Sand (Game Over)

---

## 002 — The Black Doorway

**Image:** `ANU002.png`  
**Reached from:** `001`  
**Notes:** Small clean-up edit.

**Text:**  
You stop at the doorway and look down a staircase lit by cold blue flames. Carvings on the walls show Anubis standing beside a great set of scales, judging the dead before they pass into the afterlife. The final carving has been smashed, showing the scales broken and a many-jawed creature rising from below. A scraping sound echoes from somewhere deep beneath you before the hidden voice speaks again. “You may enter willingly, or you may enter afraid.”

### Choices

- **Enter** → `004` The Jackal Temple
- **Call into the darkness** → `003` Lost in the Sand (Game Over)

---

## 003 — Lost in the Sand (Game Over)

**Image:** `ANU001.png`  
**Outcome:** `death` · Death · `anubis_lost_in_desert`  
**Reached from:** `001`, `002`  
**Notes:** Rewritten: lost in the desert. Reached from 001 (Turn back) and 002 (Call into the darkness), so the copy avoids naming either choice.

**Text:**  
The black doorway sinks back beneath the dune as if it had never been there, and the voice falls silent. You walk toward where you think the expedition camp should be, but every dune looks the same and the stars never appear to guide you. Your footprints vanish almost as soon as you make them. Hours pass, then what feels like days. Your lips crack, your legs give way and the cold sand slowly pulls you down. The last thing you hear is a jackal calling somewhere in the dark, patient and unhurried, as if it always knew you would return.

**Outcome text:**  
The doorway closed, and the desert claimed you instead.  
Your journey ends beneath the sand, never judged by the dead and never found by the living.

---

## 004 — The Jackal Temple

**Image:** `ANU003.png`  
**Reached from:** `002`  
**Notes:** Story copied from old 003.

**Text:**  
The staircase leads into an ancient temple lined with black jackal statues. Their golden collars remain bright despite the dust, and each statue slowly turns its head to watch you. A narrow path leads toward a circular opening in the floor, while a side room glitters with masks, ceremonial blades and piles of gold. Behind you, the staircase has disappeared and the wall now shows a carving shaped exactly like you. The voice below asks, “What did you come here seeking?”

### Choices

- **Follow the statues** → `013` Golden Scarab Vault
- **Enter the stairs** → `005` Anubis Revealed

---

## 005 — Anubis Revealed

**Image:** `ANU005.png`  
**Reached from:** `004`  
**Notes:** Old 004 and 005 combined and rewritten.

**Text:**  
You descend a spiral staircase that circles a shaft with no visible bottom. As you go, the steps show flashes of your own life: small acts of kindness, lies that were never discovered and moments when fear made your choices for you. At the bottom, the stairs open into a hall so vast that its ceiling disappears into darkness. Anubis stands at its centre, dressed in black and gold, his amber eyes glowing. Behind him lies a shattered set of scales, with one pan cracked on the floor and the central balance stone torn from its frame. Shadowy souls drift through open gates while something enormous growls behind the pillars. Anubis tells you that the scales have been stolen and asks for your help before the boundary between life and death collapses.

### Choices

- **Help** → `006` Terms of Judgment
- **Run** → `007` Run from the God

---

## 006 — Terms of Judgment

**Image:** `ANU006.png`  
**Reached from:** `005`, `007`  
**Notes:** Story unchanged.

**Text:**  
Anubis raises his hand and shows you visions of the three missing pieces: the Feather Arm, the Heart Pan and the Balance Stone. He explains that fear, greed and rebellion have carried them into different parts of the underworld. If you return them, the dead can be judged again and the gates between worlds can be closed. When you ask what happens to you, Anubis says that an honest heart may return to the living, but anyone seeking a reward must first understand its price.

### Choices

- **Agree** → `008` River of the Dead
- **Ask for a reward** → `033` The Price of a Reward

---

## 007 — Run from the God

**Image:** `ANU007.png`  
**Reached from:** `005`  
**Notes:** Rewritten: trying to run.

**Text:**  
You turn and run back toward the staircase, but the steps have gone. In their place is a corridor of pale fog filled with voices calling your name. Anubis does not chase you. His voice simply follows, calm and close, as though he is walking beside you. He warns you that the broken scales are already reaching into the living world, and the souls drifting past you now wear the faces of people you know, some of whom are still alive. If the balance is not restored soon, even he will be unable to send you home. Ahead, the fog grows darker and the voices grow louder.

### Choices

- **Agree to help** → `006` Terms of Judgment
- **Run** → `017` Swallowed by the Fog (Game Over)

---

## 008 — River of the Dead

**Image:** `ANU008.png`  
**Reached from:** `006`, `011`, `033`  
**Notes:** Feather path. Door opening rewritten so it works from 006, 033 and the HOME first gate.

**Text:**  
The first gate grinds open on stone hinges and cold air rolls out to meet you. Beyond it lies a river of black water. Faces, hands and broken objects drift beneath the surface, while the opposite bank glows beneath an archway of blue fire. A bronze bell hangs beside an empty dock, and far downstream a thin boat approaches. A faceless ferryman stands at the back, guiding it with a long black pole. As the boat gets closer, the water begins whispering in voices you recognise.

### Choices

- **Call out** → `009` The Ferryman’s Price
- **Swim** → `035` Taken by the River (Game Over)

---

## 009 — The Ferryman’s Price

**Image:** `ANU009.png`  
**Reached from:** `008`  
**Notes:** Story unchanged.

**Text:**  
The ferryman reaches the dock without disturbing the water. He is wrapped in wet linen and has no face, but the empty spaces where his eyes should be reflect moments from your past. He tells you that passage requires a memory, a promise or fear. In his hand appears a bright memory of sunlight, laughter and safety that you immediately recognise as your own. Nearby, a trapped soul presses against the river’s surface and reaches toward the boat.

### Choices

- **Pay** → `010` Hall of Whispers
- **Refuse** → `039` Taken by Force

---

## 010 — Hall of Whispers

**Image:** `ANU010.png`  
**Reached from:** `009`, `039`  
**Notes:** Story unchanged.

**Text:**  
Beyond the river is a maze of stone passages covered in thousands of names. Some are royal, some ordinary and some have been scratched away completely. Whispering voices fill the hall with excuses, confessions and forgotten memories. A golden light shines from behind a sealed door marked with the symbol of the Feather Arm, but from a side passage you hear someone crying and begging for help. The voice says that they still remember their name, but not for much longer.

### Choices

- **Follow the crying voice** → `041` The Crying Soul
- **Enter the Feather Arm door** → `012` Feather Arm Chamber

---

## 011 — HOME — The Hall of Gates

**Image:** `ANU026.png`  
**Reached from:** `012`, `013`, `020`, `036`, `037`  
**Notes:** HOME hub (rewritten). Only the gates for pieces you have not collected are shown. Once all three are collected, any route to HOME goes to 026 instead.

**Text:**  
The light folds around you and you find yourself in a round chamber of black stone beneath a ceiling painted with stars. At its centre stands the empty frame of the great scales, with three hollow sockets shaped like a feather, a heart and a smooth round stone. Three gates are set into the walls around it. The first is carved with a feather, the second with a heart and the third with a set of perfectly level scales. The gate of any piece you already carry is sealed behind a curtain of blue fire. Somewhere beyond the empty frame, Anubis waits for the scales to be made whole.

### Choices

- **Enter the first gate** → `008` River of the Dead
- **Enter the second gate** → `018` Maze of False Memories
- **Enter the third gate** → `021` The Scribe’s Secret

---

## 012 — Feather Arm Chamber

**Image:** `ANU012.png`  
**Reached from:** `010`, `041`  
**Notes:** Story unchanged.

**Text:**  
The sealed door opens into a circular room where the golden Feather Arm floats above a shaft of blue fire. Painted figures kneel around the walls holding their hearts in their hands, but their shadows move on their own. Deep scratches cross the floor and lead toward a hidden passage behind the murals. A low growl moves through the stone as the Feather Arm slowly turns within reach.

### Choices

- **Take the feather** **[collects Feather Arm]** → `011` HOME
- **Enter the shadow** → `014` Chamber of Stolen Hearts

---

## 013 — Golden Scarab Vault

**Image:** `ANU013.png`  
**Reached from:** `004`  
**Notes:** Small rewrite for the door opening.

**Text:**  
The jackal statues turn their heads one by one, guiding you along the wall until the last of them points its muzzle at bare stone. With a deep grinding sound, the wall slides open into a hidden vault filled with gold masks, jewels and statues of forgotten gods. At the centre, a golden scarab rests beneath a beam of white light. It feels warm and beats like a living heart. A whisper tells you that carrying it could change the balance of judgment, but you also sense that something trapped inside the scarab wants to be released.

### Choices

- **Take the scarab** → `014` Chamber of Stolen Hearts
- **Don’t take it** → `011` HOME

---

## 014 — Chamber of Stolen Hearts

**Image:** `ANU014.png`  
**Reached from:** `012`, `013`  
**Notes:** Start rewritten so it works from both 012 (shadow) and 013 (scarab).

**Text:**  
The world tilts and drops away beneath you. When it steadies, you are standing in a red chamber where thousands of human hearts hang from the ceiling in glass containers. Each one is marked with a name and shows flashes of the life it belonged to. Among them you find a container carrying your own name, with a heart inside beating in time with your chest. Behind the platform, a massive broken chain disappears through a doorway and a deep growl answers every heartbeat in the room.

### Choices

- **Touch the heart** → `031` Pulled Through the Glass
- **Follow the chains** → `015` Ammit Unchained

---

## 015 — Ammit Unchained

**Image:** `ANU015.png`  
**Reached from:** `014`  
**Notes:** Story unchanged.

**Text:**  
You enter a chamber covered in claw marks and come face to face with Ammit. She has the head of a crocodile, the front of a lion and the body of a hippopotamus, with broken chains hanging from her limbs. Ammit tells you that Anubis calls her a monster even though the gods created her to devour hearts that fail judgment. She lowers her huge head toward you and asks why she should not begin with yours.

### Choices

- **Help** → `016` The Broken Chain
- **Fight** → `032` Devoured by Ammit (Game Over)

---

## 016 — The Broken Chain

**Image:** `ANU016.png`  
**Reached from:** `015`  
**Notes:** Rewritten for breaking the chains.

**Text:**  
You tell Ammit that you will help her. She lowers her huge head and shows you the last chain still fastened around her neck, anchored deep in the chamber wall. The other links were cut cleanly, proving that someone released her on purpose. When you grip the chain, you see a vision of an underworld scribe lifting the Heart Pan from the scales while a hidden figure watches from the shadows. The final link is already cracked and would break with one hard strike. Ammit watches you closely, waiting to see what you will do.

### Choices

- **Free** → `034` Ammit Breaks Free
- **Leave** → `032` Devoured by Ammit (Game Over)

---

## 017 — Swallowed by the Fog (Game Over)

**Image:** `ANU007.png`  
**Outcome:** `death` · Death · `anubis_swallowed_by_fog`  
**Reached from:** `007`  
**Notes:** Rewritten: you try to run and are killed.

**Text:**  
You ignore Anubis and run deeper into the fog. The voices calling your name grow closer until they are beside you, then in front of you, then inside your head. The floor disappears and you fall into a pit of grasping shadows. Faces you know appear in the darkness, but their eyes are empty and their hands are cold. Far above, Anubis says your name one last time, quietly, the way someone speaks at a graveside. Then the shadows close over you and there is nothing left to run from.

**Outcome text:**  
You fled from the god of the dead, and the darkness between worlds caught you first.  
Your name now belongs to the voices in the fog.

---

## 018 — Maze of False Memories

**Image:** `ANU017.png`  
**Reached from:** `011`  
**Notes:** Heart path via the HOME second gate. Story copied from old 017.

**Text:**  
The passage disappears into thick white fog and the walls begin changing whenever you look away. Doors open onto places from your past, including your childhood home, crowded streets and rooms containing people you once knew. Anubis warns from somewhere far away that names disappear first, then faces and finally purpose. Two paths form ahead: one leads toward a warm memory of home, while the other leads toward the memory of your greatest failure.

### Choices

- **Follow the memory of home** → `019` Memory of Home
- **Follow your failures** → `042` Memory of Failure

---

## 019 — Memory of Home

**Image:** `ANU018.png`  
**Reached from:** `018`, `042`  
**Notes:** Story copied from old 018.

**Text:**  
You enter a perfect memory of home, complete with familiar light, sounds and the feeling of being safe. Someone you once loved enters the room and tells you that you have finally returned. Everything feels real, except their shadow points in the wrong direction and the walls flicker whenever you stop looking at them. The figure reaches out and asks you not to leave again.

### Choices

- **Accept that the memory may be false** → `020` The Heart Pan
- **Stay inside the memory** → `040` A Peaceful Death (Game Over)

---

## 020 — The Heart Pan

**Image:** `ANU020.png`  
**Reached from:** `019`, `031`, `034`, `042`  
**Notes:** Story unchanged.

**Text:**  
The fog clears and reveals a chamber shaped like the inside of a giant heart. The missing Heart Pan hangs at the centre, held above thousands of names carved into the floor. Some of the names belong to the dead, while others belong to people who have not yet been born. Your own name appears beneath your feet beside the name of an underworld scribe, suggesting that your arrival was recorded long before the scales were broken.

### Choices

- **Take** **[collects Heart Pan]** → `011` HOME

---

## 021 — The Scribe’s Secret

**Image:** `ANU021.png`  
**Reached from:** `011`  
**Notes:** Balance Stone path via the HOME third gate. Story unchanged.

**Text:**  
A hidden door leads to an underworld scribe surrounded by endless rolls of papyrus. His face is covered by a blank mask that fills with moving words whenever he speaks. He shows you a scroll describing every choice you have made and says that your arrival was written before you were born. When you ask who allowed the scales to break, he tells you that truth must be purchased with trust, force or memory.

### Choices

- **Trust the scribe** → `022` The True Name
- **Threaten the scribe** → `043` Ink and Threats

---

## 022 — The True Name

**Image:** `ANU022.png`  
**Reached from:** `021`, `043`  
**Notes:** Story unchanged.

**Text:**  
The scribe brings you into a dark chamber where stars form the shape of a jackal. He explains that the gods once had titles powerful enough to command the laws of creation. He then teaches you the hidden title of Anubis: He Who Opens the Final Door and Must Obey the Balance. Speaking it could command parts of the underworld, while keeping it secret would leave you with a weapon that no one knows you possess.

### Choices

- **Speak Anubis’s hidden title** → `023` The Rebel’s Offer
- **Keep the name secret** → `044` A Secret Kept

---

## 023 — The Rebel’s Offer

**Image:** `ANU023.png`  
**Reached from:** `022`, `043`, `044`  
**Notes:** Story unchanged.

**Text:**  
A masked rebel steps from behind the scribe’s scrolls and claims that the gods use judgment to protect their own power. They show you visions of frightened souls being weighed, forgotten workers waiting without names and kings passing easily into eternity. The rebel offers you underworld power and asks you to restore the scales only long enough to decide whether Anubis deserves to keep control of them.

### Choices

- **Reject** → `045` The Rebel’s Fire
- **Accept** → `024` Balance Stone Chamber

---

## 024 — Balance Stone Chamber

**Image:** `ANU024.png`  
**Reached from:** `023`, `044`, `045`  
**Notes:** Story unchanged.

**Text:**  
The final piece floats above a machine of turning stone rings. The Balance Stone is small enough to fit in your hand, but the entire room leans around it. A giant guardian made from stone and linen stands beside the mechanism with a ceremonial blade. Its face has been erased and it warns that only the judged may carry balance. You can either carefully unlock the mechanism or tear the stone free before the guardian attacks.

### Choices

- **Take the Balance Stone** **[collects Balance Stone]** → `036` The Guardian’s Guidance
- **Rip it from the guardian** **[collects Balance Stone]** → `025` The Final Guardian

---

## 025 — The Final Guardian

**Image:** `ANU025.png`  
**Reached from:** `024`  
**Notes:** Story unchanged. Note: the text still offers a third option (using Anubis’s hidden title) that has no button.

**Text:**  
The guardian blocks the exit as cracks spread across its body. It says that it was created to protect the Balance Stone and now has no purpose without it. The room begins collapsing behind you while the guardian lowers its weapon and asks you to judge what should happen to it. You can spare it, destroy it or use Anubis’s hidden title to command it.

### Choices

- **Spare the guardian** → `036` The Guardian’s Guidance
- **Destroy the final guardian** → `037` The Collapsing Tomb

---

## 026 — The Scales Made Whole

**Image:** `ANU026.png`  
**Reached from:** `011`  
**Notes:** HOME once all three items are collected.

**Text:**  
As you step back into the Hall of Gates, the Feather Arm, the Heart Pan and the Balance Stone pull against your hands, straining toward one another. All three gates seal behind curtains of blue fire and a fourth door opens where there was only wall before. Beyond it, Anubis waits beside the broken scales while countless souls gather in the darkness. He extends his hand and asks for the pieces. Behind you, a narrow passage glows with light from the world above, and you realise that whoever carries all three pieces holds power over the future of the underworld.

### Choices

- **Talk to Anubis** → `027` Restoring the Scales
- **Try to escape** → `028` Lord of the Tomb (Game Over)

---

## 027 — Restoring the Scales

**Image:** `ANU027.png`  
**Reached from:** `026`  
**Notes:** Rewritten to fix the scales.

**Text:**  
You walk to Anubis and place the three pieces in his hands. The Feather Arm settles into place, the Heart Pan locks onto its chain and the Balance Stone slides into the centre with a deep, ringing hum. The great scales rise from the floor, whole again, and across the underworld the open gates begin to close. Anubis turns to you. He explains that the scales must be tested before the dead can trust them, and the first heart they weigh will prove them true. He asks whether you will place your heart upon them.

### Choices

- **Accept** → `030` The Scales Restored (Game Over)
- **Reject** → `029` Released (Game Over)

---

## 028 — Lord of the Tomb (Game Over)

**Image:** `ANU027.png`  
**Outcome:** `darkWin` · Dark Ending · `anubis_lord_of_the_tomb`  
**Reached from:** `026`  
**Notes:** God-like powers; you now control the tomb of Anubis.

**Text:**  
You turn from Anubis and run for the glowing passage with the three pieces blazing in your arms. As you cross the threshold, their power pours into you. The passage does not lead home. It leads up into the heart of the tomb, and every torch, statue and stone bends toward you as you pass. Behind you, Anubis’s voice fades into silence. When you finally stop, you are seated on a throne of black stone while the jackal statues kneel before you. The tomb of Anubis is yours now, and so is every soul still waiting inside it.

**Outcome text:**  
You stole the scales and took the place of a god.  
You rule the tomb of Anubis, but you can never leave it.

---

## 029 — Released (Game Over)

**Image:** `ANU001.png`  
**Outcome:** `lose` · Released · `anubis_released`  
**Reached from:** `027`  
**Notes:** Anubis is disappointed but releases you. You wake up in hospital.

**Text:**  
You tell Anubis that you cannot do it. For a long moment he says nothing, and the disappointment in his amber eyes is worse than any anger. Then he bows his head. “You returned what was stolen,” he says. “For that, the dead are grateful. Go home.” He touches your forehead and the hall fades to white. You wake to the steady beep of a heart monitor. A nurse tells you that a rescue team found you half-buried in the sand three days after the storm. Nobody believes you about the temple, but on the hospital windowsill a small black jackal sits in the sun, watching you.

**Outcome text:**  
You helped restore the scales but refused to be weighed.  
Anubis has released you, but you will never know what your heart was truly worth.

---

## 030 — The Scales Restored (Game Over)

**Image:** `ANU027.png`  
**Outcome:** `win` · Best Ending · `anubis_scales_restored`  
**Reached from:** `027`  
**Notes:** Best ending. Based on the old True ending.

**Text:**  
You nod, and your heart leaves your chest as a sphere of red light. Anubis places it on the restored scales and, after one frightening moment, it balances perfectly with the feather of Ma’at. The gates of judgment open, forgotten souls remember their names and the stolen hearts return to their owners. Anubis tells you that a light heart is not an empty one, but one that accepts fear, failure and responsibility without placing those burdens on others. He thanks you, returns your heart and sends you back to the desert, where you wake beside the expedition trucks with a small golden feather in your hand. As the last of the temple disappears beneath the sand, you hear his voice one final time: “Live as one who has already been weighed.”

**Outcome text:**  
You restored the scales of judgment and faced them honestly.  
Anubis has returned you to the living world with his blessing.

---

## 031 — Pulled Through the Glass

**Image:** `ANU014.png`  
**Reached from:** `014`  
**Notes:** Teleport into the Heart Pan room.

**Text:**  
You press your hand against the glass. Your heart stops, and so does every heart in the room. The red chamber dissolves into thick white fog and you are pulled through it as if a hand has closed around your chest. When you can breathe again, you are kneeling on cold stone. Your heartbeat has returned, louder than ever, and it echoes from somewhere just ahead of you in the fog.

### Choices

- **Heart journey** → `020` The Heart Pan

---

## 032 — Devoured by Ammit (Game Over)

**Image:** `ANU015.png`  
**Outcome:** `death` · Death · `anubis_devoured_by_ammit`  
**Reached from:** `015`, `016`  
**Notes:** Reached from 015 (Fight) and 016 (Leave), so the copy avoids naming either choice.

**Text:**  
Ammit’s patience runs out. She moves faster than anything that size should be able to, and the chamber fills with the sound of iron dragging across stone. Her voice rumbles inside your head. She has seen what your heart holds, she says, and she does not need the scales to weigh it. Her jaws close and your heart is gone before you feel the pain. Your memories disappear next, then your name, followed by every future you might have lived.

**Outcome text:**  
Ammit judged your heart without the scales.  
The Devourer has consumed your soul, leaving no name, memory or path back to the living world.

---

## 033 — The Price of a Reward

**Image:** `ANU006.png`  
**Reached from:** `006`  
**Notes:** Anubis is angry but accepts.

**Text:**  
Anubis’s eyes narrow and the growling behind the pillars falls silent. “You stand in the hall of the dead and ask for payment,” he says. For a moment, you are certain you have made a terrible mistake. Then he laughs, low and dry. “Very well. Restore the scales and you may name your reward. But remember that the scales will weigh the asking too.” He strikes the floor with his staff and the first gate grinds open behind you.

### Choices

- **Enter the first gate** → `008` River of the Dead

---

## 034 — Ammit Breaks Free

**Image:** `ANU016.png`  
**Reached from:** `016`  
**Notes:** Ammit breaks the wall and runs away.

**Text:**  
With one hard strike, the last link shatters. Ammit throws back her head and roars, shaking dust from every surface in the chamber. She turns, not toward you, but toward the far wall, and charges straight through it. Stone explodes into the darkness and she is gone, her broken chains rattling away into the depths. Where the wall once stood, a ragged hole opens onto thick white fog, and somewhere beyond it you hear a heartbeat that sounds exactly like your own.

### Choices

- **Enter the broken wall** → `020` The Heart Pan

---

## 035 — Taken by the River (Game Over)

**Image:** `ANU008.png`  
**Outcome:** `death` · Death · `anubis_taken_by_the_river`  
**Reached from:** `008`  
**Notes:** Death from swimming the river.

**Text:**  
You lower yourself into the black water and begin to swim. It is colder than ice and heavier than it looks, as if the river itself is pulling at your clothes. Halfway across, the faces beneath the surface open their eyes. Hands rise around you, gripping your arms and ankles while voices whisper that they have waited so long for someone to stay with them. The ferryman’s boat glides past without stopping. You sink slowly, and the last thing you see is the blue fire on the far bank shrinking to a single spark.

**Outcome text:**  
You tried to cross the River of the Dead without paying its price.  
The drowned souls have claimed you as one of their own.

---

## 036 — The Guardian’s Guidance

**Image:** `ANU025.png`  
**Reached from:** `024`, `025`  
**Notes:** The guardian guides you back to HOME.

**Text:**  
The guardian lowers its blade and bows its erased face toward you. “You have judged fairly,” it says. It leads you through the shaking chamber, holding back falling stone with its own cracked body, until you reach a quiet passage lit by blue fire. At the end, the guardian stops, unable to go any further. It raises one stone hand toward the passage ahead, where you can hear the low hum of the Hall of Gates.

### Choices

- **Return to the Hall of Gates** → `011` HOME

---

## 037 — The Collapsing Tomb

**Image:** `ANU024.png`  
**Reached from:** `025`  
**Notes:** Escape the collapsing tomb.

**Text:**  
Your blow splits the guardian in two and it falls without a sound. At once, the stone rings around the mechanism lock in place, then begin tearing themselves apart. The ceiling cracks, columns fall and the floor tilts toward a pit of blue fire. Through the dust you can see the exit passage, already half-blocked by falling rubble. Above you, a huge slab breaks free from the ceiling.

### Choices

- **Run for it** → `011` HOME
- **Try and dodge** → `038` Buried with the Stone (Game Over)

---

## 038 — Buried with the Stone (Game Over)

**Image:** `ANU024.png`  
**Outcome:** `death` · Death · `anubis_buried_with_the_stone`  
**Reached from:** `037`  
**Notes:** Death from trying to dodge the falling slab.

**Text:**  
You throw yourself sideways to dodge the falling slab, but the floor tilts again and you slide straight back into its path. The slab lands with a sound like a door closing. In the silence that follows, the Balance Stone rolls from your hand and comes to rest in the dust, perfectly still, as the chamber settles over you.

**Outcome text:**  
You destroyed the guardian, and the chamber it protected took its revenge.  
You lie buried with the Balance Stone, far from the scales it belonged to.

---

## 039 — Taken by Force

**Image:** `ANU009.png`  
**Reached from:** `009`  
**Notes:** The ferryman takes the memory by force.

**Text:**  
You refuse. The ferryman says nothing. He simply reaches into your chest with a cold, wet hand and draws the memory out himself. Sunlight, laughter and safety slide out of you like thread from a spool, and afterwards you cannot remember whose voices they were. The boat carries you across the river in silence. When you step onto the far bank you feel lighter, but not in a way that feels good.

### Choices

- **Continue** → `010` Hall of Whispers

---

## 040 — A Peaceful Death (Game Over)

**Image:** `ANU018.png`  
**Outcome:** `death` · Peaceful Death · `anubis_peaceful_death`  
**Reached from:** `019`  
**Notes:** A peaceful death from staying inside the memory.

**Text:**  
You take their hand and sit down beside them. The light stays warm, the voices stay familiar and nothing asks anything of you anymore. Days pass, or perhaps years. You stop noticing that the walls flicker or that the shadows point the wrong way. The scales, your quest and finally your own name fade like a dream after waking. One evening you close your eyes in the soft light of home and simply do not open them again. It is a gentle ending, but it is still an ending.

**Outcome text:**  
You chose a beautiful memory over the truth.  
You rest forever inside it, peaceful and forgotten.

---

## 041 — The Crying Soul

**Image:** `ANU011.png`  
**Reached from:** `010`  
**Notes:** Filled gap (was ??). Based on old 011. Both choices continue to 012.

**Text:**  
You find a trapped soul pinned beneath a heavy stone tablet. Their body flickers between a child, an old woman and a wounded soldier as the hall steals pieces of who they were. They tell you that they were waiting for judgment when the scales broke and that soon they will forget their own name. Freeing them will take time, but they promise to show you the safest way to the Feather Arm if you help them.

### Choices

- **Free the trapped soul** → `012` Feather Arm Chamber
- **Leave them and go to the Feather Arm door** → `012` Feather Arm Chamber

---

## 042 — Memory of Failure

**Image:** `ANU019.png`  
**Reached from:** `018`  
**Notes:** Filled gap (was ??). Based on old 019. Blaming someone sends you into the comforting false memory at 019.

**Text:**  
The maze forces you to relive a moment when you failed someone, acted out of fear or allowed another person to carry the cost of your choice. The scene repeats until everyone in it turns to face you. A voice asks whose fault it was, while the maze offers you several people to blame. Behind them, the path forward begins to close.

### Choices

- **Admit responsibility** → `020` The Heart Pan
- **Blame someone else** → `019` Memory of Home

---

## 043 — Ink and Threats

**Image:** `ANU021.png`  
**Reached from:** `021`  
**Notes:** Filled gap (was ??).

**Text:**  
You grab the scribe by his robes and demand the truth. The words on his mask stop moving. Then every scroll in the room unrolls at once, and lines of black ink crawl across the floor and coil around your ankles. “Force writes its own record,” the scribe says calmly. “Would you like to read what it says about you?” He holds out a scroll with your name at the top, the ink still wet. Behind the shelves, something shifts, as if someone else has been listening.

### Choices

- **Apologise and trust the scribe** → `022` The True Name
- **Search behind the shelves** → `023` The Rebel’s Offer

---

## 044 — A Secret Kept

**Image:** `ANU022.png`  
**Reached from:** `022`  
**Notes:** Filled gap (was ??).

**Text:**  
You fold the name away inside your mind and say nothing. The scribe’s mask fills with a single approving word before falling blank again. “A secret is a weapon,” he says, “and every weapon draws attention.” Behind him, the stars on the ceiling shift and reveal a narrow stair spiralling down toward a low grinding sound, like great stone wheels turning. At the same moment, a masked figure slips between the scroll shelves, watching you.

### Choices

- **Follow the masked figure** → `023` The Rebel’s Offer
- **Take the stairs** → `024` Balance Stone Chamber

---

## 045 — The Rebel’s Fire

**Image:** `ANU023.png`  
**Reached from:** `023`  
**Notes:** Filled gap (was ??).

**Text:**  
The rebel’s mask tilts to one side. “Then you are just another servant of the scales,” they say, and sweep a lamp from the table. Fire races across the scrolls. By the time you and the scribe have smothered the flames, the rebel is gone. The scribe, his mask darkened with smoke, points you toward a narrow stair spiralling downward. “The Balance Stone lies below,” he says. “Take it before they do.”

### Choices

- **Take the stairs** → `024` Balance Stone Chamber

---

# Route Safeguards

1. Every choice has one fixed destination; HOME is the only page whose buttons depend on collected pieces.
2. Verify every destination exists and every page from `000` to `045` is reachable.
3. Verify every reachable state can still reach a game-over page (no soft-locks).
4. `026` must only be reachable once all three pieces are collected.
5. Restarting clears collected pieces but keeps completed endings.
