// Shared drawing helpers for The Descent to Hades scene art.
// Every scene is drawn in a 1000x1000 SVG coordinate space and rendered to
// 1254x1254 PNG (the same size as the other stories' art). Figures stand
// with their feet at y = 0; an adult is about 340 units tall at scale 1.

const OL = '#1c1424';
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
const rot = (x, y, deg, content) => g(content, `rotate(${deg} ${x} ${y})`);
const fade = (op, content) => `<g opacity="${op}">${content}</g>`;

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

function blur(sd, content) {
  const id = uid('bl');
  return `<defs><filter id="${id}" x="-30%" y="-30%" width="160%" height="160%"><feGaussianBlur stdDeviation="${sd}"/></filter></defs><g filter="url(#${id})">${content}</g>`;
}

function clip(shape, content) {
  const id = uid('cl');
  return `<defs><clipPath id="${id}">${shape}</clipPath></defs><g clip-path="url(#${id})">${content}</g>`;
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

function vignette(op = 0.55, col = '#000') {
  const gr = radGrad([[0.55, col, 0], [1, col, op]], 0.5, 0.5, 0.75);
  return `${gr.def}<rect width="1000" height="1000" fill="${gr.url}"/>`;
}

// Washes the whole frame toward a colour (used for faded / forgotten scenes).
const wash = (col, op) => `<rect width="1000" height="1000" fill="${col}" opacity="${op}"/>`;

function sky(top, bottom, y0 = 0, y1 = 1000) {
  const gr = linGrad([[0, top], [1, bottom]]);
  return `${gr.def}<rect x="0" y="${y0}" width="1000" height="${y1 - y0}" fill="${gr.url}"/>`;
}

function shape(d, top, bottom, w = 3, horiz = false) {
  const gr = horiz ? linGrad([[0, top], [1, bottom]], 0, 0, 1, 0) : linGrad([[0, top], [1, bottom]]);
  return `${gr.def}<path d="${d}" fill="${gr.url}" ${w ? stroke(w) : ''}/>`;
}

// ---------------------------------------------------------------- atmosphere

function fog(y, seed = 3, col = '#e8ecf3', op = 0.75, n = 18, h = 140, x0 = -50, x1 = 1050) {
  const r = rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) {
    const cx = x0 + r() * (x1 - x0);
    const cy = y + r() * h - h / 2;
    const rr = 60 + r() * 90;
    s += `<circle cx="${cx.toFixed(0)}" cy="${cy.toFixed(0)}" r="${rr.toFixed(0)}" fill="${col}" opacity="${(op * (0.5 + r() * 0.5)).toFixed(2)}"/>`;
  }
  return blur(14, s);
}

function stars(seed, n = 140, yMax = 1000, col = '#fff6dc') {
  const r = rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) s += `<circle cx="${(r() * 1000).toFixed(0)}" cy="${(r() * yMax).toFixed(0)}" r="${(0.8 + r() * 2).toFixed(1)}" fill="${col}" opacity="${(0.3 + r() * 0.7).toFixed(2)}"/>`;
  return s;
}

function sparks(seed, n, x0, y0, x1, y1, col = '#ffd27a', rMax = 4) {
  const r = rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) {
    const x = x0 + r() * (x1 - x0), y = y0 + r() * (y1 - y0);
    s += `<circle cx="${x.toFixed(0)}" cy="${y.toFixed(0)}" r="${(1 + r() * rMax).toFixed(1)}" fill="${col}" opacity="${(0.4 + r() * 0.6).toFixed(2)}"/>`;
  }
  return s;
}

function lightBeam(x1top, x2top, x1bot, x2bot, yTop, yBot, col = '#ffe7a6', op = 0.4) {
  const gr = linGrad([[0, col, op], [1, col, 0.02]]);
  return gr.def + blur(6, `<polygon points="${x1top},${yTop} ${x2top},${yTop} ${x2bot},${yBot} ${x1bot},${yBot}" fill="${gr.url}"/>`);
}

function rain(seed, n = 160, col = '#cfe0e8', op = 0.45) {
  const r = rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) {
    const x = r() * 1200 - 100, y = r() * 1000, l = 30 + r() * 50;
    s += `<path d="M${x.toFixed(0)} ${y.toFixed(0)} l${(-l * 0.45).toFixed(0)} ${l.toFixed(0)}" stroke="${col}" stroke-width="${(1.5 + r() * 2).toFixed(1)}" opacity="${(op * (0.5 + r() * 0.5)).toFixed(2)}" stroke-linecap="round"/>`;
  }
  return s;
}

// ---------------------------------------------------------------- fire

function flamePath(w, h) {
  return `M0 ${-h} C${w * 0.18} ${-h * 0.72} ${w * 0.62} ${-h * 0.52} ${w * 0.5} ${-h * 0.22}
    C${w * 0.42} ${-h * 0.02} ${w * 0.2} 0 0 0 C${-w * 0.2} 0 ${-w * 0.45} ${-h * 0.04} ${-w * 0.5} ${-h * 0.24}
    C${-w * 0.56} ${-h * 0.48} ${-w * 0.22} ${-h * 0.56} ${-w * 0.1} ${-h * 0.78} C${-w * 0.04} ${-h * 0.62} ${w * 0.04} ${-h * 0.84} 0 ${-h} Z`;
}

const FIRE = {
  orange: ['#f07a12', '#ffc02e', '#fff2b0', '#7a2e05'],
  blue: ['#1f5fd6', '#4fa6ff', '#d8f1ff', '#0f2a66'],
  silver: ['#8a9ab8', '#c8d4ea', '#ffffff', '#3a4660'],
};

function flame(x, y, w, h, kind = 'orange') {
  const c = FIRE[kind];
  return at(x, y, 1, `
    <path d="${flamePath(w, h)}" fill="${c[0]}" ${stroke(2, c[3])}/>
    <path d="${flamePath(w * 0.68, h * 0.72)}" fill="${c[1]}" transform="translate(0 -2)"/>
    <path d="${flamePath(w * 0.36, h * 0.42)}" fill="${c[2]}" transform="translate(0 -3)"/>`);
}

function brazier(x, y, sc = 1, kind = 'orange') {
  const gc = { orange: '#ff9a2a', blue: '#4aa3ff', silver: '#dfe8ff' }[kind];
  return glow(x, y - 90 * sc, 220 * sc, gc, 0.5) + at(x, y, sc, `
    <path d="M-14 0 L14 0 L8 -70 L-8 -70 Z" fill="#8a5a2c" ${stroke(3)}/>
    <path d="M-40 4 L40 4 L30 -8 L-30 -8 Z" fill="#a8743a" ${stroke(3)}/>
    <path d="M-62 -110 L62 -110 C56 -76 30 -66 0 -66 C-30 -66 -56 -76 -62 -110 Z" fill="#c08a4a" ${stroke(3)}/>
    <path d="M-50 -96 L50 -96" stroke="#7a4e22" stroke-width="4"/>
    <path d="M-44 -86 L-34 -96 L-24 -86 L-14 -96 L-4 -86 L6 -96 L16 -86 L26 -96 L36 -86" fill="none" stroke="#7a4e22" stroke-width="3"/>
    ${flame(0, -108, 90, 120, kind)}`);
}

// ---------------------------------------------------------------- figures

const SKIN = { warm: '#e8b48a', olive: '#c9946a', pale: '#e6d6c8', ghost: '#cfdcea', grey: '#c3c8cc', god: '#f0c896' };

const ARM = {
  down: [[-62, -165], [-66, -104]],
  out: [[-100, -205], [-152, -196]],
  up: [[-84, -280], [-100, -344]],
  forward: [[-78, -168], [-40, -150]],
  hip: [[-86, -172], [-50, -134]],
  raise: [[-96, -250], [-92, -318]],
  offer: [[-80, -170], [-118, -150]],
  chest: [[-60, -160], [-14, -186]],
  reachDown: [[-82, -170], [-110, -110]],
};

function arm(side, pose, col, skin, w = 21) {
  const pts = Array.isArray(pose) ? pose : ARM[pose] || ARM.down;
  const [[ex, ey], [hx, hy]] = pts;
  // ARM poses are written for the left arm (negative x); mirror for the right.
  const dd = side === 'l' ? `M-42 -226 L${ex} ${ey} L${hx} ${hy}` : `M42 -226 L${-ex} ${ey} L${-hx} ${hy}`;
  const hxF = side === 'l' ? hx : -hx;
  return `<path d="${dd}" fill="none" stroke="${OL}" stroke-width="${w + 7}" stroke-linejoin="round" stroke-linecap="round"/>
    <path d="${dd}" fill="none" stroke="${col}" stroke-width="${w}" stroke-linejoin="round" stroke-linecap="round"/>
    <circle cx="${hxF}" cy="${hy}" r="13" fill="${skin}" ${stroke(3)}/>`;
}

function handPos(side, pose) {
  const pts = Array.isArray(pose) ? pose : ARM[pose] || ARM.down;
  const [, [hx, hy]] = pts;
  return side === 'l' ? [hx, hy] : [-hx, hy];
}

