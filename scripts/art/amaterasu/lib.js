// Drawing helpers for The Cave of Amaterasu page art.
// Every helper returns an SVG fragment string on a 1000 x 1000 canvas.
'use strict';

const OUT = '#1b1730'; // outline ink
let defs = [];
let idCounter = 0;
const uid = (p = 'g') => `${p}${++idCounter}`;

// ---------- seeded random ----------
let seedState = 1;
function seed(n) { seedState = n >>> 0 || 1; }
function rand() {
  seedState |= 0; seedState = (seedState + 0x6d2b79f5) | 0;
  let t = Math.imul(seedState ^ (seedState >>> 15), 1 | seedState);
  t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
  return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
}
const rr = (a, b) => a + rand() * (b - a);
const pick = (arr) => arr[Math.floor(rand() * arr.length)];

// ---------- core ----------
function lg(stops, x1 = 0, y1 = 0, x2 = 0, y2 = 1) {
  const id = uid('lg');
  defs.push(`<linearGradient id="${id}" x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}">${stops
    .map((s, i) => { const [c, o = 1, off = i / (stops.length - 1)] = Array.isArray(s) ? s : [s]; return `<stop offset="${off}" stop-color="${c}" stop-opacity="${o}"/>`; })
    .join('')}</linearGradient>`);
  return `url(#${id})`;
}
function rg(stops, cx = 0.5, cy = 0.5, r = 0.5) {
  const id = uid('rg');
  defs.push(`<radialGradient id="${id}" cx="${cx}" cy="${cy}" r="${r}">${stops
    .map((s, i) => { const [c, o = 1, off = i / (stops.length - 1)] = Array.isArray(s) ? s : [s]; return `<stop offset="${off}" stop-color="${c}" stop-opacity="${o}"/>`; })
    .join('')}</radialGradient>`);
  return `url(#${id})`;
}

function svg(body) {
  const d = defs.join('');
  defs = [];
  return `<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="1024" viewBox="0 0 1000 1000">
<defs>
<filter id="b4" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="4"/></filter>
<filter id="b10" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="10"/></filter>
<filter id="b24" x="-80%" y="-80%" width="260%" height="260%"><feGaussianBlur stdDeviation="24"/></filter>
<filter id="paper"><feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="3" seed="7"/><feColorMatrix values="0 0 0 0 0.5  0 0 0 0 0.45  0 0 0 0 0.4  0 0 0 1.4 -0.35"/></filter>
${d}
</defs>
<g stroke-linejoin="round" stroke-linecap="round">${body}</g>
<rect width="1000" height="1000" filter="url(#paper)" opacity="0.16" style="mix-blend-mode:overlay"/>
</svg>`;
}

const g = (x, y, s, body, { flip = false, rot = 0, op = 1 } = {}) =>
  `<g transform="translate(${x} ${y}) rotate(${rot}) scale(${flip ? -s : s} ${s})"${op < 1 ? ` opacity="${op}"` : ''}>${body}</g>`;
const fade = (op, body) => `<g opacity="${op}">${body}</g>`;
const shape = (d, top, bottom = top, sw = 3, stroke = OUT) =>
  `<path d="${d}" fill="${top === bottom ? top : lg([top, bottom])}" stroke="${sw ? stroke : 'none'}" stroke-width="${sw}"/>`;

// ---------- sky & light ----------
function sky(top, bottom, y0 = 0, y1 = 1000) {
  return `<rect x="0" y="${y0}" width="1000" height="${y1 - y0}" fill="${lg([top, bottom])}"/>`;
}
function stars(sd, n, ymax, col = '#e8e4ff', big = 0.12) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) {
    const x = rr(0, 1000), y = rr(0, ymax), r = rr(0.8, 2.4);
    s += `<circle cx="${x.toFixed(1)}" cy="${y.toFixed(1)}" r="${r.toFixed(1)}" fill="${col}" opacity="${rr(0.4, 1).toFixed(2)}"/>`;
    if (rand() < big) s += `<path d="M${x} ${y - 8}L${x + 1.5} ${y - 1.5}L${x + 8} ${y}L${x + 1.5} ${y + 1.5}L${x} ${y + 8}L${x - 1.5} ${y + 1.5}L${x - 8} ${y}L${x - 1.5} ${y - 1.5}Z" fill="${col}" opacity="0.9"/>`;
  }
  return s;
}
const glow = (x, y, r, col, op = 0.8) =>
  `<circle cx="${x}" cy="${y}" r="${r}" fill="${rg([[col, op], [col, op * 0.35, 0.45], [col, 0, 1]])}"/>`;
function rays(x, y, n, len, col, op = 0.35, width = 0.12, start = 0) {
  let s = '';
  for (let i = 0; i < n; i++) {
    const a = start + (i / n) * Math.PI * 2, a1 = a - width / 2, a2 = a + width / 2;
    s += `<path d="M${x} ${y}L${x + Math.cos(a1) * len} ${y + Math.sin(a1) * len}L${x + Math.cos(a2) * len} ${y + Math.sin(a2) * len}Z" fill="${col}"/>`;
  }
  return `<g opacity="${op}" filter="url(#b4)">${s}</g>`;
}
function vignette(op = 0.6, col = '#05040a') {
  return `<rect width="1000" height="1000" fill="${rg([[col, 0], [col, 0, 0.55], [col, op, 1]], 0.5, 0.5, 0.75)}"/>`;
}
function wash(col, op) { return `<rect width="1000" height="1000" fill="${col}" opacity="${op}"/>`; }

