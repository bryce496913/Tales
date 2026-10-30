// One image per story page (ANU000–ANU047), drawn from the player's point of
// view: the traveller is never in frame. Scenes that still match the copy are
// reused from scenes.js; the rest are drawn here.
const L = require('./lib');
const M = require('./lib2');
const O = require('./scenes');
const { svg, room, glow, ellipseGlow, vignette, linGrad, radGrad, stroke, at, g, OL } = L;

const goldRoom = { top: '#7a5228', bottom: '#5a3a1c', side: '#45290f', floorA: '#6a4523', floorB: '#3e2612', ceil: '#2c190b' };
const home = { top: '#f1d2a2', bottom: '#e0b880', side: '#c99a62', floorA: '#9a6234', floorB: '#6a3e1e', ceil: '#b98a5a' };

const sky = (top, bottom) => {
  const gr = linGrad([[0, top], [1, bottom]]);
  return `${gr.def}<rect width="1000" height="1000" fill="${gr.url}"/>`;
};
const dune = (d, top, bottom) => {
  const gr = linGrad([[0, top], [1, bottom]]);
  return `${gr.def}<path d="${d}" fill="${gr.url}" ${stroke(3)}/>`;
};
const sandRipples = (y0, y1, seed, col, op = 0.35) => {
  const r = L.rng(seed);
  let s = '';
  for (let y = y0; y < y1; y += 26 + r() * 20) {
    const x = r() * 700 - 100, w = 200 + r() * 300;
    s += `<path d="M${x} ${y} q${w / 4} -12 ${w / 2} 0 t${w / 2} 0" fill="none" stroke="${col}" stroke-width="3" opacity="${op}" stroke-linecap="round"/>`;
  }
  return s;
};
const amberEyes = (x, y, s = 1, col = '#ffb43a') =>
  glow(x - 30 * s, y, 50 * s, col, 0.7) + glow(x + 30 * s, y, 50 * s, col, 0.7) +
  `<path d="M${x - 50 * s} ${y} Q${x - 30 * s} ${y - 14 * s} ${x - 10 * s} ${y} Q${x - 30 * s} ${y + 8 * s} ${x - 50 * s} ${y} Z" fill="${col}"/>
   <path d="M${x + 10 * s} ${y} Q${x + 30 * s} ${y - 14 * s} ${x + 50 * s} ${y} Q${x + 30 * s} ${y + 8 * s} ${x + 10 * s} ${y} Z" fill="${col}"/>`;
const visionCircle = (x, y, r, content, col = '#ffd36b') =>
  glow(x, y, r * 1.6, col, 0.45) + `<circle cx="${x}" cy="${y}" r="${r}" fill="#3a2410" ${stroke(4)}/>
  <circle cx="${x}" cy="${y}" r="${r}" fill="none" stroke="${col}" stroke-width="8"/>${content}`;
const ghostly = { skin: '#d8ecff', hair: '#8fb0d8', cloth: '#a8c8f0' };
// A soul wearing the face of someone you know.
const soulPerson = (x, y, sc, o = {}) => M.person(x, y, sc, { ...ghostly, op: 0.55, mood: 'sad', ...o });
const shadowHand = (x, y, sc = 1, rot = 0) => g(`
  <path d="M-16 0 L-14 -40 C-18 -60 -8 -80 6 -78 L16 -130 L28 -127 L24 -78 L36 -132 L48 -129 L40 -74 L56 -116 L68 -110 L52 -60 L70 -76 L80 -66 L54 -24 C50 -8 46 0 44 0 Z M-16 0 L-20 200 L48 200 L44 0 Z" fill="#0a0612" stroke="#2a1e3a" stroke-width="3"/>`,
  `translate(${x} ${y}) rotate(${rot}) scale(${sc})`);
