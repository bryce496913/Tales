// Usage: node render.js <outDir> [sceneName ...]
const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');
const scenes = require('./scenes');

(async () => {
  const [outDir, ...names] = process.argv.slice(2);
  fs.mkdirSync(outDir, { recursive: true });
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 1254, height: 1254 } });
  for (const name of names.length ? names : Object.keys(scenes)) {
    const markup = scenes[name]();
    await page.setContent(`<html><body style="margin:0">${markup}</body></html>`);
    await page.locator('svg').screenshot({ path: path.join(outDir, `${name}.png`) });
    console.log('rendered', name);
  }
  await browser.close();
})();
