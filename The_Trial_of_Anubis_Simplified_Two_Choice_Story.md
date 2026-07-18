# The Trial of Anubis — Simplified Story Views
## Two-Choice Gameplay Version

**Story ID:** `trial-of-anubis`  
**Purpose:** A simplified version of *The Trial of Anubis* that keeps the existing story structure, narrative text, progress, win endings and lose endings while removing hidden state, inventory, conditions and calculated ending logic.

---

# Simple Gameplay Rules

1. Every playable story page displays exactly two choice buttons.
2. Every choice routes directly to a fixed next page or ending.
3. There is no Heart Weight value.
4. There is no memory counter.
5. There is no allegiance system.
6. There is no inventory or item tracking.
7. There are no locked or conditional choices.
8. There is no hidden ending calculation.
9. Save only the current page, visited pages and reached endings.
10. Record an ending before showing restart or return-to-library controls.

```swift
struct TrialOfAnubisProgress: Codable {
    var currentNodeID: String
    var visitedNodeIDs: Set<String>
    var completedEndingIDs: Set<String>
}
```

---

# Ending Routes

The five endings remain available through direct choices:

- **Lost Soul:** Choose to remain inside the false memory at `ANU-018`.
- **Devoured by Ammit:** Hide a scale piece at `ANU-026`, then submit to judgment at `ANU-027`.
- **Defy the Gods:** Hide a scale piece at `ANU-026`, then challenge Anubis at `ANU-027`.
- **The Scales Restored:** Return the pieces honestly at `ANU-026`, then accept judgment at `ANU-028`.
- **Cheat the Scales:** Return the pieces at `ANU-026`, then manipulate the balance at `ANU-028`.

---

# Act I — The Summons

## ANU-001 — The Silent Desert

**Suggested image:** `ANU001.png`

**Text:**  
The desert is completely silent. There is no wind, no stars and no sound apart from the slow beat of your own heart. You do not remember how you got here, but a trail of footprints follows you across the cold sand. Ahead, half-buried beneath a dune, stands a black stone doorway carved with golden-eyed jackals. As you move closer, the doorway slowly opens by itself and a voice calls from the darkness, “Your heart has been expected.”

### Choices

- **Approach the black doorway** → `ANU-002`
- **Walk away into the desert** → `ANU-003`

---

## ANU-002 — The Black Doorway

**Suggested image:** `ANU002.png`

**Text:**  
You stop at the doorway and look down a staircase lit by cold blue flames. The walls show Anubis standing beside a great set of scales, judging the dead before they pass into the afterlife. The final carving has been smashed apart, showing the scales broken and a many-jawed creature rising from below. A scraping noise comes from somewhere deep beneath you before the hidden voice speaks again. “You may enter willingly, or you may enter afraid.”

### Choices

- **Enter the doorway** → `ANU-003`
- **Call into the darkness** → `ANU-004`

---

## ANU-003 — The Jackal Temple

**Suggested image:** `ANU003.png`

**Text:**  
The staircase leads into an ancient temple lined with black jackal statues. Their golden collars remain bright despite the dust, and each statue slowly turns its head to watch you. A narrow path leads toward a circular opening in the floor, while a side room glitters with masks, ceremonial blades and piles of gold. Behind you, the staircase has disappeared and the wall now shows a carving shaped exactly like you. The voice below asks, “What did you come here seeking?”

### Choices

- **Follow the jackal statues** → `ANU-004`
- **Search the temple for treasure** → `ANU-013`

---

## ANU-004 — The Voice Below

**Suggested image:** `ANU004.png`

**Text:**  
You descend a spiral staircase that circles a shaft with no visible bottom. The voice follows beside you and asks why you entered the temple. As you continue downward, the steps show flashes of your own life: small acts of kindness, lies that were never discovered and moments when fear controlled you. Far below, two amber eyes open in the darkness. The voice speaks again, this time with greater force. “Answer.”

### Choices

- **Answer honestly** → `ANU-005`
- **Lie about why you are here** → `ANU-005`

---

## ANU-005 — Anubis Revealed

**Suggested image:** `ANU005.png`

**Text:**  
The staircase opens into a hall so large that the ceiling disappears into darkness. At its centre stands Anubis, dressed in black and gold with glowing amber eyes. Behind him is a shattered set of scales, with one pan cracked on the floor and the central balance stone torn from its frame. Shadowy souls drift through open gates while something enormous growls from behind the pillars. Anubis tells you that the scales used to judge the dead have been stolen and that you must recover the missing pieces before the boundary between life and death collapses.

