// Pages HDS024–HDS047: Tartarus, Elysium and the end-game.
const L = require('./lib');
const {
  svg, sky, shape, glow, vignette, wash, fog, at, g, rot, fade, place, stroke, OL, hand, blur,
  theo, hermes, persephone, hades, throne, fury, sisyphus, boulder, achilles, sibyl, shade, shadeCrowd,
  pomegranate, flask, bowl, bough, column, cypress, oliveTree, asphodelField, grass, stairsUp, waves,
  sparks, lightBeam, flame, brazier, SKIN,
} = L;
const { underSky, road, hills, sunDisc, fortress, fireRiver, redSky, lightning } = require('./scenery');

const ELYSIUM = { skyTop: '#5ab4f0', skyBottom: '#d8f0ff', grass: '#7ac04a', grassDark: '#4a8a2a', sea: '#2aa8d8' };

function batWings(x, y, sc = 1, col = '#120a0a') {
  return at(x, y, sc, `<path d="M0 0 C-40 -50 -110 -60 -150 -30 C-120 -20 -110 0 -116 20 C-90 6 -70 10 -60 30 C-40 14 -20 14 0 30 C20 14 40 14 60 30 C70 10 90 6 116 20 C110 0 120 -20 150 -30 C110 -60 40 -50 0 0 Z" fill="${col}" ${stroke(3)}/>`);
}

function fireWheel(x, y, r) {
  let spokes = '';
  for (let i = 0; i < 8; i++) spokes += `<path d="M0 0 L${(Math.cos((i * Math.PI) / 4) * r).toFixed(0)} ${(Math.sin((i * Math.PI) / 4) * r).toFixed(0)}" stroke="#5a2a10" stroke-width="10"/>`;
  let flames = '';
  for (let i = 0; i < 10; i++) {
    const a = (i / 10) * Math.PI * 2;
    flames += flame(Math.cos(a) * r, Math.sin(a) * r, 36, 60);
  }
  return glow(x, y, r * 2.2, '#ff7a1a', 0.5) + at(x, y, 1, `<circle r="${r}" fill="none" stroke="${OL}" stroke-width="22"/><circle r="${r}" fill="none" stroke="#7a3a14" stroke-width="14"/>${spokes}${flames}
    <ellipse cx="0" cy="-10" rx="22" ry="44" fill="#c9946a" ${stroke(3)}/><circle cx="0" cy="-64" r="20" fill="#c9946a" ${stroke(3)}/>`);
}

function hallFloor(y = 760) {
  return shape(`M0 ${y} L1000 ${y} L1000 1000 L0 1000 Z`, '#241c34', '#0c0812', 3) +
    [0, 1, 2, 3, 4, 5].map((i) => `<path d="M${500 - 60 - i * 110} ${y} L${500 - 220 - i * 300} 1000 M${500 + 60 + i * 110} ${y} L${500 + 220 + i * 300} 1000" stroke="#3a2e50" stroke-width="3"/>`).join('') +
    [0, 1, 2].map((i) => `<path d="M0 ${y + 40 + i * i * 40 + i * 30} L1000 ${y + 40 + i * i * 40 + i * 30}" stroke="#3a2e50" stroke-width="3"/>`).join('');
}

function throneHall() {
  let s = sky('#0a0812', '#1c1630');
  for (const [x, w] of [[90, 90], [250, 70], [750, 70], [910, 90]]) s += column(x, 40, 780, w, { col: '#2a2240', shade: '#1a1430' });
  s += hallFloor(760);
  return s;
}

function steps(y, w = 560, n = 3, col = '#2e2644') {
  let s = '';
  for (let i = 0; i < n; i++) s += `<rect x="${500 - w / 2 - i * 50}" y="${y + i * 34}" width="${w + i * 100}" height="34" fill="${col}" ${stroke(3)}/>`;
  return s;
}

