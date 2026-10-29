# Trial of Anubis scene art

Code-drawn illustrations for `Tales/The Trial of Anubis/Images/ANU001.png`–`ANU027.png`,
styled to match the flat, outlined, paper-grain look of the Tales From the Sphinx art.

- `lib.js` – shared shapes (rooms, torches, braziers, pillars, Anubis, the traveller, ghosts, scales…)
- `lib2.js` – scene-specific characters and props (Ammit, ferryman, scribe, rebel, guardian…)
- `scenes.js` – one function per screen
- `render.js` – renders scenes to 1254×1254 PNG with Playwright/Chromium
- `finish.py` – adds the soft paper grain

```bash
node render.js /tmp/anubis-raw            # or: node render.js /tmp/anubis-raw ANU005 ANU012
python3 finish.py /tmp/anubis-raw "../../Tales/The Trial of Anubis/Images"
```