const hallFrame = (x, y, sc, opts = {}) => {
  // Empty frame of the great scales with three hollow sockets.
  const { pieces = false } = opts;
  return at(x, y, sc, `
    <path d="M-110 0 L110 0 L80 -38 L-80 -38 Z" fill="#f2b833" ${stroke(3)}/>
    <rect x="-14" y="-380" width="28" height="345" fill="#f2b833" ${stroke(3)}/>
    <rect x="-200" y="-392" width="400" height="22" rx="8" fill="#f2b833" ${stroke(3)}/>
    <circle cx="0" cy="-400" r="34" fill="${pieces ? '#26a59a' : '#1a1208'}" ${stroke(3)}/>
    ${pieces ? glow(0, -400, 80, '#5fe0d0', 0.6) : ''}
    <path d="M-150 -440 C-170 -470 -170 -520 -150 -560 C-130 -520 -130 -470 -150 -440 Z" fill="${pieces ? '#ffe08a' : '#1a1208'}" ${stroke(3)}/>
    <path d="M150 -430 C110 -460 110 -500 132 -510 C142 -514 150 -506 150 -496 C150 -506 158 -514 168 -510 C190 -500 190 -460 150 -430 Z" fill="${pieces ? '#d6283f' : '#1a1208'}" ${stroke(3)}/>
    <path d="M-150 -392 L-150 -440 M150 -392 L150 -430" stroke="#f2b833" stroke-width="8"/>`);
};
const gate = (x, y, w, h, symbol, sealed = false) => {
  let s = L.archDoor(x, y, w, h, '#0a0612', '#3a3448', 16);
  if (sealed) {
    s += glow(x, y - h / 2, w, '#4aa3ff', 0.55);
    for (let i = 0; i < 4; i++) s += L.flame(x - w * 0.36 + i * w * 0.24, y, w * 0.32, h * 0.9, true);
  } else s += glow(x, y - h / 2, w * 0.6, '#ffd36b', 0.25);
  s += at(x, y - h - 34, 1, symbol);
  return s;
};

