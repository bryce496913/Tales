#!/usr/bin/env node
// Renders every page in scenes.js to PNG (1024 x 1024) with the pre-installed Playwright Chromium.
// Usage: node render.js <outDir> [AMA000 AMA001 ...]
'use strict';
const fs = require('fs');
const path = require('path');
const { chromium } = require('playwright');
const scenes = require(process.env.SCENES || './scenes');

(async () => {
  const out = path.resolve(process.argv[2] || 'out');
  const only = process.argv.slice(3);
  fs.mkdirSync(out, { recursive: true });
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 1024, height: 1024 } });
  for (const [name, fn] of Object.entries(scenes)) {
    if (only.length && !only.includes(name)) continue;
    const svg = fn();
    fs.writeFileSync(path.join(out, `${name}.svg`), svg);
    await page.setContent(`<html><body style="margin:0;background:#000">${svg}</body></html>`);
    await page.screenshot({ path: path.join(out, `${name}.png`), clip: { x: 0, y: 0, width: 1024, height: 1024 } });
    console.log(name);
  }
  await browser.close();
})();