function eyesSvg(kind, col = '#1a1208') {
  const y = -292;
  if (kind === 'closed') return `<path d="M-22 ${y} Q-13 ${y + 6} -4 ${y} M4 ${y} Q13 ${y + 6} 22 ${y}" fill="none" stroke="${col}" stroke-width="3.5" stroke-linecap="round"/>`;
  if (kind === 'milky') return `<ellipse cx="-13" cy="${y}" rx="7" ry="6" fill="#f4f1ea" ${stroke(2)}/><ellipse cx="13" cy="${y}" rx="7" ry="6" fill="#f4f1ea" ${stroke(2)}/>`;
  if (kind === 'hollow') return `<ellipse cx="-13" cy="${y}" rx="6" ry="8" fill="#26324a"/><ellipse cx="13" cy="${y}" rx="6" ry="8" fill="#26324a"/>`;
  if (kind && kind.startsWith('glow:')) {
    const c = kind.slice(5);
    return glow(-13, y, 26, c, 0.8) + glow(13, y, 26, c, 0.8) +
      `<ellipse cx="-13" cy="${y}" rx="7" ry="4.5" fill="${c}"/><ellipse cx="13" cy="${y}" rx="7" ry="4.5" fill="${c}"/>`;
  }
  if (kind === 'sly') return `<ellipse cx="-13" cy="${y}" rx="4.5" ry="5" fill="${col}"/><ellipse cx="13" cy="${y}" rx="4.5" ry="5" fill="${col}"/>
    <path d="M-21 ${y - 4} L-5 ${y - 2} M5 ${y - 2} L21 ${y - 4}" stroke="${col}" stroke-width="3" stroke-linecap="round"/>`;
  if (kind === 'wide') return `<ellipse cx="-13" cy="${y}" rx="7" ry="8" fill="#fff" ${stroke(2)}/><ellipse cx="13" cy="${y}" rx="7" ry="8" fill="#fff" ${stroke(2)}/>
    <circle cx="-13" cy="${y + 1}" r="4" fill="${col}"/><circle cx="13" cy="${y + 1}" r="4" fill="${col}"/>`;
  if (kind === 'grey') return `<ellipse cx="-13" cy="${y}" rx="6" ry="5" fill="#fff" ${stroke(2)}/><ellipse cx="13" cy="${y}" rx="6" ry="5" fill="#fff" ${stroke(2)}/>
    <circle cx="-13" cy="${y}" r="3.4" fill="#6f7c8a"/><circle cx="13" cy="${y}" r="3.4" fill="#6f7c8a"/>`;
  return `<ellipse cx="-13" cy="${y}" rx="4.5" ry="6" fill="${col}"/><ellipse cx="13" cy="${y}" rx="4.5" ry="6" fill="${col}"/>
    <circle cx="-11.5" cy="${y - 2}" r="1.6" fill="#fff"/><circle cx="14.5" cy="${y - 2}" r="1.6" fill="#fff"/>`;
}

function browsSvg(mood) {
  const y = -306;
  if (mood === 'stern' || mood === 'angry') return `<path d="M-24 ${y - 4} L-5 ${y + 2} M24 ${y - 4} L5 ${y + 2}" stroke="#1a1208" stroke-width="3.5" stroke-linecap="round"/>`;
  if (mood === 'sad' || mood === 'pleading') return `<path d="M-23 ${y + 2} L-6 ${y - 4} M23 ${y + 2} L6 ${y - 4}" stroke="#1a1208" stroke-width="3" stroke-linecap="round"/>`;
  if (mood === 'sly') return `<path d="M-23 ${y} Q-14 ${y - 6} -5 ${y - 2} M5 ${y - 6} Q14 ${y - 10} 23 ${y - 4}" fill="none" stroke="#1a1208" stroke-width="3" stroke-linecap="round"/>`;
  return '';
}

function mouthSvg(mood) {
  const y = -266;
  const m = {
    smile: `M-11 ${y - 2} Q0 ${y + 9} 11 ${y - 2}`,
    grin: `M-14 ${y - 4} Q0 ${y + 12} 14 ${y - 4} Q0 ${y + 2} -14 ${y - 4} Z`,
    sad: `M-10 ${y + 4} Q0 ${y - 4} 10 ${y + 4}`,
    pleading: `M-9 ${y + 4} Q0 ${y - 3} 9 ${y + 4}`,
    stern: `M-10 ${y} L10 ${y}`,
    angry: `M-12 ${y + 3} Q0 ${y - 5} 12 ${y + 3}`,
    open: null,
    blank: `M-7 ${y} L7 ${y}`,
    sly: `M-10 ${y} Q4 ${y + 6} 13 ${y - 5}`,
  }[mood];
  if (mood === 'open' || mood === 'scream') return `<ellipse cx="0" cy="${y + 2}" rx="${mood === 'scream' ? 11 : 7}" ry="${mood === 'scream' ? 13 : 8}" fill="#4a1a1a" ${stroke(2)}/>`;
  if (mood === 'grin') return `<path d="${m}" fill="#fff" ${stroke(2.5, '#5a2a1a')}/>`;
  return `<path d="${m || `M-8 ${y} Q0 ${y + 4} 8 ${y}`}" stroke="#5a2a1a" stroke-width="3" fill="none" stroke-linecap="round"/>`;
}

function hairBack(style, col) {
  if (style === 'long') return `<path d="M-46 -300 C-62 -350 -30 -344 0 -344 C30 -344 62 -350 46 -300 L56 -190 Q0 -176 -56 -190 Z" fill="${col}" ${stroke(3)}/>`;
  if (style === 'longWhite') return `<path d="M-48 -300 C-64 -350 -30 -344 0 -344 C30 -344 64 -350 48 -300 L62 -170 Q0 -150 -62 -170 Z" fill="${col}" ${stroke(3)}/>`;
  return '';
}

function hairFront(style, col) {
  switch (style) {
    case 'short':
      return `<path d="M-38 -296 C-42 -338 -10 -340 0 -336 C22 -340 44 -326 38 -296 C30 -318 -22 -322 -38 -296 Z" fill="${col}" ${stroke(2.5)}/>`;
    case 'messy':
      return `<path d="M-40 -292 C-48 -320 -36 -342 -14 -340 L-6 -352 L4 -340 L18 -350 L22 -336 C40 -336 48 -318 40 -290 L34 -306 L24 -296 L18 -312 L4 -302 L-6 -316 L-16 -300 L-26 -312 Z" fill="${col}" ${stroke(2.5)}/>`;
    case 'curly': {
      let s = '';
      const pts = [[-34, -306], [-24, -326], [-6, -336], [14, -334], [30, -322], [38, -302], [-40, -288], [40, -286]];
      for (const [x, y] of pts) s += `<circle cx="${x}" cy="${y}" r="15" fill="${col}" ${stroke(2.5)}/>`;
      return s + `<path d="M-30 -300 Q0 -322 30 -300" fill="${col}"/>`;
    }
    case 'long':
    case 'longWhite':
      return `<path d="M-40 -284 C-46 -334 -12 -340 0 -338 C14 -340 46 -334 40 -284 C34 -306 12 -318 0 -316 C-12 -318 -34 -306 -40 -284 Z" fill="${col}" ${stroke(2.5)}/>`;
    case 'bald':
      return `<path d="M-38 -282 C-40 -298 -36 -304 -32 -306 M38 -282 C40 -298 36 -304 32 -306" stroke="${col}" stroke-width="8" fill="none" stroke-linecap="round"/>`;
    default:
      return '';
  }
}

function beardSvg(col, len = 40, streak = null) {
  return `<path d="M-36 -282 C-38 -250 -24 ${-250 + len} 0 ${-246 + len} C24 ${-250 + len} 38 -250 36 -282 C30 -262 18 -258 0 -258 C-18 -258 -30 -262 -36 -282 Z" fill="${col}" ${stroke(2.5)}/>
    <path d="M-14 -268 Q0 -276 14 -268" stroke="${col}" stroke-width="7" fill="none" stroke-linecap="round"/>
    ${streak ? `<path d="M-14 -250 L-12 ${-240 + len * 0.7} M10 -250 L12 ${-240 + len * 0.6}" stroke="${streak}" stroke-width="4" stroke-linecap="round"/>` : ''}`;
}

