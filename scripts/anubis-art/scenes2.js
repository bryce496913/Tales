// Scenes for the pages added in the HOME-hub story map (000, 029, 033–045).
const L = require('./lib');
const M = require('./lib2');
const { svg, room, glow, ellipseGlow, vignette, linGrad, stroke, at, g, OL } = L;

const goldRoom = { top: '#7a5228', bottom: '#5a3a1c', side: '#45290f', floorA: '#6a4523', floorB: '#3e2612', ceil: '#2c190b' };
const dustRoom = { top: '#4a3420', bottom: '#5a3e22', side: '#3a2614', floorA: '#5e4426', floorB: '#3a2612', ceil: '#24160a' };
const home = { top: '#f1d2a2', bottom: '#e0b880', side: '#c99a62', floorA: '#9a6234', floorB: '#6a3e1e', ceil: '#b98a5a' };

const sky = (top, bottom) => {
  const gr = linGrad([[0, top], [1, bottom]]);
  return `${gr.def}<rect width="1000" height="1000" fill="${gr.url}"/>`;
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

// Outlined smoke / dust puffs, like the smoke in the Sphinx car-crash art.
const puffs = (pts, fill, line = OL, w = 3) =>
  pts.map(([x, y, r]) => `<circle cx="${x}" cy="${y}" r="${r}" fill="${fill}" ${stroke(w, line)}/>`).join('') +
  pts.map(([x, y, r]) => `<circle cx="${x}" cy="${y}" r="${r - w}" fill="${fill}"/>`).join('');

const rubble = (x0, x1, y0, y1, n, seed, col = '#8a7458') => {
  const r = L.rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) {
    const x = x0 + r() * (x1 - x0), y = y0 + r() * (y1 - y0), w = 18 + r() * 40;
    s += `<rect x="${x.toFixed(0)}" y="${y.toFixed(0)}" width="${w.toFixed(0)}" height="${(w * 0.7).toFixed(0)}" rx="4" fill="${col}" ${stroke(2.5)} transform="rotate(${(r() * 70).toFixed(0)} ${x.toFixed(0)} ${y.toFixed(0)})"/>`;
  }
  return s;
};

// Pale grasping hand; origin at the wrist, fingers up.
const hand = (x, y, sc = 1, rot = 0, col = '#bcd8f5', line = '#3e5a85') => g(`
  <path d="M-16 0 L-14 -40 C-18 -60 -8 -80 6 -78 L16 -130 L28 -127 L24 -78 L36 -132 L48 -129 L40 -74 L56 -116 L68 -110 L52 -60 L70 -76 L80 -66 L54 -24 C50 -8 46 0 44 0 Z" fill="${col}" ${stroke(3, line)}/>
  <path d="M-16 0 L-20 160 L48 160 L44 0" fill="${col}" ${stroke(3, line)}/>`,
  `translate(${x} ${y}) rotate(${rot}) scale(${sc})`);

// Expedition truck, side view, facing right. Origin: ground under the middle.
const truck = (x, y, sc = 1, body = '#e9e2d0', flip = false) => at(x, y, sc, `
  <ellipse cx="0" cy="0" rx="220" ry="16" fill="#000" opacity="0.25"/>
  <path d="M-200 -40 L-200 -150 L60 -150 L60 -40 Z" fill="${body}" ${stroke(3.5)}/>
  <path d="M60 -40 L60 -190 L150 -190 L200 -120 L210 -40 Z" fill="${body}" ${stroke(3.5)}/>
  <path d="M80 -175 L140 -175 L182 -122 L80 -122 Z" fill="#9cc8e0" ${stroke(3)}/>
  <path d="M92 -168 L104 -168 L96 -132" stroke="#ffffff" stroke-width="5" opacity="0.7"/>
  <rect x="-190" y="-182" width="230" height="20" fill="#7a5a3a" ${stroke(2.5)}/>
  <rect x="-170" y="-215" width="70" height="36" fill="#6a7a4a" ${stroke(2.5)}/><rect x="-90" y="-208" width="60" height="28" fill="#b27a3a" ${stroke(2.5)}/>
  <rect x="-210" y="-60" width="430" height="24" fill="#5a5a5a" ${stroke(3)}/>
  <path d="M-180 -110 L40 -110" stroke="#c9a86a" stroke-width="10"/>
  <rect x="194" y="-96" width="20" height="16" fill="#ffe08a" ${stroke(2)}/>
  ${[-130, 130].map(wx => `<circle cx="${wx}" cy="-30" r="44" fill="#2a2420" ${stroke(3)}/><circle cx="${wx}" cy="-30" r="18" fill="#9a9894" ${stroke(2.5)}/>`).join('')}`, flip);

