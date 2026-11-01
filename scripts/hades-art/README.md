# The Descent to Hades scene art

Code-drawn illustrations for every Descent to Hades page, `Tales/The Descent to Hades/Images/HDS000.png`–`HDS047.png`
(one per page, named after the page number), in the same flat, outlined, paper-grain style as the Trial of Anubis art.

- `lib.js` – shared shapes: figures and the cast (Theo, Hermes, Charon, Cerberus, Persephone, Hades, the Furies, Sisyphus, Achilles, the Sibyl, the judges, shades), the player's hands, props (pomegranate, flask, bowl, Golden Bough) and scenery (columns, cypresses, asphodel, gates, stairs, fire)
- `scenery.js` – larger backdrops shared between pages (roads, hills, the Styx, Lethe, Phlegethon, Tartarus)
- `pages.js` (`000`–`023`) and `pages2.js` (`024`–`047`) – one entry per story page; the source of truth for what gets rendered

Every image is drawn from the player's point of view, so the player never appears in frame apart from their own hands.
Remembered-choice details (Theo or Hermes at the throne, for example) are left out of the pictures because each page shows the same image on every route.

- `render.js` – renders scenes to 1254×1254 PNG with Playwright/Chromium
- `finish.py` – adds the soft paper grain

```bash
node render.js /tmp/hades-raw            # or: node render.js /tmp/hades-raw HDS005 HDS012
python3 finish.py /tmp/hades-raw "../../Tales/The Descent to Hades/Images"
```