// Generic adult figure. Characters below are built on it.
function figure(o = {}) {
  const {
    skin = SKIN.warm, robe = '#6a7fa0', trim = null, hair = '#2a1a10', hairStyle = 'short',
    beard = null, beardLen = 40, beardStreak = null, eyes = 'normal', mood = 'neutral',
    armL = 'down', armR = 'down', sleeve = null, body = 'robe', back = false, seated = false,
    behind = '', front = '', head = '', handL = '', handR = '', blush = true, legs = '#3e3a44',
    sandals = '#7a4e22',
  } = o;
  const sl = sleeve || robe;
  let torso = '';
  if (body === 'robe') {
    torso = `<path d="M-48 -236 L48 -236 L72 0 L-72 0 Z" fill="${robe}" ${stroke(3)}/>
      <path d="M-20 -236 L0 -200 L20 -236" fill="none" stroke="${OL}" stroke-width="2.5" opacity="0.5"/>
      <path d="M-30 -140 L-40 -4 M22 -150 L30 -4" stroke="${OL}" stroke-width="2.5" opacity="0.25"/>
      ${trim ? `<path d="M-70 -14 L70 -14" stroke="${trim}" stroke-width="10"/><path d="M-48 -150 L48 -150" stroke="${trim}" stroke-width="7"/>` : ''}`;
  } else if (body === 'tunic') {
    torso = `<path d="M-14 -120 L-18 -8 M14 -120 L18 -8" stroke="${OL}" stroke-width="27" stroke-linecap="round"/>
      <path d="M-14 -120 L-18 -8 M14 -120 L18 -8" stroke="${skin}" stroke-width="20" stroke-linecap="round"/>
      <path d="M-30 -2 L-6 -2 L-8 -16 L-30 -14 Z M6 -2 L30 -2 L30 -14 L8 -16 Z" fill="${sandals}" ${stroke(2.5)}/>
      <path d="M-46 -236 L46 -236 L58 -112 L-58 -112 Z" fill="${robe}" ${stroke(3)}/>
      <path d="M-50 -150 L50 -150" stroke="${trim || '#7a4e22'}" stroke-width="8"/>
      ${trim ? `<path d="M-57 -120 L57 -120" stroke="${trim}" stroke-width="7"/>` : ''}`;
  } else if (body === 'jacket') {
    torso = `<path d="M-16 -100 L-18 -10 M16 -100 L18 -10" stroke="${OL}" stroke-width="25" stroke-linecap="round"/>
      <path d="M-16 -100 L-18 -10 M16 -100 L18 -10" stroke="${skin}" stroke-width="18" stroke-linecap="round"/>
      <path d="M-34 0 L-4 0 L-6 -16 L-32 -14 Z M4 0 L34 0 L32 -14 L6 -16 Z" fill="#f2f2f2" ${stroke(2.5)}/>
      <path d="M-40 -132 L40 -132 L42 -86 L-42 -86 Z" fill="${legs}" ${stroke(3)}/>
      <path d="M0 -130 L0 -90" stroke="${OL}" stroke-width="2.5"/>
      <path d="M-46 -236 L46 -236 L50 -120 L-50 -120 Z" fill="${robe}" ${stroke(3)}/>
      <path d="M0 -234 L0 -122" stroke="#b8901a" stroke-width="3"/>
      <path d="M-34 -170 L-14 -170 M14 -170 L34 -170" stroke="#b8901a" stroke-width="3"/>`;
  }
  if (seated) torso = `<g transform="translate(0 0)">${torso}</g>`;
  const faceSvg = back
    ? ''
    : `${eyesSvg(eyes)}${browsSvg(mood)}${beard ? '' : mouthSvg(mood)}
       ${blush && !beard ? `<circle cx="-23" cy="-275" r="6" fill="#e8907a" opacity="0.4"/><circle cx="23" cy="-275" r="6" fill="#e8907a" opacity="0.4"/>` : ''}`;
  return `${behind}${hairBack(hairStyle, hair)}
    ${torso}
    ${arm('l', armL, sl, skin)}${arm('r', armR, sl, skin)}
    <rect x="-10" y="-258" width="20" height="26" fill="${skin}" ${stroke(2.5)}/>
    <ellipse cx="0" cy="-290" rx="36" ry="42" fill="${skin}" ${stroke(3)}/>
    ${back ? `<path d="M-37 -300 C-40 -336 -10 -338 0 -336 C20 -338 42 -330 37 -300 C40 -280 34 -262 0 -258 C-34 -262 -40 -280 -37 -300 Z" fill="${hair}" ${stroke(2.5)}/>` : ''}
    ${faceSvg}
    ${beard && !back ? beardSvg(beard, beardLen, beardStreak) + mouthSvg(mood) : ''}
    ${hairFront(hairStyle, hair)}
    ${head}
    ${handL ? g(handL, `translate(${handPos('l', armL).join(' ')})`) : ''}
    ${handR ? g(handR, `translate(${handPos('r', armR).join(' ')})`) : ''}
    ${front}`;
}

const place = (x, y, sc, content, flip = false, op = 1) => at(x, y, sc, op < 1 ? fade(op, content) : content, flip);

// Seated pose: upper body lowered onto a lap with shins below.
function seatedFigure(o = {}) {
  const { robe = '#6a7fa0', trim = null } = o;
  const lap = `<path d="M-64 -112 L64 -112 L74 -76 L-74 -76 Z" fill="${robe}" ${stroke(3)}/>
    <path d="M-62 -78 L-56 0 L-8 0 L-6 -78 Z M6 -78 L8 0 L56 0 L62 -78 Z" fill="${robe}" ${stroke(3)}/>
    ${trim ? `<path d="M-56 -10 L-8 -10 M8 -10 L56 -10" stroke="${trim}" stroke-width="8"/>` : ''}`;
  const upper = figure({ ...o, body: 'robe', trim: null }).replace('<path d="M-30 -140 L-40 -4 M22 -150 L30 -4"', '<path d="M0 0"');
  return lap + g(upper.replace(/<path d="M-48 -236 L48 -236 L72 0 L-72 0 Z"/, '<path d="M-48 -236 L48 -236 L60 -206 L-60 -206 Z"'), 'translate(0 106)');
}

// ---------------------------------------------------------------- the player

const PLAYER_SLEEVE = '#2f4a6e';

// The player's own forearm and hand reaching in from the bottom of the frame.
// Origin is the wrist; fingers point up (toward -y). pose: open | reach | grip | fist | cup
function hand(x, y, sc = 1, deg = 0, o = {}) {
  const { pose = 'open', skin = SKIN.warm, sleeve = PLAYER_SLEEVE, flip = false, ring = false, cuts = false } = o;
  const sleeveSvg = sleeve ? `<path d="M-62 30 L-58 520 L62 520 L66 30 Z" fill="${sleeve}" ${stroke(4)}/>
    <path d="M-64 40 L66 40 L66 74 L-62 74 Z" fill="${sleeve}" ${stroke(4)}/>
    <path d="M-40 120 L-36 500 M24 140 L28 500" stroke="#000" stroke-opacity="0.15" stroke-width="5"/>` : '';
  const wrist = `<path d="M-44 40 L-46 -10 L46 -10 L44 40 Z" fill="${skin}" ${stroke(4)}/>`;
  const palm = `<path d="M-50 -4 C-56 -50 -56 -90 -48 -108 L48 -108 C56 -90 56 -50 50 -4 Z" fill="${skin}" ${stroke(4)}/>`;
  let fingers = '';
  if (pose === 'grip' || pose === 'fist') {
    const xs = [-36, -12, 12, 36];
    fingers = xs.map((fx) => `<rect x="${fx - 12}" y="-128" width="24" height="44" rx="12" fill="${skin}" ${stroke(3.5)}/>`).join('') +
      `<path d="M-48 -86 Q0 -78 48 -86" fill="none" stroke="${OL}" stroke-width="3" opacity="0.5"/>` +
      `<path d="M-50 -40 C-80 -60 -80 -96 -58 -104 C-44 -108 -40 -92 -42 -78 Z" fill="${skin}" ${stroke(3.5)}/>`;
  } else {
    const lens = pose === 'cup' ? [46, 54, 52, 42] : pose === 'reach' ? [86, 98, 94, 74] : [74, 86, 82, 64];
    const spread = pose === 'open' ? [-10, -3, 3, 10] : [-4, -1, 1, 4];
    const xs = [-36, -12, 12, 36];
    fingers = xs.map((fx, i) => rot(fx, -100, spread[i], `<rect x="${fx - 12}" y="${-100 - lens[i]}" width="24" height="${lens[i] + 10}" rx="12" fill="${skin}" ${stroke(3.5)}/>
      <path d="M${fx - 6} ${-100 - lens[i] * 0.45} L${fx + 6} ${-100 - lens[i] * 0.45}" stroke="${OL}" stroke-width="2" opacity="0.35"/>`)).join('') +
      rot(-50, -40, -38, `<rect x="-62" y="-118" width="26" height="84" rx="13" fill="${skin}" ${stroke(3.5)}/>`);
  }
  const ringSvg = ring ? `<rect x="-26" y="-118" width="28" height="11" rx="4" fill="#d9dde3" ${stroke(2.5)}/><circle cx="-12" cy="-112" r="2.5" fill="#fff"/>` : '';
  const cutSvg = cuts ? `<path d="M-38 -70 L20 -84 M-30 -46 L34 -60" stroke="#c0394a" stroke-width="3" stroke-linecap="round" opacity="0.85"/>` : '';
  return g(at(0, 0, 1, sleeveSvg + wrist + palm + fingers + ringSvg + cutSvg, flip), `translate(${x} ${y}) rotate(${deg}) scale(${sc})`);
}

// ---------------------------------------------------------------- characters

function theo(x, y, sc = 1, o = {}) {
  const { ghost = false, mood = 'neutral', back = false, armL = 'down', armR = 'down', op = 1, flip = false, eyes = 'normal', wet = false, alive = false } = o;
  const skin = ghost ? SKIN.ghost : SKIN.pale;
  const jacket = ghost ? '#d8cf9a' : '#ffcf1f';
  const hood = `<path d="M-40 -238 C-44 -262 44 -262 40 -238 L30 -228 L-30 -228 Z" fill="${jacket}" ${stroke(3)}/>`;
  const drips = wet ? `<path d="M-30 -250 l-2 14 M28 -246 l2 12 M-48 -200 l-2 12" stroke="#7fb8e8" stroke-width="4" stroke-linecap="round"/>` : '';
  const glowSvg = ghost ? glow(0, -180, 220, '#bcd8ff', 0.3) : alive ? glow(0, -180, 240, '#fff1b0', 0.4) : '';
  const body = figure({ skin, robe: jacket, hair: '#3b2616', hairStyle: 'messy', body: 'jacket', mood, eyes, back, armL, armR, behind: hood, front: drips, legs: '#384050' });
  return glowSvg + place(x, y, sc, `<g transform="scale(0.82)">${body}</g>`, flip, ghost ? Math.min(op, 0.88) : op);
}

