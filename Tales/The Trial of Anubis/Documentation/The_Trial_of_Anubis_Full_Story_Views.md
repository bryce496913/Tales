# The Trial of Anubis — Full Story View Script

**Story ID:** `trial-of-anubis`  
**Canonical source:** `The_Trial_of_Anubis_Story_Architecture.md`  
**Purpose:** Complete narrative copy, choice labels, route destinations, conditions, and state effects for all story views.

> Implementation rule: State effects are applied once when the player selects a choice, before routing to the destination node. After every memory loss, immediately check whether `memoriesRemaining <= 0` and route to `END-LOST`.

---

# Act I — The Summons

## ANU-001 — The Silent Desert

The desert is silent.

No wind moves across the dunes. No insects stir beneath the sand. Even the stars have vanished, leaving the sky as black and empty as a sealed tomb.

The only sound is the slow beat of your own heart.

You do not remember falling asleep. You do not remember walking here. Yet behind you, a trail of footprints stretches across the cold sand until it disappears into darkness.

Ahead, half-buried beneath a dune, stands a doorway of polished black stone.

Jackal-headed figures are carved around its frame. Each holds a feather in one hand and a human heart in the other. Their painted golden eyes seem to follow you as you approach.

A thin crack appears between the doors.

Sand spills inward, although there is no wind.

Then the doorway opens by itself.

A voice speaks from somewhere deep below.

“Your heart has been expected.”

### Choices

#### Approach the black doorway
- Destination: `ANU-002`
- Effects: None

#### Walk away into the desert
- Destination: `ANU-003`
- Effects: `memoriesRemaining -= 1`
- Feedback: *A memory slips away before you can name it.*

---

## ANU-002 — The Black Doorway

You stop at the threshold.

Beyond the doorway, a staircase descends into darkness. Blue flames burn in shallow bowls along the walls, but they give off no heat. Their light reveals hieroglyphs cut so deeply into the stone that they resemble wounds.

The carvings show a great scale standing between two worlds.

On one side, the living kneel beneath the sun.

On the other, the dead wait beneath a field of stars.

At the center stands a jackal-headed god, holding the balance steady.

But the final image has been violently destroyed. The scale is broken. The dead pour upward. A many-jawed beast rises beneath them.

From somewhere below comes the scrape of stone against stone.

Then the voice speaks again.

“You may enter willingly.”

A pause.

“Or you may enter afraid.”

The blue flames lean toward the staircase as though caught in a breath from below.

### Choices

#### Enter the doorway
- Destination: `ANU-003`
- Effects: None

#### Call into the darkness
- Destination: `ANU-004`
- Effects: None

---

## ANU-003 — The Jackal Temple

Whether you entered the doorway or tried to escape the desert, the path has brought you here.

The staircase ends inside a buried temple.

Rows of black jackal statues line the chamber. Each sits upright with its paws together and its ears raised. Their golden collars are untouched by dust.

Between them, a narrow path leads toward a circular opening in the floor.

To your right, a side chamber glitters with reflected gold. You see the outline of treasure chests, ceremonial blades, jeweled masks, and a single scarab resting beneath a beam of pale light.

Behind you, the staircase is gone.

There is only a wall carved with your own silhouette.

The jackal statues turn their heads toward you one by one.

From the opening in the floor, the hidden voice says:

“Choose what you came seeking.”

### Choices

#### Follow the jackal statues
- Destination: `ANU-004`
- Effects: None

#### Search the temple for treasure
- Destination: `ANU-013`
- Effects: `heartWeight += 1`
- Feedback: *A pleasant weight settles behind your ribs.*

---

## ANU-004 — The Voice Below

The circular opening leads to a spiral stair cut around a shaft without a visible bottom.

As you descend, the voice travels beside you.

It does not echo. It speaks as if its mouth were beside your ear.

“Why did you enter my temple?”

The question should have a simple answer.

Curiosity.

Fear.

An accident.

But each explanation fades before you can speak it. You sense that the voice is not asking how you arrived. It is asking what part of you opened the door.

The blue flames along the stair brighten.

For an instant, every step bears a different memory from your life: a kindness no one noticed, a lie that was never discovered, a moment you fled, a moment you stayed.

Far below, two amber eyes open in the darkness.

“Answer.”

### Choices

#### Answer honestly
You admit that you do not fully know. Perhaps you were curious. Perhaps afraid. Perhaps some part of you wanted to be chosen.

- Destination: `ANU-005`
- Effects: `heartWeight -= 1`
- Feedback: *Your heart beats more freely.*

#### Lie about why you are here
You invent a noble purpose and speak it with confidence.

- Destination: `ANU-005`
- Effects:
  - `heartWeight += 1`
  - `liedToAnubis = true`
- Feedback: *The lie settles inside you like a stone.*

---

## ANU-005 — Anubis Revealed

The stair opens into a hall so vast that its ceiling disappears into darkness.

Thousands of unlit braziers surround a platform of black stone. At its center stands a figure taller than any man.

His body is wrapped in black and gold linen. Obsidian armor covers his shoulders and chest. His head is that of a jackal, and his eyes glow like embers beneath a funeral moon.

Anubis.

Behind him rests a broken scale.

One pan lies cracked upon the floor. The other is missing. The central balance stone has been torn from its frame, leaving jagged fractures across the sacred mechanism.

