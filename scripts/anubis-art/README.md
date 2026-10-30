# Trial of Anubis scene art

Code-drawn illustrations for every Trial of Anubis page, `Tales/The Trial of Anubis/Images/ANU000.png`–`ANU047.png`
(one per page, named after the page number),
styled to match the flat, outlined, paper-grain look of the Tales From the Sphinx art.

- `lib.js` – shared shapes (rooms, torches, braziers, pillars, Anubis, the traveller, ghosts, scales…)
- `lib2.js` – scene-specific characters and props (Ammit, ferryman, scribe, rebel, guardian…)
- `pages.js` – one entry per story page; the source of truth for what gets rendered
- `scenes.js`, `scenes2.js` – scene drawings that `pages.js` reuses

Every image is drawn from the player's point of view, so the traveller never appears in frame.
- `render.js` – renders scenes to 1254×1254 PNG with Playwright/Chromium
- `finish.py` – adds the soft paper grain

```bash
node render.js /tmp/anubis-raw            # or: node render.js /tmp/anubis-raw ANU005 ANU012
python3 finish.py /tmp/anubis-raw "../../Tales/The Trial of Anubis/Images"
```