### Choices

- **Kneel and listen** → `ANU-006`
- **Demand to be released** → `ANU-007`

---

## ANU-006 — Terms of Judgment

**Suggested image:** `ANU006.png`

**Text:**  
Anubis raises his hand and shows you visions of the three missing pieces: the Feather Arm, the Heart Pan and the Balance Stone. He explains that fear, greed and rebellion have carried them into different parts of the underworld. If you return them, the dead can be judged again and the gates between worlds can be closed. When you ask what happens to you, Anubis says that an honest heart may return to the living, but anyone seeking a reward must first understand its price.

### Choices

- **Agree to restore the scales** → `ANU-008`
- **Agree only for a reward** → `ANU-008`

---

## ANU-007 — Refuse the God

**Suggested image:** `ANU007.png`

**Text:**  
You tell Anubis that you did not choose this and demand to be sent home. He warns you that the doorway only opens for people already standing between important choices. Around you, the wandering souls briefly take the faces of people you know, including some who cannot possibly be dead. Anubis explains that the broken scales have already begun affecting the living world and that soon even he may be unable to return you. A doorway appears behind you, leading into a corridor of pale fog filled with voices calling your name.

### Choices

- **Accept after Anubis warns you** → `ANU-008`
- **Flee into the darkness** → `ANU-017`

---

# Act II — The Broken Underworld

## ANU-008 — River of the Dead

**Suggested image:** `ANU008.png`

**Text:**  
The first gate opens beside a river of black water. Faces, hands and broken objects drift beneath the surface, while the opposite bank glows beneath an archway of blue fire. A bronze bell hangs beside an empty dock, and far downstream a thin boat approaches. A faceless ferryman stands at the back, guiding it with a long black pole. As the boat gets closer, the water begins whispering in voices you recognise.

### Choices

- **Call for the ferryman** → `ANU-009`
- **Swim through the black water** → `ANU-010`

---

## ANU-009 — The Ferryman’s Price

**Suggested image:** `ANU009.png`

**Text:**  
The ferryman reaches the dock without disturbing the water. He is wrapped in wet linen and has no face, but the empty spaces where his eyes should be reflect moments from your past. He tells you that passage requires a memory, a promise or fear. In his hand appears a bright memory of sunlight, laughter and safety that you immediately recognise as your own. Nearby, a trapped soul presses against the river’s surface and reaches toward the boat.

### Choices

- **Give the ferryman a memory** → `ANU-010`
- **Threaten the ferryman** → `ANU-010`

---

## ANU-010 — Hall of Whispers

**Suggested image:** `ANU010.png`

**Text:**  
Beyond the river is a maze of stone passages covered in thousands of names. Some are royal, some ordinary and some have been scratched away completely. Whispering voices fill the hall with excuses, confessions and forgotten memories. A golden light shines from behind a sealed door marked with the symbol of the Feather Arm, but from a side passage you hear someone crying and begging for help. The voice says that they still remember their name, but not for much longer.

### Choices

- **Follow the crying voice** → `ANU-011`
- **Ignore the voices and seek the scales** → `ANU-012`

---

## ANU-011 — The Crying Soul

**Suggested image:** `ANU011.png`

**Text:**  
You find a trapped soul pinned beneath a heavy stone tablet. Their body changes between a child, an old woman and a wounded soldier as the hall steals pieces of their identity. They tell you that they were waiting for judgment when the scales broke and that they will soon forget their own name. Freeing them will take time, but they promise to tell you what they know about Ammit and the stolen pieces if you help them.

### Choices

- **Free the trapped soul** → `ANU-012`
- **Leave the soul trapped** → `ANU-012`

---

## ANU-012 — Feather Arm Chamber

**Suggested image:** `ANU012.png`

**Text:**  
The sealed door opens into a circular room where the golden Feather Arm floats above a shaft of blue fire. Painted figures kneel around the walls holding their hearts in their hands, but their shadows move on their own. Deep scratches cross the floor and lead toward a hidden passage behind the murals. A low growl moves through the stone as the Feather Arm slowly turns within reach.

### Choices

- **Lift the Feather Arm** → `ANU-013`
- **Inspect the shadows** → `ANU-014`

---

## ANU-013 — Golden Scarab Vault

**Suggested image:** `ANU013.png`

