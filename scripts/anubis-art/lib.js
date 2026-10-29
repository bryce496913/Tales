// Shared drawing helpers for The Trial of Anubis scene art.
// Every scene is drawn in a 1000x1000 SVG coordinate space and rendered to
// 1254x1254 PNG (the same size as the Tales From the Sphinx art).

const OL = '#2a1708';
let gid = 0;
const uid = (p = 'g') => `${p}${++gid}`;

function rng(seed) {
  let a = seed >>> 0;
  return () => {
    a = (a + 0x6d2b79f5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

const stroke = (w = 3, c = OL) =>
  `stroke="${c}" stroke-width="${w}" stroke-linejoin="round" stroke-linecap="round"`;

const g = (content, tf = '') => `<g${tf ? ` transform="${tf}"` : ''}>${content}</g>`;
const at = (x, y, sc = 1, content, flip = false) =>
  g(content, `translate(${x} ${y}) scale(${flip ? -sc : sc} ${sc})`);

function linGrad(stops, x1 = 0, y1 = 0, x2 = 0, y2 = 1) {
  const id = uid('lg');
  const s = stops.map(([o, c, op = 1]) => `<stop offset="${o}" stop-color="${c}" stop-opacity="${op}"/>`).join('');
  return { id, def: `<defs><linearGradient id="${id}" x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}">${s}</linearGradient></defs>`, url: `url(#${id})` };
}

function radGrad(stops, cx = 0.5, cy = 0.5, r = 0.5) {
  const id = uid('rg');
  const s = stops.map(([o, c, op = 1]) => `<stop offset="${o}" stop-color="${c}" stop-opacity="${op}"/>`).join('');
  return { id, def: `<defs><radialGradient id="${id}" cx="${cx}" cy="${cy}" r="${r}">${s}</radialGradient></defs>`, url: `url(#${id})` };
}

// Soft light pool.
function glow(cx, cy, r, color, op = 0.55) {
  const gr = radGrad([[0, color, op], [0.45, color, op * 0.45], [1, color, 0]]);
  return `${gr.def}<circle cx="${cx}" cy="${cy}" r="${r}" fill="${gr.url}"/>`;
}

function ellipseGlow(cx, cy, rx, ry, color, op = 0.5) {
  const gr = radGrad([[0, color, op], [0.5, color, op * 0.4], [1, color, 0]]);
  return `${gr.def}<ellipse cx="${cx}" cy="${cy}" rx="${rx}" ry="${ry}" fill="${gr.url}"/>`;
}

function vignette(op = 0.55) {
  const gr = radGrad([[0.55, '#000', 0], [1, '#000', op]], 0.5, 0.5, 0.75);
  return `${gr.def}<rect width="1000" height="1000" fill="${gr.url}"/>`;
}

// ---------------------------------------------------------------- rooms

const WALL = { top: '#6e4626', bottom: '#4b2b15', side: '#3f2412', floorA: '#5d3b1f', floorB: '#3a2211', ceil: '#2c190b' };

// Perspective room. Back wall is the rectangle (x0,y0)-(x1,y1).
function room(b, pal = WALL, opts = {}) {
  const { x0, y0, x1, y1 } = b;
  const back = linGrad([[0, pal.top], [1, pal.bottom]]);
  const floor = linGrad([[0, pal.floorA], [1, pal.floorB]]);
  const lw = linGrad([[0, pal.side], [1, pal.top]], 0, 0, 1, 0);
  const rw = linGrad([[0, pal.top], [1, pal.side]], 0, 0, 1, 0);
  let out = back.def + floor.def + lw.def + rw.def;
  out += `<rect width="1000" height="1000" fill="${pal.ceil}"/>`;
  out += `<polygon points="0,0 ${x0},${y0} ${x0},${y1} 0,1000" fill="${lw.url}"/>`;
  out += `<polygon points="1000,0 ${x1},${y0} ${x1},${y1} 1000,1000" fill="${rw.url}"/>`;
  out += `<polygon points="0,1000 ${x0},${y1} ${x1},${y1} 1000,1000" fill="${floor.url}"/>`;
  out += `<rect x="${x0}" y="${y0}" width="${x1 - x0}" height="${y1 - y0}" fill="${back.url}"/>`;
  out += `<polygon points="0,0 1000,0 ${x1},${y0} ${x0},${y0}" fill="${pal.ceil}"/>`;
  // edges
  out += `<g opacity="0.35" ${stroke(2)} fill="none"><path d="M0 0 L${x0} ${y0} L${x0} ${y1} L0 1000 M1000 0 L${x1} ${y0} L${x1} ${y1} L1000 1000 M${x0} ${y1} L${x1} ${y1}"/></g>`;
  if (opts.tiles !== false) out += floorTiles(b, opts.tileRows || 6, opts.tileCols || 7);
  if (opts.blocks !== false) out += wallBlocks(x0, y0, x1, y1);
  return out;
}

function floorTiles({ x0, x1, y1 }, rows = 6, cols = 7) {
  // Vanishing point where the two floor edges meet.
  const m1 = (y1 - 1000) / x0, m2 = (y1 - 1000) / (x1 - 1000);
  const vxx = (m1 * 0 - m2 * 1000) / (m1 - m2);
  const vy = 1000 + m1 * (vxx - 0);
  let d = '';
  for (let i = 1; i < cols; i++) {
    const bx = x0 + ((x1 - x0) * i) / cols;
    const t = (1000 - vy) / (y1 - vy);
    d += `M${bx} ${y1} L${vxx + (bx - vxx) * t} 1000 `;
  }
  for (let j = 1; j <= rows; j++) {
    const t = Math.pow(j / rows, 1.8);
    const y = y1 + (1000 - y1) * t;
    d += `M0 ${y} L1000 ${y} `;
  }
  const id = uid('cl');
  return `<defs><clipPath id="${id}"><polygon points="0,1000 ${x0},${y1} ${x1},${y1} 1000,1000"/></clipPath></defs>
  <path d="${d}" clip-path="url(#${id})" stroke="#1e1007" stroke-opacity="0.28" stroke-width="2.5" fill="none"/>`;
}

function wallBlocks(x0, y0, x1, y1, op = 0.18) {
  let d = '';
  const h = 70;
  let row = 0;
  for (let y = y0 + h; y < y1; y += h, row++) {
    d += `M${x0} ${y} L${x1} ${y} `;
    const off = row % 2 ? 0 : 75;
    for (let x = x0 + off + 150; x < x1; x += 150) d += `M${x} ${y} L${x} ${y + h} `;
  }
  const id = uid('cl');
  return `<defs><clipPath id="${id}"><rect x="${x0}" y="${y0}" width="${x1 - x0}" height="${y1 - y0}"/></clipPath></defs>
  <path d="${d}" clip-path="url(#${id})" stroke="#1e1007" stroke-opacity="${op}" stroke-width="2.5" fill="none"/>`;
}

// ---------------------------------------------------------------- fire

function flamePath(w, h) {
  return `M0 ${-h} C${w * 0.18} ${-h * 0.72} ${w * 0.62} ${-h * 0.52} ${w * 0.5} ${-h * 0.22}
    C${w * 0.42} ${-h * 0.02} ${w * 0.2} 0 0 0 C${-w * 0.2} 0 ${-w * 0.45} ${-h * 0.04} ${-w * 0.5} ${-h * 0.24}
    C${-w * 0.56} ${-h * 0.48} ${-w * 0.22} ${-h * 0.56} ${-w * 0.1} ${-h * 0.78} C${-w * 0.04} ${-h * 0.62} ${w * 0.04} ${-h * 0.84} 0 ${-h} Z`;
}

function flame(x, y, w, h, blue = false) {
  const c = blue ? ['#1f5fd6', '#4fa6ff', '#d8f1ff'] : ['#f07a12', '#ffc02e', '#fff2b0'];
  return at(x, y, 1, `
    <path d="${flamePath(w, h)}" fill="${c[0]}" ${stroke(2, blue ? '#0f2a66' : '#7a2e05')}/>
    <path d="${flamePath(w * 0.68, h * 0.72)}" fill="${c[1]}" transform="translate(0 -2)"/>
    <path d="${flamePath(w * 0.36, h * 0.42)}" fill="${c[2]}" transform="translate(0 -3)"/>`);
}

function torch(x, y, sc = 1, flip = false) {
  return glow(x, y - 70 * sc, 190 * sc, '#ff9a2a', 0.5) + at(x, y, sc, `
    <path d="M-7 0 L7 0 L4 120 L-4 120 Z" fill="#6b3c1c" ${stroke(2.5)}/>
    <path d="M-3 4 L-2 116" stroke="#8d5630" stroke-width="3" opacity="0.7"/>
    <rect x="-16" y="-10" width="32" height="16" rx="3" fill="#7d7a76" ${stroke(2.5)}/>
    <rect x="-12" y="40" width="24" height="10" rx="2" fill="#6b6865" ${stroke(2)}/>
    <path d="M12 45 L30 45 L30 60" fill="none" stroke="#5a5755" stroke-width="5"/>
    ${flame(0, -6, 40, 78)}`, flip);
}

function brazier(x, y, sc = 1, blue = true) {
  const col = blue ? '#4aa3ff' : '#ff9a2a';
  return glow(x, y - 110 * sc, 230 * sc, col, 0.5) + at(x, y, sc, `
    <path d="M-30 0 L30 0 L18 -12 L-18 -12 Z" fill="#3b3430" ${stroke(2.5)}/>
    <rect x="-8" y="-62" width="16" height="52" fill="#4a423c" ${stroke(2.5)}/>
    <path d="M-52 -92 L52 -92 Q46 -58 0 -56 Q-46 -58 -52 -92 Z" fill="#544a42" ${stroke(3)}/>
    <path d="M-52 -92 L52 -92" stroke="#7c6d60" stroke-width="5"/>
    <path d="M-40 -80 Q0 -70 40 -80" fill="none" stroke="#c9a14a" stroke-width="4"/>
    ${flame(0, -92, 70, 120, blue)}`);
}

// ---------------------------------------------------------------- architecture

function pillar(x, yTop, yBot, w = 70, pal = { a: '#e6ae3a', b: '#c98c22', c: '#f6cf62' }) {
  const h = yBot - yTop;
  const sh = linGrad([[0, pal.b], [0.35, pal.c], [0.7, pal.a], [1, pal.b]], 0, 0, 1, 0);
  return sh.def + `<g ${stroke(3)}>
    <rect x="${x - w / 2 - 12}" y="${yBot - 26}" width="${w + 24}" height="26" fill="${pal.b}"/>
    <rect x="${x - w / 2 - 6}" y="${yBot - 40}" width="${w + 12}" height="16" fill="${pal.a}"/>
    <rect x="${x - w / 2}" y="${yTop + 40}" width="${w}" height="${h - 80}" fill="${sh.url}"/>
    <path d="M${x - w / 2 - 22} ${yTop} L${x + w / 2 + 22} ${yTop} L${x + w / 2 + 6} ${yTop + 30} L${x - w / 2 - 6} ${yTop + 30} Z" fill="${pal.a}"/>
    <rect x="${x - w / 2 - 4}" y="${yTop + 28}" width="${w + 8}" height="14" fill="${pal.b}"/>
  </g>
  <path d="M${x - w * 0.18} ${yTop + 50} L${x - w * 0.18} ${yBot - 50} M${x + w * 0.18} ${yTop + 50} L${x + w * 0.18} ${yBot - 50}" stroke="${pal.b}" stroke-width="3" opacity="0.6"/>`;
}

function archDoor(x, y, w, h, inner = '#120a05', frame = '#e3a93a', fw = 22) {
  const r = w / 2;
  const path = (W, H) => `M${-W / 2} 0 L${-W / 2} ${-H + W / 2} A${W / 2} ${W / 2} 0 0 1 ${W / 2} ${-H + W / 2} L${W / 2} 0 Z`;
  return at(x, y, 1, `
    <path d="${path(w + fw * 2, h + fw)}" fill="${frame}" ${stroke(3)}/>
    <path d="${path(w, h)}" fill="${inner}" ${stroke(3)}/>`);
}

function stairsDown(x, y, w, n = 7, col = '#5a3a20') {
  let s = '';
  for (let i = 0; i < n; i++) {
    const t = i / n;
    const ww = w * (1 - t * 0.55);
    const yy = y - i * 34 * (1 - t * 0.4);
    const hh = 30 * (1 - t * 0.4);
    const shade = Math.round(90 - t * 60);
    s += `<rect x="${x - ww / 2}" y="${yy - hh}" width="${ww}" height="${hh}" fill="rgb(${shade + 40},${shade + 10},${shade - 20})" ${stroke(2)}/>`;
  }
  return s;
}

// Small hieroglyph doodles.
function glyph(kind, x, y, s, col = '#2a1708', op = 0.5) {
  const k = ['ankh', 'eye', 'bird', 'water', 'feather', 'sun', 'reed', 'jackal'][kind % 8];
  let d = '';
  switch (k) {
    case 'ankh': d = `<ellipse cx="0" cy="-12" rx="5" ry="7" fill="none"/><path d="M0 -5 L0 14 M-8 -3 L8 -3"/>`; break;
    case 'eye': d = `<path d="M-11 0 Q0 -9 11 0 Q0 7 -11 0 Z" fill="none"/><circle cx="0" cy="-1" r="2.5"/><path d="M-3 4 L-5 11"/>`; break;
    case 'bird': d = `<path d="M-8 10 L-6 -2 Q-2 -12 6 -8 L10 -6 L5 -4 Q4 6 -2 10 Z" fill="none"/>`; break;
    case 'water': d = `<path d="M-12 0 L-8 -4 L-4 0 L0 -4 L4 0 L8 -4 L12 0"/>`; break;
    case 'feather': d = `<path d="M0 12 L0 -12 Q8 -6 4 10"/>`; break;
    case 'sun': d = `<circle cx="0" cy="0" r="7" fill="none"/><circle cx="0" cy="0" r="2"/>`; break;
    case 'reed': d = `<path d="M0 12 L0 -8 Q6 -14 4 -4 M-4 12 L4 12"/>`; break;
    case 'jackal': d = `<path d="M-10 6 L6 6 L8 -2 L12 -4 L8 -8 L6 -14 L4 -8 L-6 -4 Z" fill="none"/>`; break;
  }
  return `<g transform="translate(${x} ${y}) scale(${s})" stroke="${col}" stroke-width="${2.2 / s}" stroke-linecap="round" fill="${col}" opacity="${op}">${d}</g>`;
}

function glyphField(x0, y0, x1, y1, seed, opts = {}) {
  const r = rng(seed);
  const { size = 1, col = '#2a1708', op = 0.45, dx = 34, dy = 40, colLines = true } = opts;
  let out = '';
  for (let x = x0 + dx / 2; x < x1; x += dx) {
    if (colLines) out += `<path d="M${x + dx / 2} ${y0} L${x + dx / 2} ${y1}" stroke="${col}" stroke-opacity="${op * 0.4}" stroke-width="1.5"/>`;
    for (let y = y0 + dy / 2; y < y1; y += dy) {
      if (r() < 0.12) continue;
      out += glyph(Math.floor(r() * 8), x, y, size * (0.8 + r() * 0.3), col, op);
    }
  }
  return out;
}

// ---------------------------------------------------------------- props

function scales(x, y, sc = 1, opts = {}) {
  const { tilt = 0, broken = false, left = '', right = '', glowCol = null } = opts;
  const gold = '#f2b833', dk = '#b9801b';
  const pan = (px, py, content) => `
    <path d="M${px - 70} ${py} L${px} ${py - 150} L${px + 70} ${py}" fill="none" stroke="#8a5d14" stroke-width="3"/>
    ${content}
    <path d="M${px - 78} ${py} Q${px} ${py + 46} ${px + 78} ${py} Z" fill="${gold}" ${stroke(3)}/>
    <path d="M${px - 78} ${py} L${px + 78} ${py}" stroke="${dk}" stroke-width="5"/>`;
  const a = (tilt * Math.PI) / 180;
  const lx = -190 * Math.cos(a), ly = -190 * Math.sin(a);
  const rx = 190 * Math.cos(a), ry = 190 * Math.sin(a);
  let body = `
    ${glowCol ? glow(0, -300, 360, glowCol, 0.4) : ''}
    <path d="M-110 0 L110 0 L80 -38 L-80 -38 Z" fill="${gold}" ${stroke(3)}/>
    <rect x="-14" y="-380" width="28" height="345" fill="${gold}" ${stroke(3)}/>
    <path d="M-4 -370 L-4 -50" stroke="#fbe08a" stroke-width="5"/>
    <circle cx="0" cy="-395" r="24" fill="${gold}" ${stroke(3)}/>
    <circle cx="0" cy="-395" r="9" fill="#2f8fd1" ${stroke(2)}/>`;
  if (broken) {
    body += `
    <g transform="translate(0 -380) rotate(18)">
      <rect x="-200" y="-10" width="160" height="20" rx="6" fill="${gold}" ${stroke(3)}/>
    </g>
    <path d="M-40 -380 L-20 -392 L-10 -372" fill="none" ${stroke(3)}/>
    <g transform="translate(150 -16) rotate(-8)">
      <path d="M-78 0 Q0 46 78 0 Z" fill="${gold}" ${stroke(3)}/>
      <path d="M-20 4 L-6 22 L-14 36 M10 2 L4 20" fill="none" ${stroke(3)}/>
    </g>
    <g transform="translate(-170 -12) rotate(14)">
      <rect x="-26" y="-14" width="52" height="28" rx="6" fill="#d39a2a" ${stroke(3)}/>
    </g>`;
  } else {
    body += `
    <g transform="translate(0 -380)">
      <path d="M${lx} ${ly} L${rx} ${ry}" stroke="${OL}" stroke-width="22" stroke-linecap="round"/>
      <path d="M${lx} ${ly} L${rx} ${ry}" stroke="${gold}" stroke-width="16" stroke-linecap="round"/>
      ${g(pan(0, 150, left), `translate(${lx} ${ly})`)}
      ${g(pan(0, 150, right), `translate(${rx} ${ry})`)}
    </g>`;
  }
  return at(x, y, sc, body);
}

function feather(x, y, sc = 1, rot = 0, col = '#fbf3df', vane = '#e9d9b4') {
  return g(`
    <path d="M0 0 C-30 -40 -34 -150 -6 -230 C26 -170 34 -60 0 0 Z" fill="${col}" ${stroke(3)}/>
    <path d="M0 10 C-4 -70 -6 -150 -6 -226" fill="none" stroke="#b99a62" stroke-width="3"/>
    <g stroke="${vane}" stroke-width="3" fill="none">
      <path d="M-4 -40 L-22 -60 M-5 -80 L-25 -102 M-6 -120 L-22 -144 M-6 -160 L-16 -182 M-2 -50 L18 -70 M-3 -95 L20 -116 M-4 -140 L14 -160"/>
    </g>
    <path d="M-14 -96 L-20 -90" stroke="${OL}" stroke-width="3"/>`,
    `translate(${x} ${y}) rotate(${rot}) scale(${sc})`);
}

function heart(x, y, sc = 1, col = '#d6283f') {
  return at(x, y, sc, `
    <path d="M0 40 C-60 0 -70 -40 -40 -55 C-20 -65 -4 -52 0 -36 C4 -52 20 -65 40 -55 C70 -40 60 0 0 40 Z" fill="${col}" ${stroke(3)}/>
    <path d="M-34 -40 C-46 -30 -44 -16 -36 -6" fill="none" stroke="#ff8a96" stroke-width="7" stroke-linecap="round"/>`);
}

function balanceStone(x, y, sc = 1) {
  return glow(x, y, 120 * sc, '#5fe0d0', 0.55) + at(x, y, sc, `
    <path d="M0 -48 L40 -16 L30 36 L-30 36 L-40 -16 Z" fill="#26a59a" ${stroke(3)}/>
    <path d="M0 -48 L12 -6 L30 36 M12 -6 L-40 -16 M12 -6 L-30 36" fill="none" stroke="#1a7a72" stroke-width="3"/>
    <path d="M-6 -36 L-28 -16" stroke="#aaf5ec" stroke-width="6" stroke-linecap="round"/>
    <path d="M-40 -16 L40 -16" stroke="#f2b833" stroke-width="7"/>`);
}

function scarab(x, y, sc = 1) {
  return at(x, y, sc, `
    <g fill="none" stroke="${OL}" stroke-width="5" stroke-linecap="round">
      <path d="M-40 -10 L-70 -30 M-42 14 L-74 20 M-36 34 L-62 58 M40 -10 L70 -30 M42 14 L74 20 M36 34 L62 58"/>
    </g>
    <ellipse cx="0" cy="12" rx="46" ry="54" fill="#f2b833" ${stroke(3)}/>
    <path d="M0 -30 L0 64" stroke="#b9801b" stroke-width="4"/>
    <path d="M-30 -24 Q0 -36 30 -24" fill="none" stroke="#b9801b" stroke-width="4"/>
    <path d="M-26 -36 Q0 -74 26 -36 Z" fill="#e3a52a" ${stroke(3)}/>
    <path d="M-20 0 Q-26 30 -12 50" fill="none" stroke="#fde59a" stroke-width="7" stroke-linecap="round"/>`);
}

function chainLinks(x1, y1, x2, y2, size = 26, col = '#9a9894', dark = '#5a5856') {
  const len = Math.hypot(x2 - x1, y2 - y1);
  const ang = (Math.atan2(y2 - y1, x2 - x1) * 180) / Math.PI;
  const n = Math.floor(len / (size * 1.25));
  let s = '';
  for (let i = 0; i < n; i++) {
    const cx = i * size * 1.25 + size / 2;
    if (i % 2 === 0) s += `<ellipse cx="${cx}" cy="0" rx="${size * 0.82}" ry="${size * 0.48}" fill="none" stroke="${OL}" stroke-width="${size * 0.42}"/><ellipse cx="${cx}" cy="0" rx="${size * 0.82}" ry="${size * 0.48}" fill="none" stroke="${col}" stroke-width="${size * 0.26}"/>`;
    else s += `<rect x="${cx - size * 0.8}" y="${-size * 0.13}" width="${size * 1.6}" height="${size * 0.26}" rx="${size * 0.13}" fill="${dark}" ${stroke(2)}/>`;
  }
  return g(s, `translate(${x1} ${y1}) rotate(${ang})`);
}

// Seated jackal statue (facing right). Origin is the bottom centre of the plinth.
function jackalStatue(x, y, sc = 1, flip = false, opts = {}) {
  const { body = '#1b1d2a', hi = '#353a52', eye = '#ffc43a', plinth = '#c7922e' } = opts;
  return at(x, y, sc, `
    <rect x="-80" y="-40" width="170" height="40" fill="${plinth}" ${stroke(3)}/>
    <rect x="-70" y="-56" width="150" height="18" fill="#e0aa3e" ${stroke(3)}/>
    <path d="M-60 -56 C-74 -110 -60 -170 -16 -180 C2 -220 10 -250 22 -262
             L40 -300 L44 -258 L52 -252 L66 -298 L70 -244 C80 -236 84 -230 92 -224 L128 -210
             C132 -204 130 -196 122 -194 L84 -190 C76 -184 70 -176 68 -160
             L62 -118 L64 -56 Z" fill="${body}" ${stroke(3)}/>
    <path d="M22 -56 L28 -150 L58 -150 L58 -56 Z" fill="${body}" ${stroke(3)}/>
    <path d="M40 -56 L44 -140" stroke="${hi}" stroke-width="4" fill="none"/>
    <path d="M18 -56 Q40 -68 72 -56 Z" fill="${body}" ${stroke(2.5)}/>
    <path d="M-50 -64 C-58 -110 -46 -150 -20 -166" stroke="${hi}" stroke-width="6" fill="none" stroke-linecap="round"/>
    <path d="M-60 -56 C-90 -56 -96 -40 -76 -40" fill="none" stroke="${body}" stroke-width="12" stroke-linecap="round"/>
    <path d="M14 -184 Q46 -164 76 -182 L72 -168 Q44 -150 12 -170 Z" fill="#f2b833" ${stroke(2.5)}/>
    <path d="M24 -170 L28 -160 M40 -164 L42 -154 M56 -166 L56 -156" stroke="#2f8fd1" stroke-width="3"/>
    <path d="M58 -240 Q68 -246 78 -238 Q68 -232 58 -240 Z" fill="${eye}" ${stroke(1.5)}/>
    ${glow(68, -238, 30, eye, 0.6)}
    <path d="M46 -290 L48 -262" stroke="${hi}" stroke-width="3"/>`, flip);
}

// ---------------------------------------------------------------- characters

// Anubis standing, body facing viewer, head in profile facing right.
// Origin: between the feet. Height ~640 at sc=1.
function anubis(x, y, sc = 1, opts = {}) {
  const { flip = false, arm = 'staff', eye = '#ffc43a' } = opts;
  const skin = '#1e2236', skinHi = '#3a4266', gold = '#f2b833', blue = '#2c62c9';
  const staff = `
    <rect x="150" y="-540" width="14" height="545" rx="4" fill="${gold}" ${stroke(3)}/>
    <path d="M150 -540 L150 -572 L176 -590 L188 -574 L164 -560 L164 -540 Z" fill="${gold}" ${stroke(3)}/>
    <path d="M150 5 L164 5 L170 22 L144 22 Z" fill="${gold}" ${stroke(2)}/>`;
  const rightArm = arm === 'staff' ? `
    <path d="M86 -360 C120 -340 142 -300 150 -270 L168 -270 C162 -320 138 -380 104 -398 Z" fill="${skin}" ${stroke(3)}/>
    <rect x="132" y="-292" width="46" height="34" rx="12" fill="${skin}" ${stroke(3)}/>
    <rect x="128" y="-336" width="34" height="18" rx="4" fill="${gold}" ${stroke(2.5)}/>`
    : arm === 'reach' ? `
    <path d="M86 -390 C150 -380 210 -360 262 -350 L262 -318 C200 -322 140 -330 90 -340 Z" fill="${skin}" ${stroke(3)}/>
    <rect x="160" y="-362" width="22" height="38" rx="4" fill="${gold}" ${stroke(2.5)}/>
    <path d="M258 -356 C290 -366 312 -358 316 -342 C318 -328 300 -318 262 -318 Z" fill="${skin}" ${stroke(3)}/>
    <path d="M286 -360 L306 -380 M298 -356 L322 -370" stroke="${skin}" stroke-width="12" stroke-linecap="round"/>`
    : `
    <path d="M80 -420 C140 -470 200 -560 236 -640 L262 -626 C230 -540 160 -440 96 -380 Z" fill="${skin}" ${stroke(3)}/>
    <rect x="186" y="-560" width="30" height="22" rx="4" fill="${gold}" ${stroke(2.5)}/>
    <path d="M232 -640 C224 -680 240 -704 252 -712 L262 -684 L272 -714 L280 -680 L292 -706 L290 -662 L262 -626 Z" fill="${skin}" ${stroke(3)}/>`;
  return at(x, y, sc, `
    ${arm === 'staff' ? staff : ''}
    <!-- legs -->
    <path d="M-50 -170 L-46 -8 L-12 -8 L-8 -170 Z" fill="${skin}" ${stroke(3)}/>
    <path d="M10 -170 L14 -8 L48 -8 L52 -170 Z" fill="${skin}" ${stroke(3)}/>
    <path d="M-62 0 L-46 -14 L-10 -14 L-6 0 Z M6 0 L14 -14 L50 -14 L64 0 Z" fill="${skin}" ${stroke(3)}/>
    <rect x="-52" y="-58" width="44" height="14" fill="${gold}" ${stroke(2)}/>
    <rect x="8" y="-58" width="44" height="14" fill="${gold}" ${stroke(2)}/>
    <!-- kilt -->
    <path d="M-78 -270 L78 -270 L92 -150 L-92 -150 Z" fill="#f4ead2" ${stroke(3)}/>
    <path d="M-30 -268 L-40 -152 M0 -268 L0 -152 M30 -268 L40 -152" stroke="#cdbf9c" stroke-width="3"/>
    <path d="M-22 -270 L22 -270 L30 -140 L0 -118 L-30 -140 Z" fill="${gold}" ${stroke(3)}/>
    <path d="M-16 -250 L16 -250 M-18 -225 L18 -225 M-20 -200 L20 -200 M-22 -175 L22 -175" stroke="${blue}" stroke-width="6"/>
    <rect x="-82" y="-290" width="164" height="26" fill="${gold}" ${stroke(3)}/>
    <!-- torso -->
    <path d="M-86 -440 C-92 -380 -80 -320 -70 -290 L70 -290 C80 -320 92 -380 86 -440 Z" fill="${skin}" ${stroke(3)}/>
    <path d="M-50 -380 Q-40 -330 -40 -300" stroke="${skinHi}" stroke-width="6" fill="none" stroke-linecap="round"/>
    <!-- left arm -->
    <path d="M-86 -430 C-120 -400 -128 -330 -120 -260 L-92 -260 C-96 -320 -92 -380 -70 -404 Z" fill="${skin}" ${stroke(3)}/>
    <rect x="-126" y="-330" width="34" height="18" rx="4" fill="${gold}" ${stroke(2.5)}/>
    <ellipse cx="-106" cy="-248" rx="20" ry="24" fill="${skin}" ${stroke(3)}/>
    ${rightArm}
    <!-- broad collar -->
    <path d="M-96 -446 C-80 -380 80 -380 96 -446 C60 -470 -60 -470 -96 -446 Z" fill="${gold}" ${stroke(3)}/>
    <path d="M-84 -438 C-60 -400 60 -400 84 -438" fill="none" stroke="${blue}" stroke-width="9"/>
    <path d="M-72 -426 C-50 -410 50 -410 72 -426" fill="none" stroke="#1fa59a" stroke-width="6"/>
    <g transform="translate(0 -452) scale(1.28) translate(0 452)">
    <!-- nemes stripes behind head -->
    <path d="M-40 -560 C-70 -540 -76 -480 -64 -440 L-28 -440 C-36 -480 -30 -530 -12 -560 Z" fill="${gold}" ${stroke(3)}/>
    <path d="M-58 -530 L-28 -540 M-64 -500 L-30 -506 M-64 -470 L-32 -472" stroke="${blue}" stroke-width="7"/>
    <!-- head (profile, facing right) -->
    <path d="M-40 -456 C-56 -500 -46 -560 -10 -580 L-20 -680 L18 -600 L30 -598 L40 -688 L58 -588
             C70 -578 78 -566 86 -558 L150 -540 C160 -536 160 -522 150 -518 L86 -512
             C70 -500 50 -470 40 -452 Z" fill="${skin}" ${stroke(3)}/>
    <path d="M-12 -664 L2 -604 M38 -670 L44 -600" stroke="${skinHi}" stroke-width="5" stroke-linecap="round"/>
    <path d="M-10 -592 C-30 -560 -30 -510 -10 -470" stroke="${skinHi}" stroke-width="6" fill="none" stroke-linecap="round"/>
    <path d="M40 -560 Q56 -566 70 -556 Q56 -548 40 -556 Z" fill="${eye}" ${stroke(2)}/>
    ${glow(55, -557, 40, eye, 0.55)}
    <path d="M148 -530 L152 -526" stroke="#000" stroke-width="5" stroke-linecap="round"/>
    </g>`, flip);
}

// Hooded traveller seen from behind. Origin: bottom centre. Height ~420.
function hero(x, y, sc = 1, opts = {}) {
  const { flip = false, cloak = '#45322a', hair = '#24160f', turn = 0, kneel = false, armOut = false } = opts;
  const cloakHi = '#57402f';
  const h = kneel ? 0.72 : 1;
  const body = kneel ? `
    <path d="M-120 0 C-130 -80 -110 -200 -70 -240 C-30 -270 40 -268 80 -236 C120 -190 140 -80 150 0 Z" fill="${cloak}" ${stroke(3.5)}/>
    <path d="M-60 -230 C-80 -160 -90 -80 -84 -10" stroke="${cloakHi}" stroke-width="8" fill="none" stroke-linecap="round"/>
    <path d="M0 -250 C10 -170 12 -80 10 -6" stroke="#2a1d17" stroke-width="5" fill="none"/>`
    : `
    <path d="M-110 0 C-100 -120 -96 -230 -78 -300 C-60 -340 60 -340 78 -300 C96 -230 100 -120 118 0 Z" fill="${cloak}" ${stroke(3.5)}/>
    <path d="M-50 -296 C-70 -200 -78 -100 -80 -12" stroke="${cloakHi}" stroke-width="9" fill="none" stroke-linecap="round"/>
    <path d="M10 -310 C14 -200 16 -100 20 -6" stroke="#2a1d17" stroke-width="5" fill="none"/>
    <path d="M60 -300 C70 -200 80 -100 92 -10" stroke="#2a1d17" stroke-width="4" fill="none" opacity="0.6"/>`;
  const top = kneel ? -240 : -300;
  const arm = armOut ? `
    <path d="M70 ${top + 30} C120 ${top + 40} 170 ${top + 60} 200 ${top + 70} L196 ${top + 96} C150 ${top + 90} 110 ${top + 80} 70 ${top + 80} Z" fill="${cloak}" ${stroke(3)}/>
    <ellipse cx="208" cy="${top + 82}" rx="18" ry="15" fill="#b77a52" ${stroke(2.5)}/>` : '';
  let curls = '';
  const r = rng(7);
  const hy = top - 60;
  for (let i = 0; i < 18; i++) {
    const a = (i / 18) * Math.PI * 2;
    const cx = Math.cos(a) * 42 + turn * 8;
    const cy = hy + Math.sin(a) * 40 - 8;
    curls += `<circle cx="${cx.toFixed(1)}" cy="${cy.toFixed(1)}" r="${(17 + r() * 6).toFixed(1)}" fill="${hair}" ${stroke(2.5)}/>`;
  }
  return at(x, y, sc, `
    ${body}
    ${arm}
    <path d="M-86 ${top + 10} C-70 ${top - 30} 70 ${top - 30} 86 ${top + 10} C60 ${top + 40} -60 ${top + 40} -86 ${top + 10} Z" fill="#4a3528" ${stroke(3)}/>
    <path d="M-60 ${top + 6} C-30 ${top + 22} 30 ${top + 22} 60 ${top + 6}" stroke="#2a1d17" stroke-width="4" fill="none"/>
    ${turn ? `<path d="M${30 + turn * 20} ${hy + 10} Q${50 + turn * 26} ${hy + 30} ${36 + turn * 20} ${hy + 46}" fill="#b77a52" ${stroke(2.5)}/>` : ''}
    ${curls}
    <circle cx="${turn * 8}" cy="${hy - 6}" r="42" fill="${hair}"/>
    ${[[-30, -30], [-4, -38], [22, -26], [-22, 2], [8, -8], [30, 8], [-36, 20], [0, 24]].map(([cx, cy]) =>
      `<path d="M${cx + turn * 8 - 6} ${hy + cy} a7 7 0 1 1 8 7" stroke="#4b3022" stroke-width="3" fill="none"/>`).join('')}`, flip);
}

// Cute sheet ghost / soul.
function ghost(x, y, sc = 1, opts = {}) {
  const { col = '#cfe6ff', op = 0.85, flip = false, mood = 'sad' } = opts;
  const mouth = mood === 'sad' ? `<path d="M-8 6 Q0 0 8 6" fill="none" stroke="#26324a" stroke-width="3" stroke-linecap="round"/>`
    : mood === 'o' ? `<ellipse cx="0" cy="6" rx="5" ry="7" fill="#26324a"/>` : '';
  return glow(x, y - 40 * sc, 110 * sc, '#8fc4ff', 0.35) + at(x, y, sc, `
    <g opacity="${op}">
      <path d="M-40 0 C-44 -40 -50 -90 -30 -110 C-10 -130 20 -128 36 -108 C52 -86 46 -40 44 0
               Q36 -12 28 2 Q20 14 12 0 Q4 -12 -4 2 Q-12 14 -20 0 Q-30 -12 -40 0 Z" fill="${col}" ${stroke(3, '#3e5a85')}/>
      <path d="M-26 -96 C-34 -80 -34 -50 -30 -30" stroke="#ffffff" stroke-width="6" fill="none" stroke-linecap="round" opacity="0.8"/>
    </g>
    <ellipse cx="-12" cy="-68" rx="6" ry="9" fill="#26324a"/>
    <ellipse cx="12" cy="-68" rx="6" ry="9" fill="#26324a"/>
    <g transform="translate(0 -52)">${mouth}</g>`, flip);
}

// Fog bank made of soft puffs.
function fog(y, seed = 3, col = '#e8ecf3', op = 0.75, n = 18, h = 140) {
  const r = rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) {
    const cx = r() * 1100 - 50;
    const cy = y + r() * h - h / 2;
    const rr = 60 + r() * 90;
    s += `<circle cx="${cx.toFixed(0)}" cy="${cy.toFixed(0)}" r="${rr.toFixed(0)}" fill="${col}" opacity="${(op * (0.5 + r() * 0.5)).toFixed(2)}"/>`;
  }
  const id = uid('bl');
  return `<defs><filter id="${id}" x="-20%" y="-20%" width="140%" height="140%"><feGaussianBlur stdDeviation="14"/></filter></defs><g filter="url(#${id})">${s}</g>`;
}

function stars(seed, n = 140, yMax = 1000, col = '#fff6dc') {
  const r = rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) s += `<circle cx="${(r() * 1000).toFixed(0)}" cy="${(r() * yMax).toFixed(0)}" r="${(0.8 + r() * 2).toFixed(1)}" fill="${col}" opacity="${(0.3 + r() * 0.7).toFixed(2)}"/>`;
  return s;
}

function lightBeam(x1top, x2top, x1bot, x2bot, yTop, yBot, col = '#ffe7a6', op = 0.4) {
  const gr = linGrad([[0, col, op], [1, col, 0.02]]);
  const id = uid('bl');
  return `${gr.def}<defs><filter id="${id}"><feGaussianBlur stdDeviation="6"/></filter></defs>
    <polygon points="${x1top},${yTop} ${x2top},${yTop} ${x2bot},${yBot} ${x1bot},${yBot}" fill="${gr.url}" filter="url(#${id})"/>`;
}

function svg(content, bg = '#000') {
  gid = 0;
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000" width="1254" height="1254">
    <rect width="1000" height="1000" fill="${bg}"/>${content}</svg>`;
}

module.exports = {
  OL, uid, rng, stroke, g, at, linGrad, radGrad, glow, ellipseGlow, vignette,
  WALL, room, wallBlocks, floorTiles, flame, flamePath, torch, brazier, pillar, archDoor, stairsDown,
  glyph, glyphField, scales, feather, heart, balanceStone, scarab, chainLinks, jackalStatue,
  anubis, hero, ghost, fog, stars, lightBeam, svg,
};