// ---------- land ----------
function ridge(y, sd, amp, step = 110) {
  seed(sd);
  const pts = [];
  for (let x = -100; x <= 1100; x += step) pts.push([x, y - rr(0, amp)]);
  let d = `M-100 1000L${pts[0][0]} ${pts[0][1]}`;
  for (let i = 0; i < pts.length - 1; i++) {
    const [x1, y1] = pts[i], [x2, y2] = pts[i + 1];
    d += `Q${x1 + step / 2} ${y1} ${(x1 + x2) / 2 + step / 4} ${(y1 + y2) / 2}`;
  }
  d += `L1100 1000Z`;
  return d;
}
const hills = (y, sd, top, bottom, amp = 60, step = 110, sw = 3) => shape(ridge(y, sd, amp, step), top, bottom, sw);
function mountain(x, y, w, h, top, bottom, snow = null) {
  let s = shape(`M${x - w / 2} ${y}Q${x - w * 0.2} ${y - h * 0.55} ${x - w * 0.06} ${y - h * 0.95}Q${x} ${y - h * 1.02} ${x + w * 0.06} ${y - h * 0.95}Q${x + w * 0.2} ${y - h * 0.55} ${x + w / 2} ${y}Z`, top, bottom);
  if (snow) s += shape(`M${x - w * 0.11} ${y - h * 0.8}Q${x - w * 0.04} ${y - h * 1.0} ${x} ${y - h * 1.0}Q${x + w * 0.05} ${y - h * 0.99} ${x + w * 0.11} ${y - h * 0.8}L${x + w * 0.06} ${y - h * 0.76}L${x + w * 0.02} ${y - h * 0.82}L${x - w * 0.03} ${y - h * 0.75}Z`, snow, snow, 2);
  return s;
}
const ground = (y, top, bottom) => shape(`M-10 ${y}L1010 ${y}L1010 1010L-10 1010Z`, top, bottom, 3);
function paddies(y0, y1, col, line, frost = 0) {
  let s = `<rect x="0" y="${y0}" width="1000" height="${y1 - y0}" fill="${col}"/>`;
  for (let i = 0; i < 7; i++) {
    const y = y0 + (y1 - y0) * Math.pow(i / 7, 1.5) + 6;
    s += `<path d="M0 ${y}Q500 ${y + 10} 1000 ${y - 6}" stroke="${line}" stroke-width="${2 + i}" fill="none"/>`;
  }
  for (let i = 0; i < 9; i++) {
    const x = -200 + i * 180;
    s += `<path d="M500 ${y0}L${x} ${y1}" stroke="${line}" stroke-width="3" fill="none" opacity="0.7"/>`;
  }
  if (frost) {
    seed(31);
    for (let i = 0; i < 160; i++) {
      const y = rr(y0 + 5, y1), x = rr(0, 1000);
      s += `<circle cx="${x}" cy="${y}" r="${rr(1, 2.5 + (y - y0) / 120)}" fill="#e8f2ff" opacity="${frost * rr(0.3, 0.9)}"/>`;
    }
  }
  return s;
}
function sprouts(y0, y1, col, n = 120, sd = 3) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) {
    const y = rr(y0, y1), x = rr(0, 1000), h = 6 + (y - y0) / 14;
    s += `<path d="M${x} ${y}l-3 ${-h}M${x} ${y}l0 ${-h * 1.2}M${x} ${y}l3 ${-h}" stroke="${col}" stroke-width="${1.5 + (y - y0) / 200}" fill="none"/>`;
  }
  return s;
}