**Text:**  
A hidden wall opens into a vault filled with gold masks, jewels and statues of forgotten gods. At the centre, a golden scarab rests beneath a beam of white light. It feels warm and beats like a living heart. A whisper tells you that carrying it could change the balance of judgment, but you also sense that something trapped inside the scarab wants to be released.

### Choices

- **Take the Golden Scarab and continue** → `ANU-014`
- **Leave the treasure untouched** → `ANU-014`

---

## ANU-014 — Chamber of Stolen Hearts

**Suggested image:** `ANU014.png`

**Text:**  
The hidden passage leads into a red chamber where thousands of human hearts hang in glass containers from the ceiling. Each one is marked with a name and shows flashes of the life it belonged to. As you move between them, you discover a container carrying your own name, with a heart inside beating in time with your chest. Behind the platform, a massive broken chain disappears through a doorway and a deep growl answers every heartbeat in the room.

### Choices

- **Search the suspended hearts** → `ANU-015`
- **Cut the chains holding the hearts** → `ANU-016`

---

## ANU-015 — Ammit Unchained

**Suggested image:** `ANU015.png`

**Text:**  
You enter a chamber covered in claw marks and come face to face with Ammit. She has the head of a crocodile, the front of a lion and the body of a hippopotamus, with broken chains hanging from her limbs. Ammit tells you that Anubis calls her a monster even though the gods created her to devour hearts that fail judgment. She lowers her huge head toward you and asks why she should not begin with yours.

### Choices

- **Calm Ammit and speak without fear** → `ANU-016`
- **Attack Ammit and escape** → `ANU-016`

---

## ANU-016 — The Broken Chain

**Suggested image:** `ANU016.png`

**Text:**  
At the far side of Ammit’s chamber, you find a section of her broken chain lying across the path. The links were cut cleanly, proving that someone released her on purpose. When you touch the chain, you see a vision of an underworld scribe removing the Heart Pan while a hidden figure watches. A fragment of dark power floats above the broken metal, offering you the choice to repair part of the chain or take its power for yourself.

### Choices

- **Repair the broken chain** → `ANU-017`
- **Leave the chain and continue** → `ANU-017`

---

# Act III — Memory and Temptation

## ANU-017 — Maze of False Memories

**Suggested image:** `ANU017.png`

**Text:**  
The passage disappears into thick white fog and the walls begin changing whenever you look away. Doors open onto places from your past, including your childhood home, crowded streets and rooms containing people you once knew. Anubis warns from somewhere far away that names disappear first, then faces and finally purpose. Two paths form ahead: one leads toward a warm memory of home, while the other leads toward the memory of your greatest failure.

### Choices

- **Follow the memory of home** → `ANU-018`
- **Follow the memory of your greatest failure** → `ANU-019`

---

## ANU-018 — Memory of Home

**Suggested image:** `ANU018.png`

**Text:**  
You enter a perfect memory of home, complete with familiar light, sounds and the feeling of being safe. Someone you once loved enters the room and tells you that you have finally returned. Everything feels real, except their shadow points in the wrong direction and the walls flicker whenever you stop looking at them. The figure reaches out and asks you not to leave again.

### Choices

- **Accept that the memory may be false** → `ANU-020`
- **Stay inside the memory** → `END-LOST`

---

## ANU-019 — Memory of Failure

**Suggested image:** `ANU019.png`

**Text:**  
The maze forces you to relive a moment when you failed someone, acted out of fear or allowed another person to carry the cost of your choice. The scene repeats until everyone turns to face you. A voice asks whose fault it was, while the maze offers you several people to blame. Behind them, the path forward begins closing.

### Choices

- **Admit responsibility** → `ANU-020`
- **Blame someone else** → `ANU-020`

---

## ANU-020 — The Heart Pan

**Suggested image:** `ANU020.png`

**Text:**  
The fog clears and reveals a chamber shaped like the inside of a giant heart. The missing Heart Pan hangs at the centre, held above thousands of names carved into the floor. Some of the names belong to the dead, while others belong to people who have not yet been born. Your own name appears beneath your feet beside the name of an underworld scribe, suggesting that your arrival was recorded long before the scales were broken.

### Choices

- **Recover the Heart Pan** → `ANU-021`
- **Examine the names beneath it** → `ANU-021`

---

## ANU-021 — The Scribe’s Secret

**Suggested image:** `ANU021.png`