Beyond the platform, shadowy figures drift through open gates. Some cry for names they have forgotten. Others whisper names that belong to the living.

Anubis looks down at you.

“The dead no longer wait for judgment,” he says. “The scales have been shattered, and their pieces carried into the broken places of my realm.”

He steps closer.

“Without judgment, memory decays. The dead cross into life. The living are drawn toward death.”

A growl rolls through the hall.

In the darkness behind the scale, something enormous shifts its chains.

“You will return what was taken.”

### Choices

#### Kneel and listen
- Destination: `ANU-006`
- Effects: `allegiance = anubis`

#### Demand to be released
- Destination: `ANU-007`
- Effects: `allegiance = self`

#### Ask what power is offered
- Destination: `ANU-006`
- Effects:
  - `allegiance = rebel`
  - `heartWeight += 1`
- Feedback: *Anubis notices the hunger behind your question.*

---

## ANU-006 — Terms of Judgment

Anubis raises one hand.

Three images form in the air between you.

The first is a long golden arm shaped like a feather. It turns slowly inside a hall crowded with whispering souls.

The second is a dark bronze pan suspended above thousands of beating hearts.

The third is a stone carved with the symbol of balance, guarded by a creature whose face has been erased.

“The Feather Arm. The Heart Pan. The Balance Stone.”

The images fracture and vanish.

“These pieces were not stolen by one hand,” Anubis says. “Fear took one. Greed took another. Rebellion claimed the last.”

You look toward the open gates.

“And if I restore them?”

“The dead will return to judgment.”

“And me?”

Anubis studies you in silence.

“If your purpose is honest, you will return to the living.”

His eyes narrow.

“If you seek payment, name it only after you understand the price.”

Behind him, the chained creature exhales. The braziers tremble.

### Choices

#### Agree to restore the scales
- Destination: `ANU-008`
- Effects:
  - `allegiance = anubis`
  - `heartWeight -= 1`
- Feedback: *The path ahead feels terrible, but clear.*

#### Agree only for a reward
- Destination: `ANU-008`
- Effects:
  - `allegiance = self`
  - `heartWeight += 1`
- Feedback: *The promise of reward follows you into the dark.*

---

## ANU-007 — Refuse the God

“I did not choose this,” you say. “Send me back.”

The amber light in Anubis’s eyes dims.

“You entered a door that opens only for those already standing between choices.”

“I am alive.”

“For now.”

He gestures toward the drifting souls beyond the platform. Among them, you glimpse familiar faces—people you know, people you have lost, and people who cannot possibly be dead.

The vision changes too quickly to trust.

“The collapse has touched your world,” Anubis says. “Each moment the scales remain broken, the boundary weakens. Soon, returning you will be beyond even my power.”

A doorway appears behind you.

It leads not to the desert but into a corridor filled with pale fog. Within it, voices call your name in tones of love, accusation, and grief.

“You may still refuse,” Anubis says. “But refusal is also a choice, and every choice is weighed.”

### Choices

#### Accept after Anubis warns you
- Destination: `ANU-008`
- Effects: None

#### Flee into the darkness
- Destination: `ANU-017`
- Effects: `memoriesRemaining -= 1`
- Feedback: *You run toward a voice you recognize and forget why it mattered.*

---

# Act II — The Broken Underworld

## ANU-008 — River of the Dead

The first gate opens onto the bank of a black river.

Its surface reflects no light. Shapes drift beneath it—hands, faces, crowns, broken weapons, and fragments of houses that vanished centuries ago.

The opposite bank lies beneath an archway of blue fire.

Between you and it, the river moves without sound.

A narrow dock extends into the water. A bronze bell hangs from a post beside it. There is no boat, but deep grooves in the wood suggest that one has arrived here countless times.

As you approach, the water whispers with stolen voices.

Some beg you to enter.

Some warn you not to touch it.

One voice sounds exactly like your own.

Far downstream, a thin boat moves through the darkness. A faceless figure stands at its stern, guiding it with a long black pole.

### Choices

#### Call for the ferryman
You strike the bronze bell.

- Destination: `ANU-009`
- Effects: None

#### Swim through the black water
- Destination: `ANU-010`
- Effects:
  - `memoriesRemaining -= 1`
  - `heartWeight += 1`
- Feedback: *The river takes something from you and leaves cold anger in its place.*

---

## ANU-009 — The Ferryman’s Price

The boat reaches the dock without disturbing the water.

The ferryman is wrapped in damp linen. No face shows beneath the cloth. Where eyes should be, two shallow hollows hold shifting reflections of your past.

He extends one hand.

“Passage has a price.”

“I have no coin.”

“Coin is for the living.”

The ferryman opens his palm.

Inside it lies a small, bright memory: sunlight through a window, laughter in another room, the feeling of being safe without knowing why.

It is yours.

The ferryman closes his fingers around it.

“A memory,” he says. “A promise. Or fear.”

The river behind him fills with pale faces.

One of them presses against the surface near the boat, unable to rise.

“Choose what you can afford to lose.”

### Choices

#### Give the ferryman a memory
- Destination: `ANU-010`
- Effects: `memoriesRemaining -= 1`
- Feedback: *You know something precious is gone, but not what it was.*

#### Promise to free a trapped soul
- Destination: `ANU-010`
- Effects: Set mercy oath flag
- Feedback: *The ferryman accepts your promise as though it were already a deed.*