// ---------- trees & plants ----------
function bamboo(x, y0, y1, w, col, dark) {
  let s = `<rect x="${x - w / 2}" y="${y0}" width="${w}" height="${y1 - y0}" fill="${lg([dark, col, dark], 0, 0, 1, 0)}" stroke="${OUT}" stroke-width="2"/>`;
  for (let y = y1 - 60; y > y0; y -= 70 + (x % 13)) s += `<path d="M${x - w / 2} ${y}L${x + w / 2} ${y}" stroke="${OUT}" stroke-width="2"/><path d="M${x - w / 2} ${y + 4}L${x + w / 2} ${y + 4}" stroke="${col}" stroke-width="2" opacity="0.6"/>`;
  return s;
}
function bambooLeaves(x, y, s, col) {
  let o = '';
  for (let i = 0; i < 5; i++) {
    const a = -150 + i * 25;
    o += `<path d="M0 0Q${30} ${-8} ${70} 0Q${30} ${8} 0 0Z" fill="${col}" stroke="${OUT}" stroke-width="1.5" transform="rotate(${a})"/>`;
  }
  return g(x, y, s, o);
}
function bambooGrove(sd, n, x0, x1, y1, col, dark, leaf, wmin = 14, wmax = 30) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) {
    const x = rr(x0, x1), w = rr(wmin, wmax);
    s += bamboo(x, -20, y1 + rr(-20, 20), w, col, dark);
    for (let k = 0; k < 2; k++) s += bambooLeaves(x + w / 2, rr(80, y1 - 200), rr(0.7, 1.2), leaf);
  }
  return s;
}
function conifer(x, y, h, w, col, dark, trunk = '#3a2a24') {
  let s = `<rect x="${x - w * 0.06}" y="${y - h * 0.2}" width="${w * 0.12}" height="${h * 0.2}" fill="${trunk}" stroke="${OUT}" stroke-width="2"/>`;
  for (let i = 0; i < 4; i++) {
    const ty = y - h * 0.15 - i * h * 0.22, tw = w * (1 - i * 0.2), th = h * 0.36;
    s += shape(`M${x - tw / 2} ${ty}Q${x} ${ty + 12} ${x + tw / 2} ${ty}L${x} ${ty - th}Z`, col, dark, 2.5);
  }
  return s;
}
function pine(x, y, s, col = '#2c4a3a', dark = '#1a2e26', trunk = '#4a342a') {
  let o = `<path d="M0 0Q-10 -60 10 -120Q30 -170 0 -220" stroke="${OUT}" stroke-width="20" fill="none"/><path d="M0 0Q-10 -60 10 -120Q30 -170 0 -220" stroke="${trunk}" stroke-width="14" fill="none"/>`;
  const pads = [[-70, -150, 90], [60, -190, 80], [-20, -240, 100], [40, -110, 70]];
  for (const [px, py, w] of pads) o += shape(`M${px - w / 2} ${py}Q${px - w / 2} ${py - 30} ${px} ${py - 32}Q${px + w / 2} ${py - 30} ${px + w / 2} ${py}Q${px} ${py + 12} ${px - w / 2} ${py}Z`, col, dark, 2.5);
  return g(x, y, s, o);
}
function cedarTrunk(x, w, y1, col = '#5a3a2e', dark = '#2e1e1a') {
  let s = `<rect x="${x - w / 2}" y="-20" width="${w}" height="${y1 + 20}" fill="${lg([dark, col, dark], 0, 0, 1, 0)}" stroke="${OUT}" stroke-width="3"/>`;
  seed(Math.round(x));
  for (let i = 0; i < 6; i++) { const bx = x + rr(-w / 3, w / 3); s += `<path d="M${bx} ${rr(0, 200)}Q${bx + rr(-6, 6)} ${y1 / 2} ${bx} ${y1}" stroke="${OUT}" stroke-width="1.5" fill="none" opacity="0.45"/>`; }
  s += shape(`M${x - w / 2 - 30} ${y1}Q${x - w / 2} ${y1 - 30} ${x - w / 2} ${y1 - 70}L${x + w / 2} ${y1 - 70}Q${x + w / 2} ${y1 - 30} ${x + w / 2 + 30} ${y1}Z`, col, dark, 3);
  return s;
}
function foliage(sd, n, y0, y1, col, dark) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) {
    const x = rr(-50, 1050), y = rr(y0, y1), r = rr(50, 110);
    s += `<ellipse cx="${x}" cy="${y}" rx="${r}" ry="${r * 0.55}" fill="${lg([col, dark])}" stroke="${OUT}" stroke-width="2.5"/>`;
  }
  return s;
}
function sakuraBranch(x, y, s, flip = false) {
  let o = `<path d="M0 0Q60 -20 120 -10Q170 0 220 -40" stroke="${OUT}" stroke-width="11" fill="none"/><path d="M0 0Q60 -20 120 -10Q170 0 220 -40" stroke="#4a2e2a" stroke-width="7" fill="none"/><path d="M110 -12Q130 -50 170 -70" stroke="#4a2e2a" stroke-width="5" fill="none"/>`;
  seed(Math.round(x + y));
  for (let i = 0; i < 9; i++) o += blossom(rr(30, 220), rr(-80, 0), rr(0.7, 1.1));
  return g(x, y, s, o, { flip });
}
function blossom(x, y, s = 1) {
  let p = '';
  for (let i = 0; i < 5; i++) p += `<ellipse cx="0" cy="-9" rx="6.5" ry="9" fill="#f6b8c8" stroke="${OUT}" stroke-width="1.2" transform="rotate(${i * 72})"/>`;
  return g(x, y, s, p + `<circle r="3.5" fill="#e0607a"/>`);
}
function petals(sd, n, x0, x1, y0, y1, col = '#f6b8c8') {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) { const x = rr(x0, x1), y = rr(y0, y1); s += `<ellipse cx="${x}" cy="${y}" rx="${rr(4, 7)}" ry="${rr(2.5, 4)}" fill="${col}" transform="rotate(${rr(0, 180)} ${x} ${y})" opacity="${rr(0.6, 1)}"/>`; }
  return s;
}
function grassTufts(sd, n, y0, y1, col) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) { const x = rr(0, 1000), y = rr(y0, y1), h = rr(10, 26); s += `<path d="M${x} ${y}l-6 ${-h}M${x} ${y}l1 ${-h * 1.2}M${x} ${y}l7 ${-h * 0.9}" stroke="${col}" stroke-width="2.5" fill="none"/>`; }
  return s;
}
function ferns(x, y, s, col = '#2e5040') {
  let o = '';
  for (let i = 0; i < 5; i++) {
    const a = -160 + i * 35;
    let leaf = `<path d="M0 0Q50 -30 110 -10" stroke="${col}" stroke-width="4" fill="none"/>`;
    for (let k = 1; k < 8; k++) leaf += `<ellipse cx="${k * 13}" cy="${-14 + Math.abs(k - 3) * 1.5}" rx="7" ry="3" fill="${col}" transform="rotate(30 ${k * 13} ${-14})"/>`;
    o += `<g transform="rotate(${a + 90})">${leaf}</g>`;
  }
  return g(x, y, s, o);
}
function sakaki(x, y, s, opts = {}) {
  let o = `<path d="M0 0L0 -380" stroke="${OUT}" stroke-width="30"/><path d="M0 0L0 -380" stroke="#5a3e2e" stroke-width="22"/>`;
  o += `<path d="M0 -200Q-80 -230 -150 -230M0 -200Q80 -230 150 -230M0 -300Q-60 -330 -120 -340M0 -300Q60 -330 120 -340" stroke="#5a3e2e" stroke-width="10" fill="none"/>`;
  for (const [cx, cy, r] of [[-150, -240, 60], [150, -240, 60], [-110, -350, 55], [110, -350, 55], [0, -420, 75], [0, -300, 50]])
    o += `<ellipse cx="${cx}" cy="${cy}" rx="${r}" ry="${r * 0.7}" fill="${lg(['#3e7a4a', '#1e4a30'])}" stroke="${OUT}" stroke-width="3"/>`;
  for (let i = 0; i < 4; i++) o += shide(-150 + i * 100, -205 - (i % 2) * 100, 0.8);
  if (opts.jewels) o += magatamaString(0, -380, 1.1, opts.jewelsOff);
  if (opts.mirror) o += mirror(0, -235, 60, opts.mirrorGlow ?? 0.8);
  return g(x, y, s, o);
}