**Text:**  
A hidden door leads to an underworld scribe surrounded by endless rolls of papyrus. His face is covered by a blank mask that fills with moving words whenever he speaks. He shows you a scroll describing every choice you have made and says that your arrival was written before you were born. When you ask who allowed the scales to break, he tells you that truth must be purchased with trust, force or memory.

### Choices

- **Trust the underworld scribe** → `ANU-022`
- **Threaten the scribe** → `ANU-022`

---

## ANU-022 — The True Name

**Suggested image:** `ANU022.png`

**Text:**  
The scribe brings you into a dark chamber where stars form the shape of a jackal. He explains that the gods once had titles powerful enough to command the laws of creation. He then teaches you the hidden title of Anubis: He Who Opens the Final Door and Must Obey the Balance. Speaking it could command parts of the underworld, while keeping it secret would leave you with a weapon that no one knows you possess.

### Choices

- **Speak Anubis’s hidden title** → `ANU-023`
- **Keep the name secret** → `ANU-023`

---

## ANU-023 — The Rebel’s Offer

**Suggested image:** `ANU023.png`

**Text:**  
A masked rebel steps from behind the scribe’s scrolls and claims that the gods use judgment to protect their own power. They show you visions of frightened souls being weighed, forgotten workers waiting without names and kings passing easily into eternity. The rebel offers you underworld power and asks you to restore the scales only long enough to decide whether Anubis deserves to keep control of them.

### Choices

- **Reject the rebel’s offer** → `ANU-024`
- **Accept the rebel’s offer** → `ANU-024`

---

## ANU-024 — Balance Stone Chamber

**Suggested image:** `ANU024.png`

**Text:**  
The final piece floats above a machine of turning stone rings. The Balance Stone is small enough to fit in your hand, but the entire room leans around it. A giant guardian made from stone and linen stands beside the mechanism with a ceremonial blade. Its face has been erased and it warns that only the judged may carry balance. You can either carefully unlock the mechanism or tear the stone free before the guardian attacks.

### Choices

- **Take the Balance Stone carefully** → `ANU-025`
- **Rip it from the guardian mechanism** → `ANU-025`

---

## ANU-025 — The Final Guardian

**Suggested image:** `ANU025.png`

**Text:**  
The guardian blocks the exit as cracks spread across its body. It says that it was created to protect the Balance Stone and now has no purpose without it. The room begins collapsing behind you while the guardian lowers its weapon and asks you to judge what should happen to it. You can spare it, destroy it or use Anubis’s hidden title to command it.

### Choices

- **Spare the final guardian** → `ANU-026`
- **Destroy the final guardian** → `ANU-026`

---

# Act IV — Judgment

## ANU-026 — Return to the Hall

**Suggested image:** `ANU026.png`

**Text:**  
The three recovered pieces begin pulling toward one another and open a doorway back to the Hall of Judgment. Anubis waits beside the broken scales while countless souls gather in the darkness. Ammit watches from behind the pillars, and the rebel’s words remain in your mind. Anubis extends his hand and orders you to return the pieces, but you now understand that carrying them gives you power over the future of the underworld.

### Choices

- **Return the scale pieces honestly** → `ANU-028`
- **Hide one piece and bargain** → `ANU-027`

---

## ANU-027 — The Weighing Begins

**Suggested image:** `ANU027.png`

**Text:**  
The restored scales rise from the floor with the feather of Ma’at resting on one side and the empty Heart Pan waiting on the other. Anubis stands beside the balance while Ammit watches from the shadows. Every lie, act of mercy, moment of greed and sacrifice returns to your mind as your heart begins burning inside your chest. Anubis reaches out his hand and orders you to place your heart upon the scales.

### Choices

- **Submit to Anubis’s judgment** → `END-AMMIT`
- **Challenge Anubis and reject judgment** → `END-REBEL`

---

## ANU-028 — Final Decision

**Suggested image:** `ANU028.png`

**Text:**  
You return every piece of the scales to Anubis and the sacred balance begins rebuilding itself. Your heart rises from your chest and floats above the empty pan while the feather of Ma’at waits on the other side. Anubis tells you that this is your final chance to accept judgment honestly. You can allow the scales to decide your fate or interfere with the balance before it settles.

### Choices

- **Accept honest judgment** → `END-TRUE`
- **Manipulate the scales** → `END-TRICKSTER`

---

# Endings

## END-TRUE — The Scales Restored