#### Threaten the ferryman
- Destination: `ANU-010`
- Effects: `heartWeight += 2`
- Feedback: *The ferryman obeys, but every face beneath the water turns toward you.*

---

## ANU-010 — Hall of Whispers

Beyond the river stands a hall made from thousands of narrow stone passages.

Every wall is carved with names.

Some are royal. Some ordinary. Some have been scratched away so thoroughly that only scars remain.

Whispers move through the corridors.

“I was forgotten.”

“I was innocent.”

“I was feared.”

“I was loved.”

“I did what I had to.”

The voices overlap until they become a wind of confession.

Ahead, a faint golden light pulses behind a sealed door. The symbol carved above it matches the Feather Arm shown by Anubis.

But from a passage to your left comes the sound of someone crying.

Not the distant sorrow of the dead. This is close, frightened, and exhausted.

“Please,” the voice says. “I still remember my name.”

The golden light brightens, urging you onward.

### Choices

#### Follow the crying voice
- Destination: `ANU-011`
- Effects: None

#### Ignore the voices and seek the scales
- Destination: `ANU-012`
- Effects: `heartWeight += 1`
- Feedback: *The crying stops. Your footsteps sound heavier.*

---

## ANU-011 — The Crying Soul

You find a young soul pinned beneath a fallen stone tablet.

Their form flickers between ages. A child reaches for you, then an old woman, then a soldier covered in dust. Their face cannot decide which life it belongs to.

Chains of written names bind the tablet to the floor.

“I was crossing for judgment when the hall broke,” the soul says. “The whispers are stealing me. Soon I will not remember which name is mine.”

The golden chamber lies close. You can feel the first scale piece beyond the wall.

Freeing the soul will take time.

The soul notices your hesitation.

“I know where the beast was chained,” they say quickly. “I heard the thieves speaking. Help me, and I will tell you.”

The whispers crowd closer.

Some urge mercy.

Others say the dead have already had their lives.

### Choices

#### Free the trapped soul
You break the chains without asking for anything.

- Destination: `ANU-012`
- Effects:
  - `savedLostSoul = true`
  - `heartWeight -= 2`
- Feedback: *The soul remembers its name. Your heart feels almost weightless.*

#### Ask the soul for information first
You demand the truth before lifting the stone, then free them.

- Destination: `ANU-012`
- Effects:
  - `savedLostSoul = true`
  - `heartWeight -= 1`
- Feedback: *Mercy given with conditions is still mercy, though not without weight.*

#### Leave the soul trapped
- Destination: `ANU-012`
- Effects: `heartWeight += 2`
- Feedback: *The soul calls after you until the whispers take its voice.*

---

## ANU-012 — Feather Arm Chamber

The sealed door opens into a circular chamber.

At its center, suspended above a shaft of blue fire, rests the Feather Arm of the sacred scale. It is longer than your body, made of gold so pale it appears almost white.

The arm turns slowly, although nothing supports it.

Around the chamber, painted figures kneel with their hearts held open in their hands.

The shadows behind them move independently.

As you step closer, one painted figure turns its head.

A low growl passes through the walls.

You sense a hidden passage beyond the murals, leading deeper into the underworld. Scratches in the floor suggest that something with heavy claws was dragged through it.

The Feather Arm waits within reach.

### Choices

#### Lift the Feather Arm
- Destination: `ANU-013`
- Effects: `firstScalePieceRecovered = true`
- Feedback: *The first piece answers your touch with a clear metallic note.*

#### Inspect the shadows
You recover the Feather Arm, then follow the claw marks and discover signs that Ammit’s chains were broken from the outside.

- Destination: `ANU-014`
- Effects:
  - `firstScalePieceRecovered = true`
  - Learn Ammit clue
- Feedback: *The beast may not have freed itself.*

---

## ANU-013 — Golden Scarab Vault

A hidden wall slides aside.

Beyond it lies a vault untouched by decay.

Gold masks stare from shelves. Ceremonial cups overflow with jewels. Small statues of forgotten gods stand in rows, their names deliberately chiseled away.

At the center of the room, beneath a narrow beam of white light, rests a golden scarab.

Unlike the other treasure, it is warm.

When you pick it up—or merely draw close—you hear a heartbeat inside it.

A voice whispers:

“Carry me, and no balance need bind you.”

The scarab’s wings open slightly. Light leaks from beneath them, revealing tiny symbols of alteration, concealment, and false measure.

You understand without knowing how: this object could interfere with sacred judgment.

It could also be destroyed.

Something trapped inside it wants to be released.

### Choices

#### Take the Golden Scarab
- Destination: `ANU-014`
- Effects:
  - `tookGoldenScarab = true`
  - `heartWeight += 2`
- Feedback: *The scarab is small, but your heart strains beneath its weight.*

#### Leave the treasure untouched
- Destination: `ANU-014`
- Effects: `heartWeight -= 1`
- Feedback: *The vault loses its hold on you.*

#### Break the scarab and release the light
You crush it beneath the Feather Arm. A bright spirit escapes and wraps you briefly in protective fire.

- Destination: `ANU-014`
- Effects:
  - `heartWeight -= 1`
  - Gain protection flag
- Feedback: *The released light circles you once, then disappears beneath your skin.*

---

## ANU-014 — Chamber of Stolen Hearts

The hidden passage opens into a red-black cavern.