// Sitting with knees pulled up (Asphodel Meadows).
function theoSitting(x, y, sc = 1, o = {}) {
  const { ghost = true } = o;
  const skin = ghost ? SKIN.ghost : SKIN.pale;
  const jacket = ghost ? '#e0cf7a' : '#ffcf1f';
  return glow(x, y - 100 * sc, 200 * sc, '#bcd8ff', 0.28) + place(x, y, sc, `
    <path d="M-58 -150 C-64 -100 -60 -40 -52 0 L52 0 C60 -40 64 -100 58 -150 Z" fill="${jacket}" ${stroke(3)}/>
    <path d="M-36 -30 L-30 -126 L-6 -126 L-10 -30 Z M10 -30 L6 -126 L30 -126 L36 -30 Z" fill="#384050" ${stroke(3)}/>
    <path d="M-34 -126 C-40 -150 -10 -160 -4 -128 M6 -128 C10 -160 40 -150 34 -126" fill="${skin}" ${stroke(3)}/>
    <path d="M-60 -120 C-64 -150 -20 -150 -10 -132 L-12 -112 C-30 -116 -50 -110 -60 -120 Z" fill="${jacket}" ${stroke(3)}/>
    <path d="M60 -120 C64 -150 20 -150 10 -132 L12 -112 C30 -116 50 -110 60 -120 Z" fill="${jacket}" ${stroke(3)}/>
    <circle cx="-8" cy="-124" r="12" fill="${skin}" ${stroke(2.5)}/><circle cx="8" cy="-124" r="12" fill="${skin}" ${stroke(2.5)}/>
    <path d="M-36 -2 L-4 -2 L-6 -16 L-34 -14 Z M4 -2 L36 -2 L34 -14 L6 -16 Z" fill="#e8e8e8" ${stroke(2.5)}/>
    <ellipse cx="0" cy="-192" rx="34" ry="40" fill="${skin}" ${stroke(3)}/>
    <g transform="translate(0 98)">${hairFront('messy', '#3b2616')}${eyesSvg('normal')}${mouthSvg('blank')}</g>
  `, false, ghost ? 0.88 : 1);
}

function hermes(x, y, sc = 1, o = {}) {
  const { armL = 'down', armR = 'down', mood = 'smile', eyes = 'normal', flip = false, coinHand = 'r', hat = true, cloak = true, back = false } = o;
  const coin = `<circle cx="0" cy="-12" r="11" fill="#ffd34a" ${stroke(2.5)}/><circle cx="0" cy="-12" r="5" fill="none" stroke="#c89412" stroke-width="2"/>`;
  const wing = (s) => `<path d="M${s * 34} -18 C${s * 50} -30 ${s * 66} -26 ${s * 70} -16 C${s * 60} -14 ${s * 54} -10 ${s * 58} -4 C${s * 48} -6 ${s * 42} -6 ${s * 34} -6 Z" fill="#ffffff" ${stroke(2.5)}/>`;
  const sandalWings = `<g transform="translate(-6 -6) scale(0.55)">${wing(-1)}</g><g transform="translate(6 -6) scale(0.55)">${wing(1)}</g>`;
  const hatSvg = hat ? `
    <ellipse cx="0" cy="-322" rx="74" ry="16" fill="#8f949c" ${stroke(3)}/>
    <path d="M-36 -326 C-34 -366 34 -366 36 -326 Z" fill="#a3a8b0" ${stroke(3)}/>
    <path d="M-36 -330 Q0 -338 36 -330" stroke="#6a6e76" stroke-width="5" fill="none"/>
    <g transform="translate(-6 -310)">${wing(-1)}</g><g transform="translate(6 -310)">${wing(1)}</g>` : '';
  const cloakSvg = cloak ? `<path d="M-50 -236 C-80 -200 -86 -120 -76 -60 L-56 -64 L-46 -230 Z" fill="#8a5a32" ${stroke(3)}/>` : '';
  return place(x, y, sc, figure({
    skin: SKIN.god, robe: '#7fc0ea', trim: '#f2c14e', hair: '#c4862e', hairStyle: 'curly', body: 'tunic', sandals: '#9a6a3a',
    mood, eyes, armL, armR, back, behind: cloakSvg,
    head: hatSvg, front: sandalWings,
    handL: coinHand === 'l' ? coin : '', handR: coinHand === 'r' ? coin : '',
  }), flip);
}

function charon(x, y, sc = 1, o = {}) {
  const { pole = true, armL = 'down', armR = [[-70, -200], [-60, -260]], flip = false, palm = false, ring = false, back = false } = o;
  const hood = `<path d="M-56 -300 C-62 -372 62 -372 56 -300 L60 -230 L-60 -230 Z" fill="#3a3a44" ${stroke(3)}/>`;
  const hoodFront = `<path d="M-56 -300 C-62 -372 62 -372 56 -300 C46 -330 30 -342 0 -344 C-30 -342 -46 -330 -56 -300 Z" fill="#3a3a44" ${stroke(3)}/>
    <path d="M-46 -300 C-44 -320 -20 -332 0 -332 C20 -332 44 -320 46 -300 L44 -276 C30 -290 -30 -290 -44 -276 Z" fill="#141018" opacity="0.85"/>`;
  const poleSvg = pole ? `<path d="M76 -560 L96 60" stroke="${OL}" stroke-width="15" stroke-linecap="round"/><path d="M76 -560 L96 60" stroke="#7a5a3a" stroke-width="9" stroke-linecap="round"/>` : '';
  const palmSvg = palm ? `<path d="M-12 -6 C-20 -20 -16 -34 0 -34 C16 -34 20 -20 12 -6 Z" fill="#b7aca0" ${stroke(2.5)}/>${ring ? `<circle cx="0" cy="-22" r="8" fill="none" stroke="#e3e7ec" stroke-width="4"/>` : ''}` : '';
  const body = figure({
    skin: '#b7aca0', robe: '#3a3a44', hair: '#9a9aa2', hairStyle: 'none', beard: '#b4b4bc', beardLen: 90,
    eyes: 'glow:#ff8a2a', mood: 'stern', armL, armR, back, blush: false,
    behind: hood + poleSvg, head: back ? `<path d="M-56 -300 C-62 -372 62 -372 56 -300 L56 -260 C30 -250 -30 -250 -56 -260 Z" fill="#3a3a44" ${stroke(3)}/>` : hoodFront,
    handL: palmSvg,
    front: `<path d="M-72 0 L-66 -40 L-56 -10 L-46 -36 L-36 -4 L-24 -30 L-12 -2 L0 -28 L12 -2 L24 -30 L36 -4 L46 -36 L56 -10 L66 -40 L72 0 Z" fill="#3a3a44" ${stroke(3)}/>`,
  });
  return place(x, y, sc, `<g transform="scale(1.08 1.12)">${body}</g>`, flip);
}

function persephone(x, y, sc = 1, o = {}) {
  const { armL = 'down', armR = 'down', mood = 'smile', eyes = 'normal', flip = false, fruit = false, seated = false, grey = false } = o;
  const fruitSvg = fruit ? pomegranate(0, -6, 0.55, { split: true }) : '';
  const crown = `<path d="M-40 -318 Q0 -340 40 -318" stroke="#2a3a20" stroke-width="7" fill="none"/>` +
    [[-36, -318, '#9e2b3a'], [-20, -330, '#6a3a8a'], [0, -336, '#9e2b3a'], [20, -330, '#6a3a8a'], [36, -318, '#9e2b3a']]
      .map(([cx, cy, c]) => `<circle cx="${cx}" cy="${cy}" r="10" fill="${c}" ${stroke(2.5)}/><circle cx="${cx}" cy="${cy}" r="3" fill="#ffd27a"/>`).join('');
  const opts = {
    skin: grey ? '#d6d2d0' : '#efd2c0', robe: grey ? '#6e6672' : '#5e2a5a', trim: grey ? '#b8b0a0' : '#e0b04a', hair: '#24161e', hairStyle: 'long',
    mood, eyes, armL, armR, head: crown, handR: fruitSvg,
  };
  return place(x, y, sc, seated ? seatedFigure(opts) : figure(opts), flip);
}

function hades(x, y, sc = 1, o = {}) {
  const { armL = [[-80, -170], [-70, -120]], armR = [[-80, -170], [-70, -120]], mood = 'stern', flip = false, seated = true, soft = false } = o;
  const crown = `<path d="M-38 -320 L-34 -350 L-22 -330 L-12 -362 L0 -334 L12 -362 L22 -330 L34 -350 L38 -320 Z" fill="#4a4a56" ${stroke(3)}/>
    <path d="M-38 -320 L38 -320" stroke="#c08a4a" stroke-width="5"/>`;
  const opts = {
    skin: '#d8c8bc', robe: '#1e1a2c', trim: '#6a3aa0', hair: '#1a1620', hairStyle: 'short', beard: '#24202c', beardLen: 46, beardStreak: '#9a9aa8',
    eyes: 'grey', mood: soft ? 'neutral' : mood, armL, armR, head: crown, sleeve: '#2e2444', blush: false,
  };
  return place(x, y, sc, seated ? seatedFigure(opts) : figure(opts), flip);
}