**Ending ID:** `anubis_true_restored`  
**Classification:** Win / Best Ending  
**Suggested image:** `ENDTRUE.png`

**Text:**  
Your heart leaves your chest and appears in Anubis’s hand as a sphere of red light. He places it on the restored scales and, after one frightening moment, it balances perfectly with the feather of Ma’at. The gates of judgment open, forgotten souls remember their names and the stolen hearts return to their owners. Anubis tells you that a light heart is not empty, but one that accepts fear, failure and responsibility without placing those burdens on others. He returns your heart and sends you back to the desert, where a small golden feather remains in your hand. As the temple disappears beneath the sand, his voice tells you, “Live as one who has already been weighed.”

### Outcome Text

**The Scales Restored**

You returned all three sacred pieces, faced judgment honestly and proved that mercy and responsibility can outweigh fear.

Anubis has returned you to the living world with his blessing.

---

## END-AMMIT — Devoured by Ammit

**Ending ID:** `anubis_dark_ammit`  
**Classification:** Death  
**Suggested image:** `ENDAMMIT.png`

**Text:**  
Anubis places your heart on the scales, but it immediately sinks beneath the weight of every lie, betrayal and selfish choice. The feather rises and the sound of the failed judgment echoes through the hall. You try to explain your actions, but Anubis tells you that the scales do not compare you with others; they only reveal what you chose to carry. Ammit opens her jaws and devours your heart in a single bite. Your memories disappear, then your name, followed by every future you might have lived.

### Outcome Text

**Devoured by Ammit**

Your heart outweighed the feather.

The Devourer has consumed your soul, leaving no name, memory or path back to the living world.

---

## END-REBEL — Defy the Gods

**Ending ID:** `anubis_rebel_escape`  
**Classification:** Dark Win / Sequel Hook  
**Suggested image:** `ENDREBEL.png`

**Text:**  
You refuse to place your heart on the scales as underworld power gathers around the broken Hall of Judgment. Anubis warns that you have confused power with freedom, but you strike the Balance Stone and split the scales apart. The hall collapses as souls escape through every gate and Ammit roars in triumph. You tear open a doorway and return to the desert beneath a sky filled with red stars. The stolen power remains beneath your skin, your shadow now has the head of a jackal and the dead begin whispering your name as their liberator.

### Outcome Text

**Defy the Gods**

You rejected divine judgment, broke the sacred mechanism and escaped with stolen underworld power.

You are free for now, but the consequences have followed you home.

---

## END-TRICKSTER — Cheat the Scales

**Ending ID:** `anubis_trickster_cheat`  
**Classification:** Secret Lose / Sequel Hook  
**Suggested image:** `ENDTRICKSTER.png`

**Text:**  
You place your heart on the scales while speaking the forbidden title you learned in the underworld. The Balance Stone turns backwards and the scales falsely declare your heart lighter than the feather. You escape through the gate to the living world before Anubis can stop you. Once you reach the desert, a crack of darkness opens in the air behind you. A tall ancient creature steps through the opening and causes every shadow in the desert to turn toward it.

### Outcome Text

**Cheat the Scales**

You manipulated the balance and escaped judgment.

But your deception opened a path for an ancient presence to enter the living world.

Survival is not always victory.

---

## END-LOST — Lost Soul

**Ending ID:** `anubis_lost_soul`  
**Classification:** Lose  
**Suggested image:** `ENDLOST.png`

**Text:**  
You continue walking through the fog, knowing that there was once a task you needed to complete, but you can no longer remember what it was. Memories of home have become empty rooms, faceless people and warmth without a source. Other forgotten souls walk beside you, each trying and failing to remember their own name. The ferryman waits beside the black river, but he asks for no payment because you have nothing left to give. Somewhere in the distance, Anubis calls for the living traveller who entered his temple, but you no longer understand that he means you.

### Outcome Text

**Lost Soul**

The underworld took your final memory.

Without a name, a past or a purpose, you have joined the procession of forgotten souls.

---

# Static Route Safeguards

1. Preserve all node and ending IDs.
2. Keep exactly two choices on every `ANU` story page.
3. Each choice must have one fixed destination.
4. Do not add state effects, counters, inventory, conditions or random ending logic.
5. Verify that every destination exists.
6. Verify that all 28 story pages remain reachable through at least one route.
7. Verify that all five endings remain reachable.
8. Save progress after entering each page.
9. Record completed endings across app launches.
10. Restarting this story must not erase completed endings or progress from other stories.