Thousands of human hearts hang from chains descending from the ceiling.

Some beat slowly.

Some race in panic.

Some are still.

Each is enclosed within a glass vessel marked with a name. The chains converge above a stone platform where the missing Heart Pan once rested.

A deep vibration moves through the chamber, and every heart beats at once.

You step among them.

Faces appear in the glass—not faces of the dead, but memories belonging to them. A mother holding a child. A thief burying stolen bread. A ruler ordering a death. A stranger offering shelter.

Then you see a vessel bearing your own name.

Inside it, a heart beats in perfect time with the one in your chest.

Behind the platform, a massive chain disappears through a broken doorway.

A growl answers the heartbeat.

### Choices

#### Search the suspended hearts
You examine your own vessel and learn that part of your judgment has already begun.

- Destination: `ANU-015`
- Effects: Learn that one heart is yours

#### Cut the chains holding the hearts
You strike the bindings. Dozens of vessels descend safely to the floor, freeing their hearts from the machinery.

- Destination: `ANU-016`
- Effects: `heartWeight -= 1`
- Feedback: *The freed hearts beat together like distant applause.*

---

## ANU-015 — Ammit Unchained

The broken doorway leads into a chamber scored by claws.

Ammit rises from the darkness.

Her head is that of a crocodile, broad and armored. Her forequarters belong to a lion, her hind body to a hippopotamus. Broken chains drag from her limbs, each link carved with a divine name.

Her jaws open.

Inside them, you see no throat—only a depth filled with fading stars.

“The living one,” she says.

Her voice is not the roar you expected. It is old, tired, and hungry beyond reason.

“You carry judgment’s scent.”

She lowers her head until one golden eye fills your vision.

“Anubis calls me monster. Yet he made hunger my purpose. He weighs the heart. I carry out the sentence.”

Her claws close around the stone beside you.

“Tell me why I should not begin with yours.”

### Choices

#### Calm Ammit and speak without fear
You acknowledge her hunger without surrendering to it.

- Destination: `ANU-016`
- Effects: `heartWeight -= 1`
- Feedback: *For one breath, the Devourer remembers restraint.*

#### Attack Ammit
You strike as she lunges and tear loose one of her black fangs.

- Destination: `ANU-016`
- Effects:
  - `possessesAmmitFang = true`
  - `heartWeight += 2`
- Feedback: *The fang burns in your hand. Ammit’s roar follows you.*

#### Offer the Golden Scarab
**Condition:** Available only when `tookGoldenScarab == true`.

Ammit bites down on the scarab. Its false heartbeat shatters, satisfying her hunger long enough for you to escape.

- Destination: `ANU-016`
- Effects:
  - `tookGoldenScarab = false`
  - `heartWeight -= 2`
- Feedback: *A burden leaves your heart as the scarab disappears between her jaws.*

---

## ANU-016 — The Broken Chain

You reach the far side of Ammit’s chamber.

A section of her sacred chain lies across the path. Several links have been cut cleanly, not broken by force. Black energy leaks from the severed names carved into the metal.

When you touch the chain, you see a vision.

A robed scribe kneels beside the scales.

A hidden figure whispers from behind a veil.

The scribe removes the Heart Pan.

Ammit’s chain breaks.

Then the vision ends.

A fragment of dark power floats above the severed link. It pulses like smoke held inside glass.

You could repair the chain, restoring part of the order that contained Ammit.

Or you could take the fragment.

Its power would belong to no god once held by a living hand.

### Choices

#### Repair the broken chain
- Destination: `ANU-017`
- Effects: `heartWeight -= 1`
- Feedback: *A divine name seals beneath your hand. Ammit’s distant roar grows quieter.*

#### Take a fragment of underworld power
- Destination: `ANU-017`
- Effects:
  - `acceptedUnderworldPower = true`
  - `heartWeight += 1`
- Feedback: *Cold power enters your blood and refuses to leave.*

---

# Act III — Memory and Temptation

## ANU-017 — Maze of False Memories

The passage narrows, then dissolves into fog.

Walls appear only when you look away from them. Doors open onto places that cannot exist beneath the desert: your childhood home, a crowded street, a room where someone waits with their back turned.

The maze is built from memory.

Not all of it is yours.

You hear Anubis’s warning in the distance:

“Names decay first. Then faces. Then purpose.”

Two paths form.

To the left, warm light spills from an open doorway. You smell familiar food and hear laughter from a time when the world felt safe.

To the right, a cold corridor leads toward a moment you have tried not to remember. At its end, someone says your name with disappointment.

The fog closes behind you.

There is no path that avoids the past.

### Choices

#### Follow the memory of home
- Destination: `ANU-018`
- Effects: None

#### Follow the memory of your greatest failure
- Destination: `ANU-019`
- Effects: None

---

## ANU-018 — Memory of Home

You step into a place you know.

Every detail is perfect.

The angle of sunlight. The worn edge of a table. The sound of someone moving in the next room. A familiar voice calls you by a name spoken with affection.

For a moment, the underworld feels impossible.

You could stay here.

No scales. No gods. No hungry beast. No judgment.

A person you once loved—or still love—enters the room. Their face is exactly as you remember it, except their shadow points in the wrong direction.

“You came back,” they say.

Behind them, the wall flickers.

For an instant, you see the maze feeding on the memory, copying it each time you look away.