function throne(x, y, sc = 1, small = false) {
  const w = small ? 120 : 160, h = small ? 360 : 520;
  return place(x, y, sc, `
    <path d="M${-w} 0 L${w} 0 L${w - 10} ${-h} C${w - 30} ${-h - 60} ${-w + 30} ${-h - 60} ${-w + 10} ${-h} Z" fill="#14101e" ${stroke(4)}/>
    <path d="M${-w + 30} -40 L${w - 30} -40 L${w - 40} ${-h + 30} C${w - 60} ${-h - 20} ${-w + 60} ${-h - 20} ${-w + 40} ${-h + 30} Z" fill="#241c38" ${stroke(3)}/>
    <path d="M${-w + 50} ${-h + 60} L${-w + 70} ${-h + 20} M${w - 50} ${-h + 80} L${w - 66} ${-h + 40}" stroke="#7a6aa8" stroke-width="4" opacity="0.6"/>
    <rect x="${-w - 20}" y="-140" width="50" height="140" rx="8" fill="#1a1428" ${stroke(3)}/>
    <rect x="${w - 30}" y="-140" width="50" height="140" rx="8" fill="#1a1428" ${stroke(3)}/>
    <circle cx="0" cy="${-h + 10}" r="${small ? 14 : 20}" fill="#9e2b3a" ${stroke(3)}/>`);
}

function fury(x, y, sc = 1, o = {}) {
  const { robe = '#7a1a26', armL = 'down', armR = [[-100, -230], [-120, -290]], mood = 'stern', flip = false, whip = true, wingsUp = true, eyes = 'glow:#ff5a3a' } = o;
  const wing = (s) => `<path d="M${s * 30} -230 C${s * 120} -360 ${s * 240} -380 ${s * 300} -330 C${s * 270} -300 ${s * 260} -260 ${s * 270} -220
      C${s * 236} -240 ${s * 210} -230 ${s * 200} -200 C${s * 170} -220 ${s * 140} -214 ${s * 130} -186 C${s * 100} -200 ${s * 70} -196 ${s * 40} -170 Z" fill="#1c1622" ${stroke(3)}/>
    <path d="M${s * 40} -220 L${s * 270} -320 M${s * 40} -210 L${s * 200} -200 M${s * 40} -200 L${s * 130} -186" stroke="#3a3044" stroke-width="4"/>`;
  const wings = wingsUp ? wing(-1) + wing(1) : '';
  let snakes = '';
  const sp = [[-40, -310, -70], [-30, -334, -40], [-10, -344, -12], [12, -344, 14], [30, -334, 40], [40, -310, 70], [-44, -284, -96], [44, -284, 96]];
  for (const [sx, sy, a] of sp) {
    snakes += g(`<path d="M0 0 C6 -14 -6 -26 2 -40" fill="none" stroke="${OL}" stroke-width="12" stroke-linecap="round"/>
      <path d="M0 0 C6 -14 -6 -26 2 -40" fill="none" stroke="#4a8a3a" stroke-width="7" stroke-linecap="round"/>
      <ellipse cx="2" cy="-44" rx="7" ry="9" fill="#5aa04a" ${stroke(2.5)}/><circle cx="0" cy="-46" r="1.8" fill="#ffde5a"/>`, `translate(${sx} ${sy}) rotate(${a})`);
  }
  const hp = handPos('r', armR);
  const whipSvg = whip ? `<path d="M${hp[0]} ${hp[1]} C${hp[0] + 80} ${hp[1] - 80} ${hp[0] + 160} ${hp[1] + 40} ${hp[0] + 120} ${hp[1] + 160}" fill="none" stroke="#ff7a1a" stroke-width="12" stroke-linecap="round"/>
    <path d="M${hp[0]} ${hp[1]} C${hp[0] + 80} ${hp[1] - 80} ${hp[0] + 160} ${hp[1] + 40} ${hp[0] + 120} ${hp[1] + 160}" fill="none" stroke="#ffe08a" stroke-width="4" stroke-linecap="round"/>` : '';
  return (whip ? '' : '') + place(x, y, sc, figure({
    skin: '#c9a8a0', robe, trim: '#2a1418', hair: '#2a1a20', hairStyle: 'none', eyes, mood, armL, armR, blush: false,
    behind: wings, head: snakes, front: whipSvg + (whip ? glow(hp[0] + 100, hp[1] + 40, 110, '#ff8a2a', 0.35) : ''),
  }), flip);
}

function sisyphus(x, y, sc = 1, o = {}) {
  const { flip = false, mood = 'sad' } = o;
  // Leans into a boulder on his right (+x). Origin at his feet.
  const fig = figure({
    skin: '#c9946a', robe: '#8a8a8a', hair: '#3a2a20', hairStyle: 'short', beard: '#3a2a20', beardLen: 30, body: 'tunic',
    mood, armL: [[60, -200], [110, -232]], armR: [[-70, -220], [-112, -244]], sandals: '#5a3a22',
    front: `<path d="M-40 -140 L-30 -128 L-20 -142 L-10 -130 L0 -144 L12 -128 L24 -142 L36 -128 L48 -140" fill="none" stroke="${OL}" stroke-width="3"/>`,
  });
  return place(x, y, sc, g(fig, 'rotate(22)'), flip);
}

function boulder(x, y, r) {
  return at(x, y, 1, `
    <circle cx="0" cy="0" r="${r}" fill="#7e7a76" ${stroke(4)}/>
    <path d="M${-r * 0.6} ${-r * 0.3} C${-r * 0.3} ${-r * 0.5} ${r * 0.1} ${-r * 0.4} ${r * 0.3} ${-r * 0.6}" fill="none" stroke="${OL}" stroke-width="3" opacity="0.45"/>
    <path d="M${-r * 0.2} ${r * 0.4} C0 ${r * 0.2} ${r * 0.3} ${r * 0.4} ${r * 0.5} ${r * 0.2}" fill="none" stroke="${OL}" stroke-width="3" opacity="0.45"/>
    <ellipse cx="${-r * 0.35}" cy="${-r * 0.4}" rx="${r * 0.25}" ry="${r * 0.14}" fill="#a8a4a0" opacity="0.6"/>`);
}

function achilles(x, y, sc = 1, o = {}) {
  const { flip = false, mood = 'sad', eyes = 'normal' } = o;
  const cup = `<path d="M-18 -20 L18 -20 L12 4 L-12 4 Z" fill="#c08a4a" ${stroke(2.5)}/><ellipse cx="0" cy="-20" rx="18" ry="5" fill="#ffd56a" ${stroke(2)}/>`;
  const cloak = `<path d="M-50 -236 C-90 -180 -90 -80 -70 0 L70 0 C90 -80 90 -180 50 -236 Z" fill="#a8282e" ${stroke(3)}/>`;
  const armour = `<path d="M-46 -236 L46 -236 L50 -140 Q0 -124 -50 -140 Z" fill="#d49a4a" ${stroke(3)}/>
    <path d="M-30 -210 Q-16 -190 0 -200 Q16 -190 30 -210 M-34 -170 Q0 -158 34 -170" fill="none" stroke="#8a5a22" stroke-width="3"/>
    <path d="M-50 -140 L-56 -100 L-36 -96 L-30 -134 M-20 -132 L-20 -94 M0 -130 L0 -92 M20 -132 L20 -94 M50 -140 L56 -100 L36 -96 L30 -134" fill="none" stroke="#8a5a22" stroke-width="5"/>`;
  return place(x, y, sc, figure({
    skin: '#d9a87e', robe: '#d49a4a', hair: '#b07a32', hairStyle: 'curly', mood, eyes, armL: 'down', armR: 'forward', sleeve: '#d9a87e',
    behind: cloak, front: '', head: '', handR: cup,
  }).replace(/(<rect x="-10" y="-258")/, `${armour}$1`), flip);
}

function sibyl(x, y, sc = 1, o = {}) {
  const { eyes = 'closed', mood = 'neutral', flip = false } = o;
  let leaves = '';
  for (const [lx, ly, a] of [[-34, -326, -30], [8, -340, 20], [36, -310, 60], [-48, -250, -80], [50, -230, 100]])
    leaves += g(`<path d="M0 0 C6 -6 14 -6 18 0 C14 6 6 6 0 0 Z" fill="#b07a3a" ${stroke(2)}/>`, `translate(${lx} ${ly}) rotate(${a})`);
  const shawl = `<path d="M-60 -250 C-30 -210 30 -210 60 -250 L74 -140 Q0 -120 -74 -140 Z" fill="#8a8a90" ${stroke(3)}/>`;
  return place(x, y, sc, seatedFigure({
    skin: '#dcc4ae', robe: '#6e6e76', hair: '#ecebe6', hairStyle: 'longWhite', eyes, mood, blush: false,
    armL: [[-60, -150], [-20, -134]], armR: [[-60, -150], [-20, -128]], front: shawl, head: leaves,
  }), flip);
}

function judge(x, y, sc = 1, o = {}) {
  const { flip = false, beard = '#e8e4dc' } = o;
  return place(x, y, sc, seatedFigure({
    skin: '#dcb898', robe: '#ece6d8', trim: '#c08a4a', hair: beard, hairStyle: 'bald', beard, beardLen: 70, mood: 'stern', blush: false,
    armL: [[-70, -150], [-56, -120]], armR: [[-70, -150], [-56, -120]],
  }), flip);
}