// ---------- water ----------
function waves(n, y0, y1, col, crest, amp = 14, sd = 5) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) {
    const y = y0 + (y1 - y0) * (i / n), w = 40 + (y - y0) / 6, off = rr(0, w);
    let d = `M${-off} ${y}`;
    for (let x = -off; x < 1050; x += w) d += `q${w / 4} ${-amp * (0.4 + (y - y0) / (y1 - y0))} ${w / 2} 0t${w / 2} 0`;
    s += `<path d="${d}" stroke="${crest}" stroke-width="${1.5 + (y - y0) / 160}" fill="none" opacity="${0.35 + 0.5 * (y - y0) / (y1 - y0)}"/>`;
  }
  return s;
}
function bubbles(sd, n, x0, x1, y0, y1, col = '#bfe8ff') {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) s += `<circle cx="${rr(x0, x1)}" cy="${rr(y0, y1)}" r="${rr(2, 9)}" fill="none" stroke="${col}" stroke-width="1.8" opacity="${rr(0.3, 0.8)}"/>`;
  return s;
}
function sparks(sd, n, x0, x1, y0, y1, col, r = 4) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) { const x = rr(x0, x1), y = rr(y0, y1), rad = rr(r * 0.4, r); s += glow(x, y, rad * 4, col, 0.5) + `<circle cx="${x}" cy="${y}" r="${rad * 0.6}" fill="#fff8e0"/>`; }
  return s;
}
function rain(sd, n, col = '#d8e8ff', op = 0.5) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) { const x = rr(-100, 1000), y = rr(-50, 1000), l = rr(25, 55); s += `<path d="M${x} ${y}l${l * 0.25} ${l}" stroke="${col}" stroke-width="2" opacity="${rr(op * 0.5, op)}"/>`; }
  return s;
}
function mist(sd, n, y0, y1, col = '#c8d0e8', op = 0.25) {
  seed(sd);
  let s = '';
  for (let i = 0; i < n; i++) s += `<ellipse cx="${rr(0, 1000)}" cy="${rr(y0, y1)}" rx="${rr(150, 320)}" ry="${rr(18, 40)}" fill="${col}" opacity="${rr(op * 0.5, op)}" filter="url(#b10)"/>`;
  return s;
}
function swirlCloud(x, y, s, col = '#3a5a9a', line = '#8aa8e0') {
  const o = `<path d="M-120 30Q-130 -10 -90 -15Q-85 -55 -40 -50Q-20 -80 20 -60Q60 -75 75 -35Q120 -35 115 5Q125 30 90 30Z" fill="${col}" stroke="${OUT}" stroke-width="3"/>
  <path d="M-60 10q-5 -25 20 -25q22 2 18 22q-4 14 -18 10" fill="none" stroke="${line}" stroke-width="4"/><path d="M30 12q-4 -20 16 -20q16 3 12 18" fill="none" stroke="${line}" stroke-width="4"/>`;
  return g(x, y, s, o);
}
function smoke(x, y, s, col = '#eef0f4', op = 0.8) {
  const o = `<path d="M0 0C-30 -40 30 -70 0 -110C-30 -150 40 -180 10 -230C-20 -270 30 -300 60 -320" stroke="${col}" stroke-width="26" fill="none" filter="url(#b4)"/><path d="M0 0C-30 -40 30 -70 0 -110C-30 -150 40 -180 10 -230" stroke="#fff" stroke-width="8" fill="none" opacity="0.6"/>`;
  return g(x, y, s, o, { op });
}