The figure reaches for your hand.

“Do not leave again.”

### Choices

#### Accept that the memory may be false
You let the scene break rather than surrender to the comfort it offers.

- Destination: `ANU-020`
- Effects: `heartWeight -= 1`
- Feedback: *Truth hurts, but it does not own you.*

#### Stay inside the memory
The figure embraces you. Warmth becomes fog. When you awaken, a piece of your life is missing.

- Destination: `ANU-019`
- Effects: `memoriesRemaining -= 1`
- Feedback: *You remember being loved, but not by whom.*

---

## ANU-019 — Memory of Failure

The corridor opens onto a moment you wish had happened differently.

The maze changes its details to fit you.

Perhaps someone trusted you and you failed them.

Perhaps fear made you silent.

Perhaps pride made you cruel.

Perhaps you chose the easier path and allowed another person to bear the cost.

The scene repeats.

This time, everyone turns to look at you.

A voice asks:

“Whose fault was it?”

The question is unfair. No failure belongs to one person alone. There were circumstances, pressures, mistakes made by others.

The maze offers faces to blame.

Each waits silently for you to choose one.

Behind them, the path to the Heart Pan begins to close.

### Choices

#### Admit responsibility
You name your part without claiming blame that is not yours.

- Destination: `ANU-020`
- Effects: `heartWeight -= 1`
- Feedback: *The memory remains painful, but it stops controlling the path.*

#### Blame someone else
The chosen face fades. So does another piece of your own memory.

- Destination: `ANU-020`
- Effects:
  - `heartWeight += 1`
  - `memoriesRemaining -= 1`
- Feedback: *The maze accepts your accusation and takes a truth in exchange.*

---

## ANU-020 — The Heart Pan

The fog collapses.

You stand in a chamber shaped like the inside of a heart.

Bronze walls contract with a slow, rhythmic pulse. At the center hangs the missing Heart Pan, suspended by threads of red light.

Beneath it, thousands of names are carved into the floor.

Some are crossed out.

Some repeat.

Some belong to people not yet born.

The pan lowers when you approach.

Its surface reflects not your face, but every version of you that might have existed: kinder, crueler, braver, more afraid.

A line of fresh writing appears beneath your feet.

It is your name.

Beside it is a second name you do not recognize, followed by the symbol of a royal scribe.

The Heart Pan waits to be claimed.

### Choices

#### Recover the Heart Pan
- Destination: `ANU-021`
- Effects: `secondScalePieceRecovered = true`
- Feedback: *The second piece joins the first with a deep bronze tone.*

#### Examine the names beneath it
You recover the pan and discover that the theft was recorded before it occurred, suggesting a conspiracy within the Hall of Judgment.

- Destination: `ANU-021`
- Effects:
  - `secondScalePieceRecovered = true`
  - Gain conspiracy clue
- Feedback: *Someone planned the breaking of the scales long before your arrival.*

---

## ANU-021 — The Scribe’s Secret

A hidden door opens behind the Heart Pan.

Inside sits an underworld scribe surrounded by endless rolls of papyrus.

His body is thin and birdlike. Ink stains his hands to the wrists. A blank mask covers his face, but words move across it as he speaks.

“I recorded your arrival,” he says.

“You knew I was coming?”

“I recorded it before you were born.”

He gestures to a scroll bearing your name.

Lines of writing describe choices you have already made. Below them, the text continues—but the future lines rearrange whenever you try to read them.

“The scales were not merely stolen,” the scribe says. “They were allowed to break.”

“By Anubis?”

The words on his mask scatter.

“Truth has a cost. Trust, force, or memory. Those are the currencies left to us.”

He places one ink-black finger on the scroll.

“Choose how you wish to learn.”

### Choices

#### Trust the underworld scribe
- Destination: `ANU-022`
- Effects: None

#### Threaten the scribe
- Destination: `ANU-022`
- Effects: `heartWeight += 1`
- Feedback: *The scribe reveals the truth, but records the threat beside your name.*

#### Trade a memory for the truth
- Destination: `ANU-022`
- Effects: `memoriesRemaining -= 1`
- Feedback: *The scribe takes a memory and writes it into a scroll you may never read.*

---

## ANU-022 — The True Name

The scribe leads you into a chamber without walls.

Above, constellations form the shape of a jackal.

Below, the darkness reflects them perfectly.

“In the beginning,” the scribe says, “the gods were not called by the names mortals gave them. Their true titles were commands written into creation.”

He speaks a phrase too vast to understand.

The stars bend.

You feel the hidden title of Anubis settle into your mind—not his ordinary name, but the name that means:

**He Who Opens the Final Door and Must Obey the Balance.**

The knowledge is dangerous.

Spoken openly, it could compel the mechanisms of judgment.

Kept secret, it remains a weapon no one knows you possess.

The scribe’s mask turns blank.

“Now the name belongs to you.”

### Choices

#### Speak Anubis’s hidden title
You test the words. The darkness trembles, and distant gates open.

- Destination: `ANU-023`
- Effects: `learnedTrueName = true`
- Feedback: *The underworld hears you.*

#### Keep the name secret
You bury the title in silence.

- Destination: `ANU-023`
- Effects:
  - `learnedTrueName = true`
  - `heartWeight -= 1`
- Feedback: *Power withheld weighs less than power displayed.*

---