// A soul of the dead. view: front | back
function shade(x, y, sc = 1, o = {}) {
  const { op = 0.6, back = true, mood = 'sad', col = '#c8dcf4', arms = 'down', eyes = 'hollow', flip = false } = o;
  const body = `<path d="M-46 -236 L46 -236 C58 -160 62 -80 54 0 Q40 -14 28 4 Q16 16 4 0 Q-8 -14 -20 4 Q-32 16 -44 0 Q-60 -80 -46 -236 Z" fill="${col}" ${stroke(3, '#3e5a85')}/>`;
  const armPose = arms === 'reach' ? { l: [[-90, -220], [-140, -232]], r: [[-90, -220], [-140, -232]] } : { l: 'down', r: 'down' };
  const fig = `${body}${arm('l', armPose.l, col, col)}${arm('r', armPose.r, col, col)}
    <ellipse cx="0" cy="-290" rx="36" ry="42" fill="${col}" ${stroke(3, '#3e5a85')}/>
    ${back ? `<path d="M-30 -310 C-20 -326 20 -326 30 -310" stroke="#9ab4d8" stroke-width="5" fill="none"/>` : `${eyesSvg(eyes)}${mouthSvg(mood)}`}`;
  return place(x, y, sc, fade(op, fig), flip);
}

function shadeCrowd(seed, n, y0, y1, o = {}) {
  const r = rng(seed);
  const { x0 = 0, x1 = 1000, scale = [0.12, 0.5], op = 0.55, back = true, col = '#c8dcf4', skip = null } = o;
  const items = [];
  for (let i = 0; i < n; i++) {
    const t = r();
    const y = y0 + (y1 - y0) * t;
    const sc = scale[0] + (scale[1] - scale[0]) * t;
    const x = x0 + r() * (x1 - x0);
    if (skip && skip(x, y)) continue;
    items.push({ x, y, sc });
  }
  items.sort((a, b) => a.y - b.y);
  return items.map((it) => shade(it.x, it.y, it.sc, { op, back, col })).join('');
}

function cerberus(x, y, sc = 1, o = {}) {
  const { asleep = false, snarl = true, fur = '#1e1a22', flip = false } = o;
  const headSvg = (hx, hy, a, hsc, mid) => {
    const eyesS = asleep
      ? `<path d="M-30 -14 Q-20 -8 -10 -14 M10 -14 Q20 -8 30 -14" fill="none" stroke="#8a7a90" stroke-width="4" stroke-linecap="round"/>`
      : glow(-20, -16, 26, '#ff3a2a', 0.8) + glow(20, -16, 26, '#ff3a2a', 0.8) +
        `<path d="M-32 -18 L-10 -12 L-30 -10 Z M32 -18 L10 -12 L30 -10 Z" fill="#ff4a2a"/>`;
    const teeth = !asleep && snarl && mid
      ? `<path d="M-30 40 L-24 60 L-16 42 L-8 64 L0 44 L8 64 L16 42 L24 60 L30 40 Z" fill="#f4f0e6" ${stroke(2.5)}/>`
      : !asleep && snarl ? `<path d="M-20 42 L-14 54 L-8 44 M8 44 L14 54 L20 42" fill="#f4f0e6" ${stroke(2)}/>` : '';
    return g(`
      <path d="M-46 -40 L-60 -100 L-20 -56 Z M46 -40 L60 -100 L20 -56 Z" fill="${fur}" ${stroke(3)}/>
      <path d="M-44 -50 L-52 -84 L-30 -58 Z M44 -50 L52 -84 L30 -58 Z" fill="#5a2a3a"/>
      <path d="M-52 -30 C-56 -70 56 -70 52 -30 C56 0 40 20 34 34 L-34 34 C-40 20 -56 0 -52 -30 Z" fill="${fur}" ${stroke(3)}/>
      <path d="M-30 10 C-30 -6 30 -6 30 10 L32 44 C20 54 -20 54 -32 44 Z" fill="#2c2632" ${stroke(3)}/>
      ${teeth}
      <ellipse cx="0" cy="10" rx="13" ry="9" fill="#0a080c" ${stroke(2)}/>
      ${eyesS}`, `translate(${hx} ${hy}) rotate(${a}) scale(${hsc})`);
  };
  const snakeMane = (cx, cy, rr, seed) => {
    const r = rng(seed);
    let s = '';
    for (let i = 0; i < 9; i++) {
      const a = Math.PI * (1.05 + (i / 8) * 0.9);
      const sx = cx + Math.cos(a) * rr, sy = cy + Math.sin(a) * rr;
      const deg = (a * 180) / Math.PI + 90 + (r() - 0.5) * 30;
      s += g(`<path d="M0 0 C8 -12 -8 -22 0 -36" fill="none" stroke="${OL}" stroke-width="11" stroke-linecap="round"/>
        <path d="M0 0 C8 -12 -8 -22 0 -36" fill="none" stroke="#3f8a3a" stroke-width="6" stroke-linecap="round"/>
        <ellipse cx="0" cy="-40" rx="6" ry="8" fill="#56a24a" ${stroke(2)}/>`, `translate(${sx.toFixed(0)} ${sy.toFixed(0)}) rotate(${deg.toFixed(0)})`);
    }
    return s;
  };
  const tail = `<path d="M150 -60 C260 -80 280 -200 220 -260" fill="none" stroke="${OL}" stroke-width="30" stroke-linecap="round"/>
    <path d="M150 -60 C260 -80 280 -200 220 -260" fill="none" stroke="#3f8a3a" stroke-width="22" stroke-linecap="round"/>
    <path d="M200 -262 C206 -300 250 -300 248 -264 C246 -246 214 -244 200 -262 Z" fill="#56a24a" ${stroke(3)}/>
    <circle cx="232" cy="-272" r="3.5" fill="#ffde5a"/>`;
  if (asleep) {
    return place(x, y, sc, `
      <path d="M-260 0 C-280 -120 -160 -190 0 -190 C160 -190 280 -120 260 0 Z" fill="${fur}" ${stroke(4)}/>
      <path d="M-120 -160 C-60 -180 60 -180 120 -160" fill="none" stroke="#3a3440" stroke-width="5"/>
      <path d="M180 -40 C260 -30 300 -10 280 0" fill="none" stroke="${OL}" stroke-width="26" stroke-linecap="round"/>
      <path d="M180 -40 C260 -30 300 -10 280 0" fill="none" stroke="#3f8a3a" stroke-width="18" stroke-linecap="round"/>
      ${headSvg(-170, -60, -8, 0.9, false)}${headSvg(0, -80, 0, 1, false)}${headSvg(170, -60, 8, 0.9, false)}
      <path d="M-240 0 L-160 -30 L-80 0 M80 0 L160 -30 L240 0" fill="${fur}" ${stroke(3)}/>
      <text x="40" y="-200" font-family="Georgia" font-size="40" fill="#cfd8ff" opacity="0.8">z</text>
      <text x="80" y="-240" font-family="Georgia" font-size="54" fill="#cfd8ff" opacity="0.7">z</text>`, flip);
  }
  return place(x, y, sc, `
    ${tail}
    <path d="M-170 0 C-200 -140 -170 -300 0 -310 C170 -300 200 -140 170 0 Z" fill="${fur}" ${stroke(4)}/>
    <path d="M-120 0 L-110 -150 L-60 -150 L-70 0 Z M70 0 L60 -150 L110 -150 L120 0 Z" fill="#26202c" ${stroke(3)}/>
    <path d="M-130 0 C-130 -20 -50 -20 -50 0 Z M50 0 C50 -20 130 -20 130 0 Z" fill="#2c2632" ${stroke(3)}/>
    <path d="M-120 -240 C-60 -270 60 -270 120 -240 L110 -210 C60 -236 -60 -236 -110 -210 Z" fill="#5a5660" ${stroke(3)}/>
    ${[-90, -30, 30, 90].map((sx) => `<path d="M${sx - 8} -248 L${sx} -272 L${sx + 8} -248 Z" fill="#a8a4ae" ${stroke(2)}/>`).join('')}
    <path d="M-110 -260 C-150 -330 -190 -360 -210 -380 L-150 -410 C-120 -370 -90 -320 -70 -280 Z" fill="${fur}" ${stroke(3)}/>
    <path d="M110 -260 C150 -330 190 -360 210 -380 L150 -410 C120 -370 90 -320 70 -280 Z" fill="${fur}" ${stroke(3)}/>
    <path d="M-50 -290 L-50 -400 L50 -400 L50 -290 Z" fill="${fur}" ${stroke(3)}/>
    ${snakeMane(-190, -400, 70, 3)}${snakeMane(0, -440, 76, 5)}${snakeMane(190, -400, 70, 7)}
    ${headSvg(-190, -400, -14, 1.05, false)}${headSvg(190, -400, 14, 1.05, false)}${headSvg(0, -440, 0, 1.2, true)}`, flip);
}

// ---------------------------------------------------------------- props

function pomegranate(x, y, sc = 1, o = {}) {
  const { split = false, missing = 0 } = o;
  if (!split) return at(x, y, sc, `<circle cx="0" cy="0" r="40" fill="#b8283a" ${stroke(3)}/><path d="M-10 -40 L-14 -54 L-4 -46 L0 -58 L4 -46 L14 -54 L10 -40 Z" fill="#8a1a28" ${stroke(2.5)}/><ellipse cx="-14" cy="-14" rx="10" ry="6" fill="#ff8a8a" opacity="0.5"/>`);
  let seeds = '';
  const pts = [[-22, -6], [-8, -14], [8, -14], [22, -6], [-26, 8], [-12, 4], [4, 2], [18, 6], [-16, 20], [0, 18], [14, 20], [-4, -2], [26, 18], [-28, -18], [28, -18], [-2, 30]];
  pts.forEach(([sx, sy], i) => {
    if (i < missing) seeds += `<ellipse cx="${sx}" cy="${sy}" rx="5" ry="6" fill="#f4e2c8" opacity="0.9"/>`;
    else seeds += `<ellipse cx="${sx}" cy="${sy}" rx="6" ry="7" fill="#e8243c" ${stroke(1.5, '#6a0a18')}/><circle cx="${sx - 2}" cy="${sy - 2}" r="2" fill="#ffd0d8"/>`;
  });
  return at(x, y, sc, `
    <path d="M-48 0 C-48 -50 48 -50 48 0 C48 40 -48 40 -48 0 Z" fill="#b8283a" ${stroke(3)}/>
    <ellipse cx="0" cy="2" rx="40" ry="34" fill="#f4e2c8" ${stroke(2.5)}/>${seeds}
    <path d="M-12 -44 L-14 -58 L-4 -50 L0 -62 L4 -50 L14 -58 L12 -44" fill="#8a1a28" ${stroke(2.5)}/>`);
}

