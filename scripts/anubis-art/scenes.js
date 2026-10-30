// One function per story screen; each returns an SVG string.
const L = require('./lib');
const M = require('./lib2');
const { svg, room, glow, ellipseGlow, vignette, linGrad, stroke, at, g, OL } = L;

const sky = (top, bottom) => {
  const gr = linGrad([[0, top], [1, bottom]]);
  return `${gr.def}<rect width="1000" height="1000" fill="${gr.url}"/>`;
};

const dune = (d, top, bottom) => {
  const gr = linGrad([[0, top], [1, bottom]]);
  return `${gr.def}<path d="${d}" fill="${gr.url}" ${stroke(3)}/>`;
};

const sandRipples = (y0, y1, seed, col = '#8a7458', op = 0.35) => {
  const r = L.rng(seed);
  let s = '';
  for (let y = y0; y < y1; y += 26 + r() * 20) {
    const x = r() * 700 - 100;
    const w = 200 + r() * 300;
    s += `<path d="M${x} ${y} q${w / 4} -12 ${w / 2} 0 t${w / 2} 0" fill="none" stroke="${col}" stroke-width="3" opacity="${op}" stroke-linecap="round"/>`;
  }
  return s;
};

const footprints = pts =>
  pts.map(([x, y, s], i) => `<ellipse cx="${x + (i % 2 ? 10 : -10) * s}" cy="${y}" rx="${9 * s}" ry="${14 * s}" fill="#6f5d48" opacity="0.6" transform="rotate(${i % 2 ? 8 : -8} ${x} ${y})"/>`).join('');

const blueRoom = { top: '#3d3550', bottom: '#2a2338', side: '#1d1828', floorA: '#3a2f45', floorB: '#1e1828', ceil: '#141018' };
const goldRoom = { top: '#7a5228', bottom: '#5a3a1c', side: '#45290f', floorA: '#6a4523', floorB: '#3e2612', ceil: '#2c190b' };
const redRoom = { top: '#7a2228', bottom: '#4a1216', side: '#3a0d10', floorA: '#5a1a1c', floorB: '#2a0a0c', ceil: '#1e0607' };

const amberEyes = (x, y, s = 1, col = '#ffb43a') =>
  glow(x - 30 * s, y, 50 * s, col, 0.7) + glow(x + 30 * s, y, 50 * s, col, 0.7) +
  `<path d="M${x - 50 * s} ${y} Q${x - 30 * s} ${y - 14 * s} ${x - 10 * s} ${y} Q${x - 30 * s} ${y + 8 * s} ${x - 50 * s} ${y} Z" fill="${col}"/>
   <path d="M${x + 10 * s} ${y} Q${x + 30 * s} ${y - 14 * s} ${x + 50 * s} ${y} Q${x + 30 * s} ${y + 8 * s} ${x + 10 * s} ${y} Z" fill="${col}"/>
   <path d="M${x - 30 * s} ${y - 8 * s} L${x - 30 * s} ${y + 6 * s} M${x + 30 * s} ${y - 8 * s} L${x + 30 * s} ${y + 6 * s}" stroke="#1a0a00" stroke-width="${4 * s}"/>`;

const visionCircle = (x, y, r, content, col = '#ffd36b') =>
  glow(x, y, r * 1.6, col, 0.45) + `<circle cx="${x}" cy="${y}" r="${r}" fill="#3a2410" ${stroke(4)}/>
  <circle cx="${x}" cy="${y}" r="${r}" fill="none" stroke="${col}" stroke-width="8"/>
  <circle cx="${x}" cy="${y}" r="${r - 12}" fill="none" stroke="#fff3c4" stroke-width="2" opacity="0.6"/>${content}`;

const clawMarks = (x, y, s = 1, rot = 0, col = '#1e0f06') =>
  g(`<path d="M0 0 C10 40 14 80 10 130 M30 -6 C40 40 44 84 40 140 M60 4 C68 40 72 76 68 120" stroke="${col}" stroke-width="9" fill="none" stroke-linecap="round" opacity="0.7"/>
     <path d="M4 4 C14 40 18 80 14 126 M34 0 C44 40 48 84 44 134" stroke="#b07a4a" stroke-width="2" fill="none" opacity="0.5"/>`,
    `translate(${x} ${y}) rotate(${rot}) scale(${s})`);

const brokenScales = (x, y, s = 1) => L.scales(x, y, s, { broken: true });