// ---------- fire & light ----------
function flame(x, y, s, col = '#ffb347', core = '#fff1b0') {
  return g(x, y, s, `<path d="M0 0C-18 -6 -20 -30 -8 -48C-4 -36 4 -36 2 -58C16 -44 22 -22 14 -6C10 0 4 2 0 0Z" fill="${col}" stroke="${OUT}" stroke-width="2"/><path d="M0 -3C-8 -6 -9 -18 -2 -28C2 -20 8 -18 6 -8C5 -4 3 -3 0 -3Z" fill="${core}"/>`);
}
function torch(x, y, s, lit = 1) {
  return glow(x, y - 70 * s, 120 * s * lit, '#ff9a3c', 0.55 * lit) + g(x, y, s, `<path d="M0 0L-4 -60L4 -60Z" fill="#5a3a2a" stroke="${OUT}" stroke-width="2"/><rect x="-7" y="-66" width="14" height="10" fill="#3a2a22" stroke="${OUT}" stroke-width="2"/>`) + (lit ? flame(x, y - 64 * s, s * 0.9 * lit) : smoke(x, y - 66 * s, s * 0.25, '#8a8a96', 0.6));
}
function foxfire(x, y, r, col = '#7fd0ff', op = 1) {
  return fade(op, glow(x, y, r * 4, col, 0.55) + g(x, y, r / 12, `<path d="M0 10C-12 10 -14 -6 -6 -14C-6 -6 0 -6 0 -20C8 -12 14 -4 10 4C8 8 4 10 0 10Z" fill="${col}"/><circle cy="2" r="5" fill="#fff"/>`));
}
function paperLantern(x, y, s, col = '#e8503a', lit = 1) {
  return (lit ? glow(x, y, 90 * s, '#ffb050', 0.6 * lit) : '') + g(x, y, s, `<path d="M0 -50L0 -38" stroke="${OUT}" stroke-width="3"/><rect x="-14" y="-40" width="28" height="8" rx="2" fill="#2a1e1e"/><ellipse cx="0" cy="0" rx="26" ry="34" fill="${lit ? rg(['#ffe8a0', col]) : '#6a4a44'}" stroke="${OUT}" stroke-width="3"/>${[-18, -6, 6, 18].map((k) => `<path d="M-25 ${k}Q0 ${k + 4} 25 ${k}" stroke="${OUT}" stroke-width="1.2" fill="none" opacity="0.4"/>`).join('')}<rect x="-14" y="32" width="28" height="8" rx="2" fill="#2a1e1e"/>`);
}
function stoneLantern(x, y, s, lit = 1) {
  const st = '#7a7e8e', dk = '#4a4c5c';
  return (lit ? glow(x, y - 150 * s, 120 * s, '#ffc060', 0.55 * lit) : '') + g(x, y, s,
    shape('M-40 0L40 0L34 -20L-34 -20Z', st, dk) + shape('M-12 -20L12 -20L10 -100L-10 -100Z', st, dk) + shape('M-36 -100L36 -100L30 -118L-30 -118Z', st, dk) +
    `<rect x="-26" y="-178" width="52" height="60" fill="${dk}" stroke="${OUT}" stroke-width="3"/><rect x="-16" y="-168" width="32" height="40" fill="${lit ? '#ffd27a' : '#2a2a34'}" stroke="${OUT}" stroke-width="2"/>` +
    shape('M-56 -176L56 -176L20 -212L-20 -212Z', st, dk) + `<circle cx="0" cy="-220" r="10" fill="${st}" stroke="${OUT}" stroke-width="3"/>`);
}