function flask(x, y, sc = 1, o = {}) {
  const { sealed = false, full = false, frost = false } = o;
  return at(x, y, sc, `
    ${frost ? glow(0, -60, 110, '#dff2ff', 0.55) : ''}
    <path d="M-16 -110 L16 -110 L16 -84 C50 -74 64 -44 60 -14 C56 20 30 34 0 34 C-30 34 -56 20 -60 -14 C-64 -44 -50 -74 -16 -84 Z" fill="#c27a4a" ${stroke(3.5)}/>
    <path d="M-50 -20 Q0 -4 50 -20" stroke="#8a4a26" stroke-width="5" fill="none"/>
    <path d="M-44 -40 L-30 -52 L-16 -40 L-2 -52 L12 -40 L26 -52 L40 -40" stroke="#f0d8a8" stroke-width="3" fill="none"/>
    <ellipse cx="-26" cy="-46" rx="10" ry="16" fill="#e8a678" opacity="0.6"/>
    ${full ? `<ellipse cx="0" cy="-108" rx="16" ry="5" fill="#c9ccd0"/>` : `<ellipse cx="0" cy="-110" rx="16" ry="5" fill="#3a2010" ${stroke(2)}/>`}
    ${sealed ? `<path d="M-22 -112 C-24 -128 24 -128 22 -112 L24 -96 C10 -90 -10 -90 -24 -96 Z" fill="#5a1a2a" ${stroke(3)}/>
      <circle cx="0" cy="-110" r="10" fill="#7a2a3a" ${stroke(2)}/>
      ${[0, 72, 144, 216, 288].map((a) => `<ellipse cx="0" cy="-116" rx="2.6" ry="5" fill="#d8a0b0" transform="rotate(${a} 0 -110)"/>`).join('')}` : ''}
    ${frost ? `<path d="M-40 -130 c-6 -20 8 -30 0 -50 M10 -136 c-6 -20 8 -30 0 -50 M44 -124 c-6 -20 8 -30 0 -50" stroke="#e6f4ff" stroke-width="5" fill="none" stroke-linecap="round" opacity="0.7"/>` : ''}`);
}

function bowl(x, y, sc = 1, o = {}) {
  const { ember = false, out = false, tipped = false } = o;
  const inner = ember && !out ? glow(0, -40, 120, '#ffb43a', 0.7) + `<ellipse cx="0" cy="-34" rx="22" ry="16" fill="#fff6c8" ${stroke(2.5, '#c84a10')}/><ellipse cx="0" cy="-34" rx="12" ry="8" fill="#ffffff"/>` +
    flame(0, -40, 34, 60) : out ? `<ellipse cx="0" cy="-32" rx="16" ry="10" fill="#3a2a22" ${stroke(2)}/><path d="M0 -42 c-10 -20 10 -30 0 -60" stroke="#8a8a8a" stroke-width="4" fill="none" opacity="0.6"/>` : '';
  const b = `
    <path d="M-80 -30 L80 -30 C76 10 40 30 0 30 C-40 30 -76 10 -80 -30 Z" fill="#c08a4a" ${stroke(3.5)}/>
    <ellipse cx="0" cy="-30" rx="80" ry="16" fill="#8a5a2a" ${stroke(3)}/>
    <path d="M-66 -6 Q0 14 66 -6" stroke="#e0b070" stroke-width="4" fill="none"/>
    <path d="M-20 30 L-26 44 L26 44 L20 30" fill="#a8743a" ${stroke(3)}/>`;
  return at(x, y, sc, tipped ? g(b + inner, 'rotate(-70)') : b + inner);
}

function bough(x, y, sc = 1, deg = 0, o = {}) {
  const { glowOn = true } = o;
  let leaves = '';
  const pts = [[30, -10, -40], [60, -30, 30], [90, -24, -30], [120, -46, 40], [150, -40, -20], [180, -60, 30], [200, -54, -10], [70, 6, 60], [130, -14, 60], [170, -24, 70], [215, -72, 10]];
  for (const [lx, ly, a] of pts) leaves += g(`<path d="M0 0 C10 -12 30 -12 42 0 C30 12 10 12 0 0 Z" fill="#ffd34a" ${stroke(2.5, '#7a5210')}/><path d="M2 0 L38 0" stroke="#c8920a" stroke-width="2"/>`, `translate(${lx} ${ly}) rotate(${a})`);
  return (glowOn ? glow(x + 100 * sc, y - 30 * sc, 200 * sc, '#ffe27a', 0.5) : '') + g(`
    <path d="M0 0 C60 -10 120 -30 220 -70" fill="none" stroke="#7a5210" stroke-width="14" stroke-linecap="round"/>
    <path d="M0 0 C60 -10 120 -30 220 -70" fill="none" stroke="#f2b833" stroke-width="8" stroke-linecap="round"/>
    <path d="M100 -24 L150 -2 M60 -12 L80 20" stroke="#f2b833" stroke-width="6" stroke-linecap="round"/>
    ${leaves}
    ${sparks(77, 10, 0, -100, 230, 20, '#fff6c0', 3)}`, `translate(${x} ${y}) rotate(${deg}) scale(${sc})`);
}

function coin(x, y, sc = 1) {
  return at(x, y, sc, `<circle cx="0" cy="0" r="16" fill="#ffd34a" ${stroke(3)}/><circle cx="0" cy="0" r="8" fill="none" stroke="#c89412" stroke-width="2.5"/>`);
}

// ---------------------------------------------------------------- scenery

function column(x, yTop, yBot, w = 70, o = {}) {
  const { col = '#ece4d6', shade = '#c9bea8', broken = false } = o;
  let flutes = '';
  for (let i = 1; i < 5; i++) flutes += `<path d="M${x - w / 2 + (w * i) / 5} ${yTop + 34} L${x - w / 2 + (w * i) / 5} ${yBot - 24}" stroke="${shade}" stroke-width="3"/>`;
  return `<rect x="${x - w / 2}" y="${yTop + 30}" width="${w}" height="${yBot - yTop - 50}" fill="${col}" ${stroke(3)}/>
    <rect x="${x + w * 0.18}" y="${yTop + 30}" width="${w * 0.32}" height="${yBot - yTop - 50}" fill="${shade}" opacity="0.6"/>
    ${flutes}
    ${broken ? `<path d="M${x - w / 2} ${yTop + 30} L${x - w / 4} ${yTop + 10} L${x} ${yTop + 34} L${x + w / 4} ${yTop + 14} L${x + w / 2} ${yTop + 30}" fill="${col}" ${stroke(3)}/>`
    : `<path d="M${x - w * 0.7} ${yTop} L${x + w * 0.7} ${yTop} L${x + w * 0.62} ${yTop + 16} L${x - w * 0.62} ${yTop + 16} Z" fill="${col}" ${stroke(3)}/>
      <path d="M${x - w * 0.6} ${yTop + 16} C${x - w * 0.55} ${yTop + 30} ${x + w * 0.55} ${yTop + 30} ${x + w * 0.6} ${yTop + 16}" fill="${col}" ${stroke(3)}/>`}
    <rect x="${x - w * 0.66}" y="${yBot - 22}" width="${w * 1.32}" height="22" fill="${col}" ${stroke(3)}/>`;
}

function cypress(x, y, h, o = {}) {
  const { col = '#1f3a2a', dark = '#12261a', w = h * 0.22 } = o;
  return `<path d="M${x - 8} ${y} L${x - 6} ${y - h * 0.1} L${x + 6} ${y - h * 0.1} L${x + 8} ${y} Z" fill="#4a2e1a" ${stroke(3)}/>
    <path d="M${x} ${y - h} C${x + w * 0.3} ${y - h * 0.8} ${x + w * 0.6} ${y - h * 0.5} ${x + w * 0.5} ${y - h * 0.25} C${x + w * 0.45} ${y - h * 0.1} ${x + w * 0.2} ${y - h * 0.06} ${x} ${y - h * 0.06}
      C${x - w * 0.2} ${y - h * 0.06} ${x - w * 0.45} ${y - h * 0.1} ${x - w * 0.5} ${y - h * 0.25} C${x - w * 0.6} ${y - h * 0.5} ${x - w * 0.3} ${y - h * 0.8} ${x} ${y - h} Z" fill="${col}" ${stroke(3)}/>
    <path d="M${x + w * 0.1} ${y - h * 0.85} C${x + w * 0.35} ${y - h * 0.6} ${x + w * 0.4} ${y - h * 0.4} ${x + w * 0.3} ${y - h * 0.15}" fill="none" stroke="${dark}" stroke-width="${Math.max(3, w * 0.12)}" opacity="0.7"/>`;
}

