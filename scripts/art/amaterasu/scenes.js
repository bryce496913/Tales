// One function per page of The Cave of Amaterasu. Each returns a full SVG document.
// Regenerate: node scripts/art/amaterasu/render.js <outDir>, then import with scripts/art/import_art.py.
// Scene notes follow the Art notes in The_Cave_of_Amaterasu_Image_Prompts.md.
'use strict';
const L = require('./lib');
const C = require('./characters');
const {
  svg, g, fade, shape, sky, stars, glow, rays, vignette, wash, hills, mountain, ground, paddies, sprouts, bambooGrove, conifer, pine,
  cedarTrunk, foliage, sakuraBranch, petals, grassTufts, ferns, sakaki, waves, bubbles, sparks, rain, mist, swirlCloud, smoke, flame,
  torch, foxfire, paperLantern, stoneLantern, torii, shimenawa, shide, shrine, house, boulder, rockCave, loom, vat, boat, bucket, ladle,
  lowTable, fence, hall, mirror, magatama, magatamaString, sword, lacquerBox, bell, rope, OUT, lg, rg, seed, rr,
} = L;
const { person, traveller } = C;

// ---------- shared set pieces ----------
function village(day) {
  let s = day ? sky('#4a9ae0', '#cfe6f6') + glow(830, 170, 260, '#fff2b0', 0.9) + `<circle cx="830" cy="170" r="70" fill="#ffe680" stroke="${OUT}" stroke-width="3"/>` + rays(830, 170, 16, 400, '#fff6c0', 0.4)
    : sky('#04050b', '#1a2240');
  s += mountain(420, 620, 1300, 520, day ? '#6a8aa8' : '#1e2438', day ? '#45657e' : '#12162a');
  s += hills(560, 4, day ? '#5a8a5a' : '#1c2830', day ? '#3e6a46' : '#121a22', 70);
  s += shape('M330 660Q500 430 760 380Q900 350 1010 370L1010 680Z', day ? '#5a9a4e' : '#1e2c2a', day ? '#3e7a3e' : '#121c1c');
  s += `<path d="M700 980Q560 860 690 760Q800 680 700 600Q640 520 760 400" stroke="${OUT}" stroke-width="40" fill="none"/><path d="M700 980Q560 860 690 760Q800 680 700 600Q640 520 760 400" stroke="${day ? '#c8a878' : '#3a3a40'}" stroke-width="32" fill="none"/>`;
  s += pine(920, 420, 0.5, day ? '#3e7a4a' : '#16261e', day ? '#2a5a36' : '#0e1a16') + pine(560, 560, 0.45, day ? '#3e7a4a' : '#16261e', day ? '#2a5a36' : '#0e1a16');
  s += shrine(780, 392, 0.75, day ? 0 : 1);
  s += paddies(690, 1000, day ? '#5aa860' : '#202a36', day ? '#3e7a40' : '#141a24', day ? 0.25 : 0.8);
  if (day) s += sprouts(700, 1000, '#2e6a30', 200);
  for (const [x, y, k, sd] of [[120, 690, 0.85, 1], [290, 715, 1.0, 2], [450, 680, 0.7, 3], [90, 820, 1.2, 4], [380, 860, 1.25, 5]]) s += house(x, y, k, day ? 0 : 0.5, sd);
  return s;
}
function nightSky(top = '#060714', bottom = '#1c2446', n = 140, sd = 1) { return sky(top, bottom) + stars(sd, n, 700); }
function crowd(sd, n, y0, y1, x0 = 0, x1 = 1000, o = {}) {
  seed(sd);
  const items = [];
  for (let i = 0; i < n; i++) items.push([rr(x0, x1), rr(y0, y1)]);
  items.sort((a, b) => a[1] - b[1]);
  const robes = ['#6a5a9a', '#3e6a8a', '#8a4a4a', '#5a7a5a', '#a88a4a', '#7a5a7a', '#4a5a7a'];
  let s = '';
  for (const [x, y] of items) {
    seed(Math.round(x * 7 + y));
    const k = 0.18 + (y - y0) / (y1 - y0 + 1) * (o.grow ?? 0.16) + (o.base ?? 0);
    const hasTorch = (o.torches ?? 0.45) > rr(0, 1);
    s += person(x, y, k, {
      robe: L.pick(robes), robe2: L.pick(robes), hatType: L.pick(['eboshi', 'eboshi', null, 'kasa']), hairStyle: L.pick(['short', 'bun', 'long']),
      eyes: o.eyes || L.pick(['dot', 'happy', 'closed']), mouth: o.mouth || L.pick(['smile', 'open', 'flat']), beard: rr(0, 1) < 0.25 ? 'short' : null,
      armR: hasTorch ? [[60, -170], [50, -220]] : o.armR || [[66, -140], [58, -92]], armL: o.armL || [[-66, -140], [-58, -92]],
      holdR: hasTorch ? `<path d="M0 30L0 -40" stroke="${OUT}" stroke-width="8"/><path d="M0 30L0 -40" stroke="#6a4a30" stroke-width="5"/>` + flame(0, -40, 1.1) : '',
      back: !!o.back, blush: true,
    });
    if (hasTorch && o.torchGlow !== false) s += glow(x + 50 * k, y - 270 * k, 90 * k * 3, '#ff9a3c', 0.35);
  }
  return s;
}
function hollow() {
  let s = sky('#0a1418', '#16241e');
  for (const [x, w] of [[60, 120], [930, 140], [300, 70], [700, 80]]) s += cedarTrunk(x, w, 520, '#4a3428', '#22160f');
  s += `<path d="M-20 520Q200 380 420 460Q520 300 600 460Q800 360 1020 520" stroke="${OUT}" stroke-width="56" fill="none"/><path d="M-20 520Q200 380 420 460Q520 300 600 460Q800 360 1020 520" stroke="#4a3428" stroke-width="46" fill="none"/>`;
  s += shape('M-20 1010L-20 560Q500 420 1020 560L1020 1010Z', '#3e6a3e', '#1e3a26');
  s += shape('M80 1010Q120 640 500 620Q880 640 920 1010Z', '#4e8a4a', '#2a5a32', 3);
  seed(9);
  for (let i = 0; i < 22; i++) { const x = rr(60, 940), y = rr(600, 980); s += glow(x, y, 26, '#a8ffcf', 0.4) + `<path d="M${x - 9} ${y}Q${x} ${y - 16} ${x + 9} ${y}Z" fill="#c8f0d0" stroke="${OUT}" stroke-width="1.5"/>`; }
  s += sparks(12, 30, 0, 1000, 200, 700, '#d8ff9a', 3);
  return s;
}
function underwater(top = '#0a3050', bottom = '#04101e') { return sky(top, bottom) + `<g opacity="0.25">${[150, 380, 620, 860].map((x, i) => `<path d="M${x} -10L${x - 120 + i * 30} 1000L${x - 40 + i * 30} 1000Z" fill="#9ad8ff" filter="url(#b10)"/>`).join('')}</g>`; }
function palaceHall() {
  let s = underwater('#0e3a4e', '#06141e');
  s += shape('M0 760L1000 760L1000 1000L0 1000Z', '#2a5a5a', '#123030');
  for (const x of [80, 920]) s += `<rect x="${x - 40}" y="-10" width="80" height="780" fill="${lg(['#a8302a', '#e05a40', '#a8302a'], 0, 0, 1, 0)}" stroke="${OUT}" stroke-width="3"/><rect x="${x - 50}" y="730" width="100" height="40" fill="#d8b860" stroke="${OUT}" stroke-width="3"/>`;
  s += `<rect x="0" y="40" width="1000" height="40" fill="#a8302a" stroke="${OUT}" stroke-width="3"/>`;
  return s;
}
function shoreSky() { return sky('#020306', '#10141e', 0, 520); }
function riverNight() {
  let s = sky('#05070c', '#141c26');
  s += mountain(200, 560, 800, 420, '#1a2420', '#0e1410') + mountain(780, 560, 900, 360, '#16201c', '#0c120e');
  s += hills(600, 21, '#1a2a22', '#0e1812', 60);
  return s;
}
const rustySword = (rot = -30) => `<g transform="rotate(${rot})"><path d="M-7 0L-7 -150L0 -164L7 -150L7 0Z" fill="${lg(['#a07050', '#6a4a3a'], 0, 0, 1, 0)}" stroke="${OUT}" stroke-width="3"/><circle cx="-2" cy="-60" r="4" fill="#8a4a2a"/><circle cx="3" cy="-110" r="5" fill="#8a4a2a"/><rect x="-22" y="0" width="44" height="9" fill="#5a4a3a" stroke="${OUT}" stroke-width="2"/><rect x="-6" y="9" width="12" height="44" fill="#3a2a22" stroke="${OUT}" stroke-width="2"/></g>`;
function orochiBody(x, y, s, o = {}) {
  let b = `<path d="M-520 80Q-460 -230 -150 -280Q120 -320 360 -220Q560 -140 620 80Z" fill="${lg(['#4a5a3a', '#26301e'])}" stroke="${OUT}" stroke-width="5"/>`;
  b += `<path d="M-420 -60Q-200 -230 100 -230Q340 -200 500 -40" stroke="#6a7a4a" stroke-width="10" stroke-dasharray="40 24" fill="none" opacity="0.6"/>`;
  for (const [tx, ty, k] of [[-300, -200, 0.9], [-120, -270, 1.1], [80, -280, 1], [260, -230, 0.9], [420, -140, 0.8]]) b += conifer(tx, ty + 20, 200 * k, 110 * k, '#2a4a32', '#16281c');
  b += mist(4, 4, -300, -100, '#b8c8b0', 0.18);
  return g(x, y, s, b, o);
}
function gods(sd, n, y0, y1, o) { return crowd(sd, n, y0, y1, 0, 1000, o); }
function caveScene(o = {}) {
  let s = nightSky('#060612', '#1e1a3a', 120, 4);
  s += rockCave(500, o.by ?? 720, o.scale ?? 0.9, { glowAmt: o.glowAmt ?? 0.6, rolled: o.rolled ?? 0 });
  s += shape('M-10 700Q500 650 1010 700L1010 1010L-10 1010Z', '#3a3448', '#1c1828');
  return s;
}
function tub(x, y, s) { return g(x, y, s, shape('M-70 0L-80 -70L80 -70L70 0Z', '#a8804e', '#6a4a2a') + `<path d="M-76 -50L76 -50M-72 -18L72 -18" stroke="#3a2a22" stroke-width="5"/><ellipse cx="0" cy="-70" rx="80" ry="12" fill="#8a6038" stroke="${OUT}" stroke-width="3"/>`); }
const kasaHand = `<path d="M0 0L0 0" />`;