## ANU-023 — The Rebel’s Offer

The constellations vanish.

A figure steps from behind the scribe’s hanging scrolls.

They wear the broken mask of a priest and carry a staff carved from one of Ammit’s old chains. Their body shifts between human and shadow.

“I wondered which path you would take,” the rebel says.

The scribe lowers his head but does not interfere.

“The gods call this disorder,” the rebel continues. “But what is judgment except power made sacred by repetition?”

Images appear around you.

Anubis weighing frightened souls.

Ammit devouring those deemed unworthy.

Kings passing into eternity while forgotten laborers wait without names.

“The scales do not measure goodness,” the rebel says. “They measure obedience to an order built by those who control the balance.”

A shard of underworld power forms above their palm.

“Take the final piece. Return to the Hall. Then decide whether any god deserves to judge you.”

### Choices

#### Reject the rebel’s offer
- Destination: `ANU-024`
- Effects: `allegiance = anubis`
- Feedback: *Whatever its flaws, you choose to restore the order before deciding its future.*

#### Accept power to challenge Anubis
- Destination: `ANU-024`
- Effects:
  - `acceptedUnderworldPower = true`
  - `allegiance = rebel`
  - `heartWeight += 1`
- Feedback: *Power gathers around you like a second shadow.*

#### Pretend to accept
- Destination: `ANU-024`
- Effects:
  - `allegiance = self`
  - `heartWeight += 1`
- Feedback: *You offer the rebel a lie and keep your purpose hidden.*

---

## ANU-024 — Balance Stone Chamber

The final chamber lies at the center of a ruined temple.

The Balance Stone floats above a mechanism of interlocking rings. It is small enough to hold in one hand, yet the entire chamber leans around it.

On one side, dust falls upward.

On the other, blue flame pours like water.

Guarding the mechanism is a towering figure made of stone and linen. Its face has been erased, leaving a smooth surface marked only by a vertical crack.

As you enter, the guardian raises a ceremonial blade.

“Only the judged may carry balance,” it says.

“I have not been judged.”

“Then you may not leave.”

The rings turn faster.

The Balance Stone pulses in time with your heart.

You see two ways to take it: patiently release the locking seals, or tear it free before the guardian strikes.

### Choices

#### Take the Balance Stone carefully
You align the rings and release the stone without breaking the mechanism.

- Destination: `ANU-025`
- Effects: `finalScalePieceRecovered = true`
- Feedback: *The final piece settles into your palm without resistance.*

#### Rip it from the guardian mechanism
You seize the stone. The rings fracture, and the chamber lurches violently.

- Destination: `ANU-025`
- Effects:
  - `finalScalePieceRecovered = true`
  - `heartWeight += 1`
- Feedback: *You have the piece, but the chamber begins to die around you.*

---

## ANU-025 — The Final Guardian

The guardian blocks the only exit.

Cracks spread across its body. Through them, pale light reveals thousands of trapped names.

“I was made to protect balance,” it says. “Without the stone, I have no purpose.”

Its blade lowers slightly.

“Return it.”

Behind you, the chamber collapses one ring at a time.

You could destroy the guardian and escape.

You could spare it, risking pursuit.

Or, with the true title of Anubis, you might command the guardian to recognize a new purpose.

The guardian kneels on one cracked leg.

“Judge me, living one.”

### Choices

#### Spare the final guardian
You refuse to destroy a being whose purpose has already been taken from it.

- Destination: `ANU-026`
- Effects: `heartWeight -= 1`
- Feedback: *The guardian lowers its blade and opens the path.*

#### Destroy the final guardian
You strike the central crack. The guardian shatters, releasing the names trapped within it.

- Destination: `ANU-026`
- Effects: `heartWeight += 2`
- Feedback: *The path opens through violence. The released names do not thank you.*

#### Command it using the true name
**Condition:** Available only when `learnedTrueName == true`.

You invoke Anubis’s hidden title and command the guardian to protect the path between judgment and mercy.

- Destination: `ANU-026`
- Effects: None
- Feedback: *The guardian bows to a law older than obedience.*

---

# Act IV — Judgment

## ANU-026 — Return to the Hall

The three scale pieces resonate.

The Feather Arm shines in pale gold.

The Heart Pan beats with a sound like distant thunder.

The Balance Stone pulls them toward one another.

A doorway opens, returning you to the Hall of Judgment.

Anubis waits beside the broken scale.

Around him, countless souls crowd the darkness. Some recognize the pieces and begin to kneel. Others recoil as though they hoped judgment would never return.

Ammit watches from behind the pillars.

The rebel’s words remain with you.

So does the scribe’s secret name.

Anubis extends his hand.

“You have crossed fear, hunger, memory, and power,” he says. “Return the pieces.”

The hall grows still.

You understand that you are no longer merely carrying the scales.

You are carrying leverage.

### Choices

#### Return the scale pieces to Anubis
- Destination: `ANU-027`
- Effects: None

#### Hide one piece and bargain
You conceal part of the mechanism and demand safe passage, reward, or authority.

- Destination: `ANU-027`
- Effects:
  - `heartWeight += 1`
  - `allegiance = self`
- Feedback: *Anubis accepts the bargain’s existence, but not its innocence.*

#### Enter the Hall of Judgment armed
**Condition:** Available when `possessesAmmitFang == true` or `acceptedUnderworldPower == true`.