function table(y, o = {}) {
  const { food = true, cup = true } = o;
  let s = shape(`M-40 ${y} L1040 ${y} L1040 1000 L-40 1000 Z`, '#a8743a', '#6a4422', 4);
  s += `<path d="M-40 ${y + 14} L1040 ${y + 14}" stroke="#c8925a" stroke-width="6"/>`;
  if (food) {
    s += `<ellipse cx="200" cy="${y + 70}" rx="110" ry="30" fill="#ece4d6" ${stroke(3)}/>` +
      [[160, '#7a3a8a'], [200, '#9e2b3a'], [240, '#e8b84a'], [180, '#6a9a3a'], [220, '#7a3a8a']].map(([x, c], i) => `<circle cx="${x}" cy="${y + 56 - (i > 2 ? 14 : 0)}" r="18" fill="${c}" ${stroke(2.5)}/>`).join('') +
      `<ellipse cx="820" cy="${y + 70}" rx="100" ry="28" fill="#ece4d6" ${stroke(3)}/><path d="M760 ${y + 62} C770 ${y + 20} 870 ${y + 20} 880 ${y + 62} Z" fill="#d8a056" ${stroke(3)}/>`;
  }
  if (cup) s += `<path d="M450 ${y + 150} L550 ${y + 150} L530 ${y + 230} L470 ${y + 230} Z" fill="#c08a4a" ${stroke(3)}/><ellipse cx="500" cy="${y + 150}" rx="50" ry="14" fill="#ffd56a" ${stroke(3)}/>
    <path d="M488 ${y + 230} L486 ${y + 260} L514 ${y + 260} L512 ${y + 230}" fill="#a8743a" ${stroke(3)}/>`;
  return s;
}

function hero(x, y, sc, o = {}) {
  return place(x, y, sc, L.figure({
    skin: o.skin || '#d9a87e', robe: '#d49a4a', hair: o.hair || '#3a2a1a', hairStyle: o.style || 'short', mood: o.mood || 'smile',
    beard: o.beard || null, armL: o.armL || 'down', armR: o.armR || 'up', behind: `<path d="M-50 -236 C-80 -180 -80 -80 -70 0 L70 0 C80 -80 80 -180 50 -236 Z" fill="${o.cloak || '#3a5aa8'}" ${stroke(3)}/>`,
    handR: `<path d="M-14 -16 L14 -16 L10 4 L-10 4 Z" fill="#c08a4a" ${stroke(2)}/>`,
  }));
}

function goldenTree(x, y, sc = 1) {
  return at(x, y, sc, `
    <path d="M-26 0 C-20 -80 -40 -150 -14 -230 L14 -230 C0 -150 30 -80 26 0 Z" fill="#7a5a3a" ${stroke(3)}/>
    <path d="M-6 -200 L-70 -260 M8 -210 L70 -270" stroke="#7a5a3a" stroke-width="16" stroke-linecap="round"/>
    ${[[-80, -300, 80], [0, -340, 95], [80, -300, 80], [-40, -250, 70], [50, -250, 70]].map(([cx, cy, r]) => `<circle cx="${cx}" cy="${cy}" r="${r}" fill="#5a8a3a" ${stroke(3)}/>`).join('')}
    <path d="M-40 -330 Q0 -360 40 -340" stroke="#8ab05a" stroke-width="6" fill="none"/>`) + bough(x + 10 * sc, y - 170 * sc, sc * 0.9, 10);
}

function bench(x, y, sc = 1) {
  return at(x, y, sc, `<rect x="-130" y="-70" width="260" height="30" rx="6" fill="#b8b4a8" ${stroke(3)}/>
    <rect x="-110" y="-42" width="34" height="42" fill="#9a968a" ${stroke(3)}/><rect x="76" y="-42" width="34" height="42" fill="#9a968a" ${stroke(3)}/>`);
}

function elysiumLand(horizon = 520) {
  return sky(ELYSIUM.skyTop, ELYSIUM.skyBottom, 0, horizon) +
    `<rect x="0" y="${horizon - 60}" width="1000" height="70" fill="${ELYSIUM.sea}"/>` + waves(61, horizon - 50, horizon, '#bfe8ff', '#ffffff', 14) +
    hills(horizon, 62, ELYSIUM.grass, ELYSIUM.grassDark, 40);
}

function cliffCape(sunny = true) {
  return shape('M600 1000 L620 640 L680 560 L760 420 L860 380 L1000 360 L1000 1000 Z', sunny ? '#a8865a' : '#3a3440', sunny ? '#6a5236' : '#1a161e', 4) +
    `<path d="M700 600 L740 640 M820 470 L800 540 M900 420 L930 500" stroke="${OL}" stroke-width="4" opacity="0.4"/>`;
}