// ---------- buildings ----------
function torii(x, y, s, col = '#d9442e', dark = '#8e2a1e') {
  return g(x, y, s,
    shape('M-150 0L-130 0L-125 -300L-145 -300Z', col, dark) + shape('M130 0L150 0L145 -300L125 -300Z', col, dark) +
    `<rect x="-160" y="-30" width="40" height="30" fill="#1e1a22" stroke="${OUT}" stroke-width="3"/><rect x="120" y="-30" width="40" height="30" fill="#1e1a22" stroke="${OUT}" stroke-width="3"/>` +
    shape('M-170 -255L170 -255L170 -235L-170 -235Z', col, dark) + `<rect x="-14" y="-300" width="28" height="48" fill="${col}" stroke="${OUT}" stroke-width="3"/>` +
    shape('M-215 -300Q0 -290 215 -300L230 -330Q0 -315 -230 -330Z', '#2a2026', '#1a1418') + shape('M-190 -300L190 -300L190 -282L-190 -282Z', col, dark));
}
function shimenawa(x1, y1, x2, y2, sag = 40, w = 18) {
  const mx = (x1 + x2) / 2, my = (y1 + y2) / 2 + sag;
  let s = `<path d="M${x1} ${y1}Q${mx} ${my + sag} ${x2} ${y2}" stroke="${OUT}" stroke-width="${w + 6}" fill="none"/><path d="M${x1} ${y1}Q${mx} ${my + sag} ${x2} ${y2}" stroke="#d8b878" stroke-width="${w}" fill="none"/><path d="M${x1} ${y1}Q${mx} ${my + sag} ${x2} ${y2}" stroke="#a8884a" stroke-width="${w * 0.35}" stroke-dasharray="${w * 0.6} ${w * 0.6}" fill="none"/>`;
  for (let i = 1; i < 4; i++) {
    const t = i / 4, px = (1 - t) * (1 - t) * x1 + 2 * (1 - t) * t * mx + t * t * x2, py = (1 - t) * (1 - t) * y1 + 2 * (1 - t) * t * (my + sag) + t * t * y2;
    s += shide(px, py + w / 2, w / 20);
  }
  return s;
}
const shide = (x, y, s) => g(x, y, s, `<path d="M0 0L14 0L6 18L20 18L10 38L24 38L12 62L4 62L12 42L-2 42L6 22L-6 22Z" fill="#f4f0e6" stroke="${OUT}" stroke-width="2"/>`);
function shrine(x, y, s, lit = 1, wood = '#7a4a32') {
  return (lit ? glow(x, y - 60 * s, 160 * s, '#ffb050', 0.5 * lit) : '') + g(x, y, s,
    shape('M-110 0L110 0L110 -14L-110 -14Z', '#6a6a76', '#44444e') +
    `<rect x="-80" y="-120" width="160" height="106" fill="${wood}" stroke="${OUT}" stroke-width="3"/>` +
    `<rect x="-50" y="-100" width="100" height="86" fill="${lit ? '#ffcf78' : '#1a1418'}" stroke="${OUT}" stroke-width="3"/><path d="M0 -100L0 -14M-50 -60L50 -60" stroke="${OUT}" stroke-width="2"/>` +
    shape('M-130 -112Q0 -125 130 -112L90 -180L-90 -180Z', '#4a3a3a', '#2a2026') + shape('M-100 -180L100 -180L100 -192L-100 -192Z', '#5a4040', '#3a2a2a') +
    `<path d="M-60 -192L-75 -215M60 -192L75 -215M-80 -215L-50 -192M80 -215L50 -192" stroke="${OUT}" stroke-width="5"/>` +
    shimenawa(-60, -112, 60, -112, 4, 8));
}
function house(x, y, s, lit = 0.6, sd = 1) {
  seed(sd);
  return (lit ? glow(x, y - 40 * s, 90 * s, '#ff9a40', 0.35 * lit) : '') + g(x, y, s,
    `<rect x="-70" y="-70" width="140" height="70" fill="#5a4234" stroke="${OUT}" stroke-width="3"/>` +
    `<rect x="-50" y="-55" width="30" height="40" fill="#2a1e1a" stroke="${OUT}" stroke-width="2"/><rect x="15" y="-55" width="35" height="40" fill="#2a1e1a" stroke="${OUT}" stroke-width="2"/>` +
    (lit ? `<path d="M-35 -55L-35 -15M32 -55L32 -15" stroke="#ffb050" stroke-width="2" opacity="${lit}"/>` : '') +
    shape('M-95 -62L0 -150L95 -62Z', '#a88a5a', '#6e5636') + shape('M-30 -128L30 -128L20 -150L-20 -150Z', '#5a4630', '#4a3624', 2) +
    `<path d="M-60 -80L-20 -118M60 -80L20 -118M-80 -66L80 -66" stroke="#5a4426" stroke-width="2" opacity="0.7"/>`);
}
function boulder(x, y, r, opts = {}) {
  const { glowAmt = 0.6, col = '#5a5a6a', dark = '#2a2a36', open = 0 } = opts;
  const d = `M${x - r} ${y}Q${x - r * 1.05} ${y - r * 0.9} ${x - r * 0.4} ${y - r * 1.1}Q${x + r * 0.2} ${y - r * 1.3} ${x + r * 0.8} ${y - r * 0.9}Q${x + r * 1.1} ${y - r * 0.5} ${x + r} ${y}Z`;
  let s = '';
  if (glowAmt > 0) s += `<path d="${d}" fill="none" stroke="#ffd060" stroke-width="${10 + 30 * glowAmt}" opacity="${glowAmt}" filter="url(#b10)"/><path d="${d}" fill="none" stroke="#fff2b0" stroke-width="${3 + 5 * glowAmt}" opacity="${glowAmt}"/>`;
  s += `<path d="${d}" fill="${lg([col, dark], 0, 0, 1, 1)}" stroke="${OUT}" stroke-width="4"/>`;
  s += `<path d="M${x - r * 0.5} ${y - r * 0.7}Q${x - r * 0.2} ${y - r * 0.85} ${x + r * 0.2} ${y - r * 0.75}M${x + r * 0.3} ${y - r * 0.3}Q${x + r * 0.5} ${y - r * 0.2} ${x + r * 0.6} ${y - r * 0.4}M${x - r * 0.6} ${y - r * 0.25}l${r * 0.2} ${r * 0.05}" stroke="${OUT}" stroke-width="3" fill="none" opacity="0.5"/>`;
  return s;
}
// The Heavenly Rock Cave: black cliff, cave mouth, boulder, rope.
function rockCave(cx, by, s, opts = {}) {
  const { glowAmt = 0.6, rope = true, rolled = 0 } = opts;
  let o = shape('M-560 0L-520 -300Q-470 -480 -300 -560Q-100 -650 120 -600Q330 -560 460 -420Q560 -300 560 0Z', '#3a3a4c', '#1c1c28', 4);
  o += `<path d="M-400 -350Q-300 -380 -260 -460M300 -470Q360 -420 380 -330M-120 -560Q-60 -520 0 -540" stroke="${OUT}" stroke-width="3" fill="none" opacity="0.5"/>`;
  o += `<path d="M-230 0Q-240 -250 -120 -330Q0 -380 120 -330Q240 -250 230 0Z" fill="${glowAmt > 0.9 ? rg(['#fff6c8', '#ffcc50', '#c87a20']) : '#0a0810'}" stroke="${OUT}" stroke-width="4"/>`;
  if (glowAmt > 0.9) o += rays(0, -150, 18, 700, '#ffe28a', 0.35);
  o += boulder(-460 * rolled, 0, 250, { glowAmt: rolled ? 0 : glowAmt });
  if (rope) o += shimenawa(-260, -370, 260, -370, 30, 22);
  return g(cx, by, s, o);
}
function loom(x, y, s, threads = '#c8d4f0') {
  let o = `<path d="M-120 0L-120 -220M120 0L120 -220M-140 -220L140 -220M-130 -40L130 -40M-120 -130L120 -130" stroke="${OUT}" stroke-width="16"/><path d="M-120 0L-120 -220M120 0L120 -220M-140 -220L140 -220M-130 -40L130 -40M-120 -130L120 -130" stroke="#7a5a3e" stroke-width="10"/>`;
  for (let i = 0; i < 16; i++) o += `<path d="M${-105 + i * 14} -215L${-105 + i * 14} -45" stroke="${threads}" stroke-width="1.6" opacity="0.8"/>`;
  return g(x, y, s, o);
}
function vat(x, y, s, fill = '#e8dcc0') {
  return g(x, y, s, shape('M-60 0L-66 -90L66 -90L60 0Z', '#8a6040', '#5a3a28') + `<path d="M-63 -30L63 -30M-65 -65L65 -65" stroke="#2a2a30" stroke-width="5"/><ellipse cx="0" cy="-90" rx="66" ry="16" fill="${fill}" stroke="${OUT}" stroke-width="3"/>`);
}
function boat(x, y, s, extras = true) {
  let o = shape('M-160 -40Q-150 10 -100 20L110 20Q160 10 175 -45L150 -30L-140 -30Z', '#8a5a3a', '#4e2e1e', 3);
  o += `<path d="M-140 -30L150 -30" stroke="${OUT}" stroke-width="3"/><path d="M-120 -5L140 -5" stroke="#3a2418" stroke-width="2"/>`;
  if (extras) o += `<path d="M-90 -36L30 -70" stroke="${OUT}" stroke-width="9"/><path d="M-90 -36L30 -70" stroke="#b08a5a" stroke-width="5"/>` + bucket(70, -32, 0.5) + ladle(-30, -36, 0.6);
  return g(x, y, s, o);
}
const bucket = (x, y, s) => g(x, y, s, shape('M-30 0L-36 -60L36 -60L30 0Z', '#b08a5a', '#7a5a3a') + `<path d="M-34 -40L34 -40M-32 -15L32 -15" stroke="#3a2a22" stroke-width="4"/><path d="M-34 -60Q0 -100 34 -60" stroke="${OUT}" stroke-width="3" fill="none"/>`);
const ladle = (x, y, s, broken = true) => g(x, y, s, `<path d="M0 0L90 -60" stroke="${OUT}" stroke-width="9"/><path d="M0 0L90 -60" stroke="#c8a070" stroke-width="5"/><ellipse cx="-8" cy="6" rx="22" ry="12" fill="${broken ? '#2a1e1a' : '#c8a070'}" stroke="#c8a070" stroke-width="6"/><ellipse cx="-8" cy="6" rx="22" ry="12" fill="none" stroke="${OUT}" stroke-width="2"/>`);
function lowTable(x, y, s, dishes = true) {
  let o = shape('M-140 -50L140 -50L150 -36L-150 -36Z', '#c83a2a', '#8a2218') + `<path d="M-130 -36L-130 0M130 -36L130 0" stroke="${OUT}" stroke-width="12"/><path d="M-130 -36L-130 0M130 -36L130 0" stroke="#8a2218" stroke-width="7"/>`;
  if (dishes) o += [-90, -20, 50, 110].map((dx, i) => `<ellipse cx="${dx}" cy="-56" rx="26" ry="9" fill="${['#f0e6d0', '#2a2a30', '#f0e6d0', '#c83a2a'][i]}" stroke="${OUT}" stroke-width="2"/><ellipse cx="${dx}" cy="-62" rx="14" ry="6" fill="${['#f08a6a', '#e8c070', '#7ab070', '#f0e0b0'][i]}"/>`).join('');
  return g(x, y, s, o);
}
function fence(x0, x1, y, h, col = '#7a5a3e') {
  let s = `<path d="M${x0} ${y - h * 0.75}L${x1} ${y - h * 0.75}M${x0} ${y - h * 0.3}L${x1} ${y - h * 0.3}" stroke="${OUT}" stroke-width="10"/><path d="M${x0} ${y - h * 0.75}L${x1} ${y - h * 0.75}M${x0} ${y - h * 0.3}L${x1} ${y - h * 0.3}" stroke="${col}" stroke-width="6"/>`;
  for (let x = x0; x <= x1; x += 26) s += `<rect x="${x - 6}" y="${y - h}" width="12" height="${h}" fill="${col}" stroke="${OUT}" stroke-width="2"/>`;
  return s;
}
function hall(beams = '#2a1e1a', wall = '#3a2a24', floor = '#4a3428') {
  return `<rect width="1000" height="1000" fill="${lg([wall, '#1a1210'])}"/>` +
    shape('M0 700L1000 700L1000 1000L0 1000Z', floor, '#2a1e18') +
    [0, 1, 2, 3, 4, 5, 6].map((i) => `<path d="M${500 + (i - 3) * 60} 700L${500 + (i - 3) * 260} 1000" stroke="#2a1e18" stroke-width="3"/>`).join('') +
    [60, 300, 700, 940].map((x) => `<rect x="${x - 26}" y="0" width="52" height="${x === 300 || x === 700 ? 700 : 1000}" fill="${beams}" stroke="${OUT}" stroke-width="3"/>`).join('') +
    `<rect x="0" y="40" width="1000" height="40" fill="${beams}" stroke="${OUT}" stroke-width="3"/>`;
}