- Destination: `ANU-027`
- Effects: `allegiance = rebel`
- Feedback: *The souls draw back. Even Anubis shifts his stance.*

---

## ANU-027 — The Weighing Begins

The restored scales rise from the floor.

The Feather Arm locks into place.

The Heart Pan hangs opposite the feather of Ma’at.

The Balance Stone turns once, and the entire underworld becomes still.

Anubis stands beside the scale.

Behind him, Ammit lowers herself to the floor, watching with terrible patience.

Every promise you made returns to you.

Every lie.

Every act of mercy.

Every moment you chose yourself over another.

Every truth you accepted when a lie would have been easier.

Your heart burns inside your chest as though it knows it is being called.

Anubis extends one hand.

“Place your heart upon the scales.”

The hidden title of the god waits behind your teeth.

The Golden Scarab, if you still possess it, gives a false heartbeat.

The Fang of Ammit aches with dark power.

The final choice is yours, but it is not the only choice that matters.

### Choices

#### Submit to honest judgment
- Destination: `ANU-028`
- Effects: Set final choice to `honestJudgment`

#### Challenge Anubis
- Destination: `ANU-028`
- Effects: Set final choice to `rebel`

#### Manipulate the scales
- Destination: `ANU-028`
- Effects:
  - Set final choice to `cheat`
  - `heartWeight += 2`
- Feedback: *The scale moves before your heart touches it.*

---

## ANU-028 — Final Decision

This node contains no ordinary story choices.

The Hall of Judgment reacts to the player’s accumulated state. The final choice determines what the player attempts, but the result is resolved from all prior actions.

### Deterministic Ending Order

1. If `memoriesRemaining <= 0` → `END-LOST`
2. Strong rebel route → `END-REBEL`
3. Strong trickster route → `END-TRICKSTER`
4. Full true-ending route → `END-TRUE`
5. If `heartWeight >= 4` → `END-AMMIT`
6. Weaker valid rebel route → `END-REBEL`
7. Weaker valid cheat route → `END-TRICKSTER`
8. Fallback:
   - `heartWeight <= 1` → `END-TRUE`
   - otherwise → `END-AMMIT`

Before displaying the ending, record the ending ID as reached.

---

# Terminal Endings

## END-TRUE — The Scales Restored

**Ending ID:** `anubis_true_restored`  
**Classification:** Win / Best Ending

Your heart leaves your chest without pain.

It appears in Anubis’s hand as a sphere of living red light. Within it move every choice you made: the soul you freed, the treasure you refused or surrendered, the truths you accepted, the fear you carried without allowing it to rule you.

Anubis places the heart upon the pan.

The scales move.

For one terrible moment, your heart sinks.

Ammit raises her head.

Then the feather descends to meet it.

The balance becomes still.

Across the Hall of Judgment, every gate opens at once.

The waiting dead begin to move. Names return to forgotten faces. The stolen hearts rise from their vessels and pass like red stars through the darkness.

Anubis studies the balance.

“A light heart is not an empty heart,” he says. “It carries grief, failure, fear, and responsibility. It becomes light when it refuses to place those burdens upon others.”

He returns your heart.

The instant it enters your chest, the Hall fills with dawn.

You stand again in the desert before the black doorway.

Wind moves across the dunes.

Stars burn overhead.

In your hand lies a small feather of gold.

Behind you, the doorway sinks beneath the sand.

Yet just before it disappears, Anubis’s voice reaches you one final time.

“Live as one who has already been weighed.”

### Outcome Text

**The Scales Restored**

You returned all three sacred pieces, faced judgment honestly, and proved that mercy and responsibility can outweigh fear.

Anubis has returned you to the living world with his blessing.

---

## END-AMMIT — Devoured by Ammit

**Ending ID:** `anubis_dark_ammit`  
**Classification:** Death

Your heart appears in Anubis’s hand.

It is darker than you expected.

Gold clings to it. Broken promises circle it like chains. Every lie has become a mark upon its surface. Every act of cruelty has weight. Every moment you chose power without responsibility presses downward.

Anubis places it on the scale.

The pan falls.

The feather rises.

The sound of the imbalance travels through the hall like a funeral bell.

Ammit stands.

You try to speak.

Perhaps you offer an explanation. Perhaps you insist that your intentions were misunderstood. Perhaps you remind Anubis that others have done worse.

But the scale does not measure comparison.

It measures what you carried here.

Anubis closes his eyes.

“Judgment is not punishment,” he says. “It is revelation.”

Ammit’s jaws open.

Inside them is a darkness deeper than death.

She devours your heart in a single bite.

There is no pain.

Pain requires a self to experience it.

Your memories vanish first. Then your name. Then the shape of everything you might have become.

The last thing you hear is the restored scale settling into balance.

### Outcome Text

**Devoured by Ammit**

Your heart outweighed the feather.

The Devourer has consumed your soul, leaving no name, memory, or path back to the living world.

---

## END-REBEL — Defy the Gods

**Ending ID:** `anubis_rebel_escape`  
**Classification:** Dark Win / Sequel Hook

You do not place your heart upon the scale.

Instead, you raise the Fang of Ammit.

Underworld power coils around your arm. The Hall darkens as every stolen fragment you accepted answers your command.

Anubis’s eyes blaze.

“You mistake power for freedom.”

“And you mistake authority for justice.”

You strike the Balance Stone.