function poplar(x, y, h, col = '#b8c4cc') {
  return cypress(x, y, h, { col, dark: '#7e8a96', w: h * 0.3 });
}

function oliveTree(x, y, sc = 1, o = {}) {
  const { leaf = '#7a9a4a', fruit = null } = o;
  let blobs = '';
  for (const [bx, by, br] of [[-90, -230, 70], [-20, -270, 85], [70, -240, 75], [-60, -180, 60], [40, -190, 65], [110, -190, 50], [-120, -170, 45]])
    blobs += `<circle cx="${bx}" cy="${by}" r="${br}" fill="${leaf}" ${stroke(3)}/>`;
  let f = '';
  if (fruit) {
    const r = rng(9);
    for (let i = 0; i < 14; i++) f += `<circle cx="${(r() * 240 - 130).toFixed(0)}" cy="${(-160 - r() * 140).toFixed(0)}" r="9" fill="${fruit}" ${stroke(2)}/>`;
  }
  return at(x, y, sc, `
    <path d="M-20 0 C-14 -60 -30 -110 -10 -170 L14 -170 C4 -110 30 -60 22 0 Z" fill="#6a4a2a" ${stroke(3)}/>
    <path d="M0 -140 L-60 -190 M6 -150 L60 -200" stroke="#6a4a2a" stroke-width="12" stroke-linecap="round"/>
    ${blobs}
    <path d="M-60 -250 Q-20 -280 20 -260 M30 -210 Q70 -230 100 -210" stroke="#a8c070" stroke-width="5" fill="none" opacity="0.6"/>${f}`);
}

function asphodel(x, y, sc = 1, col = '#f2efe6', op = 1) {
  let flowers = '';
  for (const [fx, fy] of [[0, -96], [-10, -80], [10, -74], [-4, -62], [8, -52]]) {
    let petals = '';
    for (let i = 0; i < 6; i++) petals += `<ellipse cx="0" cy="-7" rx="3.5" ry="7" fill="${col}" transform="rotate(${i * 60})"/>`;
    flowers += `<g transform="translate(${fx} ${fy})">${petals}<circle r="2.5" fill="#d8b04a"/></g>`;
  }
  return at(x, y, sc, `<g opacity="${op}"><path d="M0 0 L0 -96" stroke="#6a7a5a" stroke-width="4"/>
    <path d="M0 0 C-20 -20 -24 -40 -26 -54 M0 0 C18 -18 22 -36 26 -46" stroke="#6a7a5a" stroke-width="4" fill="none"/>${flowers}</g>`);
}

function asphodelField(seed, n, y0, y1, o = {}) {
  const { col = '#f2efe6', op = 1, x0 = -20, x1 = 1020, scale = [0.25, 1.1], skip = null } = o;
  const r = rng(seed);
  const items = [];
  for (let i = 0; i < n; i++) {
    const t = Math.pow(r(), 1.3);
    const y = y0 + (y1 - y0) * t;
    const x = x0 + r() * (x1 - x0);
    if (skip && skip(x, y)) continue;
    items.push([x, y, scale[0] + (scale[1] - scale[0]) * t]);
  }
  items.sort((a, b) => a[1] - b[1]);
  return items.map(([x, yy, s]) => asphodel(x, yy, s, col, op)).join('');
}

function grass(seed, n, y0, y1, col = '#4a7a3a', o = {}) {
  const { x0 = 0, x1 = 1000, h = 30 } = o;
  const r = rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) {
    const t = r();
    const x = x0 + r() * (x1 - x0), y = y0 + (y1 - y0) * t, hh = h * (0.4 + t);
    s += `<path d="M${x.toFixed(0)} ${y.toFixed(0)} l-4 ${(-hh).toFixed(0)} M${x.toFixed(0)} ${y.toFixed(0)} l6 ${(-hh * 0.8).toFixed(0)}" stroke="${col}" stroke-width="3" stroke-linecap="round"/>`;
  }
  return s;
}

function boatHull(x, y, w = 420, sc = 1, flip = false) {
  return place(x, y, sc, `
    <path d="M${-w / 2} -40 L${w / 2} -40 C${w / 2 - 20} 0 ${w / 2 - 60} 16 ${w / 2 - 90} 20 L${-w / 2 + 70} 20 C${-w / 2 + 30} 14 ${-w / 2 + 6} -10 ${-w / 2} -40 Z" fill="#17131c" ${stroke(4)}/>
    <path d="M${-w / 2 + 20} -24 L${w / 2 - 20} -24" stroke="#3a3044" stroke-width="5"/>
    <path d="M${w / 2} -40 C${w / 2 + 30} -60 ${w / 2 + 34} -90 ${w / 2 + 20} -100" fill="none" stroke="#17131c" stroke-width="14" stroke-linecap="round"/>
    ${glow(w / 2 + 20, -110, 50, '#ffb43a', 0.6)}<circle cx="${w / 2 + 20}" cy="-106" r="9" fill="#ffd27a" ${stroke(2)}/>`, flip);
}

function ironGate(x, y, w, h, o = {}) {
  const { open = 0 } = o;
  let bars = '';
  const n = 9;
  for (let i = 0; i <= n; i++) {
    const bx = x - w / 2 + (w * i) / n;
    bars += `<rect x="${bx - 7}" y="${y - h}" width="14" height="${h}" fill="#26222e" ${stroke(3)}/>
      <path d="M${bx - 12} ${y - h} L${bx} ${y - h - 34} L${bx + 12} ${y - h} Z" fill="#3a3444" ${stroke(3)}/>`;
  }
  const mid = open ? `<rect x="${x - w * 0.16}" y="${y - h}" width="${w * 0.32}" height="${h}" fill="#0a0812"/>` : '';
  return `${bars}${mid}
    <rect x="${x - w / 2 - 10}" y="${y - h * 0.82}" width="${w + 20}" height="18" fill="#3a3444" ${stroke(3)}/>
    <rect x="${x - w / 2 - 10}" y="${y - h * 0.2}" width="${w + 20}" height="18" fill="#3a3444" ${stroke(3)}/>
    <rect x="${x - w / 2 - 50}" y="${y - h - 40}" width="50" height="${h + 40}" fill="#1e1a26" ${stroke(3)}/>
    <rect x="${x + w / 2}" y="${y - h - 40}" width="50" height="${h + 40}" fill="#1e1a26" ${stroke(3)}/>`;
}

function waves(seed, y0, y1, col, hi, n = 30) {
  const r = rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) {
    const t = r();
    const y = y0 + (y1 - y0) * t;
    const x = r() * 1100 - 50;
    const w = 40 + t * 140;
    s += `<path d="M${(x - w / 2).toFixed(0)} ${y.toFixed(0)} q${(w / 4).toFixed(0)} ${(-w / 6).toFixed(0)} ${(w / 2).toFixed(0)} 0 t${(w / 2).toFixed(0)} 0" fill="none" stroke="${i % 3 ? col : hi}" stroke-width="${(2 + t * 4).toFixed(1)}" stroke-linecap="round" opacity="0.7"/>`;
  }
  return s;
}

// First-person staircase receding upward to a vanishing point.
function stairsUp(vx, vy, o = {}) {
  const { n = 14, top = '#3a3448', riser = '#241e30', wall = '#16121e', lit = null } = o;
  let s = `<rect width="1000" height="1000" fill="${wall}"/>`;
  s += `<polygon points="0,1000 ${vx - 40},${vy} ${vx + 40},${vy} 1000,1000" fill="${riser}"/>`;
  for (let i = 0; i < n; i++) {
    const t0 = Math.pow(i / n, 0.55), t1 = Math.pow((i + 0.5) / n, 0.55);
    const y0 = 1000 + (vy - 1000) * t0, y1 = 1000 + (vy - 1000) * t1;
    const hw0 = 520 + (40 - 520) * t0, hw1 = 520 + (40 - 520) * t1;
    s += `<polygon points="${vx - hw0},${y0} ${vx + hw0},${y0} ${vx + hw1},${y1} ${vx - hw1},${y1}" fill="${top}" ${stroke(2.5)}/>`;
  }
  s += `<polygon points="0,0 ${vx - 40},${vy - 60} ${vx - 40},${vy} 0,1000" fill="${wall}" ${stroke(3)}/>`;
  s += `<polygon points="1000,0 ${vx + 40},${vy - 60} ${vx + 40},${vy} 1000,1000" fill="${wall}" ${stroke(3)}/>`;
  if (lit) s += glow(vx, vy - 30, 260, lit, 0.7);
  return s;
}

// Distant cliffs / rock band.
function rocks(d, top = '#2a2a34', bottom = '#16161e') {
  return shape(d, top, bottom, 4);
}

function svg(content, bg = '#000') {
  gid = 0;
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000" width="1254" height="1254">
    <rect width="1000" height="1000" fill="${bg}"/>${content}</svg>`;
}

module.exports = {
  OL, uid, rng, stroke, g, at, rot, fade, place, linGrad, radGrad, blur, clip, glow, ellipseGlow, vignette, wash, sky, shape,
  fog, stars, sparks, lightBeam, rain, flame, flamePath, brazier,
  SKIN, figure, seatedFigure, hand, PLAYER_SLEEVE,
  theo, theoSitting, hermes, charon, persephone, hades, throne, fury, sisyphus, boulder, achilles, sibyl, judge, shade, shadeCrowd, cerberus,
  pomegranate, flask, bowl, bough, coin,
  column, cypress, poplar, oliveTree, asphodel, asphodelField, grass, boatHull, ironGate, waves, stairsUp, rocks, svg,
};
