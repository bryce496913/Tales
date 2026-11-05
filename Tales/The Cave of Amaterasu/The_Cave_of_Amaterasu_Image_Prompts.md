# The Cave of Amaterasu — Image Prompts

Prompts for generating the page art `AMA000` … `AMA047`, which is still placeholder. They are written to match the finished `AMA-Icon` and `AMA-Title-Screen-Art`, and the scenes follow the **Art** notes and page text in `The_Cave_of_Amaterasu_Story_Map.md`. If a page changes there, update its prompt here too.

## How to use

1. Start each image with the **Style block** below, then add that page's **Scene** prompt. For a character, paste the description from the **Character sheet**. That keeps every character looking the same from page to page.
2. Generate it square, 1024 × 1024, with **no text, letters, captions or borders** in the image. The page title is drawn by the app.
3. If your generator allows it, attach `AMA-Title-Screen-Art` (and pages you've already generated) as a style reference.
4. Import the result into the asset catalog as an 85% JPEG with the right name:

```bash
python3 scripts/art/import_art.py ~/Downloads/AMA012.png
```

   A file with a different name can be passed as `AMA012=~/Downloads/image-7.png`. The script replaces the placeholder and rewrites `Contents.json`. Then run `python3 scripts/release_readiness_checks.py`.

5. Once all 48 pages are done, remove “Page art is placeholder for now” from the README and the story map.

## Style block

> Storybook illustration for a Japanese-mythology adventure game. Clean digital painting with bold dark-indigo outlines, flat cel shading with soft gradients and light paper texture, in the style of a modern illustrated children’s book. Palette: deep indigo and sumi-ink black night skies, slate-blue rocks, warm lantern gold, vermilion lacquer red, washi cream, touches of sakura pink. Strong glowing light sources against the dark. Simple readable shapes, centred composition, square format. No text, no letters, no lettering, no border, no watermark.

**Mood by page type**

- *Story pages:* night throughout until `041`. Lanterns, torches, foxfire and sacred-treasure glow are the only light sources.
- *Death endings* (`008`, `013`, `038`): show the danger or what is left behind, never gore or a body. Use red-black tones.
- *Lose endings* (`003`, `004`, `011`, `021`, `044`, `046`): quiet, grey-blue, still, sad.
- *Bittersweet endings* (`030`, `045`): warm sunlight, but the traveller is alone. Add sakura pink.
- *Dark win* (`047`): beautiful and unsettling, with sunshine, rain and lavender shadows.
- *Best ending* (`043`): the only page that is fully bright: morning gold, blue sky, green rice.

## Character sheet

Paste these descriptions word for word whenever a character appears.

- **The traveller (the player):** a young villager of about fourteen, seen mostly from behind or at a distance so any player can be them. Short dark hair tied back with a cord, an indigo-dyed hemp jacket over a plain grey kimono, white leggings, straw sandals, a small cloth bundle on the back. Always carries **grandmother’s bell**: a cluster of small brass bells on a red braided cord.
- **Grandmother:** a small, elderly shrine priestess with white hair tied low, in a white haori over red hakama, kind and stern.
- **The white fox:** a slim pure-white kitsune with golden eyes, a sly smile and a small floating blue flame above the tip of its tail. In human form (only `047`): a handsome young man in white robes with golden fox eyes and white hair.
- **Sarutahiko:** a giant god with a bright red face, a very long nose, shining mirror-like eyes, a wild grey beard, a dark green robe with a rope sash, arms folded.
- **The weaving maiden:** a pale, half-transparent young woman in a white robe, hair loose, tired eyes. You can see the loom through her.
- **Omoikane:** a thin old god with a long white beard to his waist, a tall black court hat, pale grey robes and a wooden staff.
- **Ame-no-Uzume:** a laughing goddess of dawn with round cheeks, her hair in loops with sakaki leaves, in a pale peach robe with long sleeves tied back by a red cord.
- **Tajikarao:** a huge, bare-chested god of strength, built like a mountain, with arms like tree trunks, a shaggy black beard, a white loincloth and rope belt.
- **Amaterasu:** as on the title art: a young goddess with very long wavy black hair, a gold sunburst crown with gold flowers and red tassels, white and red layered robes with a gold sun emblem, skin that glows with soft golden light.
- **Susanoo:** a huge storm god with a long, tangled black mane and beard full of leaves, a ragged dark blue robe, faint lightning flickering around him, a lost and sorrowful face.
- **Sōjōbō, King of the Tengu:** a towering tengu with a red face, a long branch-like nose, a white beard to his belt, a small black yamabushi cap, white mountain-priest robes and great black wings, holding a feather fan.
- **Crow-tengu (karasu-tengu):** small figures with crow heads, black beaks and bright eyes, black wings and white-and-black mountain-priest robes, with little wooden swords.
- **The old turtle:** a small, ancient sea turtle with a mossy shell and kind, wise eyes. When it carries the traveller, it is huge.
- **Otohime:** a graceful princess of the sea in layered robes of sea-foam green and pearl, with a coral hair ornament.
- **Ryūjin, the Dragon King:** a colossal Eastern sea dragon with green-bronze scales, a beard like seaweed, eyes as large as rice bowls and whiskers that drift in the water.
- **Ashinazuchi, Tenazuchi and Kushinada:** an old farmer and his wife in worn brown and grey kimono, and their daughter, a young woman in a pale blue kimono with a wooden comb in her hair.
- **Yamata no Orochi:** a gigantic serpent with eight heads on eight long necks, dark moss-green scales, red eyes like winter cherries, cypress trees and moss growing on its back, and eight tails.

**The three treasures**

- **Eight-Hand Mirror:** a bronze mirror as wide as a cartwheel, its rim shaped like an eight-petalled flower, with a bright silver surface.
- **Curved Jewels:** a string of comma-shaped magatama jewels in deep green and red that glow like coals.
- **Sword of the Gathering Clouds:** a straight, double-edged sword of bright steel with storm light crackling faintly along the blade.

**Places that recur:** the **Heavenly Rock Cave** is a cliff of black rock with a huge rounded boulder sealing its mouth and a thin thread of gold light leaking around the boulder’s edge. A sacred straw rope with white paper zigzags hangs above it, with a vermilion torii nearby (as on the title art).

---

## Pages

### AMA000 — The Morning Without a Sun
A small rice-farming village of thatched-roof houses at the foot of a dark, forested mountain under a starless black sky. White frost covers the rice paddies, and the river is still. Every house is shuttered, with only faint firelight through cracks. High on the hillside above, a tiny wooden shrine with one warm glowing lantern is the only bright point in the image. Wide establishing shot, cold blue tones against one spot of gold.

### AMA001 — Grandmother’s Shrine
Inside a small wooden shrine at night. **Grandmother** kneels before a simple altar lit by a paper lantern and candles, her breath visible in the cold. She holds out **grandmother’s bell** in both hands toward the viewer (the traveller’s hands reach in from the bottom of the frame). Sakaki branches and white paper streamers on the altar. Warm gold light on her face, deep indigo shadows behind.

### AMA002 — The Night Parade
A mountain path through tall bamboo at night, with a procession of yokai coming toward the viewer: glowing paper lanterns with one big eye and lolling tongues, old paper umbrellas hopping on one leg, a woman whose very long neck lifts her head above the crowd, red-faced horned oni carrying a lacquered palanquin. Drums and festival flags, an orange and red lantern glow, playful but eerie. In the foreground the traveller’s silhouette crouches behind bamboo, seen from behind.

### AMA003 — The Endless Night *(lose)*
The steps of the small dark shrine. The traveller sits alone, seen from behind, ringing **grandmother’s bell** up at an empty black sky. The lantern beside them is burnt out, a thin wisp of smoke rising from it. Below, the village is empty and frozen, with no lit windows. Grey-blue and silent, very still.

### AMA004 — Joined the Night Parade *(lose)*
The tail end of the yokai procession disappearing into a dark forest, lanterns glowing orange among the trunks. At the very end of the line walks the traveller, holding a paper lantern, face blank and eyes empty, following without looking back. One-eyed lantern yokai look back over their shoulders at them. Grey-blue forest, warm lantern light only on the procession.

### AMA005 — The White Fox
A mossy stone path in a bamboo forest at night. **The white fox** sits in the middle of the path facing the viewer, its tail curled around it with the blue flame floating above the tip and lighting the stones in cool blue. Its golden eyes look amused. Mist between the bamboo, a few fallen leaves. Calm after the parade.

### AMA006 — The Foxfire Trail
A fork in a dark mountain path around an ancient, enormous cedar with a sacred rope tied around it. To the left, one dim, flickering pale-blue light drifts down a narrow path. To the right, a bright, warm golden light floats invitingly toward a gap in the trees. Behind the viewer’s position, two more small lights glow in the dark. The traveller stands at the fork, seen from behind, holding **grandmother’s bell**.

### AMA007 — The God of the Crossing
The rocky summit of a mountain at night, with an old leaning wooden shrine. From the rock, a bridge of mist and pale rainbow light rises in a long arc into the starry sky. Standing in front of the bridge is **Sarutahiko**, enormous, arms folded, looking down. The traveller is tiny at the bottom of the frame, looking up at him. Low angle to show his size.

### AMA008 — Led Astray by Foxfire *(death)*
The edge of a cliff in the dark, with wet ferns and loose stones at the brink and a bright, warm floating light hovering out over empty black space beyond the edge. Among the trees in the background, the silhouette of a fox with a blue flame watches. No person in the image. Red-black and deep indigo, ominous.

### AMA009 — The Floating Bridge of Heaven
Looking down from high above: a small figure (the traveller) crosses a swaying bridge of mist and faint rainbow light that climbs over a sea of clouds. Far below through gaps in the clouds, the dark islands of Japan lie in shadow, with a few small yokai fires in the forests and an ink-black sea, and one tiny warm lantern glowing on a hillside. Stars above. Dreamy and vast.

### AMA010 — The Ruined Weaving Hall
Inside a great wooden hall on the High Plain of Heaven at night, its roof torn open to the stars. Smashed looms lie on the floor, and silver silk threads trail everywhere, catching the starlight. At the one loom still standing sits **the weaving maiden**, weaving with no cloth appearing. Through the broken wall, far across a dark plain, a crowd of torches flickers. Silver and indigo, ghostly.

### AMA011 — The Endless Loom *(lose)*
The same ruined hall. The traveller and **the weaving maiden** sit side by side at the loom, weaving, seen from behind and to the side. Behind them, the half-finished cloth unravels into a growing tangle of loose silver threads across the floor. The distant torches are faint and far away. Quiet, grey-blue, endless.

### AMA012 — The Council of the Gods
A huge crowd of gods in robes and court hats holding torches, gathered before a cliff of black rock beside a starry river (the Heavenly River). At the foot of the cliff is the **Heavenly Rock Cave**, the great boulder with a thread of golden light leaking around its edge. In front, **Omoikane** raises his hand to quiet the crowd and looks toward the traveller, small in the foreground. Torchlight orange against black rock.

### AMA013 — Looked Upon the Sun *(death)*
Close-up of the great boulder at the mouth of the cave. Blinding white-gold light bursts from the crack around its edge in sharp rays. On the stone beside the crack, the dark shape of a hand is scorched into the rock. No person, and no face of the goddess. Overwhelming white and gold against black stone.

### AMA014 — HOME — The Heavenly Rock Cave
The edge of the High Plain of Heaven beside the **Heavenly Rock Cave** at night. From the edge, three roads of white cloud unroll down to the dark earth far below: the left one toward a forested mountain with a glint of silver at its top, the middle one toward a black sea, the right one toward a river valley between dark hills. **Ame-no-Uzume** sits on an overturned wooden tub beside the sealed cave, tapping her foot. **Omoikane** stands nearby with his staff, and the traveller stands at the head of the three roads, seen from behind.

### AMA015 — The Cedars of Kurama
The foot of Mount Kurama at night: giant ancient cedars climb into darkness. A steep, mossy stone stairway runs straight up the mountain, lit by a few stone lanterns. Beside it, a narrower dirt path winds through huge tangled cedar roots. Near the summit, through a gap in the trees, there is a bright silver glint like moonlight on water. Black wing shapes among the high branches.

### AMA016 — The Crow-Tengu
Halfway up the lantern-lit stone stairway. A dozen **crow-tengu** hop on the steps around the viewer, peering curiously, holding little wooden swords, wings half-spread, beaks open as if cawing. Giant cedars around them. Mischievous and a little threatening. The traveller is in the foreground, seen from behind.

### AMA017 — The Hollow of the Hidden
A deep, soft hollow among enormous cedar roots, carpeted with moss and lit by faint glowing mushrooms and fireflies. People from many ages sit peacefully, smiling vaguely with dreamy eyes: a farmer in straw sandals and a straw hat, a samurai in old-fashioned lacquered armour, a child holding a paper kite. The traveller stands at the edge holding **grandmother’s bell**. Peaceful but subtly wrong.

### AMA018 — The Hall of Sōjōbō
A hall of black cedar beams at the summit of the mountain, with paper lanterns. On a raised platform at the far end sits **Sōjōbō, King of the Tengu**, wings folded, fan in hand. Behind him, hanging from a beam, the **Eight-Hand Mirror** shines silver in the dark. **Crow-tengu** line both sides of the hall. The traveller stands small in the foreground. Symmetrical, imposing.

### AMA019 — The Mirror’s Truth
The traveller, muddy and scratched, stands in front of the giant **Eight-Hand Mirror**, seen from behind and to one side. In the mirror is their reflection, and around it, faint dreamlike scenes swirl like smoke: a mountain path, a glowing lantern on a hillside, an old priestess. The crow-tengu watch silently in the shadows. Silver light, introspective.

### AMA020 — The Eight-Hand Mirror
In the cedar hall, **Sōjōbō** bows to the traveller, his fan lowered. Behind them, two **crow-tengu** lift the great **Eight-Hand Mirror** down from its beam and wrap it in black silk; silver light still spills out from the edge of the cloth. Warm lantern light, a feeling of respect.

### AMA021 — Hidden by the Tengu *(lose)*
Split composition. Top and centre: the traveller asleep, curled up on soft moss in the cedar hollow among the smiling, dreamy spirited-away people, **grandmother’s bell** lying forgotten in the moss. Bottom corner, small and far away: a pair of straw sandals hanging on the door of a small village shrine. Grey-green and blue, hushed.

### AMA022 — The Shore of Night
A black-sand beach under a starless sky, with dark silent waves and no horizon. Down by the water, a few village children with sticks laugh around a small, old sea turtle flipped on its back, its flippers waving. Further along the beach, a small wooden fishing boat is pulled up on the sand, with two oars, a wooden bucket and a long-handled ladle inside. The traveller is in the foreground, seen from behind. A single fire on the beach gives warm light.

### AMA023 — The Turtle’s Back
Underwater. The traveller rides on the shell of the now-huge **old turtle**, holding on, as it dives through deep, dark blue water full of bubbles. Far below, the warm glow of a palace: towers of coral and pearl and gates of red lacquer. Rays of light from the palace reach up through the water. Wonder and adventure.

### AMA024 — The Sea Monk
A tiny wooden fishing boat on a black, glassy sea at night, seen from behind the traveller in the boat. In front of the boat, the sea rises into a colossal dark, bald, round-headed shadow figure (an umibōzu) as big as a temple, with no mouth and two huge, pale glowing eyes. Water streaming off it. The bucket and the bottomless ladle in the boat. Vast and eerie.

### AMA025 — The Dragon Palace
The gates of an undersea palace: coral towers, mother-of-pearl roofs and red lacquer gates, softly glowing. In the courtyards, fish in silk robes bow. Through gateways on both sides you can see four gardens in four seasons: cherry blossoms, summer green, red maples and snow. **Otohime** steps forward with open arms to welcome the traveller. Bubbles, warm golden and coral light; the most colourful page so far.

### AMA026 — The Dragon King
A towering undersea hall whose ceiling is lost in dark water. **Ryūjin, the Dragon King** is coiled around its great red pillars, his head lowered toward the viewer. Around his neck hangs the string of **Curved Jewels**, glowing green and red. **Otohime** and the traveller stand small at the bottom of the frame. Teal-green and bronze, majestic.

### AMA027 — The Feast Beneath the Waves
A lavish undersea banquet: low red-lacquer tables covered in dishes, fish servants in silk robes pouring drinks, musicians, **Otohime** dancing with sleeves flowing. The traveller sits on silk cushions, holding a cup, relaxed and dreamy. Through a large round window, the garden outside changes from cherry blossom on one side to autumn maple on the other. Warm, seductive, timeless.

### AMA028 — The Turtle Remembers
Low angle under the banquet table: **the old turtle** peeks out from beneath the tablecloth and nudges the traveller’s knee with its head. A cup has fallen from the traveller’s hand and spills across the floor. The bright feast continues above, out of focus. A sense of sudden alarm.

### AMA029 — The Curved Jewels
In the great hall, **Ryūjin** lowers his head and lets the string of glowing **Curved Jewels** slip from his neck into the traveller’s raised hands. Beside them, **Otohime** holds out a small black lacquered box tied with a red cord. Warm light from the jewels on all their faces. Grave and generous.

### AMA030 — Three Hundred Years *(bittersweet)*
Bright sunlight on a forested hillside on a clear blue day. The traveller stands, seen from behind, before a moss-covered memorial stone carved with writing (the carving should be just texture, with no readable letters). In the distance below, a town of stone and grey tile roofs sits by the sea, where a fishing village used to be. Sakura petals drift. Beautiful but lonely.

### AMA031 — The Chopsticks in the River
A fast, black river between dark pine-covered mountains at night, with mist on the water. A pair of wooden chopsticks floats on the current toward the viewer, catching a little light. On the far bank, a ruined thatched hut with a warm glow inside. The traveller stands on the near bank, seen from behind. Cold, damp, a little menacing.

### AMA032 — The Exiled God
Inside a ruined hut, **Susanoo** slumps among broken sake jars, a jar in one hand, hair and beard tangled with leaves, faint blue lightning flickering around his shoulders. He is enormous even sitting down. His expression is lost and ashamed, like a boy who has broken something. Through a hole in the roof, dark clouds. The traveller stands in the doorway.

### AMA033 — The Weeping House
Inside a shuttered farmhouse lit by a single oil lamp. **Ashinazuchi and Tenazuchi** sit weeping on either side of **Kushinada**, who sits upright and brave with the wooden comb in her hair. Rice sacks and sake-brewing tubs in the shadows. The traveller stands in the doorway. Warm, small lamplight against a heavy dark.

### AMA034 — The Eight Gates
A huge night scene: a wooden fence with eight gates around a farmhouse, a great vat of sake set in each gate. **Yamata no Orochi** fills the background over the hills, each of its eight heads plunged into a vat, drinking. Cypress trees grow on its back. The traveller crouches in the shadow of the fence in the foreground, holding an old rusty sword. Torchlight and red eyes.

### AMA035 — The Eight-Headed Serpent
The traveller, small, stands with a rusty sword raised as all eight heads of **Yamata no Orochi** rear up together to face them, sixteen red eyes glowing in the dark. A tail as thick as a tree trunk sweeps across the ground, throwing up dirt. Knocked-over vats. Behind, in the lit doorway of the farmhouse, **Kushinada** shouts. Red and black, chaotic and dangerous.

### AMA036 — The Serpent Sleeps
**Yamata no Orochi** is asleep: its eight heads slump in empty vats around the fence, and its huge body stretches away over the hills. The traveller walks carefully along its back between the cypress trees, toward its eight tails at the far end; one tail glows faintly blue from inside, like a lantern behind a paper screen. Quiet night, stars, a held breath.

### AMA037 — The Sword of the Gathering Clouds
The **Sword of the Gathering Clouds** slides out of the cut-open, glowing serpent tail, crackling with faint storm light and lighting the traveller’s face from below. The broken rusty sword lies in two pieces on the scales. In the background, **Ashinazuchi, Tenazuchi and Kushinada** bow to the ground in front of their farmhouse. Blue-white storm light against warm torchlight.

### AMA038 — Swallowed by Orochi *(death)*
Close-up of a vast serpent jaw opening above, teeth and the dark of its throat, one red eye as big as a lantern filling the side of the frame. On the ground below lies the rusty sword, dropped. No person. Red and black.

### AMA039 — The Festival at the Rock
The **Heavenly Rock Cave** with the torch-lit crowd of gods. In front of the sealed boulder stands a sakaki tree hung with the **Curved Jewels** glowing on its upper branches and the **Eight-Hand Mirror** on its middle branches, facing the rock; the **Sword of the Gathering Clouds** lies at its roots. Roosters stand along the clifftops. **Tajikarao** hides beside the boulder. **Ame-no-Uzume** ties back her sleeves. **Omoikane** turns toward the traveller, who stands in front of everyone holding **grandmother’s bell**. Optional details for the remembered choices: **Sarutahiko** watching from the side, **Susanoo** with head bowed at the edge of the crowd, **the white fox** sitting among the gods’ feet.

### AMA040 — The Dance of Ame-no-Uzume
**Ame-no-Uzume** dances wildly on her overturned wooden tub, stamping, sleeves flying and pulling a funny face. Hundreds of torch-lit gods roar with laughter, slapping their knees and falling over each other. Roosters crow on the cliffs. Behind her, the great boulder has shifted, opening a slightly wider crack of gold light. Joyful, loud, full of movement.

### AMA041 — Her Own Light
The traveller, seen from behind, holds up the **Eight-Hand Mirror** toward the gap beside the boulder. Through the gap, **Amaterasu**, with tears on her cheeks and light pouring from her skin, leans toward her own reflection in surprise. Golden light spills out of the crack and across the plain like a sunrise, lighting up the faces of the gods. **Tajikarao** braces beside the boulder, waiting. The first truly golden page.

### AMA042 — The Sacred Rope
**Tajikarao** rolls the great boulder aside with his whole body. **Amaterasu** steps out, blinking, holding his hand, and a flood of golden light pours out over the edge of heaven and down onto the islands below. **Omoikane** hands the traveller a thick twisted rope of rice straw; **Sarutahiko** takes the other end. Gods cheering, roosters crowing, the sky turning from indigo to gold.

### AMA043 — Dawn Returns *(best ending)*
Bright morning. The rice village from `AMA000` at the foot of the mountain, now under a warm sun and a blue sky. Frost is melting off green rice paddies, and the river sparkles. In the doorway of the small hillside shrine, **Grandmother** shades her eyes with her hand, squinting up at the sky with delight, as the traveller walks up the path toward her with **grandmother’s bell**, seen from behind. Make it a mirror of `AMA000`, with the same framing, in full daylight.

### AMA044 — The Rock Stays Shut *(lose)*
The **Heavenly Rock Cave** sealed tight, with no light at all around the boulder’s edge. **Ame-no-Uzume** sits on her tub with her head in her hands. Torches gutter and smoke among silent gods with bowed heads. The sakaki tree’s jewels have gone dark. Grey, cold, hopeless.

### AMA045 — The Sun’s Companion *(bittersweet)*
Inside the dark cave, looking out. In the foreground, the traveller sits cross-legged with eyes closed, seen from behind and to the side, **grandmother’s bell** in their lap. At the cave mouth, **Amaterasu** walks out into a blaze of golden light and the festival beyond, and the great boulder is beginning to roll shut behind her. Warm gold outside, soft dark inside, sakura petals blowing in through the gap.

### AMA046 — The Opened Box *(lose)*
Beside the sealed boulder, a very old, white-haired, wrinkled figure (the traveller, aged) sits with an open black lacquered box in their lap, a red cord trailing from it. White smoke curls up out of the box. At their feet, the **Eight-Hand Mirror** lies cracked on the stone. The gap in the rock is dark. Grey and white, faded.

### AMA047 — The Fox’s Wedding *(dark win)*
The High Plain of Heaven under a clear, shining sky with rain falling through the sunlight, and a faint rainbow. A procession of foxes walking on their hind legs in white and red robes crosses the plain, carrying paper lanterns and a red parasol. At the front, **the white fox** in human form leads a figure wearing a white wedding hood (the traveller, face hidden). The gods celebrate far behind them, unaware. Beautiful, sunny and unsettling, with lavender shadows.