The Fang cuts through divine law as though it were flesh.

The scales split.

A shockwave tears across the Hall of Judgment. Pillars crack. Gates burst open. Souls scatter toward every road at once.

Ammit roars—not in hunger, but triumph.

Anubis reaches for you.

You speak the first word of rebellion, and the stolen power tears a doorway into the living world.

You step through.

The desert receives you beneath a sky filled with red stars.

The black doorway collapses behind you, but the power does not remain below.

It lives beneath your skin.

Your shadow now has the head of a jackal.

Far away, dogs begin barking.

Mirrors darken.

The dead whisper your name with hope and fear.

You escaped judgment.

But the boundary between worlds is weaker than before, and something in the underworld has begun calling you its liberator.

### Outcome Text

**Defy the Gods**

You rejected divine judgment, broke the sacred mechanism, and escaped with stolen underworld power.

You are free—for now—but the consequences have followed you home.

---

## END-TRICKSTER — Cheat the Scales

**Ending ID:** `anubis_trickster_cheat`  
**Classification:** Secret Lose / Sequel Hook

You place your heart upon the pan.

At the same moment, you whisper Anubis’s hidden title.

The god freezes.

Not from fear.

From command.

The Golden Scarab opens inside your hand and releases its false heartbeat into the scale.

The Balance Stone turns backward.

Your heart rises.

The feather falls.

For one impossible instant, the scales declare you pure.

The Hall erupts with whispers.

Anubis strains against the power of his true name.

“You do not understand what you have altered.”

“I understand enough.”

The gates to the living world open.

You reclaim your heart and step through before the command breaks.

The desert air feels warm and real. Stars shine overhead. Your body is alive.

You survived.

Then the Golden Scarab splits open.

There was never a spirit trapped inside it.

There was a door.

A thin shape unfolds from the broken shell—too tall, too narrow, wearing a face assembled from pieces of people you remember.

It smiles.

Behind you, Anubis shouts a warning from a world already closing.

The creature touches the sand.

Every shadow in the desert turns toward it.

You cheated the scales.

And something ancient used your lie to pass judgment with you.

### Outcome Text

**Cheat the Scales**

You manipulated the balance and escaped judgment.

But your deception opened a path for an ancient presence to enter the living world.

Survival is not always victory.

---

## END-LOST — Lost Soul

**Ending ID:** `anubis_lost_soul`  
**Classification:** Lose

You are walking through fog.

You know there was a task.

Something broken.

Three pieces, perhaps.

A voice once spoke your name, but the name no longer belongs to anyone you recognize.

You try to remember home.

There is a room without a location.

A face without features.

Warmth without a source.

The memories fall apart when you reach for them.

Other souls move beside you.

Some whisper fragments of themselves.

“I had a daughter.”

“I built something.”

“I was afraid.”

“I was called…”

None can finish.

A faceless ferryman waits beside a black river.

He does not ask for payment.

You have nothing left to give.

Across the water, the Hall of Judgment glows with distant gold. Somewhere within it, Anubis calls for the living traveler who entered his temple.

You want to answer.

You cannot remember that he means you.

The procession moves forward.

Your footsteps join the sound of thousands.

Soon, even the desire to remember is gone.

### Outcome Text

**Lost Soul**

The underworld took your final memory.

Without a name, a past, or a purpose, you have joined the procession of forgotten souls.

---

# Conditional Choice Visibility Summary

The following choices must only appear when their requirements are met:

- `ANU-015` — **Offer the Golden Scarab**
  - Requires `tookGoldenScarab == true`

- `ANU-025` — **Command it using the true name**
  - Requires `learnedTrueName == true`

- `ANU-026` — **Enter the Hall of Judgment armed**
  - Requires `possessesAmmitFang == true` or `acceptedUnderworldPower == true`

The final choices at `ANU-027` may remain visible to all players. The ending router determines whether the attempted rebellion or manipulation succeeds fully, succeeds at a cost, or fails.

---

# State Feedback Copy

Use these accessible messages after significant choices:

| State change | Suggested feedback |
|---|---|
| `heartWeight -= 1` | Your heart feels lighter. |
| `heartWeight -= 2` | A great burden lifts from your heart. |
| `heartWeight += 1` | A weight settles in your chest. |
| `heartWeight += 2` | Your heart grows dangerously heavy. |
| `memoriesRemaining -= 1` | A memory slips beyond your reach. |
| Scale piece recovered | A piece of the sacred scales has been recovered. |
| `savedLostSoul = true` | The soul remembers its name. |
| `tookGoldenScarab = true` | The scarab beats with a borrowed pulse. |
| `possessesAmmitFang = true` | You carry the Fang of the Devourer. |
| `acceptedUnderworldPower = true` | Underworld power now answers you. |
| `learnedTrueName = true` | You have learned the hidden title of Anubis. |

---

# Implementation Safeguards

1. Preserve every node ID exactly as written.
2. Apply effects only when a choice is selected.
3. Never reapply effects when restoring a saved node.
4. Clamp `heartWeight` to `-6...6`.
5. Check for the Lost Soul ending after every memory loss.
6. Record each recovered scale piece persistently.
7. Keep all five endings reachable.
8. Record the ending before presenting reset or menu actions.
9. Resolve `ANU-028` from the complete accumulated state.
10. Do not replace the ending router with direct final-button navigation.