module.exports = {
  // 1. The Silent Desert
  ANU001: () => {
    let s = sky('#0b1026', '#2b2a48');
    s += dune('M0 520 C200 470 360 500 520 470 C700 440 860 480 1000 460 L1000 1000 L0 1000 Z', '#6c6476', '#4e475a');
    // Black doorway half buried in the dune
    s += glow(500, 520, 260, '#ffcf6b', 0.25);
    s += `<g ${stroke(3.5)}>
      <path d="M300 640 L330 360 L670 360 L700 640 Z" fill="#1c1a22"/>
      <rect x="300" y="330" width="400" height="40" fill="#24222c"/>
      <rect x="320" y="300" width="360" height="34" fill="#2c2a36"/>
      <path d="M430 640 L430 450 L570 450 L570 640 Z" fill="#ffd57a"/>
      <path d="M440 640 L440 460 L560 460 L560 640 Z" fill="#ffe9b0"/>
    </g>
    <path d="M430 450 L470 450 L470 640 L430 640 Z" fill="#1c1a22" ${stroke(3)}/>
    ${glow(500, 545, 120, '#fff0c0', 0.5)}
    <path d="M350 344 L650 344" stroke="#f2b833" stroke-width="5"/>
    ${L.glyph(1, 500, 318, 1.6, '#f2b833', 0.95)}${L.glyph(0, 440, 318, 1.3, '#f2b833', 0.8)}${L.glyph(0, 560, 318, 1.3, '#f2b833', 0.8)}`;
    s += L.jackalStatue(250, 600, 0.95, false) + L.jackalStatue(750, 600, 0.95, true);
    // Front dune swallowing the base of the doorway
    s += dune('M0 610 C180 590 330 650 500 640 C680 630 820 590 1000 610 L1000 1000 L0 1000 Z', '#b8a07c', '#8c7558');
    s += sandRipples(680, 1000, 4, '#6f5b44', 0.4);
    const pts = [];
    for (let i = 0; i < 12; i++) {
      const t = i / 11;
      pts.push([520 - 140 * Math.sin(t * 2.6) * (1 - t) + 40 * t, 1000 - t * 340, 1.6 - t * 1.1]);
    }
    s += footprints(pts);
    return svg(s + vignette(0.5));
  },

  // 2. The Black Doorway
  ANU002: () => {
    let s = room({ x0: 330, y0: 120, x1: 670, y1: 470 }, blueRoom, { tiles: false });
    // Relief panel on the back wall: Anubis and the scales, the last panel smashed
    s += `<rect x="350" y="150" width="300" height="200" fill="#4a4060" ${stroke(3)}/>`;
    s += `<g opacity="0.95">${L.anubis(420, 335, 0.27, { arm: 'reach' })}${L.scales(540, 335, 0.33)}</g>`;
    s += `<path d="M590 150 L600 200 L580 240 L610 290 L590 350 L650 350 L650 150 Z" fill="#2a2338" ${stroke(3)}/>
      <g transform="translate(622 300)">${[...Array(3)].map((_, i) => `<path d="M${-14 + i * 6} ${-20 - i * 18} q10 -12 20 0" fill="none" stroke="#c9a14a" stroke-width="3"/>`).join('')}
      <path d="M-14 24 L-10 -6 L-4 20 L0 -10 L6 18 L10 -4 L14 24 Z" fill="#c9a14a"/></g>`;
    // Staircase leading down
    const steps = 9;
    for (let i = steps - 1; i >= 0; i--) {
      const t = i / steps, t2 = (i + 1) / steps;
      const yTop = 1000 - (1000 - 470) * Math.pow(t2, 0.75), yBot = 1000 - (1000 - 470) * Math.pow(t, 0.75);
      const wTop = 340 + 660 * (1 - t2), wBot = 340 + 660 * (1 - t);
      const shade = 40 + 70 * (1 - t);
      s += `<polygon points="${500 - wBot / 2},${yBot} ${500 + wBot / 2},${yBot} ${500 + wTop / 2},${yTop} ${500 - wTop / 2},${yTop}" fill="rgb(${shade},${shade * 0.85},${shade * 1.1})" ${stroke(2.5)}/>`;
      s += `<path d="M${500 - wBot / 2} ${yBot - 10} L${500 + wBot / 2} ${yBot - 10}" stroke="#000" stroke-opacity="0.25" stroke-width="10"/>`;
    }
    s += ellipseGlow(500, 470, 220, 50, '#000', 0.6);
    s += L.brazier(180, 640, 1.2) + L.brazier(820, 640, 1.2) + L.brazier(380, 440, 0.55) + L.brazier(620, 440, 0.55);
    s += L.glyphField(30, 60, 260, 520, 9, { col: '#8aa0d0', op: 0.35 });
    s += L.glyphField(740, 60, 970, 520, 10, { col: '#8aa0d0', op: 0.35 });
    return svg(s + vignette(0.55));
  },

  // 3. The Jackal Temple
  ANU003: () => {
    let s = room({ x0: 280, y0: 160, x1: 720, y1: 520 }, goldRoom);
    // Carving on the back wall shaped like the hero
    s += `<g opacity="0.55">${L.hero(500, 470, 0.6, { cloak: '#3a2410', hair: '#3a2410' })}</g>`;
    s += `<rect x="415" y="215" width="170" height="262" fill="none" stroke="#2a1708" stroke-width="4" opacity="0.5"/>`;
    // Side room with treasure
    s += `<path d="M770 300 L900 230 L900 650 L770 600 Z" fill="#2a1708" ${stroke(3)}/>`;
    s += glow(835, 520, 140, '#ffd36b', 0.6) + M.goldPile(835, 610, 110, 80, 4);
    s += L.lightBeam(860, 900, 770, 840, 220, 620, '#ffe7a6', 0.35);
    // Circular opening with blue light
    s += ellipseGlow(500, 690, 260, 90, '#4aa3ff', 0.6);
    s += `<ellipse cx="500" cy="690" rx="170" ry="54" fill="#d8a64a" ${stroke(3)}/>
      <ellipse cx="500" cy="694" rx="140" ry="40" fill="#0d1a3a" ${stroke(3)}/>
      <ellipse cx="500" cy="698" rx="100" ry="24" fill="#2f7bff" opacity="0.7"/>
      <ellipse cx="500" cy="700" rx="56" ry="12" fill="#bfe6ff" opacity="0.8"/>
      <path d="M380 694 A120 34 0 0 1 620 694 L600 698 A100 26 0 0 0 400 698 Z" fill="#c49a4a" ${stroke(2)}/>
      <path d="M420 706 A80 18 0 0 1 580 706 L566 708 A66 13 0 0 0 434 708 Z" fill="#8a6a3a" ${stroke(2)}/>
      <path d="M392 690 L410 700 M450 668 L456 684 M520 664 L516 680 M590 676 L578 690" stroke="${OL}" stroke-width="3"/>`;
    // Rows of statues
    s += L.jackalStatue(350, 540, 0.45) + L.jackalStatue(650, 540, 0.45, true);
    s += L.jackalStatue(250, 650, 0.7) + L.jackalStatue(750, 650, 0.7, true);
    s += L.jackalStatue(110, 860, 1.05) + L.jackalStatue(890, 860, 1.05, true);
    s += L.brazier(420, 540, 0.45) + L.brazier(580, 540, 0.45);
    return svg(s + vignette(0.5));
  },

  // 4. The Voice Below
  ANU004: () => {
    let s = `<rect width="1000" height="1000" fill="#24140a"/>`;
    s += M.spiralShaft(500, 500);
    s += `<circle cx="500" cy="500" r="175" fill="#050302"/>`;
    s += glow(500, 500, 175, '#000', 0.9);
    const panels = [[500, 60, 0, 0], [870, 360, 70, 1], [820, 760, 140, 2], [180, 760, 220, 0], [120, 330, 290, 1], [700, 230, 30, 2], [300, 230, -30, 1], [720, 700, 120, 0], [290, 700, 230, 2]];
    panels.forEach(([x, y, r, k], i) => (s += M.memoryPanel(x, y, r, i < 5 ? 1 : 0.7, k)));
    s += amberEyes(500, 520, 1.2);
    s += [[120, 120], [880, 120], [120, 880], [880, 880]].map(([x, y]) => L.brazier(x, y + 60, 0.7)).join('');
    return svg(s + vignette(0.6));
  },

  // 5. Anubis Revealed
  ANU005: () => {
    let s = room({ x0: 200, y0: 60, x1: 800, y1: 620 }, { ...goldRoom, top: '#2a1a10', bottom: '#4a2e18' }, { tileRows: 7 });
    // gates
    s += L.archDoor(330, 600, 120, 240, '#0d1a3a', '#8a6a3a') + L.archDoor(670, 600, 120, 240, '#0d1a3a', '#8a6a3a');
    s += glow(330, 520, 120, '#4aa3ff', 0.4) + glow(670, 520, 120, '#4aa3ff', 0.4);
    // dais
    s += `<path d="M300 720 L700 720 L660 660 L340 660 Z" fill="#1d1a24" ${stroke(3)}/>
      <path d="M260 780 L740 780 L700 720 L300 720 Z" fill="#2a2632" ${stroke(3)}/>`;
    s += glow(500, 380, 300, '#ffc43a', 0.25);
    s += L.anubis(500, 690, 0.85);
    s += brokenScales(500, 900, 0.55);
    s += L.pillar(110, 40, 900, 90) + L.pillar(890, 40, 900, 90);
    s += amberEyes(910, 300, 0.6, '#ff6a3a');
    s += L.ghost(240, 330, 0.7, { op: 0.6 }) + L.ghost(780, 260, 0.6, { op: 0.6, flip: true }) + L.ghost(330, 170, 0.5, { op: 0.5, mood: 'o' }) + L.ghost(700, 460, 0.55, { op: 0.55 });
    s += L.brazier(240, 900, 1) + L.brazier(760, 900, 1);
    return svg(s + vignette(0.55));
  },

  // 6. Terms of Judgment
  ANU006: () => {
    let s = room({ x0: 160, y0: 80, x1: 840, y1: 640 }, { ...goldRoom, top: '#3a2414', bottom: '#5a3a1c' });
    s += L.glyphField(180, 100, 820, 620, 6, { col: '#2a1708', op: 0.25 });
    s += L.anubis(720, 960, 1.0, { arm: 'raise', flip: true });
    s += visionCircle(260, 230, 120, L.feather(268, 320, 0.7, 20, '#ffe08a', '#e8b84a'));
    s += visionCircle(240, 520, 110, `<path d="M170 520 Q240 580 310 520 Z" fill="#f2b833" ${stroke(3)}/><path d="M170 520 L310 520" stroke="#b9801b" stroke-width="5"/>` + L.heart(240, 490, 0.55));
    s += visionCircle(480, 330, 100, L.balanceStone(480, 330, 1.1), '#7ff0e0');
    s += `<path d="M560 250 Q520 300 520 330 M560 360 Q400 420 340 470 M560 300 Q420 250 380 240" stroke="#ffe7a6" stroke-width="4" fill="none" stroke-dasharray="4 14" stroke-linecap="round" opacity="0.8"/>`;
    s += L.scales(300, 960, 0.4, { broken: true });
    s += L.brazier(80, 960, 0.9) + L.brazier(940, 960, 0.9);
    return svg(s + vignette(0.5));
  },

  // 7. Refuse the God
  ANU007: () => {
    let s = room({ x0: 200, y0: 80, x1: 800, y1: 620 }, { ...goldRoom, top: '#2c1c12', bottom: '#4a2e18' });
    // fog door behind the hero
    s += L.archDoor(260, 700, 200, 400, '#dfe6ef', '#8a6a3a');
    s += `<defs><clipPath id="door7"><path d="M160 700 L160 400 A100 100 0 0 1 360 400 L360 700 Z"/></clipPath></defs><g clip-path="url(#door7)">${L.fog(560, 2, '#ffffff', 0.9, 14, 300)}</g>`;
    s += L.ghost(230, 470, 0.5, { op: 0.6, mood: 'o' }) + L.ghost(290, 590, 0.45, { op: 0.6 }) + L.ghost(220, 650, 0.35, { op: 0.5 });
    s += glow(260, 520, 220, '#ffffff', 0.25);
    s += L.anubis(690, 880, 0.95, { arm: 'reach', flip: true });
    s += L.ghost(520, 260, 0.6, { op: 0.6 }) + L.ghost(880, 300, 0.5, { op: 0.5, flip: true });
    s += L.brazier(950, 980, 0.9);
    s += L.hero(430, 1040, 1.05, { turn: 0.6 });
    return svg(s + vignette(0.5));
  },

  // 8. River of the Dead
  ANU008: () => {
    let s = sky('#060a1a', '#101a36');
    // far bank and blue fire arch
    s += `<path d="M0 420 L1000 420 L1000 470 L0 470 Z" fill="#1a1a28" ${stroke(3)}/>`;
    s += glow(620, 330, 260, '#4aa3ff', 0.45);
    s += `<path d="M520 440 L520 300 A100 100 0 0 1 720 300 L720 440" fill="none" stroke="#2a3a5a" stroke-width="40"/>
      <path d="M520 440 L520 300 A100 100 0 0 1 720 300 L720 440" fill="none" stroke="#4aa3ff" stroke-width="14" opacity="0.9"/>`;
    for (let i = 0; i < 13; i++) {
      const a = Math.PI - (i / 12) * Math.PI;
      const px = 620 + Math.cos(a) * 100, py = 300 - Math.sin(a) * 100;
      s += L.flame(px, py + 10, 34, 56, true);
    }
    s += L.flame(520, 380, 30, 50, true) + L.flame(720, 380, 30, 50, true);
    // black water
    s += `<rect x="0" y="460" width="1000" height="540" fill="#05070d"/>`;
    const r = L.rng(8);
    for (let i = 0; i < 26; i++) s += `<path d="M${r() * 1000} ${470 + r() * 520} q20 -6 40 0" stroke="#3a4a6a" stroke-width="3" fill="none" opacity="0.6"/>`;
    for (let i = 0; i < 7; i++) s += `<g opacity="0.25">${L.ghost(80 + r() * 840, 640 + r() * 300, 0.5 + r() * 0.3, { op: 0.6 })}</g>`;
    // distant boat
    s += M.boat(820, 560, 0.25) + M.ferryman(830, 555, 0.18);
    // dock
    s += `<polygon points="0,720 380,560 470,580 140,1000 0,1000" fill="#5a3a1f" ${stroke(3)}/>`;
    for (let i = 0; i < 9; i++) {
      const t = i / 9;
      s += `<path d="M${0 + 380 * t * 1} ${720 - 160 * t} L${140 + 330 * t} ${1000 - 420 * t}" stroke="${OL}" stroke-width="3" opacity="0.6"/>`;
    }
    s += `<rect x="440" y="560" width="22" height="120" fill="#4a2c17" ${stroke(2.5)}/><rect x="120" y="760" width="34" height="240" fill="#4a2c17" ${stroke(3)}/>`;
    // bell post
    s += `<rect x="60" y="300" width="30" height="480" fill="#4a2c17" ${stroke(3)}/>
      <rect x="60" y="300" width="190" height="26" fill="#4a2c17" ${stroke(3)}/>
      <path d="M200 326 L200 360" stroke="${OL}" stroke-width="5"/>
      <path d="M160 450 C160 380 170 360 200 360 C230 360 240 380 240 450 L250 466 L150 466 Z" fill="#b5762a" ${stroke(3)}/>
      <path d="M176 440 C176 400 180 380 196 376" stroke="#e8b060" stroke-width="7" fill="none" stroke-linecap="round"/>
      <circle cx="200" cy="476" r="12" fill="#8a5a1a" ${stroke(2.5)}/>`;
    s += L.brazier(400, 560, 0.5);
    return svg(s + vignette(0.6));
  },

  // 9. The Ferryman's Price
  ANU009: () => {
    let s = sky('#060a1a', '#0e1630');
    s += glow(300, 220, 200, '#4aa3ff', 0.35);
    s += `<path d="M220 300 L220 200 A80 80 0 0 1 380 200 L380 300" fill="none" stroke="#4aa3ff" stroke-width="12" opacity="0.8"/>`;
    s += `<path d="M0 300 L1000 300 L1000 330 L0 330 Z" fill="#1a1a28"/>`;
    s += `<rect x="0" y="320" width="1000" height="680" fill="#05070d"/>`;
    const r = L.rng(9);
    for (let i = 0; i < 30; i++) s += `<path d="M${r() * 1000} ${330 + r() * 660} q20 -6 40 0" stroke="#3a4a6a" stroke-width="3" fill="none" opacity="0.6"/>`;
    for (let i = 0; i < 6; i++) s += `<g opacity="0.3">${L.ghost(80 + r() * 840, 520 + r() * 380, 0.6, { op: 0.6, mood: 'o' })}</g>`;
    // reaching hand from the water
    s += glow(250, 800, 120, '#8fc4ff', 0.4);
    s += `<g opacity="0.85"><path d="M220 900 L230 790 C226 770 236 750 250 752 L262 700 L274 704 L268 754 L282 704 L294 708 L284 760 L300 724 L312 730 L296 780 C296 820 286 860 284 900 Z" fill="#bcd8f5" ${stroke(3, '#3e5a85')}/></g>`;
    s += `<ellipse cx="255" cy="900" rx="70" ry="14" fill="none" stroke="#6a8ac0" stroke-width="3"/>`;
    // boat and ferryman
    s += M.ferryman(640, 830, 1.0, { orb: true });
    s += M.boat(620, 850, 1.2);
    // dock corner
    s += `<polygon points="0,880 120,840 160,1000 0,1000" fill="#5a3a1f" ${stroke(3)}/>`;
    return svg(s + vignette(0.6));
  },

  // 10. Hall of Whispers
  ANU010: () => {
    let s = room({ x0: 360, y0: 180, x1: 640, y1: 560 }, goldRoom, { blocks: false });
    s += L.glyphField(0, 0, 360, 1000, 12, { col: '#2a1708', op: 0.45, dy: 36 });
    s += L.glyphField(640, 0, 1000, 1000, 13, { col: '#2a1708', op: 0.45, dy: 36 });
    // scratched-out names
    const r = L.rng(14);
    for (let i = 0; i < 9; i++) {
      const x = r() < 0.5 ? 40 + r() * 260 : 680 + r() * 260, y = 120 + r() * 600;
      s += `<path d="M${x} ${y} l40 -8 m-38 16 l42 -10 m-40 18 l38 -8" stroke="#1a0c04" stroke-width="4" opacity="0.6"/>`;
    }
    // sealed golden door with the feather symbol
    s += glow(500, 420, 220, '#ffd36b', 0.55);
    s += L.archDoor(500, 560, 160, 300, '#f2b833', '#b9801b', 18);
    s += L.feather(500, 520, 0.8, 0, '#fff3c4', '#e8b84a');
    s += `<path d="M500 280 L500 560" stroke="#b9801b" stroke-width="4"/>`;
    // side passage with a crying soul
    s += `<path d="M60 380 L180 420 L180 820 L60 880 Z" fill="#120a05" ${stroke(3)}/>`;
    s += L.ghost(120, 800, 0.6, { op: 0.75 });
    s += `<path d="M106 750 L104 762 M134 750 L136 762" stroke="#7ab8ff" stroke-width="4" stroke-linecap="round"/>`;
    s += L.brazier(280, 760, 0.8) + L.brazier(720, 760, 0.8);
    s += L.hero(720, 1060, 1.05, { turn: -0.6 });
    // whisper wisps
    s += `<g stroke="#cfe6ff" stroke-width="3" fill="none" opacity="0.4" stroke-linecap="round">
      <path d="M200 300 q30 -20 60 0 t60 0"/><path d="M700 260 q30 -20 60 0 t60 0"/><path d="M640 640 q30 -20 60 0 t60 0"/><path d="M240 600 q30 -20 60 0"/></g>`;
    return svg(s + vignette(0.55));
  },

  // 11. The Crying Soul
  ANU011: () => {
    let s = room({ x0: 200, y0: 120, x1: 800, y1: 540 }, goldRoom);
    s += L.glyphField(220, 140, 780, 520, 15, { col: '#2a1708', op: 0.3 });
    s += L.brazier(150, 600, 0.9) + L.brazier(850, 600, 0.9);
    // trapped soul under a tablet
    s += glow(380, 760, 220, '#8fc4ff', 0.5);
    s += L.ghost(360, 790, 1.0, { op: 0.85, mood: 'o' });
    s += `<g opacity="0.9"><path d="M310 720 C290 690 280 660 296 640" stroke="#3e5a85" stroke-width="20" fill="none" stroke-linecap="round"/><path d="M310 720 C290 690 280 660 296 640" stroke="#cfe6ff" stroke-width="14" fill="none" stroke-linecap="round"/>
      <path d="M410 716 C436 690 446 660 434 636" stroke="#3e5a85" stroke-width="20" fill="none" stroke-linecap="round"/><path d="M410 716 C436 690 446 660 434 636" stroke="#cfe6ff" stroke-width="14" fill="none" stroke-linecap="round"/></g>`;
    s += `<g transform="rotate(-8 400 760)">
      <rect x="160" y="720" width="460" height="120" rx="6" fill="#a8977c" ${stroke(3.5)}/>
      <rect x="160" y="720" width="460" height="22" fill="#c4b394" ${stroke(3)}/>
      ${L.glyphField(180, 750, 600, 830, 16, { col: '#4a3a28', op: 0.6, dy: 30, dx: 40, colLines: false })}
      <path d="M380 740 L400 780 L380 820" fill="none" stroke="${OL}" stroke-width="4"/>
    </g>`;
    s += `<g opacity="0.85"><path d="M180 790 C150 780 130 800 140 820 L190 820 Z" fill="#cfe6ff" ${stroke(3, '#3e5a85')}/></g>`;
    s += L.chainLinks(120, 860, 300, 940, 20) + L.chainLinks(560, 900, 760, 840, 20);
    s += L.hero(760, 1020, 1.0, { kneel: true, armOut: false, flip: true });
    return svg(s + vignette(0.55));
  },

  // 12. Feather Arm Chamber
  ANU012: () => {
    let s = `<rect width="1000" height="1000" fill="#2c190b"/>`;
    const wall = linGrad([[0, '#7a5228'], [1, '#4a2e16']]);
    s += wall.def + `<path d="M0 0 L1000 0 L1000 660 C800 600 200 600 0 660 Z" fill="${wall.url}"/>`;
    s += `<path d="M0 660 C200 600 800 600 1000 660 L1000 1000 L0 1000 Z" fill="#5a3a1e" ${stroke(3)}/>`;
    s += `<path d="M0 120 C250 80 750 80 1000 120" stroke="#2a1708" stroke-width="5" fill="none" opacity="0.5"/>`;
    // mural kneelers with moving shadows
    [[90, 520, false], [230, 500, false], [370, 490, false], [630, 490, true], [770, 500, true], [900, 520, true]].forEach(([x, y, f], i) => {
      s += M.muralKneeler(x + (f ? -14 : 14), y + 8, 1.15, f, '#1a0c04');
      s += `<g opacity="0.95">${M.muralKneeler(x, y, 1.1, f, '#c48a3a')}</g>`;
    });
    // scratch marks across the floor
    s += clawMarks(120, 760, 0.9, -70) + clawMarks(780, 900, 0.9, -110);
    s += `<path d="M380 920 L240 1000 M420 930 L300 1000" stroke="#1e0f06" stroke-width="8" opacity="0.6" stroke-linecap="round"/>`;
    // hidden passage hint
    s += `<path d="M930 560 L1000 556 L1000 690 L930 670 Z" fill="#160c05" ${stroke(3)}/>`;
    // blue fire shaft
    s += ellipseGlow(500, 760, 300, 110, '#4aa3ff', 0.6);
    s += `<ellipse cx="500" cy="760" rx="210" ry="70" fill="#c49a4a" ${stroke(3)}/>
      <ellipse cx="500" cy="764" rx="170" ry="52" fill="#0d1a3a" ${stroke(3)}/>`;
    s += L.lightBeam(380, 620, 340, 660, 120, 760, '#7ac0ff', 0.4);
    for (let i = 0; i < 5; i++) s += L.flame(420 + i * 40, 780, 70, 110 + (i % 2) * 40, true);
    // the floating Feather Arm
    s += glow(500, 330, 220, '#ffd36b', 0.65);
    s += `<rect x="420" y="430" width="160" height="22" rx="8" fill="#f2b833" ${stroke(3)}/>
      <circle cx="420" cy="441" r="16" fill="#f2b833" ${stroke(3)}/><circle cx="580" cy="441" r="16" fill="#f2b833" ${stroke(3)}/>`;
    s += L.feather(500, 440, 1.25, 0, '#ffe08a', '#e8b84a');
    s += L.hero(140, 1060, 0.9, { turn: 0.5 });
    return svg(s + vignette(0.5));
  },

  // 13. Golden Scarab Vault
  ANU013: () => {
    let s = room({ x0: 220, y0: 120, x1: 780, y1: 600 }, goldRoom);
    // shelves of masks
    s += `<rect x="250" y="200" width="500" height="20" fill="#5a3a1c" ${stroke(2.5)}/><rect x="250" y="360" width="500" height="20" fill="#5a3a1c" ${stroke(2.5)}/>`;
    [300, 400, 600, 700].forEach((x, i) => (s += M.goldMask(x, 150, 0.55, i % 2 ? '#c4283a' : '#1fa59a') + M.goldMask(x, 310, 0.55, i % 2 ? '#1fa59a' : '#2c62c9')));
    // statues of forgotten gods
    s += L.jackalStatue(130, 620, 0.75) + L.jackalStatue(870, 620, 0.75, true);
    // treasure heaps
    s += M.goldPile(170, 1000, 420, 220, 1) + M.goldPile(840, 1000, 420, 200, 2) + M.goldPile(330, 1000, 200, 90, 3) + M.goldPile(690, 1000, 220, 100, 5);
    // pedestal and beam
    s += L.lightBeam(430, 570, 380, 620, 0, 760, '#fff6d8', 0.55);
    s += `<rect x="410" y="700" width="180" height="150" fill="#d9a64a" ${stroke(3)}/>
      <rect x="390" y="680" width="220" height="30" fill="#f2c45a" ${stroke(3)}/>
      <rect x="390" y="840" width="220" height="30" fill="#b9801b" ${stroke(3)}/>
      ${L.glyph(7, 500, 770, 2.2, '#5a3a1c', 0.8)}`;
    s += glow(500, 620, 180, '#ffe39a', 0.7);
    s += L.scarab(500, 620, 1.05);
    s += `<path d="M430 560 q-20 -10 -30 -26 M570 560 q20 -10 30 -26" stroke="#fff3c4" stroke-width="4" fill="none" opacity="0.8" stroke-linecap="round"/>`;
    return svg(s + vignette(0.45));
  },

  // 14. Chamber of Stolen Hearts
  ANU014: () => {
    let s = room({ x0: 260, y0: 100, x1: 740, y1: 580 }, redRoom);
    // doorway with the broken chain
    s += L.archDoor(500, 580, 150, 260, '#080203', '#5a1a1c');
    s += L.chainLinks(500, 520, 640, 920, 30, '#8a8682', '#4a4644') + L.chainLinks(640, 920, 1000, 960, 30, '#8a8682', '#4a4644');
    s += amberEyes(500, 400, 0.5, '#ff4a2a');
    // platform
    s += `<path d="M260 820 L740 820 L680 740 L320 740 Z" fill="#3a1012" ${stroke(3)}/><path d="M220 880 L780 880 L740 820 L260 820 Z" fill="#4a1416" ${stroke(3)}/>`;
    // hanging jars at several depths
    const jars = [[180, 220, 0.7], [330, 140, 0.6], [670, 160, 0.6], [820, 240, 0.7], [420, 300, 0.5], [580, 280, 0.5], [90, 470, 1.0], [910, 460, 1.0], [260, 450, 0.85], [740, 430, 0.85]];
    jars.forEach(([x, y, sc]) => (s += M.heartJar(x, y, sc, { chainTop: 0 })));
    // the hero's own jar
    s += M.heartJar(500, 640, 1.1, { chainTop: 0 }) + glow(500, 640, 160, '#ff9a6a', 0.35);
    s += L.hero(230, 1080, 0.95, { turn: 0.6 });
    return svg(s + vignette(0.55));
  },

  // 15. Ammit Unchained
  ANU015: () => {
    let s = room({ x0: 140, y0: 100, x1: 860, y1: 580 }, goldRoom);
    s += clawMarks(200, 180, 1.1, 10) + clawMarks(620, 160, 1.0, -8) + clawMarks(780, 300, 0.8, 20) + clawMarks(60, 420, 0.9, -6);
    s += L.torch(260, 360) + L.torch(740, 360);
    s += M.ammit(620, 860, 0.95, { flip: true });
    s += L.chainLinks(860, 200, 980, 620, 22);
    s += L.hero(170, 1060, 0.85, { turn: 0.5 });
    return svg(s + vignette(0.5));
  },

  // 16. The Broken Chain
  ANU016: () => {
    let s = room({ x0: 220, y0: 100, x1: 780, y1: 520 }, goldRoom, { tileRows: 7 });
    s += clawMarks(300, 200, 0.9, 6) + clawMarks(600, 220, 0.8, -6);
    s += L.torch(260, 330) + L.torch(740, 330);
    // vision: scribe removing the Heart Pan
    s += visionCircle(780, 250, 110, `<g opacity="0.9">${M.scribe(770, 360, 0.3, { desk: false, standing: true })}</g><path d="M800 270 Q830 300 860 270 Z" fill="#f2b833" ${stroke(2)}/>${L.hero(720, 360, 0.18, { cloak: '#1a0c04', hair: '#1a0c04' })}`, '#c58cff');
    // the heavy gold chain with a cleanly cut link
    s += L.chainLinks(0, 940, 440, 700, 46, '#f2b833', '#b9801b');
    s += L.chainLinks(560, 680, 1000, 820, 46, '#f2b833', '#b9801b');
    s += `<path d="M450 700 L470 690 M540 690 L560 680" stroke="#fff3c4" stroke-width="6" stroke-linecap="round"/>`;
    s += M.darkOrb(500, 520, 1.2);
    s += L.hero(220, 1060, 0.95, { armOut: true, turn: 0.4 });
    return svg(s + vignette(0.5));
  },

  // 17. Maze of False Memories
  ANU017: () => {
    let s = room({ x0: 380, y0: 220, x1: 620, y1: 560 }, blueRoom, { blocks: false });
    // doors into memories on the side walls
    const door = (pts, inner) => `<polygon points="${pts}" fill="${inner}" ${stroke(3)}/>`;
    s += door('60,260 180,300 180,620 60,660', '#ffd98a') + glow(120, 460, 140, '#ffd36b', 0.45);
    s += M.person(120, 640, 0.55, { cloth: '#7a4a2a', op: 0.7 });
    s += door('820,300 940,260 940,660 820,620', '#9ab8e0') + M.person(880, 640, 0.55, { cloth: '#3a4a6a', op: 0.6, flip: true });
    s += door('230,340 300,360 300,560 230,580', '#ffcf80') + door('700,360 770,340 770,580 700,560', '#7d92b8');
    // the fork: warm left path, dark right path
    s += glow(440, 420, 140, '#ffcf6b', 0.65) + glow(560, 420, 140, '#4a5a9a', 0.5);
    s += `<path d="M380 560 L500 560 L470 260 L410 260 Z" fill="#ffdb8a" opacity="0.35"/>`;
    s += L.archDoor(445, 540, 70, 170, '#ffe3a0', '#6a5a7a', 10) + L.archDoor(555, 540, 70, 170, '#10142a', '#6a5a7a', 10);
    s += `<path d="M440 900 C420 780 440 640 445 545" stroke="#ffd98a" stroke-width="40" opacity="0.25" fill="none"/>
      <path d="M560 900 C580 780 560 640 555 545" stroke="#2a3460" stroke-width="40" opacity="0.4" fill="none"/>`;
    s += L.fog(820, 5, '#e3e8f5', 0.85, 22, 260) + L.fog(240, 6, '#c9cde8', 0.18, 8, 160);
    s += L.hero(500, 1080, 1.0);
    return svg(s + vignette(0.55));
  },

  // 18. Memory of Home
  ANU018: () => {
    const home = { top: '#f1d2a2', bottom: '#e0b880', side: '#c99a62', floorA: '#9a6234', floorB: '#6a3e1e', ceil: '#b98a5a' };
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 640 }, home, { blocks: false, tileRows: 5, tileCols: 9 });
    // window and sunlight
    s += `<rect x="560" y="200" width="200" height="240" fill="#bfe6ff" ${stroke(4)}/>
      <path d="M660 200 L660 440 M560 320 L760 320" stroke="#8a5a2a" stroke-width="10"/>
      <rect x="548" y="430" width="224" height="22" fill="#c48a52" ${stroke(3)}/>
      <path d="M540 190 C560 260 550 380 520 460 L540 460 C570 380 580 260 556 190 Z" fill="#e8706a" ${stroke(2.5)}/>
      <path d="M780 190 C760 260 770 380 800 460 L780 460 C750 380 740 260 764 190 Z" fill="#e8706a" ${stroke(2.5)}/>`;
    s += L.lightBeam(560, 760, 420, 700, 440, 900, '#fff2c0', 0.45);
    // table, plant and picture
    s += `<rect x="250" y="250" width="140" height="110" fill="#fff3dc" ${stroke(3)}/><path d="M270 340 L310 290 L340 320 L370 280 L370 340 Z" fill="#7ab86a"/><circle cx="290" cy="280" r="12" fill="#ffc43a"/>
      <rect x="200" y="560" width="230" height="20" fill="#a66a34" ${stroke(3)}/><path d="M215 580 L215 700 M415 580 L415 700" stroke="${OL}" stroke-width="12"/><path d="M215 580 L215 700 M415 580 L415 700" stroke="#a66a34" stroke-width="7"/>
      <path d="M290 560 L300 510 L340 510 L350 560 Z" fill="#c9653a" ${stroke(3)}/><path d="M320 510 C300 460 280 450 270 440 M320 510 C330 460 350 450 370 446 M320 510 L322 450" stroke="#4a8a3a" stroke-width="8" stroke-linecap="round" fill="none"/>`;
    // flickering wall reveals tomb stone
    s += `<path d="M120 120 L200 140 L180 260 L210 330 L150 420 L90 300 Z" fill="#4b2b15" ${stroke(3)}/>`;
    s += L.glyphField(100, 150, 200, 400, 17, { col: '#f2b833', op: 0.6, dx: 30, colLines: false });
    // the loved one and a shadow pointing the wrong way (towards the window)
    s += `<path d="M640 850 L840 700 L870 720 L690 870 Z" fill="#3a2010" opacity="0.4"/>`;
    s += M.person(620, 860, 1.25, { dress: true, cloth: '#f7efe0', hairLong: true, hair: '#2a1a10', mood: 'smile', armOut: 1, flip: true });
    s += L.hero(220, 1080, 1.0, { turn: 0.6 });
    return svg(s + vignette(0.35));
  },

  // 19. Memory of Failure
  ANU019: () => {
    let s = sky('#2a2c44', '#4a4a66');
    s += `<rect x="0" y="560" width="1000" height="440" fill="#3a3a52"/>`;
    // doors closing behind the figures
    [[120, 0.3], [380, 0.15], [620, 0.15], [880, 0.3]].forEach(([x, open]) => {
      s += `<rect x="${x - 80}" y="180" width="160" height="380" fill="#151526" ${stroke(3)}/>
        <rect x="${x - 80}" y="180" width="${160 * (1 - open)}" height="380" fill="#6a5a7a" ${stroke(3)}/>
        <path d="M${x - 80 + 160 * (1 - open) - 14} 360 l0 30" stroke="#f2b833" stroke-width="6" stroke-linecap="round"/>`;
    });
    s += L.fog(560, 8, '#d9dcef', 0.6, 14, 120);
    // people turning to face you; some offered as someone to blame
    const people = [
      [170, 760, { cloth: '#7a5a8a', mood: 'sad', skin: '#d8a27a' }],
      [340, 720, { cloth: '#5a7aa0', mood: 'stern', point: true, flip: true }],
      [500, 700, { cloth: '#8a6a4a', mood: 'sad', dress: true, hairLong: true, skin: '#b07850' }],
      [660, 720, { cloth: '#4a7a6a', mood: 'stern', point: true }],
      [830, 760, { cloth: '#9a5a5a', mood: 'neutral', skin: '#e0b090', hair: '#6a4a2a' }],
    ];
    people.forEach(([x, y, o]) => (s += M.person(x, y, 1.0, o)));
    s += L.fog(900, 9, '#e3e6f5', 0.85, 20, 200);
    s += L.hero(500, 1100, 1.05);
    return svg(s + vignette(0.5));
  },

  // 20. The Heart Pan
  ANU020: () => {
    let s = `<rect width="1000" height="1000" fill="#3a0a0e"/>`;
    // ribbed heart-shaped chamber
    for (let i = 0; i < 5; i++) {
      const w = 520 - i * 80, h = 560 - i * 70, op = 0.9 - i * 0.12;
      s += `<path d="M500 ${700 - i * 10} C${500 - w * 1.4} ${700 - h * 0.7} ${500 - w * 0.6} ${700 - h * 1.4} 500 ${700 - h * 0.85}
        C${500 + w * 0.6} ${700 - h * 1.4} ${500 + w * 1.4} ${700 - h * 0.7} 500 ${700 - i * 10} Z" fill="${['#7a1c24', '#8f242c', '#a32e34', '#b93a3c', '#cc4a44'][i]}" opacity="${op}" ${stroke(3, '#2a0508')}/>`;
    }
    s += `<g stroke="#5a0e14" stroke-width="10" fill="none" opacity="0.6" stroke-linecap="round">
      <path d="M100 100 C200 200 180 300 260 380"/><path d="M900 100 C800 200 820 300 740 380"/><path d="M60 500 C160 520 200 600 260 640"/><path d="M940 500 C840 520 800 600 740 640"/></g>`;
    // floor with carved names
    s += `<ellipse cx="500" cy="860" rx="520" ry="200" fill="#4a1012" ${stroke(3)}/>`;
    s += `<ellipse cx="500" cy="860" rx="420" ry="150" fill="none" stroke="#e86a5a" stroke-width="3" opacity="0.6"/><ellipse cx="500" cy="860" rx="300" ry="100" fill="none" stroke="#e86a5a" stroke-width="3" opacity="0.6"/>`;
    const r = L.rng(20);
    for (let i = 0; i < 70; i++) {
      const a = r() * Math.PI * 2, d = 0.3 + r() * 0.65;
      s += L.glyph(Math.floor(r() * 8), 500 + Math.cos(a) * 480 * d, 860 + Math.sin(a) * 170 * d, 0.9, '#ff9a7a', 0.6);
    }
    // the hanging pan and its beam
    s += L.lightBeam(470, 530, 380, 620, 420, 870, '#ff6a5a', 0.45);
    s += `<path d="M500 0 L500 200 M500 200 L400 360 M500 200 L600 360" stroke="#3a1a10" stroke-width="5"/>`;
    s += glow(500, 380, 200, '#ffb04a', 0.55);
    s += `<path d="M380 360 Q500 450 620 360 Z" fill="#f2b833" ${stroke(3.5)}/><path d="M380 360 L620 360" stroke="#b9801b" stroke-width="7"/>
      <path d="M420 380 Q440 400 470 410" stroke="#fde59a" stroke-width="6" stroke-linecap="round" fill="none"/>`;
    s += glow(500, 900, 120, '#ffd36b', 0.4);
    s += L.hero(330, 1080, 0.95, { turn: 0.5 });
    return svg(s + vignette(0.55));
  },

  // 21. The Scribe's Secret
  ANU021: () => {
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 600 }, goldRoom, { blocks: false });
    // scroll cubbies on the walls
    const cubbies = (x0, y0, cols, rows, w, h, seed) => {
      let c = '';
      const r = L.rng(seed);
      for (let i = 0; i < cols; i++) for (let j = 0; j < rows; j++) {
        const x = x0 + i * w, y = y0 + j * h;
        c += `<rect x="${x}" y="${y}" width="${w}" height="${h}" fill="#3a2210" ${stroke(2.5)}/>`;
        for (let k = 0; k < 3; k++) c += `<circle cx="${x + w * (0.25 + k * 0.25)}" cy="${y + h * (0.45 + (k % 2) * 0.2)}" r="${h * 0.18}" fill="#efe0b8" ${stroke(1.5)}/><circle cx="${x + w * (0.25 + k * 0.25)}" cy="${y + h * (0.45 + (k % 2) * 0.2)}" r="${h * 0.06}" fill="#8a6a3a"/>`;
      }
      return c;
    };
    s += cubbies(180, 130, 8, 4, 80, 70, 1);
    s += L.torch(140, 380) + L.torch(860, 380);
    s += M.scribe(560, 760, 1.15);
    s += M.scrollPile(260, 860, 12, 4, 1.1) + M.scrollPile(860, 880, 10, 6, 1.1) + M.scrollPile(700, 990, 7, 9, 1.2);
    s += M.scroll(400, 960, 160, -12, 20) + M.scroll(560, 990, 180, 6, 20);
    s += L.hero(180, 1080, 0.95, { turn: 0.5 });
    return svg(s + vignette(0.5));
  },

  // 22. The True Name
  ANU022: () => {
    let s = sky('#05061a', '#14123a');
    s += L.stars(22, 260);
    // star-drawn jackal head
    // star-drawn jackal head, traced from Anubis's own profile
    const head = [[-40, -456], [-56, -500], [-10, -580], [-20, -680], [18, -600], [30, -598], [40, -688], [58, -588], [86, -558], [150, -540], [158, -528], [150, -518], [86, -512], [40, -452]];
    const pts = head.map(([x, y]) => [400 + (x + 40) * 2, 220 + (y + 688) * 2]);
    s += glow(560, 470, 320, '#6a7aff', 0.28);
    s += `<path d="M${pts.map(p => p.join(' ')).join(' L')} Z" fill="#6a7aff" fill-opacity="0.12" stroke="#c9d2ff" stroke-width="3" stroke-dasharray="3 9" stroke-linecap="round"/>`;
    pts.forEach(([x, y]) => (s += glow(x, y, 26, '#dfe6ff', 0.9) + `<circle cx="${x}" cy="${y}" r="4.5" fill="#ffffff"/>`));
    s += glow(590, 482, 46, '#ffc43a', 0.9) + `<path d="M570 482 Q590 470 610 482 Q590 490 570 482 Z" fill="#ffe08a"/>`;
    // reflective floor
    s += `<rect x="0" y="760" width="1000" height="240" fill="#0a0a22"/><path d="M0 760 L1000 760" stroke="#4a4a8a" stroke-width="3"/>`;
    s += `<g opacity="0.35" transform="translate(0 1520) scale(1 -1)">${pts.map(([x, y]) => `<circle cx="${x}" cy="${y}" r="3" fill="#dfe6ff"/>`).join('')}</g>`;
    s += M.scribe(790, 1000, 0.8, { desk: false, standing: true });
    s += L.hero(220, 1080, 1.0, { turn: 0.5 });
    return svg(s + vignette(0.45));
  },

  // 23. The Rebel's Offer
  ANU023: () => {
    let s = room({ x0: 160, y0: 100, x1: 840, y1: 600 }, { ...goldRoom, top: '#3a2414', bottom: '#4a2e18' });
    s += M.scrollPile(220, 700, 12, 3, 1.1) + M.scrollPile(820, 690, 11, 7, 1.0);
    // visions of the unfair judgment
    s += visionCircle(270, 260, 110, L.scales(270, 340, 0.3, { tilt: -15 }) + L.ghost(250, 300, 0.3, { op: 0.9 }), '#c58cff');
    s += visionCircle(560, 200, 90, `${M.person(530, 260, 0.25, { cloth: '#6a6a7a', op: 0.9, mood: 'sad' })}${M.person(590, 260, 0.25, { cloth: '#6a6a7a', op: 0.9, mood: 'sad' })}`, '#c58cff');
    s += visionCircle(810, 290, 90, `${M.goldMask(810, 290, 0.6, '#2c62c9')}`, '#c58cff');
    s += M.rebel(600, 980, 1.05);
    s += L.hero(220, 1080, 0.95, { turn: 0.5 });
    return svg(s + vignette(0.5));
  },

  // 24. Balance Stone Chamber
  ANU024: () => {
    let s = room({ x0: 140, y0: 80, x1: 860, y1: 620 }, { ...goldRoom, top: '#4a3420', bottom: '#5a3e22' });
    // the room leans around the stone
    s += `<g opacity="0.25" stroke="#1e1007" stroke-width="3" fill="none"><path d="M140 200 Q500 300 860 160"/><path d="M140 360 Q500 430 860 330"/><path d="M140 500 Q500 560 860 480"/></g>`;
    s += L.brazier(80, 880, 0.9);
    s += M.ringMachine(430, 900, 1.15);
    s += L.balanceStone(430, 330, 1.4);
    s += M.guardian(790, 1000, 0.85);
    s += L.hero(140, 1080, 0.85, { turn: 0.5 });
    return svg(s + vignette(0.5));
  },

  // 25. The Final Guardian
  ANU025: () => {
    let s = room({ x0: 160, y0: 80, x1: 840, y1: 600 }, { ...goldRoom, top: '#4a3420', bottom: '#5a3e22' });
    // collapsing chamber
    s += `<path d="M200 80 L260 220 L230 300 L300 420" stroke="${OL}" stroke-width="5" fill="none"/><path d="M760 80 L700 200 L740 300" stroke="${OL}" stroke-width="5" fill="none"/>`;
    const r = L.rng(25);
    for (let i = 0; i < 12; i++) {
      const x = 80 + r() * 840, y = 60 + r() * 500, w = 20 + r() * 40;
      s += `<rect x="${x}" y="${y}" width="${w}" height="${w * 0.7}" fill="#8a7458" ${stroke(2.5)} transform="rotate(${r() * 60} ${x} ${y})"/>`;
    }
    s += M.ringMachine(300, 680, 0.5);
    s += `<g opacity="0.7">${L.fog(900, 11, '#c9b48f', 0.6, 14, 120)}</g>`;
    s += M.guardian(620, 1000, 0.9, { cracked: true, kneel: true });
    s += L.balanceStone(150, 660, 0.7);
    s += L.hero(170, 1080, 0.85, { turn: 0.5 });
    return svg(s + vignette(0.5));
  },

  // 26. Return to the Hall
  ANU026: () => {
    let s = room({ x0: 200, y0: 60, x1: 800, y1: 620 }, { ...goldRoom, top: '#2a1a10', bottom: '#4a2e18' }, { tileRows: 7 });
    for (let i = 0; i < 9; i++) s += L.ghost(240 + i * 65, 520 + (i % 2) * 30, 0.42, { op: 0.45 });
    s += L.pillar(130, 40, 900, 90) + L.pillar(870, 40, 900, 90);
    s += amberEyes(960, 360, 0.5, '#ff6a3a');
    s += brokenScales(380, 860, 0.6);
    s += L.anubis(620, 900, 0.9, { arm: 'reach', flip: true });
    // the three recovered pieces float above the hero's hand
    s += glow(300, 640, 200, '#ffd36b', 0.4);
    s += L.feather(220, 690, 0.45, -20, '#ffe08a', '#e8b84a');
    s += `<path d="M260 620 Q300 650 340 620 Z" fill="#f2b833" ${stroke(2.5)}/>`;
    s += L.balanceStone(380, 640, 0.55);
    s += L.hero(250, 1080, 1.0, { armOut: true, turn: 0.4 });
    return svg(s + vignette(0.5));
  },

  // 27. The Weighing Begins
  ANU027: () => {
    let s = room({ x0: 200, y0: 60, x1: 800, y1: 620 }, { ...goldRoom, top: '#22150c', bottom: '#4a2e18' }, { tileRows: 7 });
    for (let i = 0; i < 8; i++) s += L.ghost(260 + i * 70, 560 + (i % 2) * 24, 0.38, { op: 0.4 });
    // Ammit watching from the shadows behind the pillars
    s += glow(800, 520, 200, '#000', 0.6);
    s += `<g opacity="0.85">${M.ammit(880, 660, 0.45, { flip: true, mouth: 'closed', chains: false })}</g>`;
    s += L.pillar(110, 40, 900, 90) + L.pillar(890, 40, 900, 90);
    s += L.anubis(260, 880, 0.88, { arm: 'reach' });
    s += L.scales(560, 900, 0.95, { glowCol: '#ffd36b', right: L.feather(0, 140, 0.45, 75, '#fff3c4', '#e8b84a') });
    s += glow(660, 950, 220, '#ff5a4a', 0.45);
    s += L.hero(700, 1100, 0.95, { turn: -0.5 });
    s += L.heart(700, 860, 0.45) + glow(700, 860, 80, '#ff5a4a', 0.6);
    return svg(s + vignette(0.5));
  },
};
Object.assign(module.exports, require('./scenes2'));