// ---------- pages ----------
module.exports = {
  // The Morning Without a Sun
  AMA000: () => svg(village(false) + mist(2, 6, 600, 760, '#8090b0', 0.15) + vignette(0.55)),

  // Grandmother's Shrine
  AMA001: () => svg(
    `<rect width="1000" height="1000" fill="${lg(['#3a2418', '#1a100c'])}"/>` +
    [0, 1, 2, 3, 4, 5].map((i) => `<rect x="${i * 180 - 20}" y="0" width="22" height="720" fill="#2a1a12" stroke="${OUT}" stroke-width="2"/>`).join('') +
    `<rect x="0" y="80" width="1000" height="30" fill="#2a1a12" stroke="${OUT}" stroke-width="2"/>` +
    shape('M0 720L1000 720L1000 1000L0 1000Z', '#5a3a26', '#2e1c12') +
    glow(500, 420, 420, '#ffb050', 0.45) +
    shape('M250 560L750 560L760 590L240 590Z', '#8a5a36', '#5a3a22') + `<rect x="270" y="590" width="20" height="140" fill="#4a2e1c" stroke="${OUT}" stroke-width="2"/><rect x="710" y="590" width="20" height="140" fill="#4a2e1c" stroke="${OUT}" stroke-width="2"/>` +
    mirror(500, 470, 55, 0.5) + sakaki(330, 560, 0.35) + sakaki(670, 560, 0.35) +
    [380, 620].map((x) => `<rect x="${x - 8}" y="500" width="16" height="60" fill="#f4ecd8" stroke="${OUT}" stroke-width="2"/>` + glow(x, 490, 60, '#ffc060', 0.8) + flame(x, 502, 0.5)).join('') +
    shimenawa(180, 150, 820, 150, 30, 20) + paperLantern(130, 300, 1.4) + paperLantern(870, 300, 1.4) +
    C.grandmother(500, 980, 1.55, { sitting: true, eyes: 'dot', mouth: 'smile', armL: [[-50, -120], [-14, -100]], armR: [[50, -120], [14, -100]], holdR: bell(0, 40, 1.2) }) +
    smoke(470, 600, 0.18, '#f0f0f8', 0.35) +
    `<path d="M300 1010L380 900" stroke="${OUT}" stroke-width="66"/><path d="M300 1010L380 900" stroke="#34508e" stroke-width="58"/><circle cx="386" cy="892" r="24" fill="${C.SKIN}" stroke="${OUT}" stroke-width="3"/>` +
    `<path d="M700 1010L620 900" stroke="${OUT}" stroke-width="66"/><path d="M700 1010L620 900" stroke="#34508e" stroke-width="58"/><circle cx="614" cy="892" r="24" fill="${C.SKIN}" stroke="${OUT}" stroke-width="3"/>` +
    vignette(0.6)),

  // The Night Parade
  AMA002: () => svg(
    sky('#06080c', '#16201c') +
    `<path d="M380 1010Q470 700 500 420L560 420Q600 700 760 1010Z" fill="${lg(['#3a3428', '#5a4a36'])}" stroke="${OUT}" stroke-width="3"/>` +
    glow(530, 560, 380, '#ff8a30', 0.35) +
    C.oni(470, 560, 0.5, { armL: [[-50, -200], [-30, -240]], armR: [[50, -200], [30, -240]] }) + C.oni(600, 560, 0.5, { armL: [[-50, -200], [-30, -240]], armR: [[50, -200], [30, -240]] }) +
    shape('M440 450L630 450L620 400L450 400Z', '#c8302a', '#7a1a14') + shape('M430 400L640 400L535 345Z', '#2a1e22', '#120c10') + `<path d="M470 450q10 20 0 30M520 450q10 20 0 30M590 450q10 20 0 30" stroke="#f0ead8" stroke-width="5" fill="none"/>` +
    person(690, 640, 0.6, { robe: '#e8d8e8', robe2: '#9a6a9a', hairStyle: 'long', neck: 220, eyes: 'sly', mouth: 'smile' }) +
    C.umbrellaYokai(330, 700, 0.9, { rot: -10 }) + C.umbrellaYokai(760, 760, 0.8, { col: '#c87a40', flip: true, rot: 8 }) +
    C.lanternYokai(420, 650, 1.1, { rot: -8 }) + C.lanternYokai(620, 700, 1.2, { rot: 6, look: -14 }) + C.lanternYokai(540, 820, 1.4, { big: true }) +
    `<path d="M560 600L560 480" stroke="${OUT}" stroke-width="6"/><path d="M560 480L620 490L610 520L560 515Z" fill="#d8402a" stroke="${OUT}" stroke-width="2"/>` +
    sparks(7, 20, 300, 800, 380, 800, '#ffb050', 4) +
    bambooGrove(3, 9, -40, 330, 1010, '#4a7a4a', '#22402a', '#3e6a3e') + bambooGrove(4, 8, 760, 1040, 1010, '#4a7a4a', '#22402a', '#3e6a3e') +
    traveller(170, 1080, 1.4, { sitting: true, armL: [[-60, -190], [-30, -235]], armR: [[60, -190], [30, -235]], noBell: true }) +
    vignette(0.6)),

  // The Endless Night (Game Over)
  AMA003: () => svg(
    sky('#06070c', '#1a1e2a') + hills(560, 8, '#1a1e28', '#10121a', 70) +
    [[180, 640, 0.6], [330, 660, 0.7], [520, 630, 0.55], [700, 650, 0.65], [860, 640, 0.6]].map(([x, y, k], i) => house(x, y, k, 0, i)).join('') +
    paddies(660, 760, '#262c38', '#1a1e28', 0.9) +
    shape('M-10 760L1010 760L1010 1010L-10 1010Z', '#3a3a44', '#22222a') +
    [0, 1, 2].map((i) => `<rect x="${200 + i * 30}" y="${770 + i * 70}" width="${600 - i * 60}" height="70" fill="#4a4a54" stroke="${OUT}" stroke-width="3"/>`).join('') +
    shape('M-10 600L160 600L160 760L-10 760Z', '#3a2a24', '#22160f') + shape('M-30 600L200 560L190 540L-30 580Z', '#2a2026', '#1a1418') +
    stoneLantern(840, 980, 1.1, 0) + smoke(840, 790, 0.35, '#9aa0ae', 0.5) +
    traveller(500, 960, 1.15, { sitting: true, armR: [[70, -210], [60, -290]], holdR: bell(0, 0, 1.1) }) +
    wash('#3a4a6a', 0.18) + vignette(0.7)),

  // Joined the Night Parade (Game Over)
  AMA004: () => svg(
    sky('#05070a', '#121a1a') +
    [100, 260, 420, 600, 760, 920].map((x, i) => cedarTrunk(x, 50 + (i % 3) * 20, 720, '#2a2420', '#141010')).join('') +
    shape('M-10 700Q500 650 1010 700L1010 1010L-10 1010Z', '#1e2420', '#0e1210') +
    `<path d="M380 1010Q520 820 900 690" stroke="#2e2a26" stroke-width="160" fill="none" opacity="0.8"/>` +
    [[880, 690, 0.4], [800, 710, 0.5], [710, 735, 0.6]].map(([x, y, k], i) => C.lanternYokai(x, y - 120 * k, k * 1.4, { look: i % 2 ? -14 : 2 })).join('') +
    C.umbrellaYokai(760, 730, 0.45, { flip: true }) +
    C.lanternYokai(600, 680, 1.0, { look: 4, big: true, rot: 10 }) +
    traveller(450, 950, 1.2, { back: false, eyes: 'blank', mouth: 'flat', blush: false, noBell: true, armR: [[66, -150], [70, -200]], holdR: paperLantern(0, 50, 0.9) }) +
    wash('#2a3a4a', 0.2) + vignette(0.7)),

  // The White Fox
  AMA005: () => svg(
    sky('#06100e', '#12201c') +
    bambooGrove(5, 14, -40, 1040, 720, '#3a6a4a', '#1a3a26', '#2e5a3a', 12, 26) +
    mist(6, 7, 500, 760, '#a8c8d8', 0.22) +
    shape('M-10 700Q500 660 1010 700L1010 1010L-10 1010Z', '#2a3e2e', '#16241a') +
    [[300, 960, 120], [520, 900, 100], [700, 820, 80], [560, 760, 60], [430, 720, 45]].map(([x, y, w]) => `<ellipse cx="${x}" cy="${y}" rx="${w}" ry="${w * 0.32}" fill="${lg(['#5a6a5a', '#3a4a3e'])}" stroke="${OUT}" stroke-width="3"/><path d="M${x - w * 0.6} ${y - w * 0.15}q${w * 0.3} -10 ${w * 0.6} 0" stroke="#5a8a4a" stroke-width="6" fill="none"/>`).join('') +
    glow(560, 640, 340, '#6ac0ff', 0.35) +
    C.fox(520, 900, 1.9) +
    grassTufts(4, 40, 720, 1000, '#3e6a3e') + vignette(0.55)),

  // The Foxfire Trail
  AMA006: () => svg(
    sky('#05070c', '#121820') + foliage(6, 14, -40, 260, '#16241e', '#0c1410') +
    [80, 920].map((x) => cedarTrunk(x, 90, 700, '#2e2420', '#161010')).join('') +
    shape('M-10 640Q500 600 1010 640L1010 1010L-10 1010Z', '#1e2a24', '#0e1612') +
    `<path d="M500 1010Q470 820 420 720Q340 640 160 600" stroke="#3a3a36" stroke-width="70" fill="none"/><path d="M500 1010Q540 820 600 720Q680 640 860 600" stroke="#3a3a36" stroke-width="70" fill="none"/>` +
    cedarTrunk(500, 170, 720, '#4a3428', '#22160f') + shimenawa(420, 420, 580, 420, 18, 16) +
    foxfire(200, 520, 14, '#7ab8ff', 0.55) + glow(800, 500, 220, '#ffd070', 0.55) + foxfire(800, 500, 30, '#ffd070', 1) +
    foxfire(80, 860, 12, '#9ad8ff', 0.8) + foxfire(930, 820, 12, '#9ad8ff', 0.8) +
    ferns(150, 1000, 1.1) + ferns(860, 1000, 1.1) +
    traveller(500, 1060, 1.2, { armR: [[70, -170], [80, -230]], holdR: bell(0, 0, 1) }) + vignette(0.6)),

  // The God of the Crossing
  AMA007: () => svg(
    nightSky('#04061a', '#2a2a5a', 200, 7) +
    `<path d="M780 760Q700 300 120 -40" stroke="#ffffff" stroke-width="150" fill="none" opacity="0.18" filter="url(#b10)"/>` +
    ['#ff9aa8', '#ffd89a', '#c8f0a8', '#9ad8ff', '#c8a8ff'].map((c, i) => `<path d="M${740 + i * 18} 760Q${660 + i * 18} 300 ${80 + i * 18} -40" stroke="${c}" stroke-width="18" fill="none" opacity="0.45"/>`).join('') +
    mist(7, 8, 600, 820, '#d8e0f8', 0.25) +
    shape('M-10 820Q200 740 420 760Q700 730 1010 780L1010 1010L-10 1010Z', '#3a3a4c', '#1c1c28') +
    g(140, 800, 0.6, shrine(0, 0, 1, 0.6), { rot: -6 }) +
    C.sarutahiko(600, 980, 2.3) +
    traveller(220, 990, 0.65) + vignette(0.45)),

  // Led Astray by Foxfire (Game Over)
  AMA008: () => svg(
    sky('#0a0406', '#1a0a0c') +
    glow(760, 420, 300, '#ffb060', 0.5) + foxfire(760, 420, 34, '#ffd080', 1) +
    [60, 200].map((x) => cedarTrunk(x, 70, 760, '#2a1a18', '#140c0a')).join('') +
    fade(0.75, C.fox(150, 760, 0.6)) +
    shape('M-10 760Q300 720 560 780L600 860L580 1010L-10 1010Z', '#2a1e1e', '#140c0c') +
    `<path d="M560 780L600 860L580 1010" stroke="${OUT}" stroke-width="5" fill="none"/>` +
    [[470, 790, 18], [520, 800, 12], [580, 850, 10], [400, 800, 14]].map(([x, y, r]) => `<ellipse cx="${x}" cy="${y}" rx="${r}" ry="${r * 0.7}" fill="#4a3a3a" stroke="${OUT}" stroke-width="2"/>`).join('') +
    ferns(330, 820, 0.9, '#3a2a26') + ferns(500, 800, 0.7, '#3a2a26') +
    wash('#4a0a0a', 0.18) + vignette(0.75)),

  // The Floating Bridge of Heaven
  AMA009: () => svg(
    sky('#020410', '#0a1028', 0, 400) + stars(9, 160, 380) +
    sky('#141a32', '#060812', 360, 1000) +
    shape('M60 700Q200 600 360 660Q420 760 300 840Q160 880 60 800Z', '#16201c', '#0c120e') + shape('M560 760Q700 680 900 720Q980 820 860 900Q700 940 600 860Z', '#16201c', '#0c120e') +
    sparks(9, 6, 100, 900, 650, 900, '#ff8a40', 2.5) + glow(250, 720, 40, '#ffc060', 0.9) + `<circle cx="250" cy="720" r="4" fill="#fff4c0"/>` +
    `<g opacity="0.92">${[[120, 480, 1.2], [520, 520, 1.4], [880, 470, 1.1], [300, 600, 1.0], [740, 610, 1.1], [50, 900, 1.2], [500, 950, 1.3], [950, 880, 1.1]].map(([x, y, k]) => swirlCloud(x, y, k * 1.4, '#5a6488', '#8a94c0')).join('')}</g>` +
    `<path d="M-60 1060Q400 760 1060 120" stroke="#ffffff" stroke-width="160" fill="none" opacity="0.3" filter="url(#b10)"/>` +
    ['#ff9aa8', '#ffd89a', '#c8f0a8', '#9ad8ff', '#c8a8ff'].map((c, i) => `<path d="M${-60 - 40 + i * 20} ${1060 - 40 + i * 20}Q${400 - 40 + i * 20} ${760 - 40 + i * 20} ${1060 - 40 + i * 20} ${120 - 40 + i * 20}" stroke="${c}" stroke-width="22" fill="none" opacity="0.7"/>`).join('') +
    traveller(470, 640, 0.42) + vignette(0.5)),

  // The Ruined Weaving Hall
  AMA010: () => svg(
    hall('#2a2028', '#2e2838', '#3a3040') +
    `<path d="M200 0L800 0L780 60L700 30L640 120L560 40L480 150L400 50L320 110L240 30Z" fill="${lg(['#04061a', '#1a1e40'])}" stroke="${OUT}" stroke-width="3"/>` + stars(10, 30, 120) +
    `<path d="M940 300L1000 300L1000 700L940 700Z" fill="#0a0c18"/>` + [960, 975, 990].map((x, i) => glow(x, 640 - i * 6, 14, '#ff9a3c', 0.9)).join('') +
    g(250, 860, 0.9, loom(0, 0, 1, '#c8d4f0'), { rot: -70 }) + g(780, 900, 0.8, loom(0, 0, 1, '#c8d4f0'), { rot: 60 }) +
    `<g fill="none" stroke="#dfe8ff" stroke-width="2.5" opacity="0.7">${[0, 1, 2, 3, 4, 5].map((i) => `<path d="M${200 + i * 110} 740Q${300 + i * 80} ${900 - i * 20} ${120 + i * 150} 990"/>`).join('')}</g>` +
    glow(520, 560, 260, '#c8d8ff', 0.25) +
    loom(520, 760, 1.4) + C.weaver(520, 900, 1.1, { sitting: true, armL: [[-60, -150], [-40, -190]], armR: [[60, -150], [40, -190]] }) +
    vignette(0.6)),

  // The Endless Loom (Game Over)
  AMA011: () => svg(
    hall('#2a2028', '#2e2838', '#3a3040') +
    `<path d="M200 0L800 0L780 60L700 30L640 120L560 40L480 150L400 50L320 110L240 30Z" fill="${lg(['#04061a', '#1a1e40'])}" stroke="${OUT}" stroke-width="3"/>` +
    loom(500, 720, 1.6) +
    `<g fill="none" stroke="#dfe8ff" stroke-width="2.2" opacity="0.75">${[...Array(14)].map((_, i) => `<path d="M${380 + i * 18} 700Q${200 + i * 50} ${820 + (i % 3) * 30} ${80 + i * 70} ${950 + (i % 4) * 12}Q${300 + i * 20} 980 ${500 + i * 30} 1000"/>`).join('')}</g>` +
    C.weaver(600, 940, 1.15, { sitting: true, back: true, bundle: false, armL: [[-60, -150], [-40, -200]], armR: [[60, -150], [40, -200]] }) +
    traveller(390, 940, 1.15, { sitting: true, noBell: true, bundle: false, armL: [[-60, -150], [-40, -200]], armR: [[60, -150], [40, -200]] }) +
    wash('#3a4a6a', 0.22) + vignette(0.7)),

  // The Council of the Gods
  AMA012: () => svg(
    nightSky('#04051a', '#1e1a3a', 160, 12) +
    `<path d="M-50 200Q300 120 600 260Q800 340 1050 300" stroke="#c8d0ff" stroke-width="70" fill="none" opacity="0.18" filter="url(#b10)"/>` + sparks(12, 30, 0, 1000, 150, 320, '#e8ecff', 2) +
    rockCave(640, 640, 0.8, { glowAmt: 0.7 }) +
    shape('M-10 620Q500 590 1010 620L1010 1010L-10 1010Z', '#34304a', '#1a1828') +
    gods(12, 34, 640, 800, { torches: 0.55, back: true }) +
    C.omoikane(250, 1000, 1.3, { armR: [[60, -190], [70, -260]], eyes: 'dot' }) +
    traveller(760, 1040, 1.0) + vignette(0.5)),

  // Looked Upon the Sun (Game Over)
  AMA013: () => svg(
    sky('#100a08', '#2a1a10') +
    g(500, 1100, 1, boulder(0, 0, 640, { glowAmt: 1, col: '#4a4450', dark: '#1e1a22' })) +
    rays(500, 460, 24, 1200, '#fff4c8', 0.5, 0.08) + glow(500, 460, 520, '#fff8d8', 0.9) +
    `<path d="M-60 460L1060 460" stroke="#fff" stroke-width="40" opacity="0.8" filter="url(#b10)"/>` +
    g(260, 760, 1.2, `<path d="M0 0Q-30 -10 -40 -60L-46 -120Q-44 -130 -34 -126L-26 -70L-22 -150Q-20 -162 -8 -158L-4 -80L4 -164Q8 -174 18 -168L18 -80L32 -150Q38 -160 46 -152L36 -70L60 -100Q72 -104 70 -90L40 -20Q30 6 0 0Z" fill="#100a08" opacity="0.85"/>`, { rot: -10 }) +
    vignette(0.4, '#200a00')),

  // HOME — The Heavenly Rock Cave
  AMA014: () => svg(
    sky('#04051a', '#16183a', 0, 600) + stars(14, 120, 520) +
    sky('#0a0c18', '#060810', 560, 1000) +
    mountain(170, 1000, 360, 300, '#16241c', '#0c140e') + glow(170, 710, 30, '#e8f0ff', 0.9) +
    shape('M330 1010Q500 900 640 1010Z', '#06080e', '#06080e', 2) + waves(6, 930, 1000, '#06080e', '#2a3a5a', 6) +
    hills(1000, 14, '#16201a', '#0c120e', 0, 200, 0) + `<path d="M760 1010Q840 900 880 850L940 1010" fill="#0e1414" stroke="${OUT}" stroke-width="2"/><path d="M820 1010Q860 920 900 860" stroke="#3a5a7a" stroke-width="10" fill="none"/>` +
    [['M380 600Q300 760 190 840', 50], ['M500 610Q520 780 480 920', 56], ['M620 600Q760 760 860 880', 50]].map(([d, w]) => `<path d="${d}" stroke="#ffffff" stroke-width="${w + 30}" fill="none" opacity="0.18" filter="url(#b10)"/><path d="${d}" stroke="#e8ecf8" stroke-width="${w}" fill="none" stroke-dasharray="2 0"/><path d="${d}" stroke="#a8b0d0" stroke-width="${w * 0.3}" fill="none" opacity="0.6"/>`).join('') +
    shape('M-10 560Q500 610 1010 560L1010 640Q800 620 500 630Q200 620 -10 650Z', '#dfe4f2', '#a8b0d0') +
    rockCave(170, 600, 0.5, { glowAmt: 0.7 }) +
    tub(330, 600, 0.6) + C.uzume(330, 562, 0.55, { sitting: true, eyes: 'happy', mouth: 'smile' }) +
    C.omoikane(820, 610, 0.65, { eyes: 'dot' }) + traveller(510, 640, 0.6) + vignette(0.45)),

  // The Cedars of Kurama
  AMA015: () => svg(
    sky('#04060c', '#101a18') +
    glow(520, 120, 90, '#e8f0ff', 0.8) + `<ellipse cx="520" cy="120" rx="14" ry="8" fill="#f4f8ff"/>` +
    `<path d="M120 60Q180 90 230 60M780 100Q830 130 880 100" stroke="#0a0a10" stroke-width="10" fill="none"/>` +
    `<path d="M300 1010L460 180L580 180L740 1010Z" fill="${lg(['#3a3e44', '#5a6058'])}" stroke="${OUT}" stroke-width="3"/>` +
    [...Array(22)].map((_, i) => { const t = Math.pow(i / 21, 1.6), y = 180 + t * 830, x0 = 460 - t * 160, x1 = 580 + t * 160; return `<path d="M${x0} ${y}L${x1} ${y}" stroke="${OUT}" stroke-width="${1 + t * 4}"/><path d="M${x0} ${y + 2 + t * 8}L${x1} ${y + 2 + t * 8}" stroke="#4a6a3a" stroke-width="${1 + t * 4}" opacity="0.6"/>`; }).join('') +
    stoneLantern(280, 900, 0.9) + stoneLantern(760, 900, 0.9) + stoneLantern(400, 520, 0.45) + stoneLantern(640, 520, 0.45) + stoneLantern(450, 330, 0.25) + stoneLantern(590, 330, 0.25) +
    [[60, 170], [200, 120], [860, 180], [980, 120]].map(([x, w]) => cedarTrunk(x, w, 1000, '#4a3428', '#22160f')).join('') +
    `<path d="M780 1010Q900 860 860 700Q840 600 880 460" stroke="#3a2e22" stroke-width="40" fill="none"/>` +
    [[760, 900], [900, 760], [820, 620]].map(([x, y]) => `<path d="M${x - 80} ${y}Q${x} ${y - 70} ${x + 90} ${y + 10}" stroke="${OUT}" stroke-width="30" fill="none"/><path d="M${x - 80} ${y}Q${x} ${y - 70} ${x + 90} ${y + 10}" stroke="#5a3e2e" stroke-width="22" fill="none"/>`).join('') +
    vignette(0.55)),

  // The Crow-Tengu
  AMA016: () => svg(
    sky('#04060c', '#121c18') +
    [[60, 170], [940, 170]].map(([x, w]) => cedarTrunk(x, w, 1000, '#4a3428', '#22160f')).join('') +
    `<path d="M150 1010L380 100L620 100L850 1010Z" fill="${lg(['#3a3e44', '#5a6058'])}" stroke="${OUT}" stroke-width="3"/>` +
    [...Array(16)].map((_, i) => { const t = Math.pow(i / 15, 1.4), y = 100 + t * 910; return `<path d="M${380 - t * 230} ${y}L${620 + t * 230} ${y}" stroke="${OUT}" stroke-width="${2 + t * 4}"/>`; }).join('') +
    stoneLantern(230, 640, 0.6) + stoneLantern(780, 640, 0.6) +
    [[440, 360, 0.4, 0], [580, 380, 0.42, 1], [340, 520, 0.55, 0], [680, 540, 0.55, 1], [500, 520, 0.5, 0], [250, 760, 0.75, 1], [760, 780, 0.75, 0], [520, 760, 0.7, 1]].map(([x, y, k, f]) =>
      C.crowTengu(x, y, k, { flip: !!f, armL: [[-70, -170], [-100, -200]] })).join('') +
    `<path d="M200 140Q260 90 330 140Q260 120 200 140ZM700 180Q760 120 830 170Q760 150 700 180Z" fill="#14121a" stroke="${OUT}" stroke-width="2"/>` +
    traveller(260, 1080, 1.0) + vignette(0.55)),

  // The Hollow of the Hidden
  AMA017: () => svg(
    hollow() +
    person(260, 820, 0.85, { robe: '#8a7a5a', robe2: '#6a5a3e', hatType: 'straw', hairStyle: 'short', eyes: 'happy', mouth: 'smile', sitting: true }) +
    person(500, 760, 0.85, { robe: '#5a3a3a', robe2: '#3a2a2a', sash: '#d8a840', hatType: 'helmet', eyes: 'closed', mouth: 'smile', sitting: true, w: 1.1 }) +
    person(650, 880, 0.6, { robe: '#d8a040', robe2: '#c87a40', hairStyle: 'bun', eyes: 'happy', mouth: 'smile', sitting: true, armR: [[60, -160], [70, -250]],
      holdR: `<path d="M0 0Q30 -80 60 -150" stroke="#e8e8e8" stroke-width="2" fill="none"/><path d="M40 -200L90 -150L60 -100L10 -150Z" fill="#e8402a" stroke="${OUT}" stroke-width="3"/><circle cx="50" cy="-150" r="12" fill="#f4c43a"/>` }) +
    person(380, 920, 0.7, { robe: '#5a7a8a', robe2: '#4a5a6a', hairStyle: 'long', eyes: 'closed', mouth: 'smile', sitting: true }) +
    traveller(860, 1020, 1.1, { armR: [[70, -170], [80, -230]], holdR: bell(0, 0, 1) }) + vignette(0.55)),

  // The Hall of Sōjōbō
  AMA018: () => svg(
    hall() + paperLantern(180, 220, 1.2) + paperLantern(820, 220, 1.2) +
    glow(500, 290, 300, '#dfe8ff', 0.4) + mirror(500, 290, 130, 1) + `<path d="M500 80L500 150" stroke="${OUT}" stroke-width="8"/><path d="M500 80L500 150" stroke="#c8302a" stroke-width="4"/>` +
    shape('M280 700L720 700L740 760L260 760Z', '#3a2a24', '#1e140f') +
    C.sojobo(500, 720, 1.25, { sitting: true }) +
    [[150, 840, 0.55, 0], [130, 960, 0.65, 0], [850, 840, 0.55, 1], [870, 960, 0.65, 1]].map(([x, y, k, f]) => C.crowTengu(x, y, k, { flip: !!f, wings: null })).join('') +
    traveller(500, 1080, 0.9) + vignette(0.55)),

  // The Mirror's Truth
  AMA019: () => svg(
    hall() + glow(600, 450, 380, '#dfe8ff', 0.45) + mirror(600, 450, 270, 1) +
    `<clipPath id="mc"><circle cx="600" cy="450" r="225"/></clipPath><g clip-path="url(#mc)" opacity="0.85">
      <rect x="370" y="220" width="460" height="460" fill="${lg(['#7a8ab8', '#c8d4f0'])}"/>
      <path d="M380 560Q480 460 560 520Q640 580 760 440" stroke="#5a6a8a" stroke-width="24" fill="none" opacity="0.6"/>
      ${glow(720, 320, 60, '#ffc060', 0.9)}<circle cx="720" cy="320" r="10" fill="#fff0b0"/>
      ${fade(0.6, C.grandmother(460, 420, 0.5))}
      ${traveller(600, 760, 1.1, { back: false, eyes: 'wide', mouth: 'frown', noBell: true })}
      <path d="M560 560l10 18M640 560l-8 14M580 600l40 0" stroke="#8a5a3a" stroke-width="5" opacity="0.6"/>
    </g>` +
    C.crowTengu(110, 900, 0.6) + C.crowTengu(920, 920, 0.6, { flip: true }) +
    traveller(270, 1060, 1.25, { noBell: true }) + vignette(0.55)),

  // The Eight-Hand Mirror
  AMA020: () => svg(
    hall() + paperLantern(500, 150, 1.0) +
    glow(720, 400, 220, '#dfe8ff', 0.4) + mirror(720, 420, 140, 0.8) +
    `<path d="M570 300Q720 260 870 320L860 500Q720 540 600 520Z" fill="#141018" stroke="${OUT}" stroke-width="3" opacity="0.95"/><path d="M600 300Q610 420 600 520M700 280Q690 400 700 540" stroke="#3a3040" stroke-width="3" fill="none"/>` +
    C.crowTengu(580, 760, 0.8, { armR: [[60, -190], [40, -300]], armL: [[-60, -190], [-40, -290]] }) + C.crowTengu(870, 760, 0.8, { flip: true, armR: [[60, -190], [40, -300]], armL: [[-60, -190], [-40, -290]] }) +
    g(300, 960, 1, C.sojobo(0, 0, 1.25, { holdR: '', armL: [[-40, -160], [-20, -110]], armR: [[40, -160], [20, -110]] }), { rot: 18 }) +
    traveller(560, 1040, 0.85) + vignette(0.5)),

  // Hidden by the Tengu (Game Over)
  AMA021: () => svg(
    hollow() +
    person(240, 800, 0.8, { robe: '#8a7a5a', robe2: '#6a5a3e', hatType: 'straw', eyes: 'happy', sitting: true }) +
    person(760, 800, 0.8, { robe: '#5a3a3a', robe2: '#3a2a2a', sash: '#d8a840', hatType: 'helmet', eyes: 'closed', sitting: true }) +
    g(500, 880, 0.95, traveller(0, 0, 1, { back: false, eyes: 'closed', mouth: 'smile', sitting: true, noBell: true }), { rot: -80 }) +
    bell(640, 930, 0.9) +
    `<circle cx="860" cy="860" r="120" fill="#141a26" stroke="#c8b48a" stroke-width="6"/><clipPath id="ic"><circle cx="860" cy="860" r="116"/></clipPath><g clip-path="url(#ic)">${sky('#1a2234', '#0e1420')}${g(860, 960, 0.9, shrine(0, 0, 1, 0.3))}<path d="M840 830l8 30M880 830l-8 30" stroke="#c8a868" stroke-width="4"/><ellipse cx="840" cy="870" rx="10" ry="20" fill="#c8a868" stroke="${OUT}" stroke-width="2"/><ellipse cx="880" cy="870" rx="10" ry="20" fill="#c8a868" stroke="${OUT}" stroke-width="2"/></g>` +
    wash('#3a5a6a', 0.2) + vignette(0.65)),

  // The Shore of Night
  AMA022: () => svg(
    shoreSky() + sky('#06080e', '#0e1420', 500, 700) + waves(10, 520, 700, '#000', '#3a4a6a', 6) +
    shape('M-10 680Q500 650 1010 690L1010 1010L-10 1010Z', '#1e1e24', '#0a0a0e') +
    `<path d="M-10 690Q500 660 1010 700" stroke="#8a9ab8" stroke-width="3" fill="none" opacity="0.5"/>` +
    glow(160, 820, 200, '#ff9a40', 0.5) + flame(160, 840, 1.4) + `<path d="M120 850L200 830M130 830L195 852" stroke="#4a3020" stroke-width="8"/>` +
    C.turtle(440, 820, 0.7, { flipped: true }) +
    [[320, 840, 0.38, 0], [560, 830, 0.36, 1], [470, 760, 0.32, 0]].map(([x, y, k, f]) => person(x, y, k, { robe: ['#8a6a4a', '#5a6a7a', '#7a5a5a'][Math.round(x) % 3], robe2: '#5a4a3a', hairStyle: 'short', eyes: 'happy', mouth: 'grin', flip: !!f, armR: [[70, -150], [100, -110]], holdR: `<path d="M0 0L80 70" stroke="${OUT}" stroke-width="8"/><path d="M0 0L80 70" stroke="#8a6a4a" stroke-width="4"/>` })).join('') +
    boat(800, 760, 0.85) +
    traveller(620, 1080, 1.05) + vignette(0.6)),

  // The Turtle's Back
  AMA023: () => svg(
    underwater('#0e3a5a', '#04101e') +
    glow(500, 1000, 420, '#ffb070', 0.5) + rays(500, 1050, 12, 700, '#ffd8a0', 0.25, 0.08, Math.PI) +
    [[300, 1000, 260], [420, 1000, 340], [580, 1000, 360], [700, 1000, 280]].map(([x, y, h]) => `<rect x="${x - 26}" y="${y - h}" width="52" height="${h}" fill="${lg(['#ff9a8a', '#c85a5a'])}" stroke="${OUT}" stroke-width="3"/>` + shape(`M${x - 50} ${y - h}L${x + 50} ${y - h}L${x} ${y - h - 50}Z`, '#e8f0ff', '#a8b8d8')).join('') +
    torii(500, 1000, 0.6, '#e04a30', '#a02a1a') +
    bubbles(23, 60, 0, 1000, 0, 900) +
    g(480, 460, 1.9, C.turtle(0, 0, 1) + traveller(0, -40, 0.42, { sitting: true, armL: [[-60, -150], [-70, -90]], armR: [[60, -150], [70, -90]], noBell: true }), { rot: 24 }) +
    C.fishSwim(150, 250, 0.8, '#f0c050') + C.fishSwim(860, 600, 0.7, '#f08a6a', true) + C.fishSwim(800, 220, 0.5, '#9ad0e0', true) +
    vignette(0.5)),

  // The Sea Monk
  AMA024: () => svg(
    sky('#020308', '#0a0e18', 0, 640) + `<rect x="0" y="600" width="1000" height="400" fill="${lg(['#0a0e16', '#020306'])}"/>` +
    C.umibozu(500, 680, 1.4) + waves(12, 620, 1000, '#000', '#3a4a6a', 8) +
    `<path d="M-10 640Q500 600 1010 640" stroke="#4a5a7a" stroke-width="4" fill="none" opacity="0.5"/>` +
    g(500, 1030, 1.9, boat(0, 0, 1, false)) +
    traveller(500, 1000, 0.95, { sitting: true, noBell: true }) + g(500, 1030, 1.9, `<path d="M-160 -40Q-150 10 -100 20L110 20Q160 10 175 -45L150 -30L-140 -30Z" fill="#6a4a30" stroke="${OUT}" stroke-width="3"/>`) + bucket(330, 990, 0.9) + ladle(680, 990, 1.0) + vignette(0.6)),

  // The Dragon Palace
  AMA025: () => svg(
    underwater('#1a5a70', '#0a2030') + glow(500, 400, 480, '#ffd0a0', 0.4) +
    [[150, 640, 440], [850, 640, 460], [280, 620, 300], [720, 620, 320]].map(([x, y, h]) => `<rect x="${x - 34}" y="${y - h}" width="68" height="${h}" fill="${lg(['#ffa898', '#d06060'])}" stroke="${OUT}" stroke-width="3"/>` + [1, 2, 3].map((k) => shape(`M${x - 70} ${y - h * k / 3.3}Q${x} ${y - h * k / 3.3 - 20} ${x + 70} ${y - h * k / 3.3}L${x} ${y - h * k / 3.3 - 50}Z`, '#f4f0ff', '#b8c0e0')).join('')).join('') +
    `<circle cx="210" cy="760" r="70" fill="#f8c8d8" stroke="${OUT}" stroke-width="5"/><circle cx="790" cy="760" r="70" fill="#d06040" stroke="${OUT}" stroke-width="5"/>` + petals(25, 20, 150, 270, 700, 820) + petals(26, 20, 730, 850, 700, 820, '#f08040') +
    torii(500, 700, 1.0, '#e04a30', '#a02a1a') + glow(500, 580, 200, '#fff0c0', 0.5) +
    shape('M-10 700L1010 700L1010 1010L-10 1010Z', '#e8dcc0', '#a8987a') + [...Array(6)].map((_, i) => `<path d="M${500 + (i - 2.5) * 80} 700L${500 + (i - 2.5) * 360} 1010" stroke="#8a7a5e" stroke-width="2"/>`).join('') +
    g(250, 920, 0.6, C.fishServant(0, 0, 1, { armL: [[-40, -140], [10, -130]], armR: [[40, -140], [-10, -130]] }), { rot: 15 }) +
    g(760, 920, 0.6, C.fishServant(0, 0, 1, { fishCol: '#9ad0e0', robe: '#4a6aa8', armL: [[-40, -140], [10, -130]], armR: [[40, -140], [-10, -130]] }), { rot: -15 }) +
    C.otohime(500, 890, 0.95, { armL: [[-80, -160], [-120, -190]], armR: [[80, -160], [120, -190]] }) +
    bubbles(25, 40, 0, 1000, 0, 700) + traveller(400, 1080, 0.85) + vignette(0.45)),

  // The Dragon King
  AMA026: () => svg(
    palaceHall() +
    C.dragonBody('M80 900Q-60 700 80 560Q220 420 60 260Q-40 140 120 40', 110) +
    C.dragonBody('M920 900Q1060 700 920 560Q780 420 940 260Q1040 140 880 60', 100) +
    C.dragonBody('M120 40Q400 -60 600 120Q700 220 560 330', 120) +
    g(470, 420, 1.15, C.dragonHead(0, 0, 1)) + magatamaString(500, 520, 1.3) +
    C.otohime(380, 980, 0.6) + traveller(560, 1010, 0.62) + bubbles(26, 30, 0, 1000, 0, 800) + vignette(0.5)),

  // The Feast Beneath the Waves
  AMA027: () => svg(
    palaceHall() +
    `<circle cx="500" cy="300" r="190" fill="#2a1a14" stroke="${OUT}" stroke-width="8"/><clipPath id="win"><circle cx="500" cy="300" r="180"/></clipPath><g clip-path="url(#win)"><rect x="300" y="100" width="200" height="400" fill="#bfe0f0"/><rect x="500" y="100" width="200" height="400" fill="#f0c890"/>${sakuraBranch(300, 330, 1.2)}${petals(27, 30, 320, 500, 120, 480)}${petals(28, 30, 500, 690, 120, 480, '#e05a2a')}<path d="M600 480L600 300M600 380L660 330M600 340L540 300" stroke="#4a2e2a" stroke-width="10"/>${[[560, 290], [640, 310], [600, 250], [670, 380]].map(([x, y]) => `<circle cx="${x}" cy="${y}" r="40" fill="#e0602a" stroke="${OUT}" stroke-width="3"/>`).join('')}</g><path d="M500 110L500 490M310 300L690 300" stroke="#2a1a14" stroke-width="10"/>` +
    lowTable(230, 900, 1.2) + lowTable(780, 900, 1.2) +
    C.otohime(500, 760, 0.85, { armL: [[-90, -200], [-130, -250]], armR: [[90, -170], [140, -140]] }) +
    C.fishServant(120, 760, 0.65, { armR: [[60, -150], [90, -120]], holdR: `<path d="M-6 0L6 0L10 -40L-10 -40Z" fill="#f0e6d0" stroke="${OUT}" stroke-width="2"/>` }) +
    C.fishServant(900, 760, 0.65, { flip: true, fishCol: '#9ad0e0', robe: '#4a6aa8' }) +
    traveller(780, 1040, 0.85, { back: false, sitting: true, eyes: 'happy', mouth: 'smile', noBell: true, armR: [[60, -150], [40, -190]], holdR: `<path d="M-10 0L10 0L14 -24L-14 -24Z" fill="#c8302a" stroke="${OUT}" stroke-width="2"/>` }) +
    bubbles(27, 20, 0, 1000, 0, 700) + vignette(0.45)),

  // The Turtle Remembers
  AMA028: () => svg(
    sky('#2a1a14', '#140c0a') + glow(500, 120, 500, '#ffc080', 0.35) +
    shape('M-10 -10L1010 -10L1010 260L-10 260Z', '#c8302a', '#7a1a14') + `<path d="M-10 260Q100 300 200 260Q300 300 400 260Q500 300 600 260Q700 300 800 260Q900 300 1010 260" fill="#e8d8b0" stroke="${OUT}" stroke-width="3"/>` +
    `<rect x="60" y="260" width="40" height="600" fill="#5a1a14" stroke="${OUT}" stroke-width="3"/><rect x="900" y="260" width="40" height="600" fill="#5a1a14" stroke="${OUT}" stroke-width="3"/>` +
    shape('M-10 820L1010 820L1010 1010L-10 1010Z', '#4a3428', '#2a1e18') +
    `<path d="M600 1010Q620 800 760 700Q880 640 1010 660L1010 1010Z" fill="${lg(['#7a7e8c', '#4a4e5c'])}" stroke="${OUT}" stroke-width="3"/>` +
    g(330, 870, 1, `<path d="M-20 0L20 0L28 -40L-28 -40Z" fill="#c8302a" stroke="${OUT}" stroke-width="3"/>`, { rot: 100 }) +
    `<path d="M360 880Q420 900 500 890Q560 900 600 880" stroke="#f0d890" stroke-width="16" fill="none" opacity="0.8"/>` +
    g(560, 900, 1.6, C.turtle(0, 0, 1), { rot: 50 }) + vignette(0.5)),

  // The Curved Jewels
  AMA029: () => svg(
    palaceHall() +
    C.dragonBody('M1060 100Q900 60 800 180Q720 280 760 360', 120) +
    g(700, 390, 1.0, C.dragonHead(0, 0, 1, { eyes: 'closed' })) +
    glow(500, 640, 160, '#9affc0', 0.5) + magatamaString(500, 600, 1.2) +
    C.otohime(200, 980, 1.0, { armR: [[70, -160], [110, -170]], holdR: lacquerBox(30, 20, 0.6) }) +
    traveller(500, 1060, 1.1, { noBell: true, armL: [[-70, -220], [-40, -300]], armR: [[70, -220], [40, -300]] }) +
    bubbles(29, 30, 0, 1000, 0, 800) + vignette(0.5)),

  // Three Hundred Years (Game Over)
  AMA030: () => svg(
    sky('#5aa8e8', '#d8ecf8') + glow(150, 150, 220, '#fff4c0', 0.9) + `<circle cx="150" cy="150" r="60" fill="#ffe680" stroke="${OUT}" stroke-width="3"/>` +
    `<rect x="0" y="520" width="1000" height="140" fill="#4a90c8"/>` + waves(5, 530, 650, '#4a90c8', '#d8f0ff', 5) +
    [...Array(16)].map((_, i) => { const x = 380 + i * 40, h = 30 + (i % 4) * 14; return `<rect x="${x}" y="${560 - h}" width="34" height="${h}" fill="#d8d4cc" stroke="${OUT}" stroke-width="2"/>` + shape(`M${x - 6} ${560 - h}L${x + 40} ${560 - h}L${x + 17} ${540 - h}Z`, '#5a6070', '#3a4050', 2); }).join('') +
    shape('M-10 620Q300 560 560 640Q800 700 1010 660L1010 1010L-10 1010Z', '#6ab05a', '#3e7a3e') +
    foliage(30, 8, 560, 660, '#4a8a4a', '#2e5a32') +
    shape('M380 900Q370 720 470 690Q570 680 590 760Q610 860 600 900Z', '#9a9aa0', '#6a6a72') +
    `<path d="M430 740Q500 720 560 740M440 770L440 870M470 770L470 880M500 760L500 880M530 770L530 880" stroke="#4a4a52" stroke-width="5" fill="none"/><path d="M390 860Q450 820 520 880Q560 900 600 870" stroke="#5a8a4a" stroke-width="22" fill="none" opacity="0.8"/>` +
    sakuraBranch(1010, 140, 1.5, true) + petals(30, 40, 0, 1000, 100, 900) +
    traveller(760, 1040, 1.15, { noBell: true }) + vignette(0.25, '#203040')),

  // The Chopsticks in the River
  AMA031: () => svg(
    riverNight() +
    `<path d="M380 560Q520 600 500 700Q460 820 600 1010L1010 1010L1010 960Q760 860 760 720Q760 620 560 560Z" fill="${lg(['#141c24', '#05080c'])}" stroke="${OUT}" stroke-width="3"/>` +
    waves(10, 600, 1000, '#000', '#3a4a5a', 6, 31) + mist(31, 6, 560, 760, '#8a9aa8', 0.2) +
    g(800, 640, 0.5, `<path d="M-60 0L-60 -90L60 -90L60 0Z" fill="#3a2a22" stroke="${OUT}" stroke-width="3"/><path d="M-90 -80L0 -150L70 -70" fill="#5a4a3a" stroke="${OUT}" stroke-width="3"/><path d="M10 -130L30 -110L50 -140" fill="#05070c"/><rect x="-30" y="-60" width="34" height="50" fill="#ffb050" stroke="${OUT}" stroke-width="3"/>`) + glow(790, 610, 70, '#ffa040', 0.6) +
    pine(950, 600, 0.5, '#16261e', '#0c1410') + pine(260, 560, 0.6, '#16261e', '#0c1410') +
    g(620, 830, 1, `<path d="M-60 0L70 -16" stroke="${OUT}" stroke-width="10"/><path d="M-60 0L70 -16" stroke="#d8b888" stroke-width="6"/><path d="M-50 18L76 4" stroke="${OUT}" stroke-width="10"/><path d="M-50 18L76 4" stroke="#d8b888" stroke-width="6"/>`) + glow(630, 830, 90, '#c8d8e8', 0.2) +
    shape('M-10 760Q200 700 420 760Q520 820 560 1010L-10 1010Z', '#1e2a22', '#0e1612') + grassTufts(31, 40, 760, 1000, '#2e4a3a') +
    traveller(260, 1040, 1.05) + vignette(0.6)),

  // The Exiled God
  AMA032: () => svg(
    `<rect width="1000" height="1000" fill="${lg(['#2a2018', '#120c08'])}"/>` +
    `<path d="M380 0L700 0L660 160L560 120L460 180Z" fill="${lg(['#141824', '#2a3040'])}" stroke="${OUT}" stroke-width="3"/>` + swirlCloud(560, 60, 0.8, '#3a4258', '#6a7290') +
    [100, 900].map((x) => `<rect x="${x - 20}" y="0" width="40" height="760" fill="#3a2a1e" stroke="${OUT}" stroke-width="3"/>`).join('') +
    shape('M-10 760L1010 760L1010 1010L-10 1010Z', '#4a3a2a', '#2a1e14') +
    `<rect x="-10" y="300" width="130" height="460" fill="#6a5040" stroke="${OUT}" stroke-width="3"/>` + glow(60, 520, 140, '#ffc070', 0.25) +
    traveller(60, 760, 0.6, { back: false, eyes: 'wide', mouth: 'o' }) +
    glow(560, 600, 340, '#7ab8ff', 0.18) +
    C.susanoo(560, 960, 1.8, { sitting: true, armR: [[100, -160], [150, -110]], holdR: `<path d="M-20 0L20 0L26 -50Q0 -66 -26 -50Z" fill="#d8c8a8" stroke="${OUT}" stroke-width="3"/>`, eyes: 'sad', hatType: 'leaves' }) +
    [[300, 900, 0], [820, 940, 60], [880, 860, 0], [240, 980, -80]].map(([x, y, r]) => g(x, y, 1, `<path d="M-30 0L30 0L36 -60Q0 -80 -36 -60Z" fill="#d8c8a8" stroke="${OUT}" stroke-width="3"/><path d="M-10 -70L10 -70L4 -84L-6 -84Z" fill="#d8c8a8" stroke="${OUT}" stroke-width="2"/>`, { rot: r })).join('') +
    `<path d="M780 980l40 -20l10 20l30 -16" stroke="${OUT}" stroke-width="3" fill="none"/>` + vignette(0.55)),

  // The Weeping House
  AMA033: () => svg(
    `<rect width="1000" height="1000" fill="${lg(['#2a1a12', '#0e0806'])}"/>` +
    [0, 1, 2, 3, 4].map((i) => `<rect x="${120 + i * 190}" y="120" width="150" height="460" fill="#3a2418" stroke="${OUT}" stroke-width="3"/>` + [0, 1, 2, 3, 4, 5].map((k) => `<path d="M${120 + i * 190} ${150 + k * 75}L${270 + i * 190} ${150 + k * 75}" stroke="#2a180e" stroke-width="5"/>`).join('')).join('') +
    shape('M-10 600L1010 600L1010 1010L-10 1010Z', '#5a3e28', '#2a1c12') +
    glow(500, 600, 420, '#ffb060', 0.55) + g(500, 760, 1, `<path d="M-6 0L6 0L4 -80L-4 -80Z" fill="#5a3a22" stroke="${OUT}" stroke-width="2"/><ellipse cx="0" cy="-84" rx="22" ry="7" fill="#c89a3a" stroke="${OUT}" stroke-width="2"/>`) + flame(500, -92 + 760, 0.6) +
    vat(860, 720, 0.8, '#d8c8a0') + vat(940, 780, 0.6, '#d8c8a0') + `<ellipse cx="90" cy="700" rx="60" ry="80" fill="#c8b080" stroke="${OUT}" stroke-width="3"/><ellipse cx="160" cy="740" rx="50" ry="60" fill="#b8a070" stroke="${OUT}" stroke-width="3"/>` +
    C.oldMan(260, 960, 1.1, { sitting: true, armL: [[-40, -180], [-10, -230]], armR: [[40, -180], [10, -230]] }) +
    C.kushinada(500, 940, 1.1, { sitting: true }) +
    C.oldWoman(740, 960, 1.1, { sitting: true, armL: [[-40, -170], [-10, -150]], armR: [[40, -170], [10, -150]] }) +
    vignette(0.6)),

  // The Eight Gates
  AMA034: () => svg(
    riverNight() + orochiBody(500, 520, 0.9) +
    [[110, 860, -60], [230, 820, -30], [350, 800, -10], [450, 790, 10], [550, 790, -10], [650, 800, 10], [770, 820, 30], [890, 860, 60]].map(([x, y, b], i) =>
      C.orochiNeck(500 + (i - 3.5) * 70, 400, x + (i < 4 ? 50 : -50), y - 160, 46, b) + C.serpentHead(x + (i < 4 ? 50 : -50), y - 160, 0.75, { flip: i >= 4, col: '#4a5a3a' })).join('') +
    fence(-10, 1010, 900, 120) +
    [110, 230, 350, 450, 550, 650, 770, 890].map((x, i) => vat(x, 940 - Math.abs(i - 3.5) * 4, 0.7)).join('') +
    torch(40, 960, 1.2) + torch(960, 960, 1.2) +
    traveller(170, 1080, 1.0, { sitting: true, noBell: true, holdR: rustySword(-40) }) + vignette(0.55)),

  // The Eight-Headed Serpent
  AMA035: () => svg(
    riverNight() + wash('#3a0806', 0.25) + orochiBody(500, 640, 1.0) +
    [[120, 300], [230, 200], [360, 140], [460, 120], [560, 120], [660, 140], [790, 200], [900, 300]].map(([x, y], i) =>
      C.orochiNeck(500 + (i - 3.5) * 80, 560, x, y + 40, 52, (i - 3.5) * -20) + C.serpentHead(x, y + 40, 0.85, { flip: i >= 4, open: i % 2 === 0 })).join('') +
    C.dragonBody('M1060 700Q760 820 560 900Q400 960 260 900', 90, '#4a5a3a', '#a8a070') +
    `<path d="M300 920l-30 -20M330 940l-20 -30M280 960l-40 -10" stroke="#8a6a4a" stroke-width="6"/>` +
    g(80, 760, 0.5, house(0, 0, 1, 1)) + C.kushinada(90, 760, 0.35, { mouth: 'open', eyes: 'wide', armR: [[60, -170], [90, -230]] }) +
    traveller(470, 1060, 1.0, { noBell: true, armR: [[70, -200], [80, -260]], holdR: rustySword(10) }) + vignette(0.65, '#1a0000')),

  // The Serpent Sleeps
  AMA036: () => svg(
    nightSky('#04060c', '#141c26', 140, 36) +
    orochiBody(480, 760, 1.15) +
    C.dragonBody('M960 760Q900 640 960 520Q990 470 940 430', 70, '#4a5a3a', '#a8a070') +
    glow(950, 470, 130, '#7ac8ff', 0.85) + `<path d="M975 520Q990 470 940 430" stroke="#bfe8ff" stroke-width="26" opacity="0.9" filter="url(#b4)"/>` +
    [[60, 900, 0], [180, 950, 0], [300, 960, 0], [700, 960, 1], [820, 950, 1]].map(([x, y, f]) => vat(x, y, 0.6, '#3a2e22') + C.serpentHead(x + (f ? -30 : 30), y - 70, 0.6, { flip: !!f, sleep: true })).join('') +
    traveller(560, 560, 0.55, { noBell: true }) + sparks(36, 10, 0, 1000, 100, 500, '#fff', 1.5) + vignette(0.55)),

  // The Sword of the Gathering Clouds
  AMA037: () => svg(
    riverNight() + wash('#0a1a2a', 0.3) +
    g(80, 820, 0.55, house(0, 0, 1, 1)) +
    [[150, 840, 0.4, '#7a6250', 'bun'], [210, 840, 0.4, '#9ac0e0', 'long'], [270, 840, 0.4, '#8a8a92', 'bun']].map(([x, y, k, robe, hs]) => g(x, y, 1, person(0, 0, k, { robe, robe2: robe, hairStyle: hs, back: false, eyes: 'closed', sitting: true }), { rot: 25 })).join('') +
    shape('M-10 900Q300 780 700 820Q900 840 1010 760L1010 1010L-10 1010Z', '#4a5a3a', '#26301e') +
    `<path d="M520 860Q640 800 760 830Q700 900 560 900Z" fill="#7ac8ff" opacity="0.6" filter="url(#b10)"/>` +
    glow(640, 520, 360, '#8ad0ff', 0.5) + sword(640, 840, 1.2, 8) +
    rustySword(0).replace('<g transform="rotate(0)">', `<g transform="translate(460 880) rotate(-80) scale(0.6)">`) + g(430, 920, 0.6, `<path d="M-7 0L-7 -70L7 -70L7 0Z" fill="#8a6a50" stroke="${OUT}" stroke-width="3"/>`, { rot: 70 }) +
    traveller(860, 1060, 1.1, { back: false, eyes: 'wide', mouth: 'o', noBell: true }) + vignette(0.5)),

  // Swallowed by Orochi (Game Over)
  AMA038: () => svg(
    sky('#140404', '#040000') +
    C.serpentHead(620, 520, 4.2, { open: true, col: '#3a4a2e' }) +
    glow(430, 360, 140, '#ff2010', 0.6) +
    shape('M-10 900Q500 860 1010 900L1010 1010L-10 1010Z', '#2a1a14', '#140a08') +
    g(500, 940, 1.4, rustySword(-80)) + wash('#5a0000', 0.2) + vignette(0.8, '#000')),

  // The Festival at the Rock
  AMA039: () => svg(
    caveScene({ glowAmt: 0.6, by: 690, scale: 0.85 }) +
    C.rooster(120, 330, 0.6) + C.rooster(260, 260, 0.55) + C.rooster(760, 250, 0.55, true) + C.rooster(890, 320, 0.6, true) +
    C.tajikarao(780, 700, 0.75, { eyes: 'stern', mouth: 'flat' }) +
    sakaki(500, 820, 0.95, { jewels: true, mirror: true }) + sword(500, 820, 0.35, 90, 0.8) +
    C.uzume(180, 830, 0.8, { armL: [[-60, -190], [-20, -150]], armR: [[60, -190], [20, -150]] }) +
    gods(39, 16, 820, 900, { torches: 0.6, back: true, base: 0.08 }) +
    C.omoikane(850, 980, 0.9, { eyes: 'dot' }) + C.sarutahiko(960, 980, 0.75, { eyes: 'stern' }) + C.susanoo(60, 990, 0.8, { lightning: false }) +
    C.fox(300, 990, 0.45) + traveller(560, 1050, 0.95, { armR: [[70, -170], [80, -230]], holdR: bell(0, 0, 1) }) + vignette(0.45)),

  // The Dance of Ame-no-Uzume
  AMA040: () => svg(
    caveScene({ glowAmt: 0.85, by: 660, scale: 0.8 }) +
    C.rooster(120, 330, 0.6) + C.rooster(890, 320, 0.6, true) + C.rooster(300, 240, 0.5) +
    tub(500, 800, 1.3) +
    C.uzume(500, 720, 1.25, { armL: [[-120, -230], [-160, -300]], armR: [[100, -120], [160, -90]], eyes: 'happy', mouth: 'laugh' }) +
    `<path d="M380 740q-20 -30 0 -50M620 750q20 -20 10 -50" stroke="#f0e0c8" stroke-width="5" fill="none"/>` +
    gods(40, 26, 820, 960, { torches: 0.4, mouth: 'laugh', eyes: 'happy', base: 0.12, armL: [[-70, -220], [-80, -270]] }) + vignette(0.4)),

  // Her Own Light
  AMA041: () => svg(
    sky('#2a1a2a', '#6a4a3a') + glow(500, 400, 600, '#ffd060', 0.55) + rays(430, 420, 20, 900, '#ffe9a0', 0.3, 0.08) +
    shape('M-10 -10L280 -10L320 300L300 760L-10 760Z', '#3a3446', '#1c1828') +
    `<path d="M300 760Q290 500 340 250Q400 200 460 260Q470 500 450 760Z" fill="${rg(['#fffbe0', '#ffd860', '#d89030'])}" stroke="${OUT}" stroke-width="4"/>` +
    g(400, 560, 1, C.amaterasu(0, 0, 1.05, { eyes: 'sad', mouth: 'o', armR: [[60, -170], [70, -230]] })) +
    boulder(760, 760, 340, { glowAmt: 1, col: '#5a5a6a', dark: '#2a2a36' }) +
    shape('M-10 740Q500 700 1010 740L1010 1010L-10 1010Z', '#5a4a40', '#2a2028') +
    C.tajikarao(920, 870, 0.95, { armL: [[-90, -210], [-150, -250]], mouth: 'flat' }) +
    traveller(320, 1070, 1.05, { noBell: true, armL: [[-60, -230], [-20, -300]], armR: [[60, -230], [20, -300]], holdR: mirror(-20, -40, 60, 1) }) + vignette(0.35, '#2a1000')),

  // The Sacred Rope
  AMA042: () => svg(
    sky('#e88a3a', '#ffe6a0') + rays(560, 420, 22, 1000, '#fff8d0', 0.4, 0.09) +
    shape('M-10 -10L1010 -10L1010 120Q700 160 500 120Q300 80 -10 140Z', '#6a5a8a', '#c88a6a', 0) +
    rockCave(560, 700, 0.85, { glowAmt: 1, rolled: 0.9, rope: false }) +
    shape('M-10 690Q500 650 1010 690L1010 1010L-10 1010Z', '#a87a5a', '#6a4a3a') +
    C.tajikarao(260, 720, 0.85, { armL: [[-90, -170], [-150, -160]], armR: [[60, -170], [-30, -160]], flip: true }) +
    C.amaterasu(560, 760, 1.25, { eyes: 'closed', mouth: 'smile' }) +
    C.omoikane(780, 980, 0.9, { eyes: 'happy', armR: [[60, -150], [20, -130]] }) + C.sarutahiko(940, 990, 0.8, { eyes: 'glow' }) +
    rope(140, 900, 820, 860, 40) +
    traveller(450, 1060, 0.9, { noBell: true, armL: [[-60, -150], [-80, -140]] }) + C.rooster(80, 360, 0.6) + C.rooster(930, 380, 0.6, true) + vignette(0.25, '#5a2a00')),

  // Dawn Returns (Game Over)
  AMA043: () => svg(village(true) +
    C.grandmother(860, 395, 0.4, { eyes: 'happy', mouth: 'laugh', armR: [[60, -180], [20, -235]] }) +
    traveller(700, 760, 0.45, { armR: [[70, -170], [80, -230]], holdR: bell(0, 0, 1) }) +
    sakuraBranch(-20, 120, 1.4) + petals(43, 30, 0, 600, 100, 700) + vignette(0.2, '#203040')),

  // The Rock Stays Shut (Game Over)
  AMA044: () => svg(
    caveScene({ glowAmt: 0, by: 680, scale: 0.85 }) +
    sakaki(820, 820, 0.7, { jewels: true, jewelsOff: true, mirror: true, mirrorGlow: 0 }) +
    [[120, 900], [260, 960], [700, 960], [900, 940]].map(([x, y]) => torch(x, y, 1.0, 0)).join('') +
    tub(480, 900, 1.0) + C.uzume(480, 840, 1.0, { sitting: true, eyes: 'closed', mouth: 'frown', armL: [[-50, -150], [-20, -220]], armR: [[50, -150], [20, -220]] }) +
    gods(44, 14, 820, 900, { torches: 0, back: true }) + wash('#3a4a6a', 0.3) + vignette(0.7)),

  // The Sun's Companion (Game Over)
  AMA045: () => svg(
    `<rect width="1000" height="1000" fill="#0a0810"/>` +
    `<path d="M200 820Q180 380 500 300Q820 380 800 820Z" fill="${rg(['#fffbe0', '#ffd860', '#e8a040'])}" stroke="${OUT}" stroke-width="4"/>` +
    rays(500, 520, 20, 700, '#fff4c0', 0.3, 0.1) +
    C.amaterasu(500, 760, 1.05, { back: true, hairStyle: 'wavy' }) + gods(45, 10, 760, 800, { torches: 0.5, base: 0.02, grow: 0.05 }) +
    boulder(800, 820, 300, { glowAmt: 0.8 }) +
    `<path d="M-10 -10L1010 -10L1010 1010L-10 1010Z M200 820Q180 380 500 300Q820 380 800 820Z" fill="${lg(['#1a1622', '#0a0810'])}" fill-rule="evenodd" stroke="${OUT}" stroke-width="4"/>` +
    shape('M-10 800L1010 800L1010 1010L-10 1010Z', '#2a2430', '#141018') + petals(45, 26, 300, 800, 500, 950) +
    traveller(330, 1010, 1.1, { sitting: true, noBell: true, holdL: '', armR: [[60, -150], [20, -100]], holdR: bell(0, 0, 0.9) }) + vignette(0.4)),

  // The Opened Box (Game Over)
  AMA046: () => svg(
    caveScene({ glowAmt: 0, by: 700, scale: 0.9 }) +
    person(480, 920, 1.25, { robe: '#34508e', robe2: '#7a7e8c', sash: '#c8402a', hair: '#f0eef4', hairStyle: 'long', eyes: 'sad', mouth: 'frown', skin: '#e8c8a8', beard: null, sitting: true, armL: [[-60, -150], [-30, -110]], armR: [[60, -150], [30, -110]] }) +
    `<path d="M450 640q12 6 24 0M500 640q12 6 24 0M470 690q16 5 30 0" stroke="${OUT}" stroke-width="2" fill="none" opacity="0.5"/>` +
    lacquerBox(470, 880, 0.9, true) + g(560, 820, 1, smoke(0, 0, 0.9, '#f0f2f8', 0.75), { rot: 35 }) +
    mirror(740, 920, 50, 0, true) + wash('#8a90a0', 0.22) + vignette(0.6)),

  // The Fox's Wedding (Game Over)
  AMA047: () => svg(
    sky('#6ab4ec', '#f4e8d8') + glow(820, 140, 200, '#fff4c0', 0.9) + `<circle cx="820" cy="140" r="56" fill="#ffe680" stroke="${OUT}" stroke-width="3"/>` +
    ['#ff9aa8', '#ffd89a', '#c8f0a8', '#9ad8ff', '#c8a8ff'].map((c, i) => `<path d="M-100 ${640 - i * 14}Q400 ${120 - i * 14} 1100 ${560 - i * 14}" stroke="${c}" stroke-width="14" fill="none" opacity="0.4"/>`).join('') +
    shape('M-10 600Q500 560 1010 600L1010 1010L-10 1010Z', '#a8c890', '#6a9a6a') +
    fade(0.5, gods(47, 16, 600, 640, { torches: 0, base: -0.04, grow: 0.04, mouth: 'laugh' })) +
    [[860, 700, 0.4], [760, 740, 0.45], [660, 780, 0.5]].map(([x, y, k], i) => person(x, y, k, { head: 'fox', robe: i % 2 ? '#d8402a' : '#f6f4ee', robe2: i % 2 ? '#f6f4ee' : '#d8402a', armR: [[60, -170], [70, -230]], holdR: paperLantern(0, 60, 0.6, '#e8503a', 0.6) })).join('') +
    person(600, 760, 0.42, { head: 'fox', robe: '#2a2026', robe2: '#d8402a', armR: [[60, -180], [60, -260]], holdR: `<path d="M0 60L0 -60" stroke="${OUT}" stroke-width="6"/><path d="M-80 -40Q0 -110 80 -40Z" fill="#d8402a" stroke="${OUT}" stroke-width="3"/>` }) +
    person(380, 940, 1.15, { robe: '#f6f4ee', robe2: '#e8e4dc', sash: '#d8b878', hair: '#f6f4ee', hairStyle: 'short', eyes: 'sly', eyeCol: '#c89a20', mouth: 'smile', armR: [[60, -160], [110, -140]] }) +
    g(380, 940, 1.15, `<path d="M-36 -252L-44 -296L-16 -266ZM36 -252L44 -296L16 -266Z" fill="#f6f4ee" stroke="${OUT}" stroke-width="3"/>`) +
    traveller(560, 960, 1.05, { back: false, hatType: 'hood', eyes: 'none', mouth: 'none', blush: false, robe: '#f6f4ee', robe2: '#f6f4ee', sash: '#d8b878', noBell: true }) +
    `<path d="M520 728Q560 740 600 728" stroke="#d8d0c8" stroke-width="40"/>` +
    rain(47, 160, '#ffffff', 0.55) + vignette(0.25, '#3a2a5a')),
};