const scrollWalls = (seed) => {
  let c = '';
  const cub = (x0, y0, cols, rows, w, h) => {
    for (let i = 0; i < cols; i++) for (let j = 0; j < rows; j++) {
      const x = x0 + i * w, y = y0 + j * h;
      c += `<rect x="${x}" y="${y}" width="${w}" height="${h}" fill="#3a2210" ${stroke(2.5)}/>`;
      for (let k = 0; k < 3; k++) {
        const cx = x + w * (0.25 + k * 0.25), cy = y + h * (0.45 + (k % 2) * 0.2);
        c += `<circle cx="${cx}" cy="${cy}" r="${h * 0.18}" fill="#efe0b8" ${stroke(1.5)}/><circle cx="${cx}" cy="${cy}" r="${h * 0.06}" fill="#8a6a3a"/>`;
      }
    }
  };
  cub(180, 130, 8, 4, 80, 70);
  return c;
};

const unrolled = (x, y, len, rot, seed) => {
  const r = L.rng(seed);
  let lines = '';
  for (let i = 12; i < len - 20; i += 18) lines += `<path d="M${i} -10 l${8 + r() * 6} 0 M${i} 0 l${6 + r() * 8} 0 M${i} 10 l${8 + r() * 4} 0" stroke="#3a2a1a" stroke-width="2.5"/>`;
  return g(`<path d="M0 -24 L${len} -18 L${len} 22 L0 24 Z" fill="#efe0b8" ${stroke(2.5)}/>${lines}
    <ellipse cx="0" cy="0" rx="9" ry="25" fill="#d9c592" ${stroke(2.5)}/>`, `translate(${x} ${y}) rotate(${rot})`);
};

const fireCluster = (x, y, sc = 1, n = 4, seed = 1) => {
  const r = L.rng(seed);
  let s = glow(x, y - 60 * sc, 170 * sc, '#ff8a2a', 0.6);
  for (let i = 0; i < n; i++) s += L.flame(x + (i - (n - 1) / 2) * 34 * sc, y, (50 + r() * 30) * sc, (90 + r() * 80) * sc);
  return s;
};

const spiralStair = (x, y, sc = 1, glowCol = '#4aa3ff') => at(x, y, sc, `
  ${glow(0, -80, 160, glowCol, 0.45)}
  <path d="M-90 0 L-90 -200 A90 90 0 0 1 90 -200 L90 0 Z" fill="#c49a4a" ${stroke(3)}/>
  <path d="M-70 0 L-70 -196 A70 70 0 0 1 70 -196 L70 0 Z" fill="#120a05" ${stroke(3)}/>
  ${[0, 1, 2, 3, 4].map(i => `<path d="M${-60 + i * 8} ${-20 - i * 34} L${50 - i * 22} ${-34 - i * 34} L${50 - i * 22} ${-14 - i * 34} L${-60 + i * 8} ${0 - i * 34} Z" fill="rgb(${150 - i * 22},${105 - i * 16},${60 - i * 10})" ${stroke(2)}/>`).join('')}`);

