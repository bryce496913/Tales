// One image per story page (HDS000–HDS047), drawn from the player's point of
// view: the player is never in frame, apart from their own hands where the
// page calls for it. Scenes follow The_Descent_to_Hades_Story_Map.md.
const L = require('./lib');
const {
  svg, sky, shape, glow, ellipseGlow, vignette, wash, fog, at, g, rot, fade, place, stroke, OL, hand, blur, clip,
  theo, theoSitting, hermes, charon, persephone, hades, throne, fury, sisyphus, boulder, achilles, sibyl, judge, shade, shadeCrowd, cerberus,
  pomegranate, flask, bowl, bough, column, cypress, poplar, oliveTree, asphodel, asphodelField, grass, boatHull, ironGate, waves, stairsUp,
  sparks, stars, lightBeam, rain, flame, brazier, SKIN,
} = L;

const GOD = SKIN.god;
const THEO_SLEEVE = '#ffcf1f';

const {
  underSky, road, hills, milestone, caveFrame, blackRiver, lightning, sunDisc, memoryWisps, letheWater, meadowSky, fortress, fireRiver, redSky, figureKid,
} = require('./scenery');

// ---------------------------------------------------------------- pages

const pages = {
  // The Storm at Tainaron
  HDS000: () => svg(
    sky('#2a3a3a', '#5a7068') +
    lightning(240, 40, 1.1) +
    shape('M560 560 L600 380 L660 330 L700 360 L760 250 L820 300 L880 230 L1000 260 L1000 600 Z', '#1e2428', '#121618', 4) +
    `<ellipse cx="700" cy="560" rx="40" ry="50" fill="#050607" ${stroke(3)}/><ellipse cx="860" cy="570" rx="55" ry="60" fill="#050607" ${stroke(3)}/>` +
    shape('M0 560 C120 470 220 470 320 540 C420 610 520 470 640 500 C760 530 860 440 1000 520 L1000 1000 L0 1000 Z', '#2f6a5a', '#173a32', 4) +
    shape('M-40 700 C80 520 260 500 360 660 L300 700 Z', '#3f8a72', '#24564a', 4) +
    shape('M660 720 C760 520 940 500 1040 640 L1040 760 Z', '#3f8a72', '#24564a', 4) +
    waves(5, 600, 900, '#cfe8e0', '#ffffff', 40) +
    shape('M-20 1000 C120 830 880 830 1020 1000 Z', '#7a4a26', '#4a2a14', 5) +
    `<path d="M40 960 C200 860 800 860 960 960" fill="none" stroke="#9a6a3a" stroke-width="10"/>` +
    hand(330, 900, 1.05, 62, { pose: 'reach' }) +
    hand(700, 860, 0.95, -66, { pose: 'reach', skin: SKIN.pale, sleeve: THEO_SLEEVE, flip: true }) +
    sparks(8, 50, 400, 600, 640, 820, '#ffffff', 5) +
    rain(9, 220) + vignette(0.5)),

  // The Sea Cave
  HDS001: () => svg(
    `<rect width="1000" height="1000" fill="#1a1622"/>` +
    // the glowing cave mouth behind, to the left
    glow(150, 420, 360, '#3fd8a0', 0.45) +
    shape('M40 520 C30 380 120 300 200 300 C280 300 330 400 300 520 Z', '#9af0d0', '#2a9a7a', 4) +
    waves(11, 440, 515, '#d8fff0', '#6ad8b0', 10) +
    // carved doorway and stair down
    `<path d="M440 820 L440 380 C440 260 760 260 760 380 L760 820 Z" fill="#3a3448" ${stroke(4)}/>` +
    `<path d="M480 820 L480 400 C480 310 720 310 720 400 L720 820 Z" fill="#06050a" ${stroke(4)}/>` +
    [0, 1, 2, 3, 4, 5].map((i) => {
      const y = 820 - i * 46, w = 230 - i * 30;
      return `<path d="M${600 - w / 2 - 20} ${y} L${600 + w / 2 + 20} ${y} L${600 + w / 2} ${y - 30} L${600 - w / 2} ${y - 30} Z" fill="${['#4a4458', '#3e384c', '#332e40', '#282434', '#1e1a28', '#14121c'][i]}" ${stroke(2.5)}/>`;
    }).join('') +
    `<g opacity="0.75">${[0, 1, 2, 3, 4, 5, 6, 7].map((i) => `<path d="M${492 + i * 28} 288 l10 -18 l10 18 M${496 + i * 28} 300 l14 0" stroke="#c8bca0" stroke-width="4" fill="none" stroke-linecap="round"/>`).join('')}</g>` +
    fog(700, 4, '#6a90c8', 0.35, 10, 140, 460, 760) +
    caveFrame('#0e0c14') +
    shape('M0 1000 L0 860 C200 800 420 850 560 830 C720 810 860 850 1000 820 L1000 1000 Z', '#2a2632', '#141218', 4) +
    `<path d="M120 900 C200 880 300 890 360 900 M600 880 C700 870 800 880 860 870" stroke="#5a6a8a" stroke-width="5" opacity="0.6" fill="none" stroke-linecap="round"/>` +
    vignette(0.5)),

  // The Road of the Dead
  HDS002: () => svg(
    underSky('#141a30', '#4a3a6a') + stars(2, 60, 400, '#cfd8ff') +
    hills(520, 3, '#3a3450', '#221e34', 50) +
    road(520, 470, 760, '#9a96a4', '#5e5a6c') +
    shadeCrowd(12, 34, 480, 760, { x0: 340, x1: 700, scale: [0.08, 0.34], skip: (x, y) => Math.abs(x - (520 + (y - 470) * 0.5)) > 260 }) +
    theo(560, 530, 0.2, { back: true }) +
    hills(800, 8, '#2a2640', '#18142a', 30) +
    milestone(840, 990, 1.4) +
    hermes(760, 1000, 1.2, { armL: [[-60, -170], [-30, -140]], armR: [[-80, -170], [-60, -210]], mood: 'grin', eyes: 'sly' }) +
    vignette(0.45)),

  // Lost to the Sea (Game Over)
  HDS003: () => svg(
    sky('#8a929a', '#b4bac0', 0, 480) +
    shape('M0 480 L1000 480 L1000 1000 L0 1000 Z', '#6a7680', '#2a343e', 0) +
    `<path d="M0 480 L1000 480" stroke="#4a545e" stroke-width="3"/>` +
    waves(14, 500, 980, '#9aa6b0', '#c8d0d6', 34) +
    fade(0.18, [0, 1, 2, 3, 4].map((i) => `<rect x="${420 - i * 10}" y="${720 + i * 50}" width="${160 + i * 20}" height="30" fill="#c8d4e0"/>`).join('')) +
    sparks(15, 18, 300, 700, 700, 980, '#d8e4ee', 6) +
    vignette(0.4)),

  // The Grasping Shades
  HDS004: () => svg(
    underSky('#2a2840', '#4a4660') +
    shadeCrowd(21, 14, 520, 640, { scale: [0.5, 0.75], op: 0.55, back: false }) +
    [[120, 1080, 1.5, 0], [880, 1080, 1.5, 1], [300, 980, 1.25, 0], [700, 960, 1.2, 1], [500, 900, 1.0, 0]]
      .map(([x, y, s, f]) => shade(x, y, s, { back: false, arms: 'reach', op: 0.7, flip: !!f })).join('') +
    hand(470, 1060, 1.0, 12, { pose: 'open' }) +
    hand(1060, 830, 1.0, -98, { pose: 'grip', skin: GOD, sleeve: '#7fc0ea' }) +
    vignette(0.9, '#8a8a96')),

  // The Guide of Souls
  HDS005: () => svg(
    underSky('#141a30', '#4a3a6a') +
    fade(0.22, at(250, 230, 1, `<path d="M-50 60 C-70 -40 -30 -80 0 -80 C30 -80 70 -40 50 60 Z M-30 50 L-30 -40 M-10 50 L-10 -50 M10 50 L10 -50 M30 50 L30 -40" fill="none" stroke="#e8ecff" stroke-width="8" stroke-linecap="round"/>`)) +
    fade(0.18, cerberus(760, 340, 0.35, { snarl: false, fur: '#d8dcff' })) +
    hills(560, 5, '#3a3450', '#221e34', 40) +
    `<rect x="0" y="540" width="1000" height="30" fill="#07060c" opacity="0.8"/>` + fog(550, 6, '#8a8aa8', 0.45, 14, 60) +
    road(620, 560, 820, '#9a96a4', '#5e5a6c') +
    shadeCrowd(22, 22, 570, 800, { x0: 420, x1: 820, scale: [0.08, 0.3] }) +
    hermes(330, 1010, 1.55, { armL: [[-60, -170], [-30, -140]], armR: 'out', mood: 'smile', coinHand: 'l', flip: true }) +
    vignette(0.45)),

  // The Messenger's Price
  HDS006: () => svg(
    underSky('#1a1a34', '#4a3a6a') +
    blur(8, hills(620, 4, '#3a3450', '#221e34', 40) + road(500, 600, 900, '#7a7684', '#4e4a5c')) +
    hermes(500, 1480, 3.0, { armL: [[-50, -170], [-12, -150]], armR: [[-110, -170], [-80, -200]], coinHand: 'l', mood: 'sly', eyes: 'sly', cloak: false }) +
    vignette(0.6)),

  // The Banks of the Styx
  HDS007: () => svg(
    underSky('#0e1224', '#2c2848') +
    fog(480, 7, '#8a90a8', 0.6, 20, 120) +
    blackRiver(500, 780) +
    boatHull(470, 700, 520) +
    charon(470, 680, 0.82, { pole: true, armL: 'offer', palm: true }) +
    fog(560, 17, '#9a9ab8', 0.35, 10, 60) +
    shape('M0 760 C300 740 700 760 1000 740 L1000 1000 L0 1000 Z', '#2a2632', '#141218', 4) +
    shadeCrowd(23, 10, 760, 860, { x0: 0, x1: 260, scale: [0.28, 0.5] }) +
    shadeCrowd(24, 8, 760, 860, { x0: 760, x1: 1000, scale: [0.28, 0.5] }) +
    hand(720, 1030, 1.1, -14, { pose: 'open', ring: true }) +
    sparks(25, 14, 640, 820, 800, 900, '#d8c8a0', 3) +
    vignette(0.5)),

  // Taken by the Styx (Game Over)
  HDS008: () => svg(
    underSky('#2a2a3a', '#5a5a6a') +
    shape('M0 600 C300 590 700 610 1000 596 L1000 640 L0 640 Z', '#26222e', '#141218', 3) +
    shadeCrowd(26, 14, 590, 610, { scale: [0.08, 0.1] }) +
    boatHull(740, 618, 160) + `${glow(722, 595, 20, '#ff8a2a', 0.9)}${glow(734, 595, 20, '#ff8a2a', 0.9)}` +
    `<path d="M720 600 L740 520" stroke="${OL}" stroke-width="4"/>` +
    fog(560, 8, '#c8c8d8', 0.6, 22, 140) +
    shape('M0 640 L1000 640 L1000 1000 L0 1000 Z', '#0c0a12', '#030206', 0) +
    waves(27, 650, 990, '#2a2840', '#4a4864', 30) +
    memoryWisps(28, 14, 80, 920, 720, 980) +
    vignette(0.6)),

  // Charon's Question
  HDS009: () => svg(
    sky('#4a4a5a', '#6a6a78') +
    fog(400, 9, '#d8d8e4', 0.7, 26, 600) +
    fade(0.25, shadeCrowd(29, 6, 700, 760, { x0: 200, x1: 800, scale: [0.4, 0.5] })) +
    shape('M0 1000 L0 820 L360 600 L640 600 L1000 820 L1000 1000 Z', '#1e1a24', '#0a080e', 4) +
    shape('M120 1000 L400 640 L600 640 L880 1000 Z', '#2a2432', '#16121c', 3) +
    [0, 1, 2].map((i) => `<path d="M${200 + i * 60} ${900 - i * 90} L${800 - i * 60} ${900 - i * 90}" stroke="#3a3244" stroke-width="10"/>`).join('') +
    charon(560, 640, 0.95, { back: true, pole: true }) +
    glow(530, 330, 30, '#ff8a2a', 0.9) +
    vignette(0.55)),

  // Thrown Ashore
  HDS010: () => svg(
    underSky('#0e0c16', '#2a1e30') +
    ironGate(500, 470, 300, 260) +
    glow(500, 420, 240, '#ff3a2a', 0.18) +
    [[420, 400, 0.6], [500, 380, 0.7], [580, 400, 0.6]].map(([x, y, s]) => glow(x - 14 * s, y, 22, '#ff3a2a', 0.9) + glow(x + 14 * s, y, 22, '#ff3a2a', 0.9) +
      `<ellipse cx="${x - 14 * s}" cy="${y}" rx="${7 * s}" ry="${4 * s}" fill="#ff5a3a"/><ellipse cx="${x + 14 * s}" cy="${y}" rx="${7 * s}" ry="${4 * s}" fill="#ff5a3a"/>`).join('') +
    shape('M0 480 C300 470 700 490 1000 470 L1000 1000 L0 1000 Z', '#2a2632', '#16141c', 4) +
    sparks(30, 80, 0, 500, 1000, 850, '#4a4658', 3) +
    shape('M0 860 C200 820 400 880 600 850 C800 820 900 870 1000 850 L1000 1000 L0 1000 Z', '#0c0a12', '#050408', 3) +
    waves(31, 870, 990, '#3a3858', '#5a5878', 16) +
    hand(260, 1010, 1.0, 14, { pose: 'open' }) + hand(740, 1010, 1.0, -14, { pose: 'open', flip: true }) +
    `<path d="M180 870 C220 850 300 850 330 870 M670 870 C700 850 780 850 820 870" stroke="#3a3644" stroke-width="10" fill="none" stroke-linecap="round"/>` +
    vignette(0.6)),

  // The Hound of Hades
  HDS011: () => svg(
    underSky('#0a0c18', '#24203a') +
    `<rect x="250" y="190" width="500" height="460" fill="#05040a"/>` +
    ironGate(500, 650, 500, 460) +
    shape('M0 650 L1000 650 L1000 1000 L0 1000 Z', '#2a2632', '#141218', 4) +
    brazier(110, 740, 1.1, 'blue') + brazier(890, 740, 1.1, 'blue') +
    shadeCrowd(32, 6, 640, 700, { x0: 380, x1: 620, scale: [0.24, 0.3], op: 0.5 }) +
    cerberus(500, 930, 1.0) +
    vignette(0.55)),

  // Torn by Cerberus (Game Over)
  HDS012: () => svg(
    sky('#1a0608', '#5a1014') +
    rot(500, 500, -14, `<rect x="-200" y="560" width="1400" height="700" fill="#140a0c"/>` +
      ironGate(500, 700, 700, 520) +
      `<rect x="150" y="180" width="700" height="520" fill="#000" opacity="0.4"/>` +
      cerberus(500, 1260, 1.75) +
      `<path d="M200 980 L260 900 L300 960 L360 920 L330 1000 Z" fill="#2f4a6e" ${stroke(3)}/>`) +
    glow(500, 300, 500, '#ff2a1a', 0.2) +
    vignette(0.85)),

  // Persephone's Garden
  HDS013: () => svg(
    sky('#1a2240', '#4a4a70') + stars(13, 90, 450) +
    glow(780, 140, 120, '#eef2ff', 0.5) + `<circle cx="780" cy="140" r="42" fill="#eef2ff" ${stroke(3, '#9aa4c8')}/>` +
    poplar(80, 640, 460) + poplar(200, 610, 380) + poplar(820, 620, 420) + poplar(940, 650, 480) +
    shape('M0 600 C300 580 700 600 1000 590 L1000 1000 L0 1000 Z', '#3a4a4a', '#1e2a2a', 4) +
    cerberus(230, 650, 0.32, { asleep: true }) +
    asphodelField(33, 70, 610, 1000, { scale: [0.35, 1.3], skip: (x, y) => x > 360 && x < 640 && y > 640 }) +
    `<rect x="700" y="790" width="210" height="26" rx="6" fill="#b8b4a8" ${stroke(3)}/><rect x="720" y="814" width="22" height="60" fill="#9a968a" ${stroke(3)}/><rect x="870" y="814" width="22" height="60" fill="#9a968a" ${stroke(3)}/>` +
    flask(760, 770, 0.55) + bowl(860, 784, 0.5) +
    persephone(500, 960, 1.6, { armR: 'offer', fruit: true, mood: 'smile' }) +
    vignette(0.45)),

  // Bound by the Seeds (Game Over)
  HDS014: () => svg(
    sky('#6a6a72', '#8a8a90') +
    poplar(80, 640, 460, '#9a9aa0') + poplar(920, 640, 460, '#9a9aa0') +
    shape('M0 600 C300 580 700 600 1000 590 L1000 1000 L0 1000 Z', '#6a6e6c', '#4a4e4c', 4) +
    `<path d="M600 520 L1000 500" stroke="#8a8a8e" stroke-width="18"/>` +
    shadeCrowd(34, 6, 500, 512, { x0: 640, x1: 980, scale: [0.07, 0.08], col: '#d0d0d6' }) +
    theo(700, 516, 0.07, { back: true }) +
    asphodelField(35, 50, 610, 1000, { col: '#c8c8c8', scale: [0.35, 1.2] }) +
    persephone(330, 760, 0.9, { mood: 'sad', grey: true, armL: [[-60, -170], [-20, -170]], armR: [[-60, -170], [-20, -160]] }) +
    hand(640, 1040, 1.25, -8, { pose: 'cup' }) +
    pomegranate(640, 880, 1.25, { split: true, missing: 6 }) +
    vignette(0.5)),

  // HOME — The Crossroads of Judgment
  HDS015: () => svg(
    underSky('#0e1226', '#3a3058') + stars(15, 70, 380) +
    // distant palace with sealed bronze doors
    `<path d="M380 470 L380 330 L500 270 L620 330 L620 470 Z" fill="#14101e" ${stroke(4)}/>` +
    [400, 440, 560, 600].map((x) => `<rect x="${x - 8}" y="340" width="16" height="130" fill="#241c34" ${stroke(2)}/>`).join('') +
    `<rect x="470" y="370" width="60" height="100" fill="#c08a4a" ${stroke(3)}/><path d="M500 370 L500 470" stroke="${OL}" stroke-width="3"/>` +
    glow(500, 420, 80, '#c08a4a', 0.4) +
    // ground and the three roads
    glow(120, 520, 220, '#c8ccd4', 0.4) + glow(560, 560, 260, '#ff5a1a', 0.55) + glow(880, 440, 260, '#ffe27a', 0.6) +
    shape('M0 500 C300 480 700 500 1000 470 L1000 1000 L0 1000 Z', '#2a2638', '#16141e', 4) +
    shape('M380 1000 L470 760 L80 520 L140 520 L520 740 L560 560 L600 560 L560 740 L900 460 L940 470 L620 760 L640 1000 Z', '#6e6a78', '#3e3a48', 3) +
    shape('M470 760 L80 520 L140 520 L520 740 Z', '#b8bcc4', '#7a7e88', 3) +
    shape('M520 740 L560 560 L600 560 L560 740 Z', '#c08a4a', '#7a4e22', 3) +
    shape('M560 740 L900 460 L940 470 L620 760 Z', '#f2efe6', '#c8c4b8', 3) +
    fog(520, 16, '#c8ccd8', 0.22, 6, 40, -40, 240) +
    cypress(500, 720, 520, { w: 120 }) +
    `<rect x="300" y="640" width="400" height="20" fill="#5a5666" ${stroke(3)}/>` +
    [380, 500, 620].map((x) => `<path d="M${x - 50} 760 L${x - 50} 600 C${x - 50} 580 ${x + 50} 580 ${x + 50} 600 L${x + 50} 760 Z" fill="#8a8696" ${stroke(3)}/>`).join('') +
    judge(380, 770, 0.38) + judge(500, 770, 0.38, { beard: '#d8d4cc' }) + judge(620, 770, 0.38) +
    vignette(0.5)),

  // The Asphodel Meadows
  HDS016: () => svg(
    meadowSky() + fog(380, 18, '#ffffff', 0.4, 14, 120) +
    hills(470, 19, '#9aa094', '#7a8074', 30) +
    `<path d="M0 470 C300 466 600 474 1000 462" stroke="#e8f0f8" stroke-width="6" opacity="0.8"/>` +
    hills(560, 20, '#8a9084', '#5e6458', 40) +
    asphodelField(36, 160, 480, 1000, { scale: [0.15, 1.3], skip: (x, y) => Math.abs(x - 560) < 80 && y > 640 && y < 760 }) +
    shadeCrowd(37, 10, 520, 700, { scale: [0.12, 0.32], back: false, op: 0.5 }) +
    theoSitting(560, 760, 0.62) +
    vignette(0.35)),

  // The Brother Who Forgot
  HDS017: () => svg(
    meadowSky() + hills(520, 21, '#9aa094', '#7a8074', 30) +
    asphodelField(38, 60, 520, 760, { scale: [0.25, 0.6] }) +
    theo(500, 1290, 2.4, { ghost: true, mood: 'blank', armL: 'forward', armR: 'forward' }) +
    glow(500, 940, 120, '#ffe08a', 0.6) +
    hand(380, 1080, 1.15, 24, { pose: 'grip' }) + hand(620, 1080, 1.15, -24, { pose: 'grip', flip: true }) +
    vignette(0.35)),

  // The River of Forgetting
  HDS018: () => svg(
    meadowSky() + hills(420, 22, '#9aa094', '#7a8074', 30) +
    asphodelField(40, 40, 420, 500, { scale: [0.15, 0.3] }) +
    letheWater(500, 760) +
    [[160, 690], [320, 640], [480, 600], [640, 570], [790, 540]].map(([x, y], i) => `<ellipse cx="${x}" cy="${y}" rx="${60 - i * 6}" ry="${18 - i * 2}" fill="#8a8e96" ${stroke(3)}/>`).join('') +
    memoryWisps(41, 10, 100, 900, 560, 740, '#ffffff') +
    shape('M0 740 C300 760 700 730 1000 760 L1000 1000 L0 1000 Z', '#8a9084', '#5e6458', 4) +
    shade(250, 820, 0.42, { op: 0.55 }) + shade(860, 800, 0.38, { op: 0.55 }) +
    asphodelField(42, 26, 780, 1000, { scale: [0.8, 1.3], skip: (x) => x > 560 }) +
    hand(760, 1060, 1.1, -10, { pose: 'grip' }) + flask(760, 920, 0.9) +
    vignette(0.35)),

  // The Reflection
  HDS019: () => svg(
    shape('M0 0 L1000 0 L1000 1000 L0 1000 Z', '#c8cfd8', '#9aa4b2', 0) +
    waves(43, 40, 960, '#e8eef4', '#7e8a9c', 40) +
    clip(`<ellipse cx="500" cy="440" rx="330" ry="270"/>`,
      sky('#7ac8f0', '#d8f0ff', 100, 480) + sunDisc(760, 230, 40) +
      `<rect x="0" y="420" width="1000" height="300" fill="#3a9ad0"/>` + waves(44, 430, 560, '#bfe8ff', '#ffffff', 14) +
      shape('M150 760 C220 560 420 580 540 600 C680 610 800 640 860 760 Z', '#c89a6a', '#9a6a3a', 4) +
      theo(430, 640, 0.42, { mood: 'smile', armL: 'out' }) +
      figureKid(560, 640, 0.42)) +
    `<ellipse cx="500" cy="440" rx="330" ry="270" fill="none" stroke="#f4f8ff" stroke-width="10" opacity="0.8"/>` +
    glow(500, 440, 420, '#ffffff', 0.25) +
    hand(500, 1060, 1.1, 0, { pose: 'grip' }) + flask(500, 920, 0.9) +
    vignette(0.4)),

  // Echoes in the Water
  HDS020: () => svg(
    sky('#6a7686', '#9aa4b2') +
    shape('M0 380 L1000 380 L1000 1000 L0 1000 Z', '#b8c2ce', '#7a8698', 0) +
    waves(45, 400, 980, '#e4ecf4', '#5a6a80', 46) +
    glow(500, 360, 360, '#cfe8ff', 0.6) +
    fade(0.75, at(500, 420, 1, `
      <path d="M-260 60 C-200 -60 -100 -160 40 -140 C120 -130 200 -60 260 40" fill="none" stroke="#e8f4ff" stroke-width="16" stroke-linecap="round"/>
      <g transform="rotate(-24)"><path d="M-130 20 L130 20 L100 70 L-100 70 Z" fill="#a8c8e8" ${stroke(4, '#4a6a90')}/><path d="M-120 20 L-120 -20 M110 20 L110 -10" stroke="#4a6a90" stroke-width="6"/></g>`)) +
    fade(0.85, hand(420, 470, 0.55, 70, { pose: 'reach', sleeve: '#9ab8e0', skin: '#e8f2ff' }) + hand(620, 520, 0.55, -100, { pose: 'reach', sleeve: '#fff0a0', skin: '#f2f6ff', flip: true })) +
    [[200, 900], [800, 920]].map(([x, y]) => `<ellipse cx="${x}" cy="${y}" rx="120" ry="30" fill="#6a6e76" ${stroke(3)}/>`).join('') +
    waves(46, 860, 990, '#f4f8fc', '#ffffff', 16) +
    vignette(0.45)),

  // The Voice You Woke
  HDS021: () => svg(
    meadowSky() + hills(520, 23, '#9aa094', '#7a8074', 30) +
    letheWater(560, 700) +
    theo(520, 1240, 2.2, { ghost: false, mood: 'pleading', eyes: 'wide', armL: [[-90, -140], [-60, -40]] }) +
    hand(500, 1110, 1.1, 0, { pose: 'cup' }) +
    `<ellipse cx="500" cy="905" rx="58" ry="16" fill="#e8ecf2" opacity="0.9"/>` +
    hand(250, 980, 0.8, 70, { pose: 'grip', skin: '#e2d8d0', sleeve: THEO_SLEEVE }) +
    vignette(0.35)),

  // The Water of Lethe
  HDS022: () => svg(
    meadowSky() +
    blur(6, hills(500, 24, '#9aa094', '#7a8074', 30) + letheWater(540, 640) + cypress(800, 520, 160, { w: 40 }) +
      `<path d="M200 1000 C400 800 700 620 800 520" stroke="#a8a8a4" stroke-width="60" fill="none"/>`) +
    hand(380, 1080, 1.2, 18, { pose: 'grip' }) + hand(620, 1080, 1.2, -18, { pose: 'grip', flip: true }) +
    flask(500, 900, 1.9, { sealed: true, full: true, frost: true }) +
    vignette(0.4)),

  // The Sweet Forgetting (Game Over)
  HDS023: () => svg(
    meadowSky() + hills(480, 25, '#b8bcb4', '#a8aca4', 20) +
    asphodelField(47, 140, 480, 1000, { col: '#f4f4f0', scale: [0.15, 1.2], op: 0.7 }) +
    shadeCrowd(48, 8, 520, 720, { scale: [0.12, 0.3], op: 0.35 }) +
    theoSitting(680, 620, 0.3) +
    wash('#ffffff', 0.35) + vignette(0.9, '#ffffff')),
};

module.exports = { ...pages, ...require('./pages2') };