const P = {
  ANU000: O.ANU000,
  ANU001: O.ANU001,
  ANU002: O.ANU002,

  // 003. Lost in the Sand: the doorway is gone and the dunes all look the same.
  ANU003: () => {
    let s = sky('#05070f', '#1c1c30');
    s += dune('M0 470 C160 430 300 470 460 440 C640 410 820 460 1000 430 L1000 1000 L0 1000 Z', '#3e3a4c', '#2c2838');
    s += L.jackalStatue(780, 452, 0.42, true, { plinth: false, body: '#05050a', hi: '#14141c', eye: '#ffc43a' });
    s += dune('M0 560 C200 520 420 590 620 560 C800 530 900 560 1000 550 L1000 1000 L0 1000 Z', '#6a6070', '#4a4456');
    s += dune('M0 700 C240 650 520 720 760 690 C880 676 940 690 1000 700 L1000 1000 L0 1000 Z', '#9a8a74', '#6a5c4c');
    s += sandRipples(720, 1000, 3, '#4a3e32', 0.45);
    const r = L.rng(30);
    for (let i = 0; i < 8; i++) {
      const t = i / 7;
      s += `<ellipse cx="${500 + (i % 2 ? 14 : -14) - t * 60}" cy="${990 - t * 260}" rx="${12 - t * 6}" ry="${18 - t * 9}" fill="#4a3e32" opacity="${0.6 * (1 - t)}"/>`;
    }
    s += L.fog(980, 31, '#c9b8a0', 0.35, 14, 120);
    return svg(s + vignette(0.7));
  },

  // 004. The Jackal Temple, with the carving shaped like you on the back wall.
  ANU004: () => O.ANU003().replace('</svg>', '').replace(/<rect width="1000" height="1000" fill="url\(#rg\d+\)"\/>\s*$/, '') +
    `<g opacity="0.5">${M.person(500, 470, 0.72, { skin: '#3a2410', hair: '#3a2410', cloth: '#3a2410', mood: 'neutral' })}</g>` + vignette(0.5) + '</svg>',
  ANU005: O.ANU005,
  ANU006: O.ANU006,

  // 007. Run from the God: the stairs are gone; a corridor of pale fog and familiar faces.
  ANU007: () => {
    let s = room({ x0: 380, y0: 220, x1: 620, y1: 560 }, { top: '#3a3448', bottom: '#2a2436', side: '#1d1828', floorA: '#3a3446', floorB: '#1a1624', ceil: '#141018' }, { blocks: false });
    s += `<rect x="380" y="220" width="240" height="340" fill="#06040a"/>`;
    s += L.fog(420, 71, '#e6eaf2', 0.55, 14, 260) + `<rect x="380" y="220" width="240" height="340" fill="#06040a" opacity="0.6"/>`;
    s += soulPerson(260, 760, 0.9, { cloth: '#9fc4f0', hairLong: true, dress: true });
    s += soulPerson(740, 720, 0.85, { mood: 'neutral', flip: true });
    s += soulPerson(420, 560, 0.55, { op: 0.45 }) + soulPerson(600, 580, 0.5, { op: 0.4, hairLong: true });
    s += L.ghost(150, 380, 0.6, { op: 0.6, mood: 'o' }) + L.ghost(860, 340, 0.55, { op: 0.6, flip: true });
    s += `<g stroke="#cfe6ff" stroke-width="3" fill="none" opacity="0.5" stroke-linecap="round"><path d="M120 560 q30 -20 60 0 t60 0"/><path d="M760 480 q30 -20 60 0 t60 0"/><path d="M420 300 q30 -20 60 0 t60 0"/></g>`;
    // the god's shadow walks beside you along the wall
    s += `<defs><filter id="sil7"><feColorMatrix type="matrix" values="0 0 0 0 0.02 0 0 0 0 0.01 0 0 0 0 0.05 0 0 0 0.55 0"/></filter></defs>`;
    s += `<g filter="url(#sil7)">${L.anubis(120, 900, 0.75)}</g>`;
    s += amberEyes(140, 445, 0.35);
    return svg(s + vignette(0.65));
  },

  ANU008: O.ANU008,
  ANU009: O.ANU009,
  ANU010: O.ANU010,

  // 011. HOME: the Hall of Gates.
  ANU011: () => {
    let s = `<rect width="1000" height="1000" fill="#0c0a12"/>`;
    // star-painted dome
    s += `<path d="M0 0 L1000 0 L1000 300 C800 230 200 230 0 300 Z" fill="#141238"/>` + `<g>${L.stars(11, 120, 260)}</g>`;
    s += `<path d="M0 300 C200 230 800 230 1000 300" stroke="#c49a4a" stroke-width="10" fill="none"/>`;
    // curved black stone wall
    const wall = linGrad([[0, '#2a2632'], [1, '#16141c']]);
    s += wall.def + `<path d="M0 300 C200 230 800 230 1000 300 L1000 700 C800 650 200 650 0 700 Z" fill="${wall.url}"/>`;
    s += `<path d="M0 700 C200 650 800 650 1000 700 L1000 1000 L0 1000 Z" fill="#221e2a" ${stroke(3)}/>`;
    s += `<ellipse cx="500" cy="820" rx="360" ry="110" fill="none" stroke="#c49a4a" stroke-width="4" opacity="0.6"/>`;
    // carved warning around the frame
    const r = L.rng(12);
    for (let i = 0; i < 44; i++) {
      const a = Math.PI * (0.04 + 0.92 * (i / 43));
      s += L.glyph(Math.floor(r() * 8), 500 - Math.cos(a) * 330, 820 + Math.sin(a) * 96, 1.1, '#f2b833', 0.75);
    }
    // three gates: feather, heart, level scales
    s += gate(170, 640, 150, 300, L.feather(0, 22, 0.16, 0, '#f2b833', '#b9801b'));
    s += gate(500, 600, 170, 320, L.heart(0, 0, 0.45, '#f2b833'));
    s += gate(830, 640, 150, 300, `<path d="M-40 0 L40 0 M0 0 L0 -26 M-40 0 l-14 24 h28 Z M40 0 l-14 24 h28 Z" fill="#f2b833" stroke="#f2b833" stroke-width="5" stroke-linejoin="round"/>`);
    s += hallFrame(500, 880, 0.8);
    s += L.brazier(320, 700, 0.5) + L.brazier(680, 700, 0.5);
    return svg(s + vignette(0.5));
  },

  ANU012: O.ANU012,
  ANU013: O.ANU013,
  ANU014: O.ANU014,
  ANU015: O.ANU015,

  // 016. The Broken Chain: the last chain on Ammit's neck, anchored in the wall.
  ANU016: () => {
    let s = room({ x0: 140, y0: 100, x1: 860, y1: 580 }, goldRoom);
    s += L.torch(220, 340) + L.torch(780, 340);
    // anchor ring in the wall
    s += `<rect x="80" y="420" width="70" height="90" fill="#5a5856" ${stroke(3)}/><circle cx="150" cy="465" r="26" fill="none" stroke="${OL}" stroke-width="16"/><circle cx="150" cy="465" r="26" fill="none" stroke="#9a9894" stroke-width="10"/>`;
    s += M.ammit(640, 900, 1.0, { flip: true, mouth: 'closed', chains: false });
    // collar and the last chain
    s += `<rect x="440" y="560" width="40" height="110" rx="10" fill="#7e7c7a" ${stroke(3)} transform="rotate(-20 460 615)"/>`;
    s += L.chainLinks(176, 470, 450, 600, 24);
    s += glow(310, 532, 50, '#fff3c4', 0.8) + `<path d="M296 520 L306 532 L298 544" stroke="#fff3c4" stroke-width="5" fill="none"/>`;
    // vision: the scribe lifting the Heart Pan, watched from the shadows
    s += visionCircle(780, 230, 120, `<g opacity="0.95">${M.scribe(770, 350, 0.3, { desk: false, standing: true })}</g>
      <path d="M800 252 Q830 282 860 252 Z" fill="#f2b833" ${stroke(2)}/>
      <ellipse cx="712" cy="210" rx="6" ry="3" fill="#c58cff"/><ellipse cx="730" cy="210" rx="6" ry="3" fill="#c58cff"/>`, '#c58cff');
    return svg(s + vignette(0.5));
  },

  // 017. Swallowed by the Fog: falling into a pit of grasping shadows.
  ANU017: () => {
    let s = `<rect width="1000" height="1000" fill="#07050c"/>`;
    s += glow(500, 120, 260, '#cfd6e6', 0.5) + `<ellipse cx="500" cy="110" rx="180" ry="60" fill="#d9dee9" opacity="0.6"/>`;
    s += L.fog(130, 17, '#dfe4ee', 0.5, 10, 120);
    const r = L.rng(17);
    for (let i = 0; i < 6; i++) {
      const x = 120 + i * 150 + r() * 40, y = 420 + r() * 300;
      s += `<g opacity="0.55">${M.person(x, y, 0.7, { skin: '#3a3448', hair: '#1a1624', cloth: '#2a2436', mood: 'neutral', op: 0.8 })}</g>`;
      s += `<ellipse cx="${x - 9}" cy="${y - 196}" rx="5" ry="6" fill="#07050c"/><ellipse cx="${x + 9}" cy="${y - 196}" rx="5" ry="6" fill="#07050c"/>`;
    }
    s += shadowHand(120, 860, 1.2, 20) + shadowHand(320, 900, 1.1, 6) + shadowHand(560, 920, 1.2, -4) + shadowHand(780, 870, 1.2, -18) + shadowHand(900, 700, 1.0, -40) + shadowHand(60, 680, 1.0, 40);
    return svg(s + vignette(0.75));
  },

  ANU018: O.ANU017,
  ANU019: O.ANU018,
  ANU020: O.ANU020,
  ANU021: O.ANU021,
  ANU022: O.ANU022,
  ANU023: O.ANU023,
  ANU024: O.ANU024,
  ANU025: O.ANU025,
  ANU026: O.ANU026,

  // 027. Restoring the Scales: whole again, the gates beginning to close.
  ANU027: () => {
    let s = room({ x0: 200, y0: 60, x1: 800, y1: 620 }, { ...goldRoom, top: '#22150c', bottom: '#4a2e18' }, { tileRows: 7 });
    s += L.archDoor(330, 600, 110, 220, '#0d1a3a', '#8a6a3a') + L.archDoor(670, 600, 110, 220, '#0d1a3a', '#8a6a3a');
    s += `<rect x="290" y="390" width="80" height="210" fill="#3a2a1c" ${stroke(2.5)}/><rect x="630" y="440" width="80" height="160" fill="#3a2a1c" ${stroke(2.5)}/>`;
    s += L.pillar(110, 40, 900, 90) + L.pillar(890, 40, 900, 90);
    s += L.anubis(270, 900, 0.85, { arm: 'reach' });
    s += L.scales(600, 920, 0.95, { glowCol: '#ffd36b', right: L.feather(0, 140, 0.45, 75, '#fff3c4', '#e8b84a') });
    s += L.balanceStone(600, 545, 0.5);
    s += `<g stroke="#ffe7a6" stroke-width="4" opacity="0.6" fill="none" stroke-linecap="round"><path d="M600 960 l-60 30 M600 960 l60 30 M560 940 l-90 10 M640 940 l90 10"/></g>`;
    return svg(s + vignette(0.5));
  },

  // 028. Lord of the Tomb: the view from the black throne.
  ANU028: () => {
    let s = room({ x0: 380, y0: 200, x1: 620, y1: 520 }, { ...goldRoom, top: '#3a2414', bottom: '#2a180c' }, { tileRows: 8 });
    s += L.archDoor(500, 520, 110, 220, '#ffd98a', '#8a6a3a') + glow(500, 430, 160, '#ffd36b', 0.5);
    // statues kneel, torches bend toward you
    const rowL = [[300, 600, 0.45], [210, 720, 0.7], [80, 900, 1.05]];
    rowL.forEach(([x, y, sc]) => (s += `<g transform="rotate(10 ${x} ${y})">${L.jackalStatue(x, y, sc)}</g>` + `<g transform="rotate(-10 ${1000 - x} ${y})">${L.jackalStatue(1000 - x, y, sc, true)}</g>`));
    [[350, 360, 0.6], [240, 330, 0.8]].forEach(([x, y, sc]) => (s += `<g transform="rotate(14 ${x} ${y})">${L.torch(x, y, sc)}</g><g transform="rotate(-14 ${1000 - x} ${y})">${L.torch(1000 - x, y, sc)}</g>`));
    s += L.ghost(420, 560, 0.35, { op: 0.4 }) + L.ghost(580, 560, 0.35, { op: 0.4 }) + L.ghost(500, 500, 0.3, { op: 0.35 });
    // the throne's arms and the three pieces beside you
    s += `<path d="M0 760 L120 760 L160 800 L160 1000 L0 1000 Z M1000 760 L880 760 L840 800 L840 1000 L1000 1000 Z" fill="#141018" ${stroke(4)}/>
      <path d="M0 780 L130 780 M1000 780 L870 780" stroke="#f2b833" stroke-width="8"/>`;
    s += glow(100, 700, 90, '#ffd36b', 0.6) + L.feather(100, 750, 0.35, 0, '#ffe08a', '#e8b84a');
    s += glow(900, 720, 90, '#5fe0d0', 0.5) + L.balanceStone(900, 720, 0.6);
    return svg(s + vignette(0.6));
  },

  // 029. Released: waking in hospital, looking down the bed to the window.
  ANU029: () => {
    const ward = { top: '#d9ece6', bottom: '#bcd9d1', side: '#9fc2b8', floorA: '#b9c6c9', floorB: '#8e9da2', ceil: '#e8f2ef' };
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 560 }, ward, { blocks: false, tileRows: 5, tileCols: 8 });
    s += `<rect x="460" y="160" width="300" height="270" fill="#9fd4f5" ${stroke(4)}/>
      <circle cx="700" cy="220" r="36" fill="#fff3b0"/>
      <path d="M610 160 L610 430 M460 290 L760 290" stroke="#e8f2ef" stroke-width="12"/>
      <rect x="444" y="424" width="332" height="24" fill="#f4f8f6" ${stroke(3)}/>`;
    s += glow(560, 410, 110, '#fff3b0', 0.55) + L.jackalStatue(540, 426, 0.36, false, { plinth: false });
    s += L.lightBeam(460, 760, 330, 720, 448, 1000, '#fff6cc', 0.35);
    s += `<rect x="240" y="220" width="160" height="120" rx="10" fill="#4a5458" ${stroke(3)}/><rect x="252" y="232" width="136" height="96" rx="6" fill="#0e1a14"/>
      <path d="M256 290 L296 290 L306 260 L318 316 L328 278 L338 290 L384 290" stroke="#5aff9a" stroke-width="4" fill="none" stroke-linejoin="round"/>
      ${glow(320, 280, 100, '#5aff9a', 0.25)}<rect x="312" y="340" width="14" height="300" fill="#9aa4a8" ${stroke(2.5)}/>`;
    // foot of the bed and blanket in the foreground
    s += `<path d="M0 820 C300 760 700 760 1000 820 L1000 1000 L0 1000 Z" fill="#8fc0e0" ${stroke(3.5)}/>
      <path d="M60 870 C340 820 660 820 940 870 M120 930 C380 890 620 890 880 930" stroke="#6aa0c8" stroke-width="5" fill="none"/>
      <path d="M220 820 C300 780 380 790 420 800 C460 780 540 780 600 810" stroke="#6aa0c8" stroke-width="4" fill="none"/>
      <path d="M140 760 L140 660 L860 660 L860 760" fill="none" stroke="${OL}" stroke-width="16"/><path d="M140 760 L140 660 L860 660 L860 760" fill="none" stroke="#c9d0d4" stroke-width="10"/>
      <rect x="200" y="686" width="600" height="18" rx="6" fill="#c9d0d4" ${stroke(2.5)}/>`;
    return svg(s + vignette(0.25));
  },

  // 030. The Scales Restored: waking by the trucks, a golden feather in the sand.
  ANU030: () => {
    let s = sky('#f7b46a', '#fde3b0');
    s += glow(780, 420, 260, '#fff3c4', 0.7) + `<circle cx="780" cy="420" r="60" fill="#fff3c4"/>`;
    s += dune('M0 470 C200 430 400 470 600 440 C800 420 900 450 1000 440 L1000 1000 L0 1000 Z', '#e8b877', '#d9a464');
    // the last of the temple sinking beneath the sand
    s += `<path d="M560 452 L580 420 L700 420 L720 452 Z" fill="#1c1a22" ${stroke(3)}/><path d="M600 440 L680 440" stroke="#f2b833" stroke-width="4"/>`;
    s += L.fog(470, 33, '#f7d39a', 0.5, 10, 40);
    s += dune('M0 600 C240 570 520 620 760 590 C880 576 940 590 1000 600 L1000 1000 L0 1000 Z', '#f0c88a', '#e0b070');
    s += sandRipples(620, 1000, 34, '#c2915a', 0.45);
    // expedition trucks waiting
    const truck = (x, y, sc, body) => at(x, y, sc, `
      <path d="M-200 -40 L-200 -150 L60 -150 L60 -40 Z" fill="${body}" ${stroke(3.5)}/>
      <path d="M60 -40 L60 -190 L150 -190 L200 -120 L210 -40 Z" fill="${body}" ${stroke(3.5)}/>
      <path d="M80 -175 L140 -175 L182 -122 L80 -122 Z" fill="#9cc8e0" ${stroke(3)}/>
      <rect x="-210" y="-60" width="430" height="24" fill="#5a5a5a" ${stroke(3)}/>
      ${[-130, 130].map(wx => `<circle cx="${wx}" cy="-30" r="44" fill="#2a2420" ${stroke(3)}/><circle cx="${wx}" cy="-30" r="18" fill="#9a9894" ${stroke(2.5)}/>`).join('')}`);
    s += truck(230, 640, 0.75, '#e9e2d0') + truck(520, 600, 0.5, '#c9a86a');
    s += glow(560, 860, 200, '#ffd36b', 0.7) + L.feather(560, 900, 0.75, 70, '#ffe08a', '#e8b84a');
    return svg(s + vignette(0.3));
  },

  // 031. Pulled Through the Glass: kneeling in fog, the heartbeat just ahead.
  ANU031: () => {
    let s = sky('#c9ccd8', '#8a8a9a');
    s += `<path d="M0 640 L1000 640 L1000 1000 L0 1000 Z" fill="#6a6670" ${stroke(3)}/>`;
    s += L.floorTiles({ x0: 300, x1: 700, y1: 640 }, 6, 6);
    s += `<g opacity="0.45">${M.heartJar(200, 300, 0.8)}${M.heartJar(820, 260, 0.7)}${M.heartJar(680, 140, 0.5)}</g>`;
    s += glow(500, 470, 260, '#ff5a5a', 0.55) + glow(500, 470, 120, '#ffb0a0', 0.6);
    s += `<g fill="none" stroke="#ff8a8a" stroke-width="5" opacity="0.7"><ellipse cx="500" cy="470" rx="90" ry="90"/><ellipse cx="500" cy="470" rx="150" ry="150" opacity="0.6"/><ellipse cx="500" cy="470" rx="210" ry="210" opacity="0.35"/></g>`;
    s += L.heart(500, 480, 0.6, '#ff6a6a');
    s += L.fog(300, 35, '#f2f3f8', 0.75, 18, 500) + L.fog(880, 36, '#f2f3f8', 0.8, 14, 160);
    return svg(s + vignette(0.4));
  },

  // 032. Devoured by Ammit: the jaws close.
  ANU032: () => {
    let s = `<rect width="1000" height="1000" fill="#1e0a08"/>`;
    s += glow(500, 520, 420, '#7a1f2a', 0.8);
    const teeth = (y, up, n) => {
      let t = '';
      for (let i = 0; i < n; i++) {
        const x = 60 + (880 * (i + 0.5)) / n;
        t += `<path d="M${x - 26} ${y} L${x} ${y + (up ? -70 : 70)} L${x + 26} ${y} Z" fill="#fffaf0" ${stroke(3)}/>`;
      }
      return t;
    };
    s += `<path d="M-40 0 L1040 0 L1040 330 C800 400 200 400 -40 330 Z" fill="#4f9a4a" ${stroke(4)}/>
      <path d="M-40 290 C200 360 800 360 1040 290 L1040 340 C800 410 200 410 -40 340 Z" fill="#c4495a"/>`;
    s += teeth(372, false, 11);
    s += `<path d="M-40 1000 L1040 1000 L1040 720 C800 650 200 650 -40 720 Z" fill="#4f9a4a" ${stroke(4)}/>
      <path d="M-40 760 C200 690 800 690 1040 760 L1040 720 C800 650 200 650 -40 720 Z" fill="#c4495a"/>`;
    s += teeth(690, true, 11);
    s += `<path d="M0 80 Q100 50 200 80 M800 80 Q900 50 1000 80 M300 160 Q400 130 500 160 Q600 130 700 160" stroke="#357035" stroke-width="10" fill="none" stroke-linecap="round"/>`;
    s += `<ellipse cx="500" cy="530" rx="300" ry="90" fill="#0a0202"/>`;
    s += L.chainLinks(0, 900, 300, 980, 22) + L.chainLinks(1000, 920, 720, 990, 22);
    return svg(s + vignette(0.6));
  },

  ANU033: O.ANU033,
  ANU034: O.ANU034,
  ANU035: O.ANU035,
  ANU036: O.ANU036,
  ANU037: O.ANU037,
  ANU038: O.ANU038,
  ANU039: O.ANU039,

  // 040. A Peaceful Death: the soft light of home, seen from the sofa.
  ANU040: () => {
    const dusk = { ...home, top: '#c9a07a', bottom: '#a87e5a', side: '#7a5a42', ceil: '#6a4a36', floorA: '#6a4026', floorB: '#3e2614' };
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 600 }, dusk, { blocks: false, tileRows: 5, tileCols: 9 });
    s += `<rect x="330" y="170" width="260" height="250" fill="#5a4a8a" ${stroke(4)}/>
      <rect x="330" y="330" width="260" height="90" fill="#e88a6a"/>
      <circle cx="520" cy="350" r="30" fill="#ffd38a"/>
      <path d="M460 170 L460 420 M330 290 L590 290" stroke="#6a4026" stroke-width="10"/>`;
    s += glow(760, 420, 300, '#ffc86a', 0.55);
    s += `<path d="M760 640 L760 450" stroke="#4a2a1a" stroke-width="8"/><path d="M710 450 L810 450 L785 380 L735 380 Z" fill="#f6d39a" ${stroke(3)}/>`;
    s += `<path d="M190 160 L250 180 L232 280 L260 360 L200 420 L176 300 Z" fill="#4b2b15" opacity="0.6" ${stroke(2)}/>`;
    // coffee table, and the one you love sitting beside you
    s += `<path d="M260 820 L700 820 L740 880 L220 880 Z" fill="#a66a34" ${stroke(3)}/><rect x="380" y="780" width="60" height="44" rx="6" fill="#f4ead2" ${stroke(2.5)}/>`;
    s += M.person(880, 1160, 1.6, { dress: true, cloth: '#f7efe0', hairLong: true, hair: '#2a1a10', mood: 'smile', flip: true, armOut: 1 });
    s += `<path d="M0 940 C200 900 600 900 1000 940 L1000 1000 L0 1000 Z" fill="#8a3a3a" ${stroke(4)}/>`;
    const fade = radGrad([[0.45, '#fff6e8', 0], [1, '#fff6e8', 0.8]], 0.5, 0.5, 0.72);
    s += `${fade.def}<rect width="1000" height="1000" fill="${fade.url}"/>`;
    return svg(s);
  },

  ANU041: O.ANU041,
  ANU042: O.ANU042,
  ANU043: O.ANU043,
  ANU044: O.ANU044,
  ANU045: O.ANU045,

  // 046. The Voice You Saved: the memory of home cracks like glass.
  ANU046: () => {
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 640 }, home, { blocks: false, tileRows: 5, tileCols: 9 });
    s += `<rect x="560" y="200" width="200" height="240" fill="#bfe6ff" ${stroke(4)}/><path d="M660 200 L660 440 M560 320 L760 320" stroke="#8a5a2a" stroke-width="10"/>`;
    // doorway with the freed soul calling your name
    s += L.archDoor(330, 640, 170, 380, '#e6eaf2', '#a66a34', 16);
    s += glow(330, 460, 200, '#8fc4ff', 0.6);
    s += soulPerson(300, 640, 0.95, { dress: true, hairLong: true, hair: '#e8f2ff', op: 0.45 });
    s += soulPerson(360, 640, 1.0, { cloth: '#8fb0d8', op: 0.45 });
    s += soulPerson(330, 640, 0.65, { op: 0.75, mood: 'o' });
    s += `<g stroke="#cfe6ff" stroke-width="4" fill="none" opacity="0.8" stroke-linecap="round"><path d="M430 330 q20 -14 40 0 t40 0"/><path d="M440 380 q20 -14 40 0 t40 0"/><path d="M430 430 q20 -14 40 0"/></g>`;
    // cracks across the whole memory, fog showing through
    s += `<g fill="#f2f3f8" opacity="0.9"><path d="M600 470 L660 520 L640 600 L700 660 L620 640 L560 560 Z"/><path d="M820 700 L900 760 L860 860 L780 800 Z"/></g>`;
    s += glow(660, 560, 80, '#ff6a6a', 0.6);
    s += `<g stroke="#2a1708" stroke-width="4" fill="none" stroke-linejoin="round">
      <path d="M600 470 L520 380 L540 260 L480 150 M600 470 L760 460 L880 360 L1000 340 M600 470 L560 620 L460 760 L420 1000 M600 470 L720 640 L820 700 L1000 820 M520 380 L420 400 M760 460 L780 560 M560 620 L640 760"/></g>`;
    s += `<g stroke="#ffffff" stroke-width="2" fill="none" opacity="0.8"><path d="M604 474 L524 384 L544 264 M604 474 L764 464 L884 364 M604 474 L564 624 L464 764"/></g>`;
    return svg(s + vignette(0.35));
  },

  // 047. Defy the Gods: the desert under red stars, a jackal-headed shadow at your feet.
  ANU047: () => {
    let s = sky('#1a0508', '#4a1418');
    s += L.stars(47, 160, 520, '#ff6a5a');
    s += glow(500, 300, 400, '#ff3a3a', 0.15);
    s += `<path d="M0 560 C200 520 400 560 600 530 C800 510 900 540 1000 530 L1000 1000 L0 1000 Z" fill="#7a3a2a" ${stroke(3)}/>`;
    // the torn doorway behind the rebel, souls pouring out
    s += `<path d="M560 540 L590 330 L640 360 L660 300 L700 350 L740 320 L760 540 Z" fill="#05040a" ${stroke(3)}/>` + glow(660, 440, 150, '#c58cff', 0.5);
    s += L.ghost(620, 360, 0.35, { op: 0.6 }) + L.ghost(720, 300, 0.3, { op: 0.5 }) + L.ghost(820, 260, 0.3, { op: 0.45 }) + L.ghost(500, 280, 0.28, { op: 0.4 });
    s += `<path d="M0 640 C260 600 560 660 800 630 C900 620 960 630 1000 640 L1000 1000 L0 1000 Z" fill="#a8583a" ${stroke(3)}/>`;
    s += sandRipples(660, 1000, 47, '#6a2a1a', 0.45);
    s += M.rebel(360, 760, 0.85);
    // your shadow, with the head of a jackal
    s += `<g opacity="0.75" fill="#1a0806">
      <path d="M420 1000 C430 920 450 860 470 820 L530 820 C550 860 570 920 580 1000 Z"/>
      <path d="M470 830 C460 790 470 760 490 750 L484 700 L500 740 L508 740 L514 696 L522 746 C534 752 544 760 560 762 L600 770 C604 776 600 782 594 782 L548 786 C538 800 530 820 530 830 Z"/></g>`;
    return svg(s + vignette(0.55));
  },
};

module.exports = P;