// ---------- sacred treasures ----------
function mirror(x, y, r, glowAmt = 0.8, cracked = false) {
  let rim = '';
  for (let i = 0; i < 8; i++) { const a = (i / 8) * Math.PI * 2; rim += `<circle cx="${x + Math.cos(a) * r}" cy="${y + Math.sin(a) * r}" r="${r * 0.32}" fill="${lg(['#d8a84a', '#8a6020'])}" stroke="${OUT}" stroke-width="3"/>`; }
  let s = (glowAmt ? glow(x, y, r * 2.4, '#dfe8ff', 0.6 * glowAmt) : '') + rim + `<circle cx="${x}" cy="${y}" r="${r * 1.02}" fill="#b08030" stroke="${OUT}" stroke-width="3"/><circle cx="${x}" cy="${y}" r="${r * 0.86}" fill="${rg(['#ffffff', '#cfdcf0', '#8a9ab8'], 0.4, 0.35, 0.7)}" stroke="${OUT}" stroke-width="2.5"/><path d="M${x - r * 0.5} ${y - r * 0.2}Q${x - r * 0.3} ${y - r * 0.55} ${x + r * 0.05} ${y - r * 0.6}" stroke="#fff" stroke-width="${r * 0.08}" fill="none" opacity="0.8"/>`;
  if (cracked) s += `<path d="M${x - r * 0.7} ${y - r * 0.3}L${x - r * 0.1} ${y}L${x - r * 0.3} ${y + r * 0.3}L${x + r * 0.4} ${y + r * 0.6}M${x - r * 0.1} ${y}L${x + r * 0.6} ${y - r * 0.4}" stroke="${OUT}" stroke-width="3" fill="none"/>`;
  return s;
}
const magatama = (x, y, s, col, rot = 0) => g(x, y, s, `<path d="M0 -20C16 -20 22 -4 18 10C14 22 0 30 -14 26C-4 20 -6 10 -12 4C-22 -6 -14 -20 0 -20Z" fill="${col}" stroke="${OUT}" stroke-width="2.5"/><circle cx="4" cy="-6" r="4" fill="${OUT}"/><path d="M-4 -14Q4 -16 10 -10" stroke="#fff" stroke-width="2" fill="none" opacity="0.6"/>`, { rot });
function magatamaString(x, y, s, dark = false) {
  let o = `<path d="M-90 0Q0 120 90 0" stroke="#d8c8a0" stroke-width="3" fill="none"/>`;
  for (let i = 0; i < 9; i++) {
    const t = i / 8, px = -90 + 180 * t, py = 2 * (1 - t) * t * 120;
    o += (dark ? '' : glow(px, py + 10, 28, i % 2 ? '#ff6a4a' : '#5aff9a', 0.45)) + magatama(px, py + 12, 0.7, dark ? (i % 2 ? '#5a3a3a' : '#3a5a4a') : i % 2 ? '#e8402a' : '#2aa868', 180 + (px / 90) * 30);
  }
  return g(x, y, s, o);
}
function sword(x, y, s, rot = 0, glowAmt = 1) {
  let o = '';
  if (glowAmt) o += `<path d="M0 0L0 -420" stroke="#8ad0ff" stroke-width="40" opacity="${0.45 * glowAmt}" filter="url(#b10)"/>`;
  o += `<path d="M-14 0L-14 -380L0 -420L14 -380L14 0Z" fill="${lg(['#f4faff', '#9ab0c8', '#e8f2ff'], 0, 0, 1, 0)}" stroke="${OUT}" stroke-width="3"/><path d="M0 -405L0 0" stroke="#7a90a8" stroke-width="2"/>`;
  o += `<rect x="-46" y="0" width="92" height="14" rx="5" fill="#c89a3a" stroke="${OUT}" stroke-width="3"/><rect x="-10" y="14" width="20" height="90" fill="#3a2a40" stroke="${OUT}" stroke-width="3"/><path d="M-10 30L10 44M-10 54L10 68M-10 78L10 92" stroke="#c89a3a" stroke-width="3"/><circle cx="0" cy="110" r="10" fill="#c89a3a" stroke="${OUT}" stroke-width="3"/>`;
  if (glowAmt) o += `<path d="M-20 -100l-30 -20l14 -6l-26 -30M22 -220l26 -14l-12 -8l30 -26M-18 -300l-24 -10l10 -10l-20 -22" stroke="#cfeaff" stroke-width="3" fill="none" opacity="${glowAmt}"/>`;
  return g(x, y, s, o, { rot });
}
function lacquerBox(x, y, s, open = false) {
  let o = shape('M-50 0L50 0L50 -60L-50 -60Z', '#2a2026', '#100c10') + `<path d="M-30 -45l14 10l12 -8M10 -30l16 -8" stroke="#c89a3a" stroke-width="2" fill="none"/>`;
  if (!open) o += shape('M-56 -60L56 -60L52 -80L-52 -80Z', '#3a2a30', '#1a1418') + `<path d="M0 -80L0 0M-50 -30L50 -30" stroke="#d8402a" stroke-width="6"/><path d="M0 -84q-16 -18 -22 0q6 10 22 0q16 -18 22 0q-6 10 -22 0M0 -84l-12 26M0 -84l12 26" stroke="#d8402a" stroke-width="4" fill="none"/>`;
  else o += `<ellipse cx="0" cy="-60" rx="50" ry="10" fill="#0a0808" stroke="${OUT}" stroke-width="2"/>` + `<g transform="translate(-100 -30) rotate(-20)">${shape('M-56 0L56 0L52 -20L-52 -20Z', '#3a2a30', '#1a1418')}</g><path d="M50 0q40 10 70 -10q20 -10 40 4" stroke="#d8402a" stroke-width="5" fill="none"/>`;
  return g(x, y, s, o);
}
function bell(x, y, s) {
  let o = `<path d="M0 0q-6 -30 0 -60" stroke="#c8302a" stroke-width="5" fill="none"/><path d="M0 -60q-14 -6 -12 -18q10 -2 12 10q2 -12 12 -10q2 12 -12 18" stroke="#c8302a" stroke-width="4" fill="none"/>`;
  for (const [bx, by] of [[0, 8], [-14, 18], [14, 18], [-8, 30], [8, 30], [0, 42]]) o += `<circle cx="${bx}" cy="${by}" r="8" fill="${rg(['#fff0a8', '#e0b040', '#9a6a18'], 0.35, 0.35, 0.7)}" stroke="${OUT}" stroke-width="2"/><path d="M${bx - 5} ${by + 2}l10 0" stroke="${OUT}" stroke-width="1.5"/>`;
  return g(x, y, s, o);
}
const rope = (x1, y1, x2, y2, sag = 30) => shimenawa(x1, y1, x2, y2, sag, 14);

module.exports = {
  OUT, uid, seed, rand, rr, pick, lg, rg, svg, g, fade, shape, sky, stars, glow, rays, vignette, wash,
  ridge, hills, mountain, ground, paddies, sprouts, bamboo, bambooLeaves, bambooGrove, conifer, pine, cedarTrunk, foliage,
  sakuraBranch, blossom, petals, grassTufts, ferns, sakaki, waves, bubbles, sparks, rain, mist, swirlCloud, smoke,
  flame, torch, foxfire, paperLantern, stoneLantern, torii, shimenawa, shide, shrine, house, boulder, rockCave, loom, vat,
  boat, bucket, ladle, lowTable, fence, hall, mirror, magatama, magatamaString, sword, lacquerBox, bell, rope,
};