module.exports = {
  // 000. The Lost Expedition
  ANU000: () => {
    let s = sky('#e98a4a', '#f6d39a');
    // Wall of red sand rising over the horizon
    s += `<path d="M180 640 C200 520 260 400 340 330 C420 240 560 170 760 140 C860 126 940 130 1000 136 L1000 640 Z" fill="#b8492c" ${stroke(3.5)}/>`;
    s += puffs([[300, 420, 80], [360, 330, 90], [460, 250, 100], [580, 200, 110], [720, 170, 120], [870, 160, 120], [990, 170, 110], [240, 520, 70]], '#c9583a');
    s += puffs([[420, 420, 90], [560, 360, 110], [720, 330, 130], [880, 320, 130], [520, 520, 100], [700, 500, 120], [880, 500, 120]], '#a83e24');
    s += `<g stroke="#e8875a" stroke-width="6" fill="none" opacity="0.7" stroke-linecap="round">
      <path d="M380 380 q40 -30 90 -10"/><path d="M600 290 q50 -30 110 -10"/><path d="M800 260 q50 -26 100 -6"/><path d="M640 460 q50 -30 110 -10"/></g>`;
    // dunes
    s += `<path d="M0 600 C200 570 360 620 560 610 C760 600 880 580 1000 600 L1000 1000 L0 1000 Z" fill="#e6b877" ${stroke(3)}/>`;
    s += sandRipples(640, 1000, 31, '#b8864a', 0.45);
    s += `<path d="M0 780 C300 740 600 760 1000 720" stroke="#c99a5a" stroke-width="60" opacity="0.35" fill="none"/>`;
    s += truck(380, 760, 0.85, '#e9e2d0') + truck(760, 700, 0.6, '#c9a86a');
    // guide pointing at the storm, and the photographer
    s += M.person(620, 860, 0.75, { cloth: '#7a6a4a', skin: '#a8704a', point: true, mood: 'stern' });
    s += `<path d="M590 640 C600 620 650 620 660 640 Z" fill="#e9e2d0" ${stroke(2.5)}/><rect x="580" y="636" width="90" height="10" fill="#e9e2d0" ${stroke(2)}/>`;
    s += L.hero(160, 1060, 0.95, { turn: 0.5 });
    s += L.fog(980, 32, '#e8a46a', 0.5, 14, 80);
    return svg(s + vignette(0.35));
  },

  // 029. Released: waking in hospital
  ANU029: () => {
    const ward = { top: '#d9ece6', bottom: '#bcd9d1', side: '#9fc2b8', floorA: '#b9c6c9', floorB: '#8e9da2', ceil: '#e8f2ef' };
    let s = room({ x0: 140, y0: 100, x1: 860, y1: 620 }, ward, { blocks: false, tileRows: 5, tileCols: 8 });
    // window, sunlight and the jackal on the sill
    s += `<rect x="560" y="170" width="240" height="250" fill="#9fd4f5" ${stroke(4)}/>
      <circle cx="740" cy="230" r="34" fill="#fff3b0"/>
      <path d="M680 170 L680 420 M560 290 L800 290" stroke="#e8f2ef" stroke-width="12"/>
      <rect x="544" y="414" width="272" height="24" fill="#f4f8f6" ${stroke(3)}/>`;
    s += L.lightBeam(560, 800, 420, 760, 438, 900, '#fff6cc', 0.4);
    s += glow(720, 400, 90, '#fff3b0', 0.5) + L.jackalStatue(700, 416, 0.28, true, { plinth: false });
    // heart monitor and drip stand
    s += `<rect x="230" y="300" width="14" height="420" fill="#9aa4a8" ${stroke(2.5)}/>
      <rect x="170" y="230" width="150" height="110" rx="10" fill="#4a5458" ${stroke(3)}/>
      <rect x="182" y="242" width="126" height="86" rx="6" fill="#0e1a14"/>
      <path d="M186 296 L220 296 L230 270 L242 320 L252 286 L262 296 L304 296" stroke="#5aff9a" stroke-width="4" fill="none" stroke-linejoin="round"/>
      ${glow(245, 285, 90, '#5aff9a', 0.25)}
      <rect x="360" y="180" width="8" height="300" fill="#9aa4a8" ${stroke(2)}/>
      <path d="M340 180 L390 180" stroke="#9aa4a8" stroke-width="6"/>
      <rect x="370" y="190" width="34" height="56" rx="8" fill="#e8f4ff" fill-opacity="0.8" ${stroke(2.5)}/>
      <path d="M387 246 C390 340 420 420 470 520" stroke="#cfe6f0" stroke-width="3" fill="none"/>`;
    // bed with the traveller
    s += `<path d="M300 900 L300 560 M840 900 L840 600" stroke="${OL}" stroke-width="16"/><path d="M300 900 L300 560 M840 900 L840 600" stroke="#c9d0d4" stroke-width="10"/>
      <rect x="290" y="640" width="560" height="120" rx="20" fill="#ffffff" ${stroke(3.5)}/>
      <ellipse cx="420" cy="620" rx="100" ry="44" fill="#ffffff" ${stroke(3)}/>`;
    // head on the pillow
    s += `<g transform="translate(420 600)">
      <circle r="58" fill="#24160f" ${stroke(2.5)}/>
      ${[[-50, -20], [-30, -50], [0, -58], [30, -50], [50, -20]].map(([x, y]) => `<circle cx="${x}" cy="${y}" r="20" fill="#24160f" ${stroke(2.5)}/>`).join('')}
      <ellipse cx="6" cy="14" rx="40" ry="42" fill="#b77a52" ${stroke(3)}/>
      <path d="M-30 -10 C-20 -30 30 -30 40 -6 C20 -18 -10 -18 -30 -10 Z" fill="#24160f"/>
      <ellipse cx="-6" cy="12" rx="4" ry="5.5" fill="#1a1208"/><ellipse cx="22" cy="12" rx="4" ry="5.5" fill="#1a1208"/>
      <path d="M0 34 Q10 38 20 34" stroke="#5a2a1a" stroke-width="3" fill="none" stroke-linecap="round"/></g>`;
    s += `<path d="M330 660 C420 640 560 630 840 650 L850 760 L300 760 Z" fill="#8fc0e0" ${stroke(3.5)}/>
      <path d="M360 700 L820 700 M380 730 L830 730" stroke="#6aa0c8" stroke-width="4"/>
      <ellipse cx="540" cy="672" rx="26" ry="16" fill="#b77a52" ${stroke(2.5)}/>
      <rect x="280" y="760" width="580" height="40" fill="#c9d0d4" ${stroke(3)}/>`;
    return svg(s + vignette(0.25));
  },

  // 033. The Price of a Reward
  ANU033: () => {
    let s = room({ x0: 200, y0: 60, x1: 800, y1: 620 }, { ...goldRoom, top: '#2c1c12', bottom: '#4a2e18' }, { tileRows: 7 });
    // the first gate grinding open behind the traveller
    s += glow(250, 470, 230, '#4aa3ff', 0.45);
    s += `<rect x="150" y="260" width="200" height="380" fill="#0d1a3a" ${stroke(3)}/>
      <path d="M150 260 L210 270 L210 640 L150 640 Z M350 260 L290 270 L290 640 L350 640 Z" fill="#6a4a2a" ${stroke(3)}/>
      <path d="M130 240 L370 240 L370 262 L130 262 Z" fill="#c49a4a" ${stroke(3)}/>
      ${L.feather(250, 252, 0.12, 90, '#f2b833', '#b9801b')}
      <path d="M210 640 L290 640 L330 900 L170 900 Z" fill="#4aa3ff" opacity="0.15"/>`;
    s += L.pillar(880, 40, 900, 90);
    s += `<g opacity="0.35">${'' /* silent growl: eyes dimmed */}<ellipse cx="955" cy="320" rx="10" ry="4" fill="#ff6a3a"/><ellipse cx="985" cy="320" rx="10" ry="4" fill="#ff6a3a"/></g>`;
    // Anubis strikes the floor with his staff
    s += `<g fill="none" stroke="#f2b833" stroke-linecap="round">
      <ellipse cx="545" cy="900" rx="90" ry="22" stroke-width="6" opacity="0.8"/><ellipse cx="545" cy="900" rx="160" ry="40" stroke-width="4" opacity="0.5"/><ellipse cx="545" cy="900" rx="240" ry="60" stroke-width="3" opacity="0.3"/></g>`;
    s += L.anubis(690, 900, 0.95, { flip: true });
    s += `<path d="M520 860 L500 820 M570 860 L590 815 M545 856 L545 810" stroke="#ffe08a" stroke-width="5" stroke-linecap="round"/>`;
    s += L.hero(330, 1080, 0.95, { turn: 0.6 });
    return svg(s + vignette(0.5));
  },

  // 034. Ammit Breaks Free
  ANU034: () => {
    let s = room({ x0: 140, y0: 100, x1: 860, y1: 580 }, goldRoom);
    // ragged hole in the far wall opening onto fog
    const hole = 'M520 140 L600 110 L700 150 L780 120 L860 180 L880 330 L850 470 L880 590 L760 620 L640 600 L560 560 L500 440 L540 330 L490 240 Z';
    s += `<defs><clipPath id="hole34"><path d="${hole}"/></clipPath></defs>`;
    s += `<path d="${hole}" fill="#e8ecf3" ${stroke(4)}/><g clip-path="url(#hole34)">${L.fog(380, 34, '#ffffff', 0.9, 16, 400)}</g>`;
    s += glow(690, 370, 260, '#ffffff', 0.35);
    // Ammit charging through it
    s += `<g clip-path="url(#hole34)">${M.ammit(560, 660, 0.75, { mouth: 'open', chains: false })}</g>`;
    s += M.ammit(560, 660, 0.75, { mouth: 'open', chains: false }).replace(/<g transform="translate\(150 -290\)">[\s\S]*$/, '</g>');
    s += L.chainLinks(560, 560, 420, 760, 22) + L.chainLinks(600, 600, 520, 820, 22);
    // flying stone and dust
    s += rubble(420, 980, 60, 640, 22, 34);
    s += puffs([[300, 650, 34], [340, 680, 40], [880, 610, 40], [930, 570, 32]], '#b39a74');
    // the shattered last link
    s += `<g transform="translate(330 870) rotate(-20)">
      <path d="M-40 0 A40 22 0 0 1 20 -20" fill="none" stroke="${OL}" stroke-width="16"/><path d="M-40 0 A40 22 0 0 1 20 -20" fill="none" stroke="#9a9894" stroke-width="10"/>
      <path d="M50 10 A40 22 0 0 1 -10 26" fill="none" stroke="${OL}" stroke-width="16"/><path d="M50 10 A40 22 0 0 1 -10 26" fill="none" stroke="#9a9894" stroke-width="10"/></g>
      <path d="M300 840 l-20 -20 M360 830 l20 -24 M320 900 l-24 10" stroke="#fff3c4" stroke-width="5" stroke-linecap="round"/>`;
    s += L.hero(180, 1080, 0.9, { turn: 0.5 });
    return svg(s + vignette(0.5));
  },

  // 035. Taken by the River (underwater)
  ANU035: () => {
    let s = sky('#13284a', '#020409');
    // surface far above with the distant blue spark and the passing boat
    s += `<path d="M0 90 Q60 76 120 90 T240 90 T360 90 T480 90 T600 90 T720 90 T840 90 T960 90 T1080 90 L1080 0 L0 0 Z" fill="#2a4a7a" opacity="0.6"/>`;
    s += glow(760, 60, 80, '#4aa3ff', 0.9) + `<circle cx="760" cy="60" r="6" fill="#dff4ff"/>`;
    s += `<path d="M180 70 C220 110 380 110 420 70 Z" fill="#05070d" ${stroke(3)}/>`;
    s += L.lightBeam(700, 820, 560, 900, 60, 700, '#4aa3ff', 0.15);
    // faces in the deep
    const r = L.rng(35);
    for (let i = 0; i < 6; i++) s += `<g opacity="0.45">${L.ghost(80 + r() * 840, 640 + r() * 340, 0.7, { op: 0.6, mood: 'o' })}</g>`;
    // the traveller sinking
    s += `<g transform="rotate(-12 500 520)">${L.hero(500, 700, 0.8, { cloak: '#2e2a3a', hair: '#1a1210' })}</g>`;
    // hands gripping arms and ankles
    s += hand(380, 820, 0.8, 18) + hand(560, 840, 0.85, -14) + hand(320, 640, 0.7, 50) + hand(680, 640, 0.7, -50) + hand(470, 900, 0.75, 4);
    // bubbles
    for (let i = 0; i < 18; i++) {
      const bx = 430 + r() * 160, by = 120 + r() * 280, br = 4 + r() * 10;
      s += `<circle cx="${bx}" cy="${by}" r="${br}" fill="none" stroke="#9fd0ff" stroke-width="2.5" opacity="0.7"/>`;
    }
    return svg(s + vignette(0.6));
  },

  // 036. The Guardian's Guidance
  ANU036: () => {
    let s = room({ x0: 160, y0: 80, x1: 840, y1: 600 }, dustRoom);
    s += `<path d="M220 80 L280 200 L250 300" stroke="${OL}" stroke-width="5" fill="none"/><path d="M780 80 L720 220" stroke="${OL}" stroke-width="5" fill="none"/>`;
    // quiet passage lit by blue fire
    s += glow(330, 450, 240, '#4aa3ff', 0.5);
    s += L.archDoor(330, 600, 150, 300, '#0d1a3a', '#8a6a3a');
    s += `<path d="M280 600 L380 600 L360 360 L300 360 Z" fill="#4aa3ff" opacity="0.2"/>`;
    s += L.brazier(220, 640, 0.6) + L.brazier(440, 640, 0.6);
    // the guardian holding back a falling slab
    s += `<g transform="rotate(-6 690 430)"><rect x="520" y="395" width="340" height="70" fill="#8a7458" ${stroke(3.5)}/><path d="M540 415 L840 415" stroke="#a8916f" stroke-width="6"/></g>`;
    s += M.guardian(690, 1000, 0.8, { cracked: true });
    s += rubble(450, 950, 80, 300, 8, 36);
    s += `<g opacity="0.6">${L.fog(960, 37, '#c9b48f', 0.6, 12, 100)}</g>`;
    s += L.hero(330, 1080, 0.9, { turn: -0.4 });
    return svg(s + vignette(0.5));
  },

  // 037. The Collapsing Tomb
  ANU037: () => {
    let s = `<g transform="rotate(-5 500 500) scale(1.08) translate(-37 -37)">`;
    s += room({ x0: 160, y0: 80, x1: 840, y1: 600 }, dustRoom);
    s += `<path d="M300 80 L340 200 L300 280 L360 400 M700 80 L660 180 L700 260" stroke="${OL}" stroke-width="5" fill="none"/>`;
    // half-blocked exit passage
    s += glow(240, 470, 140, '#ffd36b', 0.35) + L.archDoor(240, 600, 120, 230, '#f2d39a', '#8a6a3a');
    s += rubble(170, 320, 470, 600, 12, 37, '#7a6650');
    // the stone rings tearing themselves apart
    s += `<g transform="rotate(14 560 560)">${M.ringMachine(560, 620, 0.6)}</g>`;
    // pit of blue fire
    s += ellipseGlow(720, 840, 280, 90, '#4aa3ff', 0.6);
    s += `<ellipse cx="720" cy="840" rx="210" ry="60" fill="#0d1a3a" ${stroke(3)}/>`;
    for (let i = 0; i < 6; i++) s += L.flame(600 + i * 48, 860, 60, 90 + (i % 3) * 30, true);
    // the guardian split in two
    s += `<g transform="translate(330 900) rotate(-84)"><g opacity="0.95">${M.guardian(0, 0, 0.35)}</g></g>`;
    s += `<path d="M300 700 L320 760 L300 820 L330 880" stroke="#3a2614" stroke-width="18" fill="none"/>`;
    s += `</g>`;
    // the slab breaking free above
    s += `<path d="M380 0 L720 0 L700 90 L400 110 Z" fill="#8a7458" ${stroke(4)}/><path d="M400 110 L700 90" stroke="#5a4a38" stroke-width="8"/>`;
    s += rubble(300, 800, 100, 260, 10, 38);
    s += `<g opacity="0.65">${L.fog(130, 39, '#c9b48f', 0.5, 12, 80)}</g>`;
    s += L.hero(470, 1080, 0.9, { turn: -0.6 });
    return svg(s + vignette(0.55));
  },

  // 038. Buried with the Stone
  ANU038: () => {
    let s = room({ x0: 140, y0: 80, x1: 860, y1: 560 }, { ...dustRoom, top: '#2e2014', bottom: '#3a2818' }, { tileRows: 6 });
    s += rubble(100, 900, 520, 700, 26, 40, '#6a5a44');
    s += `<path d="M120 760 L380 600 L900 640 L760 820 Z" fill="#7e6c54" ${stroke(4)}/>
      <path d="M120 760 L760 820 L760 860 L120 800 Z" fill="#5e4e3c" ${stroke(4)}/>
      <path d="M760 820 L900 640 L900 680 L760 860 Z" fill="#4a3c2e" ${stroke(4)}/>
      <path d="M300 700 L360 660 L340 720 M600 720 L660 690" stroke="#5a4a38" stroke-width="5" fill="none"/>`;
    s += rubble(80, 960, 800, 940, 14, 41, '#7a6650');
    s += `<g opacity="0.7">${L.fog(480, 42, '#a8916f', 0.35, 14, 300)}</g>`;
    s += L.lightBeam(470, 560, 420, 640, 0, 900, '#ffe7a6', 0.18);
    s += L.balanceStone(540, 900, 0.8);
    return svg(s + vignette(0.65));
  },

  // 039. Taken by Force
  ANU039: () => {
    let s = sky('#060a1a', '#0e1630');
    s += `<path d="M0 300 L1000 300 L1000 330 L0 330 Z" fill="#1a1a28"/><rect x="0" y="320" width="1000" height="680" fill="#05070d"/>`;
    const r = L.rng(39);
    for (let i = 0; i < 28; i++) s += `<path d="M${r() * 1000} ${330 + r() * 660} q20 -6 40 0" stroke="#3a4a6a" stroke-width="3" fill="none" opacity="0.6"/>`;
    s += glow(780, 200, 160, '#4aa3ff', 0.35) + `<path d="M720 300 L720 220 A60 60 0 0 1 840 220 L840 300" fill="none" stroke="#4aa3ff" stroke-width="10" opacity="0.8"/>`;
    s += M.boat(500, 900, 1.5);
    // ferryman reaching for the traveller's memory
    s += M.ferryman(330, 880, 0.95, { pole: false });
    s += `<path d="M370 600 C440 590 520 580 560 590 L556 612 C510 610 450 616 376 630 Z" fill="#c9bea6" ${stroke(3)}/>`;
    // golden thread of memory drawn out of the chest
    s += glow(600, 590, 160, '#ffd36b', 0.55);
    s += `<path d="M640 1000 C700 900 600 800 650 720 C690 660 600 640 590 600 C580 570 566 610 560 600" stroke="#ffe08a" stroke-width="7" fill="none" stroke-linecap="round"/>`;
    s += [[640, 580], [612, 626], [580, 566]].map(([x, y]) => `<circle cx="${x}" cy="${y}" r="10" fill="#fff3c4"/>`).join('');
    s += L.hero(720, 1060, 0.95, { turn: -0.6 });
    s += glow(640, 990, 120, '#ffe08a', 0.7);
    return svg(s + vignette(0.6));
  },

  // 040. A Peaceful Death
  ANU040: () => {
    const dusk = { ...home, top: '#c9a07a', bottom: '#a87e5a', side: '#7a5a42', ceil: '#6a4a36', floorA: '#6a4026', floorB: '#3e2614' };
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 640 }, dusk, { blocks: false, tileRows: 5, tileCols: 9 });
    s += `<rect x="380" y="170" width="240" height="250" fill="#5a4a8a" ${stroke(4)}/>
      <rect x="380" y="330" width="240" height="90" fill="#e88a6a"/>
      <circle cx="560" cy="350" r="30" fill="#ffd38a"/>
      ${L.stars(40, 30, 300).replace(/cx="(\d+)"/g, (m, x) => `cx="${380 + (+x % 240)}"`).replace(/cy="(\d+)"/g, (m, y) => `cy="${170 + (+y % 150)}"`)}
      <path d="M500 170 L500 420 M380 290 L620 290" stroke="#6a4026" stroke-width="10"/>`;
    // lamp glow
    s += glow(780, 420, 300, '#ffc86a', 0.55);
    s += `<path d="M790 640 L790 450" stroke="#4a2a1a" stroke-width="8"/><path d="M740 450 L840 450 L815 380 L765 380 Z" fill="#f6d39a" ${stroke(3)}/>`;
    // flickering wall shows the tomb behind it
    s += `<path d="M180 160 L250 180 L230 280 L260 360 L200 420 L170 300 Z" fill="#4b2b15" opacity="0.7" ${stroke(2)}/>`;
    // sofa from behind with two figures leaning together
    s += `<path d="M220 980 L220 740 C220 700 260 690 300 690 L700 690 C740 690 780 700 780 740 L780 980 Z" fill="#8a3a3a" ${stroke(4)}/>
      <path d="M240 740 L760 740" stroke="#a84a4a" stroke-width="10"/>`;
    s += `<g transform="translate(420 700)">
      <path d="M-50 40 C-60 -10 -40 -60 0 -64 C40 -60 70 -20 60 40 Z" fill="#2a1a10" ${stroke(3)}/></g>`;
    s += `<g transform="translate(560 690) rotate(-14)">
      ${[...Array(14)].map((_, i) => { const a = (i / 14) * Math.PI * 2; return `<circle cx="${(Math.cos(a) * 40).toFixed(1)}" cy="${(Math.sin(a) * 38 - 30).toFixed(1)}" r="18" fill="#24160f" ${stroke(2.5)}/>`; }).join('')}
      <circle cx="0" cy="-34" r="40" fill="#24160f"/></g>`;
    // the dream fading at the edges
    const fade = L.radGrad([[0.45, '#fff6e8', 0], [1, '#fff6e8', 0.75]], 0.5, 0.5, 0.72);
    s += `${fade.def}<rect width="1000" height="1000" fill="${fade.url}"/>`;
    return svg(s);
  },

  // 041. The Crying Soul (flickering between three lives)
  ANU041: () => {
    let s = room({ x0: 260, y0: 140, x1: 740, y1: 520 }, goldRoom, { blocks: false });
    s += L.glyphField(0, 0, 260, 1000, 41, { col: '#2a1708', op: 0.45, dy: 36 }) + L.glyphField(740, 0, 1000, 1000, 42, { col: '#2a1708', op: 0.45, dy: 36 });
    s += L.glyphField(260, 140, 740, 520, 43, { col: '#2a1708', op: 0.3 });
    s += L.brazier(320, 560, 0.6) + L.brazier(680, 560, 0.6);
    // three overlapping forms: child, old woman, soldier
    const ghostly = { skin: '#d8ecff', hair: '#8fb0d8', cloth: '#a8c8f0', mood: 'sad' };
    s += glow(560, 620, 280, '#8fc4ff', 0.5);
    s += M.person(470, 800, 0.85, { ...ghostly, op: 0.5, dress: true, hairLong: true, hair: '#e8f2ff', flip: true });
    s += M.person(650, 800, 0.95, { ...ghostly, op: 0.5, cloth: '#8fb0d8' });
    s += `<path d="M612 528 C616 500 684 500 688 528 Z" fill="#8fb0d8" opacity="0.6" ${stroke(2.5, '#3e5a85')}/>`;
    s += M.person(560, 800, 0.62, { ...ghostly, op: 0.75 });
    s += `<path d="M546 612 L544 624 M574 612 L576 624" stroke="#7ab8ff" stroke-width="4" stroke-linecap="round"/>`;
    // the tablet pinning them down
    s += `<g transform="rotate(4 560 800)">
      <rect x="320" y="740" width="480" height="120" rx="6" fill="#a8977c" ${stroke(3.5)}/>
      <rect x="320" y="740" width="480" height="22" fill="#c4b394" ${stroke(3)}/>
      ${L.glyphField(340, 770, 780, 850, 44, { col: '#4a3a28', op: 0.6, dy: 30, dx: 40, colLines: false })}</g>`;
    s += L.hero(200, 1030, 0.9, { kneel: true, armOut: true, turn: 0.4 });
    return svg(s + vignette(0.55));
  },

  // 042. Memory of Failure
  ANU042: () => {
    let s = sky('#24263c', '#3e3e5a');
    // walls of the maze sliding shut on the path ahead
    s += glow(500, 300, 200, '#ffe3a0', 0.5);
    s += `<rect x="470" y="120" width="60" height="460" fill="#ffe3a0"/>
      <path d="M0 80 L470 120 L470 580 L0 640 Z" fill="#4a4060" ${stroke(3)}/><path d="M1000 80 L530 120 L530 580 L1000 640 Z" fill="#4a4060" ${stroke(3)}/>
      <path d="M440 330 L400 330 M560 330 L600 330" stroke="#ffe3a0" stroke-width="6" stroke-linecap="round" opacity="0.8"/>`;
    s += L.glyphField(40, 140, 440, 560, 45, { col: '#8a7aa8', op: 0.3, colLines: false });
    s += L.glyphField(560, 140, 960, 560, 46, { col: '#8a7aa8', op: 0.3, colLines: false });
    s += `<rect x="0" y="600" width="1000" height="400" fill="#33334a"/>`;
    // people offered as someone to blame, each in a spotlight
    [[200, 0], [500, 1], [800, 2]].forEach(([x, i]) => (s += L.lightBeam(x - 30, x + 30, x - 120, x + 120, 0, 820, '#fff3c4', 0.28)));
    s += M.person(200, 800, 0.95, { cloth: '#7a5a8a', mood: 'sad', skin: '#d8a27a' });
    s += M.person(500, 780, 0.95, { cloth: '#4a7a6a', mood: 'stern', hairLong: true, dress: true, skin: '#b07850' });
    s += M.person(800, 800, 0.95, { cloth: '#9a5a5a', mood: 'neutral', skin: '#e0b090', hair: '#6a4a2a' });
    s += `<g fill="none" stroke="#f2b833" stroke-width="6" stroke-linecap="round" opacity="0.85">
      <path d="M200 470 l0 -40 m-14 14 l14 -14 l14 14"/><path d="M500 450 l0 -40 m-14 14 l14 -14 l14 14"/><path d="M800 470 l0 -40 m-14 14 l14 -14 l14 14"/></g>`;
    s += L.fog(940, 47, '#d9dcef', 0.7, 18, 160);
    s += L.hero(500, 1110, 1.0);
    return svg(s + vignette(0.5));
  },

  // 043. Ink and Threats
  ANU043: () => {
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 600 }, goldRoom, { blocks: false });
    s += scrollWalls(1);
    s += L.torch(140, 380) + L.torch(860, 380);
    // someone watching from behind the shelves
    s += `<rect x="740" y="270" width="80" height="70" fill="#0a0510" ${stroke(2.5)}/>` + `<ellipse cx="768" cy="300" rx="7" ry="4" fill="#c58cff"/><ellipse cx="792" cy="300" rx="7" ry="4" fill="#c58cff"/>` + glow(780, 300, 40, '#c58cff', 0.6);
    // scrolls unrolling across the floor
    s += unrolled(160, 760, 300, 8, 1) + unrolled(560, 800, 360, -6, 2) + unrolled(300, 900, 420, 4, 3);
    s += M.scribe(470, 1000, 0.95, { desk: false, standing: true, words: '<path d="M-24 -30 L24 -30 M-24 -8 L24 -8 M-24 14 L24 14" stroke="#1a1208" stroke-width="5"/>' });
    // ink coiling around the traveller's ankles
    s += `<g fill="none" stroke="#120a10" stroke-width="10" stroke-linecap="round">
      <path d="M560 860 C620 880 660 980 720 960 C780 940 700 900 760 890"/>
      <path d="M640 900 C700 920 860 1000 820 940 C800 910 860 900 880 930"/>
      <path d="M420 900 C500 940 600 1000 680 990"/></g>`;
    s += L.hero(780, 1080, 0.95, { armOut: true, flip: true, turn: 0.4 });
    return svg(s + vignette(0.55));
  },

  // 044. A Secret Kept
  ANU044: () => {
    let s = sky('#05061a', '#14123a');
    s += L.stars(44, 200, 560);
    // the star ceiling parts to show a spiral stair
    s += `<path d="M380 120 L620 120 L620 600 L380 600 Z" fill="#0a0814"/>`;
    s += spiralStair(500, 600, 1.15, '#8a9aff');
    s += `<path d="M380 120 L300 60 M620 120 L700 60" stroke="#b9c4ff" stroke-width="3" stroke-dasharray="3 9"/>`;
    // scroll shelves on either side
    const shelf = (x, seed) => {
      let c = `<rect x="${x}" y="200" width="200" height="560" fill="#2a1810" ${stroke(3)}/>`;
      for (let j = 0; j < 7; j++) {
        c += `<rect x="${x + 10}" y="${210 + j * 78}" width="180" height="68" fill="#1a0e08" ${stroke(2)}/>`;
        for (let k = 0; k < 4; k++) c += `<circle cx="${x + 34 + k * 44}" cy="${244 + j * 78}" r="14" fill="#c9b78f" ${stroke(1.5)}/>`;
      }
      return c;
    };
    // masked figure slipping between the shelves
    s += M.rebel(745, 760, 0.8);
    s += shelf(40, 1) + shelf(760, 2);
    s += `<rect x="0" y="760" width="1000" height="240" fill="#0a0a22"/><path d="M0 760 L1000 760" stroke="#4a4a8a" stroke-width="3"/>`;
    // the scribe, his mask showing a single approving word
    s += M.scribe(250, 1000, 0.85, { desk: false, standing: true, words: `${L.glyph(0, 0, -10, 2.6, '#f2b833', 0.95)}` });
    s += glow(250, 590, 80, '#ffd36b', 0.45);
    s += L.hero(620, 1090, 0.95, { turn: -0.4 });
    return svg(s + vignette(0.45));
  },

  // 045. The Rebel's Fire
  ANU045: () => {
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 600 }, { ...goldRoom, top: '#5a2a14', bottom: '#4a2414' }, { blocks: false });
    s += scrollWalls(2);
    // the rebel slipping out through the back
    s += L.archDoor(500, 600, 110, 220, '#0a0510', '#5a3a1c', 14);
    s += `<g opacity="0.85">${M.rebel(500, 600, 0.38, { flip: true })}</g>`;
    // stair to the Balance Stone
    s += spiralStair(800, 760, 0.9);
    // fire racing across the scrolls
    s += M.scrollPile(250, 780, 10, 4, 1) + M.scrollPile(640, 800, 8, 5, 0.9);
    s += fireCluster(250, 720, 1.1, 5, 1) + fireCluster(640, 750, 0.9, 4, 2) + fireCluster(420, 860, 0.7, 3, 3);
    s += `<path d="M380 840 L460 830 L470 860 L390 870 Z" fill="#6a3a1a" ${stroke(2.5)}/>`;
    // smoke
    s += puffs([[180, 120, 60], [260, 90, 70], [360, 120, 60], [600, 100, 70], [700, 130, 60], [460, 80, 60]], '#3a3434', '#1a1414');
    // the smoke-stained scribe pointing to the stairs
    s += M.scribe(130, 1000, 0.75, { desk: false, standing: true, mask: '#9a9288', words: '<path d="M-20 -30 C-10 -10 10 -40 20 -16" stroke="#3a3434" stroke-width="8" fill="none"/>' });
    s += L.hero(470, 1090, 0.95, { turn: 0.6 });
    return svg(s + vignette(0.5));
  },
};