function fishingBoat(x, y, sc = 1) {
  return at(x, y, sc, `
    <path d="M-110 0 L110 0 C100 30 70 44 40 46 L-60 46 C-90 40 -106 24 -110 0 Z" fill="#e8e0d0" ${stroke(3)}/>
    <path d="M-104 12 L104 12" stroke="#2a6aa8" stroke-width="8"/>
    <path d="M-10 0 L-10 -120 M-10 -110 L60 -20" stroke="${OL}" stroke-width="5"/>
    <rect x="20" y="-46" width="50" height="46" fill="#c84a3a" ${stroke(3)}/>
    ${[[-70, -30], [-40, -30]].map(([px, py]) => `<circle cx="${px}" cy="${py - 26}" r="10" fill="#e8b48a" ${stroke(2)}/><rect x="${px - 10}" y="${py - 16}" width="20" height="16" fill="#f2b833" ${stroke(2)}/><path d="M${px + 8} ${py - 14} L${px + 22} ${py - 40}" stroke="${OL}" stroke-width="5" stroke-linecap="round"/>`).join('')}`);
}

const pages = {
  // The Gates of Tartarus
  HDS024: () => svg(
    redSky() + sparks(240, 60, 0, 0, 1000, 600, '#ffb46a', 3) +
    shape('M0 300 L180 260 L260 320 L400 280 L600 300 L760 250 L1000 290 L1000 1000 L0 1000 Z', '#4a1a10', '#2a0c08', 4) +
    fireRiver(700, 860, 24) +
    fortress(700) +
    fury(500, 400, 0.38, { armR: [[-90, -180], [-110, -230]], eyes: 'glow:#ff5a3a' }) +
    shape('M300 1000 L460 860 L540 860 L700 1000 Z', '#c08a4a', '#7a4e22', 3) +
    `<path d="M460 860 L540 860" stroke="#5a3814" stroke-width="4"/><path d="M380 960 L620 960 M420 920 L580 920" stroke="#5a3814" stroke-width="5" opacity="0.6"/>` +
    vignette(0.55)),

  // Tisiphone the Avenger
  HDS025: () => svg(
    redSky() +
    `<rect x="0" y="560" width="1000" height="440" fill="#8a5a2c"/>` + [600, 650, 700, 760].map((y) => `<path d="M0 ${y} L1000 ${y}" stroke="#5a3814" stroke-width="3"/>`).join('') +
    `<path d="M380 1000 L380 760 C380 640 620 640 620 760 L620 1000 Z" fill="#1a0806" ${stroke(4)}/>` + glow(500, 860, 200, '#ff5a1a', 0.4) +
    fury(500, 1520, 2.7, { armL: 'down', armR: [[-80, -170], [-60, -120]], mood: 'stern', eyes: 'glow:#ff8a3a' }) +
    vignette(0.6)),

  // The Fury's Lash
  HDS026: () => svg(
    redSky() +
    shape('M0 420 L200 380 L360 430 L520 360 L700 420 L860 370 L1000 410 L1000 1000 L0 1000 Z', '#5a2210', '#2a0c06', 4) +
    // Tantalus in his pool beneath the fruit tree
    `<ellipse cx="230" cy="560" rx="120" ry="34" fill="#3a6aa8" ${stroke(3)}/>` +
    at(230, 560, 0.35, `<ellipse cx="0" cy="-60" rx="40" ry="60" fill="#c9946a" ${stroke(3)}/><circle cx="0" cy="-140" r="36" fill="#c9946a" ${stroke(3)}/>`) +
    `<path d="M140 560 C130 480 160 430 200 410" stroke="#4a2a1a" stroke-width="10" fill="none"/><circle cx="210" cy="400" r="30" fill="#3a6a2a" ${stroke(3)}/>` +
    `<circle cx="200" cy="420" r="9" fill="#d84a2a" ${stroke(2)}/><circle cx="222" cy="414" r="9" fill="#d84a2a" ${stroke(2)}/>` +
    fireWheel(720, 480, 70) +
    fury(520, 300, 0.32, { armR: [[-100, -230], [-140, -270]] }) +
    shape('M500 1000 L500 700 L460 560 L400 560 L380 700 Z', '#3a160a', '#2a0c06', 0) +
    shape('M160 1000 L440 660 L520 660 L380 1000 Z', '#7a6a60', '#4a3a32', 3) +
    shape('M620 1000 L560 660 L640 660 L860 1000 Z', '#6a3a1a', '#3a1a0a', 3) +
    [0, 1, 2, 3, 4].map((i) => `<path d="M${590 + i * 4 + i * i * 6} ${700 + i * 60} L${650 + i * 30 + i * i * 6} ${700 + i * 60}" stroke="#2a0c06" stroke-width="5"/>`).join('') +
    glow(700, 900, 220, '#ff7a1a', 0.45) +
    shape('M0 1000 L0 820 C200 780 400 860 600 880 C800 900 900 860 1000 880 L1000 1000 Z', '#7a7068', '#4a4440', 4) +
    sparks(260, 50, 0, 780, 1000, 1000, '#c8c0b8', 4) +
    vignette(0.55)),

  // The Hill of Sisyphus
  HDS027: () => svg(
    redSky() +
    shape('M0 1000 L0 900 L1000 260 L1000 1000 Z', '#6a3a22', '#3a1a0e', 4) +
    `<path d="M80 900 L940 330" stroke="#3a1a0e" stroke-width="18" opacity="0.6"/>` +
    sisyphus(430, 640, 1.15) + boulder(700, 345, 120) +
    sparks(270, 30, 0, 0, 1000, 400, '#ffb46a', 3) +
    vignette(0.55)),

  // The River of Fire
  HDS028: () => svg(
    redSky() + batWings(780, 180, 0.6) +
    shape('M0 380 L1000 360 L1000 520 L0 520 Z', '#4a1a10', '#2a0c08', 3) +
    fireRiver(500, 860, 28) +
    lightBeam(0, 1000, 0, 1000, 480, 860, '#ffe08a', 0.15) +
    shape('M0 860 C300 840 700 860 1000 840 L1000 1000 L0 1000 Z', '#3a2a24', '#1a120e', 4) +
    hand(380, 1060, 1.1, 22, { pose: 'grip' }) + hand(620, 1060, 1.1, -22, { pose: 'grip', flip: true }) +
    bowl(500, 900, 1.6) +
    vignette(0.5)),

  // The Furies Wake
  HDS029: () => svg(
    redSky() +
    fury(220, 360, 0.4, { robe: '#2a6a3a', armR: [[-100, -230], [-140, -270]] }) +
    fury(500, 300, 0.45, { robe: '#7a1a26' }) +
    fury(790, 360, 0.4, { robe: '#c85a14', armR: [[-100, -230], [-140, -270]], flip: true }) +
    fireRiver(560, 880, 29) +
    `<path d="M380 880 C420 700 580 700 620 880" fill="none" stroke="${OL}" stroke-width="48"/><path d="M380 880 C420 700 580 700 620 880" fill="none" stroke="#7a7068" stroke-width="38"/>` +
    shape('M0 560 L0 1000 L170 1000 L200 560 Z', '#2a0c06', '#1a0604', 4) + `<path d="M90 600 L120 760 L80 900 L110 1000" stroke="#000" stroke-width="22" fill="none"/>` +
    hand(560, 1070, 1.05, -10, { pose: 'grip' }) + bowl(560, 930, 1.4, { ember: true }) +
    vignette(0.55)),

  // The Way Out of Tartarus
  HDS030: () => svg(
    sky('#3a1410', '#a85a2a') +
    shape('M0 400 L200 360 L380 420 L620 380 L1000 360 L1000 1000 L0 1000 Z', '#5a2a16', '#2a120a', 4) +
    shape('M560 380 C620 300 760 220 1000 180 L1000 240 C780 280 660 340 620 400 Z', '#c08a4a', '#7a4e22', 3) +
    fireRiver(560, 700, 30, { low: true }) +
    shape('M0 700 L1000 700 L1000 1000 L0 1000 Z', '#4a3a32', '#241a16', 3) +
    fury(640, 770, 0.8, { wingsUp: false, whip: true, armR: [[-110, -230], [-150, -260]], mood: 'neutral', eyes: 'normal' }) +
    hand(360, 1060, 1.1, 18, { pose: 'grip' }) + bowl(360, 920, 1.4, { ember: true }) +
    vignette(0.5)),

  // Chained in Tartarus (Game Over)
  HDS031: () => svg(
    `<rect width="1000" height="1000" fill="#050306"/>` +
    glow(500, 380, 380, '#5a1a10', 0.5) +
    fade(0.75, at(500, 380, 1, `<path d="M-300 260 C-320 0 -200 -180 0 -190 C200 -180 320 0 300 260 Z" fill="#1a1012" ${stroke(4, '#2a1a1a')}/>
      <ellipse cx="-110" cy="20" rx="60" ry="34" fill="#0a0606"/><ellipse cx="110" cy="20" rx="60" ry="10" fill="#0a0606"/>
      ${glow(-110, 20, 70, '#ff8a2a', 0.6)}<ellipse cx="-110" cy="20" rx="24" ry="24" fill="#ffb43a"/><ellipse cx="-110" cy="20" rx="8" ry="20" fill="#1a0a04"/>
      <path d="M-60 160 Q0 190 60 160" stroke="#2a1a1a" stroke-width="8" fill="none"/>`)) +
    L.g(chain(160, 1000, 300, 600) + chain(840, 1000, 700, 600) + chain(360, 1000, 420, 760) + chain(640, 1000, 580, 760)) +
    bowl(500, 940, 1.2, { out: true, tipped: false }) +
    vignette(0.7)),

  // The Fields of Elysium
  HDS032: () => svg(
    elysiumLand(500) + sunDisc(820, 140, 50) +
    oliveTree(300, 640, 0.5) + oliveTree(470, 630, 0.45) +
    `<rect x="250" y="630" width="300" height="16" fill="#a8743a" ${stroke(2.5)}/>` +
    [280, 320, 360, 400, 440, 480, 520].map((x, i) => hero(x, 640, 0.16, { armR: i % 2 ? 'up' : 'raise', cloak: ['#3a5aa8', '#a8282e', '#3a8a5a'][i % 3] })).join('') +
    goldenTree(780, 560, 0.35) +
    oliveTree(110, 900, 0.9, { fruit: '#3a2a4a' }) + oliveTree(900, 920, 0.8, { fruit: '#3a2a4a' }) +
    grass(320, 120, 600, 1000, '#5a9a3a') +
    column(40, 0, 1000, 110, { col: '#fbf6e8', shade: '#e0d8c0' }) + column(960, 0, 1000, 110, { col: '#fbf6e8', shade: '#e0d8c0' }) +
    `<rect x="0" y="0" width="1000" height="44" fill="#fbf6e8" ${stroke(4)}/>`),

  // The Feast of Heroes
  HDS033: () => svg(
    elysiumLand(420) + sunDisc(160, 120, 44) +
    oliveTree(150, 600, 0.8) + oliveTree(850, 600, 0.85) +
    `<rect x="0" y="560" width="1000" height="30" fill="#8a5a2a" ${stroke(3)}/>` +
    hero(250, 760, 0.6, { armR: 'raise', cloak: '#3a8a5a', beard: '#3a2a1a' }) + hero(420, 740, 0.55, { armR: 'up', cloak: '#a8282e', style: 'curly', hair: '#6a3a1a' }) +
    hero(580, 740, 0.55, { armR: 'raise', cloak: '#3a5aa8' }) +
    achilles(790, 850, 1.25, { mood: 'sad', eyes: 'closed' }) +
    table(720)),

  // The Endless Afternoon
  HDS034: () => svg(
    elysiumLand(420) + sunDisc(160, 120, 44) +
    oliveTree(150, 600, 0.8) + oliveTree(850, 600, 0.85) +
    `<ellipse cx="740" cy="640" rx="180" ry="40" fill="#3a6a2a" opacity="0.6"/>` +
    `<rect x="0" y="560" width="1000" height="30" fill="#8a5a2a" ${stroke(3)}/>` +
    hero(300, 740, 0.55, { armR: 'raise', cloak: '#3a8a5a', beard: '#3a2a1a' }) + hero(470, 740, 0.55, { armR: 'up', cloak: '#a8282e', style: 'curly', hair: '#6a3a1a' }) +
    table(720, { cup: false }) +
    `<path d="M750 720 L770 560 L870 560 L890 720 Z" fill="#a8743a" ${stroke(3)}/>` +
    hand(470, 1090, 1.0, 10, { pose: 'grip', sleeve: '#7a8aa0' }) +
    `<path d="M410 900 L530 900 L512 990 L428 990 Z" fill="#c08a4a" ${stroke(3)}/><ellipse cx="470" cy="900" rx="60" ry="16" fill="#ffd56a" ${stroke(3)}/>` +
    blur(3, wash('#ffe8a0', 0.2)) + wash('#ffe8a0', 0.18)),

  // The Grove of the Golden Bough
  HDS035: () => svg(
    sky('#7ac0e8', '#e8f6ff') + glow(500, 300, 600, '#fff2c0', 0.4) +
    shape('M0 640 C300 620 700 640 1000 620 L1000 1000 L0 1000 Z', '#7ac04a', '#4a8a2a', 4) +
    oliveTree(110, 680, 0.9) + oliveTree(900, 680, 0.9) +
    goldenTree(500, 700, 1.15) +
    bench(560, 860, 1.0) + sibyl(560, 840, 0.9) +
    grass(350, 80, 680, 1000, '#4a8a2a') +
    lightBeam(380, 620, 300, 760, 0, 900, '#fff2b0', 0.25)),

  // The Sibyl's Riddle
  HDS036: () => svg(
    sky('#9ad0ec', '#f0f8ff') +
    shape('M0 700 C300 680 700 700 1000 680 L1000 1000 L0 1000 Z', '#7ac04a', '#4a8a2a', 4) +
    bough(560, 200, 1.1, -20) +
    bench(500, 960, 2.2) + sibyl(500, 930, 2.4, { eyes: 'milky', mood: 'neutral' }) +
    vignette(0.35)),

  // The Bough Resists
  HDS037: () => svg(
    sky('#9ad0ec', '#f0f8ff') +
    blur(5, shape('M0 700 C300 680 700 700 1000 680 L1000 1000 L0 1000 Z', '#7ac04a', '#4a8a2a', 4) + bench(760, 820, 0.8) + sibyl(760, 800, 0.7)) +
    `<path d="M-20 520 C200 420 500 380 1020 360" stroke="#7a5a3a" stroke-width="80" fill="none"/>` +
    bough(260, 470, 2.2, -14, { glowOn: true }) +
    hand(380, 900, 1.2, 8, { pose: 'grip', cuts: true }) + hand(600, 880, 1.2, -6, { pose: 'grip', cuts: true, flip: true }) +
    vignette(0.35)),

  // The Golden Bough
  HDS038: () => svg(
    sky('#7ac0e8', '#e8f6ff') +
    shape('M0 640 C300 620 700 640 1000 620 L1000 1000 L0 1000 Z', '#7ac04a', '#4a8a2a', 4) +
    shape('M400 1000 C460 800 560 700 640 640 L680 640 C620 720 560 820 560 1000 Z', '#f2efe6', '#c8c4b8', 3) +
    bench(740, 700, 0.6) + `<path d="M700 650 l10 -4 l6 8 Z M760 652 l12 -2 l2 10 Z" fill="#b07a3a" ${stroke(1.5)}/>` +
    oliveTree(200, 680, 0.7) +
    hand(380, 1100, 1.2, 16, { pose: 'cup' }) + hand(620, 1100, 1.2, -16, { pose: 'cup', flip: true }) +
    bough(300, 900, 1.6, -12)),

  // The Isles of the Blessed (Game Over)
  HDS039: () => svg(
    elysiumLand(560) + sunDisc(500, 160, 54) +
    `<path d="M700 470 L700 420 L760 390 L820 420 L820 470 Z" fill="#fbf6e8" ${stroke(3)}/><path d="M690 424 L760 384 L830 424" fill="#c84a3a" ${stroke(3)}/>` +
    `<rect x="745" y="436" width="22" height="34" fill="#3a6aa8" ${stroke(2)}/>` +
    `<path d="M-40 -40 C200 60 400 80 520 40 C640 0 800 20 1040 -20 L1040 -40 Z" fill="#5a8a3a" ${stroke(4)}/>` +
    [[120, 60], [260, 90], [400, 80], [560, 60], [700, 50], [860, 40]].map(([x, y]) => `<path d="M${x} ${y} C${x + 20} ${y + 40} ${x + 50} ${y + 50} ${x + 70} ${y + 40} C${x + 50} ${y + 20} ${x + 30} ${y + 10} ${x} ${y} Z" fill="#7aa04a" ${stroke(2.5)}/>`).join('') +
    grass(390, 260, 800, 1000, '#4a8a2a', { h: 90 }) +
    wash('#fff0b0', 0.15)),

  // The Throne of Hades
  HDS040: () => svg(
    throneHall() +
    brazier(200, 760, 0.9, 'blue') + brazier(800, 760, 0.9, 'orange') + brazier(380, 700, 0.6, 'silver') + brazier(620, 700, 0.6, 'silver') +
    throne(440, 680, 0.85) + throne(700, 680, 0.6, true) +
    hades(440, 660, 0.95) + persephone(700, 660, 0.75, { seated: true, mood: 'neutral' }) +
    steps(700, 600) +
    flask(400, 790, 0.6, { sealed: true, full: true }) + bowl(500, 800, 0.55, { ember: true }) + bough(560, 800, 0.5, -10) +
    vignette(0.5)),

  // Hades' Condition
  HDS041: () => svg(
    throneHall() +
    `<path d="M120 760 L120 260 C120 200 240 200 240 260 L240 760 Z" fill="#c08a4a" ${stroke(4)}/>` +
    `<path d="M140 760 L140 270 C140 220 220 220 220 270 L220 760 Z" fill="#05040a" ${stroke(3)}/>` +
    [0, 1, 2, 3, 4].map((i) => `<rect x="${150 + i * 6}" y="${720 - i * 60}" width="${60 - i * 12}" height="14" fill="#2a2240" opacity="${1 - i * 0.15}"/>`).join('') +
    glow(180, 280, 50, '#ffe8b0', 0.5) +
    throne(560, 760, 1.2) +
    hades(560, 760, 1.3, { armR: [[-90, -170], [-80, -230]], mood: 'stern' }) +
    persephone(860, 800, 1.05, { armL: [[-70, -190], [-140, -200]], mood: 'sad' }) +
    vignette(0.55)),

  // The Long Ascent
  HDS042: () => svg(
    stairsUp(500, 300, { top: '#2e2a3c', riser: '#1a1626', wall: '#100c18' }) +
    glow(500, 600, 500, '#3a5a9a', 0.25) +
    hand(130, 820, 1.1, 30, { pose: 'open' }) +
    vignette(0.75)),

  // The Last Stair
  HDS043: () => svg(
    stairsUp(500, 360, { top: '#4a4458', riser: '#2a2436', wall: '#1a1622', lit: '#fff2c0' }) +
    `<path d="M420 360 L420 230 C420 180 580 180 580 230 L580 360 Z" fill="#fff8d8" ${stroke(3)}/>` +
    sky('#8ad0f8', '#e8f8ff', 220, 300).replace('<rect x="0"', '<rect x="430"').replace('width="1000"', 'width="140"') +
    lightBeam(420, 580, 160, 840, 360, 1000, '#fff2c0', 0.4) +
    hand(600, 820, 1.0, -8, { pose: 'reach' }) +
    `<rect x="0" y="900" width="1000" height="100" fill="#000" opacity="0.5"/>` +
    vignette(0.5)),

  // Out Into the Sun (Game Over)
  HDS044: () => svg(
    sky('#5ab4f0', '#d8f0ff') + sunDisc(160, 140, 50) +
    `<rect x="0" y="520" width="1000" height="480" fill="#2a8ac8"/>` + waves(440, 530, 900, '#bfe8ff', '#ffffff', 34) +
    fishingBoat(240, 600, 0.6) +
    cliffCape(true) +
    shape('M0 1000 L0 860 C200 820 500 840 700 800 C820 780 900 800 1000 790 L1000 1000 Z', '#b8946a', '#7a5a3a', 4) +
    theo(560, 1080, 1.9, { alive: true, wet: true, mood: 'smile', armL: 'out', armR: 'out' }) +
    wash('#fff4c0', 0.08)),

  // Looked Back (Game Over)
  HDS045: () => svg(
    `<rect width="1000" height="1000" fill="#0c0a14"/>` +
    [0, 1, 2, 3, 4, 5, 6].map((i) => {
      const y = 1000 - i * 120, w = 1000 - i * 110;
      return `<rect x="${500 - w / 2}" y="${y - 50}" width="${w}" height="${50}" fill="${['#3a3448', '#322c40', '#2a2438', '#221e30', '#1a1628', '#141020', '#0e0a18'][i]}" ${stroke(3)}/>`;
    }).join('') +
    glow(500, 380, 320, '#fff2c0', 0.25) +
    blur(10, `<ellipse cx="500" cy="760" rx="180" ry="120" fill="#2a2438" opacity="0.9"/>`) +
    theo(500, 1000, 1.7, { mood: 'sad', armR: [[-90, -260], [-120, -340]], ghost: true, op: 0.75 }) +
    blur(12, `<path d="M300 1000 C340 860 420 820 500 840 C580 820 660 860 700 1000 Z" fill="#14101e" opacity="0.95"/>`) +
    sparks(450, 30, 300, 700, 700, 1000, '#9aa4c8', 4) +
    `<path d="M120 960 L180 900 L220 950 M820 950 L870 880 L910 940" stroke="#000" stroke-width="6" fill="none"/>` +
    vignette(0.7)),

  // The Willing Exchange (Game Over)
  HDS046: () => svg(
    throneHall() +
    `<path d="M780 760 L780 360 C780 300 940 300 940 360 L940 760 Z" fill="#c08a4a" ${stroke(4)}/>` +
    `<path d="M800 760 L800 370 C800 320 920 320 920 370 L920 760 Z" fill="#2a3a5a" ${stroke(3)}/>` +
    `<circle cx="880" cy="420" r="18" fill="#eef2ff"/>` + L.asphodelField(460, 14, 640, 760, { x0: 805, x1: 915, scale: [0.2, 0.4] }) +
    throne(420, 700, 0.85) + hades(420, 690, 0.9, { mood: 'neutral', soft: true }) +
    steps(700, 520) +
    glow(380, 700, 260, '#fff1b0', 0.55) +
    theo(380, 860, 0.85, { alive: true, mood: 'neutral', eyes: 'wide' }) +
    persephone(820, 1240, 2.1, { armL: [[-90, -170], [-150, -130]], mood: 'smile', flip: true }) +
    vignette(0.5)),

  // Thief of the Dead (Game Over)
  HDS047: () => svg(
    `<rect width="1000" height="1000" fill="#1a1a30"/>` +
    `<rect x="0" y="720" width="1000" height="280" fill="#2a2236"/>` +
    `<rect x="120" y="180" width="300" height="280" fill="#2a3a6a" ${stroke(5)}/>` +
    sky('#1a2a5a', '#3a4a8a', 186, 380).replace('<rect x="0"', '<rect x="126"').replace('width="1000"', 'width="288"') +
    `<rect x="126" y="380" width="288" height="74" fill="#1a3a6a"/>` + `<circle cx="340" cy="250" r="30" fill="#eef2ff"/>` + glow(340, 250, 120, '#eef2ff', 0.4) +
    `<path d="M270 186 L270 454 M126 320 L414 320" stroke="#4a3a2a" stroke-width="10"/>` +
    lightBeam(130, 410, 300, 760, 460, 960, '#c8d8ff', 0.2) +
    `<path d="M520 1000 L560 900 L540 840 L600 780 L580 720 L620 640 L600 560 L640 480" fill="none" stroke="#ff4a2a" stroke-width="8"/>` +
    glow(580, 760, 160, '#ff3a1a', 0.35) + `<path d="M520 1000 L560 900 L540 840 L600 780 L580 720 L620 640 L600 560 L640 480" fill="none" stroke="#1a0a0a" stroke-width="3"/>` +
    hermes(720, 900, 1.25, { armL: [[-80, -170], [-60, -140]], armR: [[-80, -180], [-60, -240]], mood: 'sly', eyes: 'sly' }) +
    at(640, 740, 0.9, `<path d="M-40 0 C-44 -60 44 -60 40 0 L36 20 L-36 20 Z" fill="#14101a" ${stroke(3)}/><path d="M-30 -20 L30 -20" stroke="#4a3a6a" stroke-width="5"/>`) +
    shape('M-20 1000 L-20 880 C300 840 700 840 1020 880 L1020 1000 Z', '#4a5a8a', '#2a3460', 4) +
    `<path d="M-20 900 C300 860 700 860 1020 900" stroke="#6a7aa8" stroke-width="10" fill="none"/>` +
    vignette(0.6)),
};

function chain(x1, y1, x2, y2) {
  const len = Math.hypot(x2 - x1, y2 - y1), size = 30;
  const ang = (Math.atan2(y2 - y1, x2 - x1) * 180) / Math.PI;
  let s = '';
  for (let i = 0; i < Math.floor(len / (size * 1.25)); i++) {
    const cx = i * size * 1.25 + size / 2;
    s += i % 2 === 0
      ? `<ellipse cx="${cx}" cy="0" rx="${size * 0.82}" ry="${size * 0.48}" fill="none" stroke="${OL}" stroke-width="${size * 0.42}"/><ellipse cx="${cx}" cy="0" rx="${size * 0.82}" ry="${size * 0.48}" fill="none" stroke="#c08a4a" stroke-width="${size * 0.26}"/>`
      : `<rect x="${cx - size * 0.8}" y="${-size * 0.13}" width="${size * 1.6}" height="${size * 0.26}" rx="${size * 0.13}" fill="#8a5a2a" ${stroke(2)}/>`;
  }
  return g(s, `translate(${x1} ${y1}) rotate(${ang})`);
}

module.exports = pages;
