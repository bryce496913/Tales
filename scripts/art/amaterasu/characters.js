// Characters and creatures for The Cave of Amaterasu page art.
// People stand with their feet at (x, y); at scale 1 they are about 290 px tall.
'use strict';
const L = require('./lib');
const { OUT, g, lg, rg, glow, shape } = L;

const SKIN = '#f2c9a0';
const HAIR = '#2a2230';

function arm(p0, p1, p2, sleeve, skin, wide, w = 20) {
  const [sx, sy] = p0, [ex, ey] = p1, [hx, hy] = p2;
  let s = '';
  if (wide) s += `<path d="M${sx} ${sy - 8}L${ex} ${ey - 6}L${ex + (ex - sx) * 0.15} ${ey + 46}Q${(sx + ex) / 2} ${Math.max(sy, ey) + 50} ${sx - Math.sign(sx) * 6} ${sy + 46}Z" fill="${sleeve}" stroke="${OUT}" stroke-width="3"/>`;
  s += `<path d="M${sx} ${sy}L${ex} ${ey}L${hx} ${hy}" stroke="${OUT}" stroke-width="${w + 6}" fill="none"/><path d="M${sx} ${sy}L${ex} ${ey}L${hx} ${hy}" stroke="${sleeve}" stroke-width="${w}" fill="none"/>`;
  s += `<circle cx="${hx}" cy="${hy}" r="${w * 0.6}" fill="${skin}" stroke="${OUT}" stroke-width="2.5"/>`;
  return s;
}

function eyes(type, col = OUT) {
  const E = [-15, 15];
  switch (type) {
    case 'closed': return E.map((x) => `<path d="M${x - 8} -230q8 6 16 0" stroke="${OUT}" stroke-width="3" fill="none"/>`).join('');
    case 'happy': return E.map((x) => `<path d="M${x - 8} -228q8 -9 16 0" stroke="${OUT}" stroke-width="3.5" fill="none"/>`).join('');
    case 'blank': return E.map((x) => `<ellipse cx="${x}" cy="-232" rx="7" ry="8" fill="#e8eef4" stroke="${OUT}" stroke-width="2"/>`).join('');
    case 'sly': return E.map((x) => `<ellipse cx="${x}" cy="-231" rx="6" ry="5" fill="${col}"/><path d="M${x - 9} -234L${x + 9} -236" stroke="${OUT}" stroke-width="3.5"/>`).join('');
    case 'glow': return E.map((x) => `<ellipse cx="${x}" cy="-232" rx="7" ry="8" fill="#ffe680" stroke="${OUT}" stroke-width="2"/><circle cx="${x}" cy="-232" r="2.5" fill="${OUT}"/>`).join('');
    case 'red': return E.map((x) => `<ellipse cx="${x}" cy="-232" rx="7" ry="7" fill="#ff3a2a" stroke="${OUT}" stroke-width="2"/>`).join('');
    case 'wide': return E.map((x) => `<ellipse cx="${x}" cy="-232" rx="8" ry="9" fill="#fff" stroke="${OUT}" stroke-width="2"/><circle cx="${x}" cy="-231" r="4" fill="${col}"/>`).join('');
    case 'sad': return E.map((x, i) => `<ellipse cx="${x}" cy="-230" rx="5.5" ry="7" fill="${col}"/><circle cx="${x + 2}" cy="-233" r="1.8" fill="#fff"/><path d="M${x - 9} ${i ? -245 : -241}L${x + 9} ${i ? -241 : -245}" stroke="${OUT}" stroke-width="3"/>`).join('') + `<path d="M-18 -222q-3 10 0 14M18 -222q3 10 0 14" stroke="#7ac0ff" stroke-width="3" fill="none"/>`;
    case 'stern': return E.map((x, i) => `<ellipse cx="${x}" cy="-231" rx="5.5" ry="6.5" fill="${col}"/><circle cx="${x + 2}" cy="-234" r="1.8" fill="#fff"/><path d="M${x - 10} ${i ? -246 : -241}L${x + 10} ${i ? -241 : -246}" stroke="${OUT}" stroke-width="4"/>`).join('');
    default: return E.map((x) => `<ellipse cx="${x}" cy="-231" rx="5.5" ry="7" fill="${col}"/><circle cx="${x + 2}" cy="-234" r="2" fill="#fff"/>`).join('');
  }
}
function mouth(type) {
  switch (type) {
    case 'smile': return `<path d="M-9 -212q9 8 18 0" stroke="${OUT}" stroke-width="3" fill="none"/>`;
    case 'grin': return `<path d="M-13 -214q13 14 26 0Z" fill="#8a2a2a" stroke="${OUT}" stroke-width="2.5"/><path d="M-10 -213l20 0" stroke="#fff" stroke-width="3"/>`;
    case 'laugh': return `<path d="M-15 -216q15 22 30 0Z" fill="#8a2a2a" stroke="${OUT}" stroke-width="2.5"/><ellipse cx="0" cy="-206" rx="7" ry="3.5" fill="#e87a7a"/>`;
    case 'open': case 'o': return `<ellipse cx="0" cy="-210" rx="6" ry="8" fill="#5a1e1e" stroke="${OUT}" stroke-width="2.5"/>`;
    case 'frown': return `<path d="M-9 -207q9 -7 18 0" stroke="${OUT}" stroke-width="3" fill="none"/>`;
    case 'none': return '';
    default: return `<path d="M-7 -211l14 0" stroke="${OUT}" stroke-width="3"/>`;
  }
}

function hairBack(style, col, back) {
  switch (style) {
    case 'long': return `<path d="M-46 -250Q-62 -150 -70 -90Q0 -70 70 -90Q62 -150 46 -250Z" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    case 'wavy': return `<path d="M-46 -255Q-80 -200 -66 -150Q-90 -110 -70 -60Q0 -40 70 -60Q90 -110 66 -150Q80 -200 46 -255Z" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    case 'wild': return `<path d="M-50 -270L-80 -260L-66 -230L-96 -200L-70 -180L-90 -140L-55 -150L-30 -130L0 -150L30 -130L55 -150L90 -140L70 -180L96 -200L66 -230L80 -260L50 -270Z" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    case 'tied': return back ? `<path d="M-4 -238Q8 -210 2 -180" stroke="${OUT}" stroke-width="14" fill="none"/><path d="M-4 -238Q8 -210 2 -180" stroke="${col}" stroke-width="9" fill="none"/>` : '';
    case 'loose': return `<path d="M-44 -250Q-56 -180 -52 -150L52 -150Q56 -180 44 -250Z" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    default: return '';
  }
}
function hairFront(style, col, back) {
  if (style === 'bald' || style === 'none') return '';
  if (back) {
    let s = `<circle cx="0" cy="-232" r="41" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    if (style === 'tied') s += `<circle cx="0" cy="-250" r="8" fill="#c8302a" stroke="${OUT}" stroke-width="2"/><path d="M-1 -246Q6 -215 2 -190" stroke="${OUT}" stroke-width="12" fill="none"/><path d="M-1 -246Q6 -215 2 -190" stroke="${col}" stroke-width="7" fill="none"/>`;
    if (style === 'bun') s += `<circle cx="0" cy="-270" r="16" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    return s;
  }
  switch (style) {
    case 'bun': return `<path d="M-41 -232Q-44 -276 0 -276Q44 -276 41 -232Q30 -258 0 -258Q-30 -258 -41 -232Z" fill="${col}" stroke="${OUT}" stroke-width="3"/><circle cx="0" cy="-284" r="16" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    case 'loops': return `<circle cx="-46" cy="-246" r="16" fill="none" stroke="${OUT}" stroke-width="11"/><circle cx="-46" cy="-246" r="16" fill="none" stroke="${col}" stroke-width="6"/><circle cx="46" cy="-246" r="16" fill="none" stroke="${OUT}" stroke-width="11"/><circle cx="46" cy="-246" r="16" fill="none" stroke="${col}" stroke-width="6"/><path d="M-41 -232Q-44 -276 0 -276Q44 -276 41 -232Q20 -262 -4 -250Q-24 -262 -41 -232Z" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    case 'wild': return `<path d="M-44 -228L-50 -262L-30 -252L-24 -282L-6 -262L8 -288L20 -260L40 -276L36 -250L50 -238L42 -230Q30 -252 0 -250Q-30 -252 -44 -228Z" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
    default: return `<path d="M-42 -226Q-46 -276 0 -276Q46 -276 42 -226Q36 -246 18 -252Q4 -238 -12 -252Q-30 -246 -42 -226Z" fill="${col}" stroke="${OUT}" stroke-width="3"/>`;
  }
}

function hat(type) {
  switch (type) {
    case 'eboshi': return `<path d="M-24 -262L-30 -330Q-6 -350 18 -330L24 -262Z" fill="#1e1a22" stroke="${OUT}" stroke-width="3"/><path d="M-36 -262L36 -262" stroke="${OUT}" stroke-width="6"/>`;
    case 'tokin': return `<path d="M-14 -268L-16 -292L0 -300L16 -292L14 -268Z" fill="#1a1418" stroke="${OUT}" stroke-width="3"/><path d="M-14 -264L14 -264" stroke="#c83a2a" stroke-width="4"/>`;
    case 'crown': {
      let s = '';
      for (let i = 0; i < 9; i++) { const a = Math.PI + (i / 8) * Math.PI; s += `<path d="M${Math.cos(a - 0.06) * 46} ${-262 + Math.sin(a - 0.06) * 46}L${Math.cos(a) * 92} ${-262 + Math.sin(a) * 92}L${Math.cos(a + 0.06) * 46} ${-262 + Math.sin(a + 0.06) * 46}Z" fill="#f4c43a" stroke="${OUT}" stroke-width="2.5"/>`; }
      s += `<path d="M-44 -262A44 44 0 0 1 44 -262Z" fill="#f4c43a" stroke="${OUT}" stroke-width="3"/><circle cx="0" cy="-280" r="12" fill="#ffe680" stroke="${OUT}" stroke-width="2.5"/>`;
      for (const x of [-42, 42]) s += `<circle cx="${x}" cy="-250" r="10" fill="#f4c43a" stroke="${OUT}" stroke-width="2.5"/><path d="M${x} -240L${x} -200" stroke="#d8402a" stroke-width="6"/>`;
      return s;
    }
    case 'hood': return `<path d="M-52 -200Q-62 -290 0 -292Q62 -290 52 -200Q40 -170 0 -165Q-40 -170 -52 -200Z" fill="#f6f4ee" stroke="${OUT}" stroke-width="3"/><path d="M-38 -210Q-40 -268 0 -270Q40 -268 38 -210Q20 -190 0 -192Q-20 -190 -38 -210Z" fill="#e6e2d8"/>`;
    case 'kasa': return `<path d="M-70 -258L0 -300L70 -258Q0 -248 -70 -258Z" fill="#c8a868" stroke="${OUT}" stroke-width="3"/><path d="M-40 -268L0 -296L40 -268" stroke="#8a6a3a" stroke-width="2" fill="none"/>`;
    case 'horns': return `<path d="M-26 -266L-34 -300L-14 -270ZM26 -266L34 -300L14 -270Z" fill="#f0e8d0" stroke="${OUT}" stroke-width="3"/>`;
    case 'comb': return `<path d="M-30 -268Q0 -284 30 -268L28 -258L-28 -258Z" fill="#a8743a" stroke="${OUT}" stroke-width="2.5"/>`;
    case 'leaves': return [-34, -12, 12, 34].map((x, i) => `<ellipse cx="${x}" cy="-272" rx="7" ry="15" fill="#3e8a4a" stroke="${OUT}" stroke-width="2" transform="rotate(${(i - 1.5) * 25} ${x} -272)"/>`).join('');
    case 'coral': return `<path d="M0 -270L-10 -300M0 -280L12 -304M-6 -290L-20 -300M6 -292L20 -296" stroke="${OUT}" stroke-width="9"/><path d="M0 -270L-10 -300M0 -280L12 -304M-6 -290L-20 -300M6 -292L20 -296" stroke="#ff7a6a" stroke-width="5"/><circle cx="0" cy="-268" r="7" fill="#f4f0ff" stroke="${OUT}" stroke-width="2"/>`;
    case 'straw': return `<ellipse cx="0" cy="-262" rx="66" ry="14" fill="#c8a868" stroke="${OUT}" stroke-width="3"/><path d="M-30 -264Q0 -304 30 -264" fill="#c8a868" stroke="${OUT}" stroke-width="3"/>`;
    case 'helmet': return `<path d="M-46 -236Q-50 -290 0 -292Q50 -290 46 -236L60 -230L-60 -230Z" fill="#3a3040" stroke="${OUT}" stroke-width="3"/><path d="M-20 -286L-34 -320M20 -286L34 -320" stroke="#d8a840" stroke-width="6"/>`;
    default: return '';
  }
}

function headShape(o) {
  const { skin = SKIN, head = 'human', back = false } = o;
  if (head === 'crow') {
    return `<circle cx="0" cy="-232" r="38" fill="#1e1c28" stroke="${OUT}" stroke-width="3"/>` + (back ? '' :
      `<path d="M-16 -224L0 -180L16 -224Z" fill="#e0a020" stroke="${OUT}" stroke-width="3"/><path d="M-12 -212L12 -212" stroke="${OUT}" stroke-width="2"/><circle cx="-16" cy="-240" r="8" fill="#ffd040" stroke="${OUT}" stroke-width="2"/><circle cx="16" cy="-240" r="8" fill="#ffd040" stroke="${OUT}" stroke-width="2"/><circle cx="-15" cy="-240" r="3.5" fill="${OUT}"/><circle cx="17" cy="-240" r="3.5" fill="${OUT}"/>`);
  }
  if (head === 'fox') {
    return `<path d="M-38 -250L-46 -300L-12 -266ZM38 -250L46 -300L12 -266Z" fill="#fbfaf6" stroke="${OUT}" stroke-width="3"/><path d="M-34 -258L-40 -288L-18 -266ZM34 -258L40 -288L18 -266Z" fill="#f2a0a8"/>` +
      `<path d="M-42 -240Q-44 -274 0 -274Q44 -274 42 -240Q40 -214 12 -198L0 -186L-12 -198Q-40 -214 -42 -240Z" fill="#fbfaf6" stroke="${OUT}" stroke-width="3"/>` +
      `<path d="M-28 -244Q-18 -252 -8 -244Q-18 -240 -28 -244ZM28 -244Q18 -252 8 -244Q18 -240 28 -244Z" fill="#f4c43a" stroke="${OUT}" stroke-width="2"/><path d="M-26 -258l10 5M26 -258l-10 5" stroke="#d8402a" stroke-width="3.5"/><ellipse cx="0" cy="-200" rx="6" ry="4" fill="${OUT}"/>`;
  }
  if (head === 'fish') {
    return `<path d="M-40 -232Q-40 -276 0 -278Q46 -276 52 -232Q46 -196 0 -192Q-40 -196 -40 -232Z" fill="${o.fishCol || '#e8804a'}" stroke="${OUT}" stroke-width="3"/><path d="M-2 -276L10 -300L22 -276" fill="${o.fishCol || '#e8804a'}" stroke="${OUT}" stroke-width="2.5"/><circle cx="18" cy="-240" r="11" fill="#fff" stroke="${OUT}" stroke-width="2.5"/><circle cx="20" cy="-240" r="5" fill="${OUT}"/><path d="M34 -214q10 4 16 -2" stroke="${OUT}" stroke-width="3" fill="none"/><path d="M-10 -250q-8 18 0 36M-24 -248q-6 16 0 30" stroke="${OUT}" stroke-width="2" fill="none" opacity="0.5"/>`;
  }
  return `<circle cx="0" cy="-232" r="40" fill="${skin}" stroke="${OUT}" stroke-width="3"/>` + (back ? '' : `<ellipse cx="-40" cy="-230" rx="6" ry="9" fill="${skin}" stroke="${OUT}" stroke-width="2.5"/><ellipse cx="40" cy="-230" rx="6" ry="9" fill="${skin}" stroke="${OUT}" stroke-width="2.5"/>`);
}

// Generic storybook person.
function person(x, y, s, o = {}) {
  const {
    skin = SKIN, robe = '#5a6a9a', robe2 = null, trim = '#f2eadb', sash = '#c8402a', hair = HAIR, hairStyle = 'short', back = false,
    eyes: ey = 'dot', mouth: mo = 'smile', blush = true, beard = null, beardCol = '#e8e4dc', nose = null, hatType = null,
    armL = [[-66, -140], [-58, -92]], armR = [[66, -140], [58, -92]], sleeve = null, wide = true, w = 1, holdL = '', holdR = '',
    wings = null, neck = 0, glowCol = null, flip = false, op = 1, sitting = false, emblem = null, feet = true, head = 'human', fishCol, lightning = false,
  } = o;
  const sl = sleeve || robe;
  let b = '';
  if (glowCol) b += glow(0, -150, 260, glowCol, 0.65);
  if (wings) b += `<path d="M-30 -180Q-180 -300 -230 -150Q-200 -120 -180 -90Q-150 -110 -140 -70Q-100 -100 -40 -110Z" fill="${wings}" stroke="${OUT}" stroke-width="3"/><path d="M30 -180Q180 -300 230 -150Q200 -120 180 -90Q150 -110 140 -70Q100 -100 40 -110Z" fill="${wings}" stroke="${OUT}" stroke-width="3"/><path d="M-60 -170Q-150 -230 -200 -150M60 -170Q150 -230 200 -150" stroke="#4a4a5a" stroke-width="2" fill="none"/>`;
  b += hairBack(hairStyle, hair, back);
  const hem = sitting ? -6 : -14;
  const hw = sitting ? 92 * w : 64 * w;
  if (feet && !sitting) b += `<ellipse cx="-22" cy="-6" rx="17" ry="8" fill="#c8a868" stroke="${OUT}" stroke-width="2.5"/><ellipse cx="22" cy="-6" rx="17" ry="8" fill="#c8a868" stroke="${OUT}" stroke-width="2.5"/>`;
  // robe body
  b += `<path d="M${-46 * w} -190Q${-58 * w} -100 ${-hw} ${hem}Q0 ${hem + 10} ${hw} ${hem}Q${58 * w} -100 ${46 * w} -190Q0 -204 ${-46 * w} -190Z" fill="${lg([robe, shade(robe)], 0, 0, 1, 1)}" stroke="${OUT}" stroke-width="3"/>`;
  if (robe2) b += `<path d="M${-54 * w} -112Q${-60 * w} -60 ${-hw} ${hem}Q0 ${hem + 10} ${hw} ${hem}Q${60 * w} -60 ${54 * w} -112Z" fill="${lg([robe2, shade(robe2)])}" stroke="${OUT}" stroke-width="3"/>` + (sitting ? '' : `<path d="M0 -100L0 ${hem + 4}" stroke="${OUT}" stroke-width="2.5"/>`);
  if (!back) b += `<path d="M-20 -196L8 -130M20 -196L-8 -130" stroke="${trim}" stroke-width="8"/><path d="M-20 -196L8 -130M20 -196L-8 -130" stroke="${OUT}" stroke-width="1.5" fill="none" opacity="0.5"/>`;
  if (sash) b += `<path d="M${-52 * w} -124Q0 -116 ${52 * w} -124L${53 * w} -104Q0 -96 ${-53 * w} -104Z" fill="${sash}" stroke="${OUT}" stroke-width="2.5"/>`;
  if (emblem) b += `<circle cx="0" cy="-60" r="22" fill="#f4c43a" stroke="${OUT}" stroke-width="2.5"/>` + L.rays(0, -60, 12, 40, '#f4c43a', 0.9, 0.18);
  if (back) b += `<path d="M-30 -180Q-36 -150 -26 -130L26 -130Q36 -150 30 -180Z" fill="#c8b48a" stroke="${OUT}" stroke-width="2.5" opacity="${o.bundle === false ? 0 : 1}"/>`;
  // neck & head
  if (neck) b += `<path d="M0 -190Q${neck * 0.25} ${-190 - neck * 0.5} 0 ${-200 - neck}" stroke="${OUT}" stroke-width="26" fill="none"/><path d="M0 -190Q${neck * 0.25} ${-190 - neck * 0.5} 0 ${-200 - neck}" stroke="${skin}" stroke-width="20" fill="none"/>`;
  let h = headShape({ skin, head, back, fishCol });
  if (head === 'human') {
    if (!back) {
      if (blush) h += `<ellipse cx="-24" cy="-218" rx="7" ry="4" fill="#f08a8a" opacity="0.55"/><ellipse cx="24" cy="-218" rx="7" ry="4" fill="#f08a8a" opacity="0.55"/>`;
      h += eyes(ey, o.eyeCol);
      if (beard) h += `<path d="M-34 -222Q-30 -${beard === 'long' ? 120 : 175} 0 -${beard === 'long' ? 100 : 160}Q30 -${beard === 'long' ? 120 : 175} 34 -222Q20 -205 0 -206Q-20 -205 -34 -222Z" fill="${beardCol}" stroke="${OUT}" stroke-width="3"/>`;
      h += mouth(beard ? 'none' : mo);
      if (nose === 'long') h += `<path d="M2 -228Q30 -220 66 -196" stroke="${OUT}" stroke-width="20" fill="none"/><path d="M2 -228Q30 -220 66 -196" stroke="${skin}" stroke-width="14" fill="none"/>`;
      else if (!beard) h += `<path d="M0 -224l2 5" stroke="${OUT}" stroke-width="2" opacity="0.5"/>`;
    }
    h += hairFront(hairStyle, hair, back);
  }
  h += hat(hatType);
  b += neck ? `<g transform="translate(0 ${-neck})">${h}</g>` : h;
  b += arm([-44 * w, -182], armL[0], armL[1], sl, skin, wide) + arm([44 * w, -182], armR[0], armR[1], sl, skin, wide);
  if (holdL) b += `<g transform="translate(${armL[1][0]} ${armL[1][1]})">${holdL}</g>`;
  if (holdR) b += `<g transform="translate(${armR[1][0]} ${armR[1][1]})">${holdR}</g>`;
  if (lightning) b += `<path d="M-90 -260l-20 30l14 2l-18 34M96 -240l18 26l-14 4l20 32M-70 -120l-26 14l10 8l-24 16" stroke="#bfe4ff" stroke-width="4" fill="none" opacity="0.9"/>` + glow(-90, -240, 50, '#9ad0ff', 0.4) + glow(100, -220, 50, '#9ad0ff', 0.4);
  return g(x, y, s, b, { flip, op });
}
function shade(hex, k = 0.62) {
  const n = parseInt(hex.slice(1), 16);
  const r = Math.round(((n >> 16) & 255) * k), gg = Math.round(((n >> 8) & 255) * k), bl = Math.round((n & 255) * k);
  return '#' + ((r << 16) | (gg << 8) | bl).toString(16).padStart(6, '0');
}

// ---------- named characters ----------
const BELL = L.bell(0, 0, 0.9);
function traveller(x, y, s, o = {}) {
  return person(x, y, s, { robe: '#34508e', robe2: '#7a7e8c', sash: '#c8402a', trim: '#e8e0cc', hairStyle: 'tied', back: true, holdR: o.noBell ? '' : BELL, ...o });
}
const grandmother = (x, y, s, o = {}) => person(x, y, s, { robe: '#f4f0e6', robe2: '#c8302a', sash: null, trim: '#ffffff', hair: '#eceaf0', hairStyle: 'bun', eyes: 'happy', mouth: 'smile', ...o });
const sarutahiko = (x, y, s, o = {}) => person(x, y, s, { skin: '#d8483a', robe: '#3e6a4a', robe2: '#2e4a3a', sash: '#d8b878', hair: '#9a9aa6', hairStyle: 'wild', beard: 'short', beardCol: '#b0b0ba', nose: 'long', eyes: 'glow', blush: false, w: 1.25, armL: [[-40, -140], [30, -150]], armR: [[40, -140], [-30, -146]], ...o });
const omoikane = (x, y, s, o = {}) => person(x, y, s, { robe: '#a8acb8', robe2: '#7a7e8c', sash: '#4a4a5a', hair: '#f0eef4', hairStyle: 'bald', beard: 'long', hatType: 'eboshi', eyes: 'closed', w: 0.85, holdL: `<path d="M0 0L0 -140M0 0L0 90" stroke="${OUT}" stroke-width="10"/><path d="M0 -140L0 90" stroke="#8a6040" stroke-width="6"/>`, ...o });
const uzume = (x, y, s, o = {}) => person(x, y, s, { robe: '#f6c8a8', robe2: '#e8a080', sash: '#d8402a', hairStyle: 'loops', hatType: 'leaves', eyes: 'happy', mouth: 'laugh', ...o });
const tajikarao = (x, y, s, o = {}) => person(x, y, s, { skin: '#d8a070', robe: '#d8a070', robe2: '#f0ece0', trim: '#d8a070', sash: '#c8a868', hairStyle: 'wild', hair: '#1a1418', beard: 'short', beardCol: '#1a1418', eyes: 'stern', w: 1.5, wide: false, sleeve: '#d8a070', ...o });
const amaterasu = (x, y, s, o = {}) => person(x, y, s, { skin: '#fbe0c0', robe: '#f8f0e0', robe2: '#d8402a', sash: '#f4c43a', trim: '#d8402a', hair: '#2a1e22', hairStyle: 'wavy', hatType: 'crown', glowCol: '#ffd860', emblem: true, eyes: 'dot', mouth: 'smile', ...o });
const susanoo = (x, y, s, o = {}) => person(x, y, s, { skin: '#e0b088', robe: '#2e3e6a', robe2: '#1e2a4a', sash: '#6a5a4a', hair: '#141018', hairStyle: 'wild', beard: 'short', beardCol: '#141018', eyes: 'sad', w: 1.35, lightning: true, ...o });
const weaver = (x, y, s, o = {}) => person(x, y, s, { skin: '#e8eef8', robe: '#eef2fa', robe2: '#cfd8ea', sash: '#b8c4dc', hair: '#5a6a8a', hairStyle: 'long', eyes: 'closed', mouth: 'flat', blush: false, op: 0.7, ...o });
const sojobo = (x, y, s, o = {}) => person(x, y, s, { skin: '#d8402e', robe: '#f2eee4', robe2: '#e0dcd0', sash: '#d8402a', hair: '#f0eef4', hairStyle: 'bald', beard: 'long', nose: 'long', hatType: 'tokin', eyes: 'stern', wings: '#1e1c28', w: 1.3, blush: false, holdR: featherFan, ...o });
const crowTengu = (x, y, s, o = {}) => person(x, y, s, { head: 'crow', robe: '#f0ece0', robe2: '#2a2830', sash: '#c8402a', wings: '#1e1c28', hatType: 'tokin', holdR: woodSword, ...o });
const otohime = (x, y, s, o = {}) => person(x, y, s, { skin: '#fbe4cc', robe: '#9ad8c8', robe2: '#e8f4f0', sash: '#f4a8b8', trim: '#ffffff', hair: '#1e2a3a', hairStyle: 'long', hatType: 'coral', eyes: 'happy', ...o });
const fishServant = (x, y, s, o = {}) => person(x, y, s, { head: 'fish', robe: '#c84a5a', robe2: '#f0e0c8', sash: '#f4c43a', ...o });
const kushinada = (x, y, s, o = {}) => person(x, y, s, { robe: '#9ac0e0', robe2: '#e8eef4', sash: '#4a6a9a', hairStyle: 'long', hatType: 'comb', eyes: 'dot', mouth: 'flat', ...o });
const oldMan = (x, y, s, o = {}) => person(x, y, s, { robe: '#7a6250', robe2: '#5a4a3e', sash: '#3a3030', hair: '#d8d4cc', hairStyle: 'bun', beard: 'short', eyes: 'sad', w: 0.95, ...o });
const oldWoman = (x, y, s, o = {}) => person(x, y, s, { robe: '#8a8a92', robe2: '#6a6a74', sash: '#5a4a5a', hair: '#e0dcd8', hairStyle: 'bun', eyes: 'sad', mouth: 'frown', w: 0.95, ...o });

const featherFan = `<g transform="rotate(-20)"><path d="M0 0L0 -40" stroke="${OUT}" stroke-width="6"/>${[-40, -20, 0, 20, 40].map((a) => `<ellipse cx="0" cy="-70" rx="12" ry="34" fill="#f4f0ea" stroke="${OUT}" stroke-width="2" transform="rotate(${a} 0 -36)"/>`).join('')}</g>`;
const woodSword = `<g transform="rotate(-30)"><path d="M0 10L0 -110" stroke="${OUT}" stroke-width="12"/><path d="M0 10L0 -110" stroke="#c8a070" stroke-width="7"/><path d="M-12 -4L12 -4" stroke="${OUT}" stroke-width="7"/></g>`;

// ---------- creatures ----------
function fox(x, y, s, o = {}) {
  const { flame = true, flip = false, op = 1, eyes: ey = 'sly' } = o;
  let b = '';
  b += `<path d="M30 -10Q120 0 120 -80Q118 -140 70 -150Q100 -110 80 -70Q60 -40 20 -40Z" fill="#fbfaf6" stroke="${OUT}" stroke-width="3"/><path d="M90 -140Q76 -150 70 -150Q84 -128 88 -110Q98 -124 90 -140Z" fill="#e8eef8"/>`;
  if (flame) b += foxfireAt(70, -175);
  b += `<path d="M-46 0Q-56 -70 -30 -110L30 -110Q56 -70 46 0Z" fill="#fbfaf6" stroke="${OUT}" stroke-width="3"/><path d="M-20 -100Q0 -60 20 -100" fill="#eef0f4"/>`;
  b += `<path d="M-30 0L-28 -40M30 0L28 -40M-10 0L-10 -30M10 0L10 -30" stroke="${OUT}" stroke-width="2" opacity="0.4"/>`;
  b += `<path d="M-44 -150L-50 -210L-14 -168ZM44 -150L50 -210L14 -168Z" fill="#fbfaf6" stroke="${OUT}" stroke-width="3"/><path d="M-40 -162L-44 -196L-24 -170ZM40 -162L44 -196L24 -170Z" fill="#f2a0a8"/>`;
  b += `<path d="M-48 -150Q-48 -186 0 -186Q48 -186 48 -150Q46 -120 14 -102L0 -88L-14 -102Q-46 -120 -48 -150Z" fill="#fbfaf6" stroke="${OUT}" stroke-width="3"/>`;
  b += `<path d="M-30 -168l12 6M30 -168l-12 6" stroke="#d8402a" stroke-width="4"/>`;
  b += ey === 'sly' ? `<path d="M-30 -146Q-20 -156 -10 -146Q-20 -142 -30 -146ZM30 -146Q20 -156 10 -146Q20 -142 30 -146Z" fill="#f4c43a" stroke="${OUT}" stroke-width="2.5"/><path d="M-20 -150l0 6M20 -150l0 6" stroke="${OUT}" stroke-width="3"/>`
    : `<ellipse cx="-20" cy="-146" rx="8" ry="9" fill="#f4c43a" stroke="${OUT}" stroke-width="2.5"/><ellipse cx="20" cy="-146" rx="8" ry="9" fill="#f4c43a" stroke="${OUT}" stroke-width="2.5"/><path d="M-20 -152l0 12M20 -152l0 12" stroke="${OUT}" stroke-width="3"/>`;
  b += `<ellipse cx="0" cy="-104" rx="7" ry="5" fill="${OUT}"/><path d="M-10 -96Q0 -90 10 -96" stroke="${OUT}" stroke-width="2.5" fill="none"/>`;
  return g(x, y, s, b, { flip, op });
}
const foxfireAt = (x, y) => L.foxfire(x, y, 22);
function turtle(x, y, s, o = {}) {
  const { flipped = false, rot = 0 } = o;
  let b = '';
  const flipper = (fx, fy, a) => `<ellipse cx="${fx}" cy="${fy}" rx="44" ry="16" fill="#7aa87a" stroke="${OUT}" stroke-width="3" transform="rotate(${a} ${fx} ${fy})"/>`;
  b += flipper(-90, -60, flipped ? -40 : 30) + flipper(90, -60, flipped ? 40 : -30) + flipper(-80, 30, flipped ? 20 : -20) + flipper(80, 30, flipped ? -20 : 20);
  if (flipped) {
    b += `<ellipse cx="0" cy="-10" rx="100" ry="70" fill="#5a7a4a" stroke="${OUT}" stroke-width="3"/><ellipse cx="0" cy="-16" rx="80" ry="58" fill="#e8d8a8" stroke="${OUT}" stroke-width="3"/><path d="M-40 -60L-40 40M40 -60L40 40M-78 -16L78 -16" stroke="#b8a070" stroke-width="3"/>`;
    b += `<ellipse cx="0" cy="-82" rx="26" ry="20" fill="#8ab88a" stroke="${OUT}" stroke-width="3"/><circle cx="-9" cy="-82" r="3" fill="${OUT}"/><circle cx="9" cy="-82" r="3" fill="${OUT}"/>`;
  } else {
    b += `<ellipse cx="0" cy="-118" rx="30" ry="26" fill="#8ab88a" stroke="${OUT}" stroke-width="3"/><circle cx="-12" cy="-124" r="5" fill="${OUT}"/><circle cx="12" cy="-124" r="5" fill="${OUT}"/><circle cx="-10" cy="-126" r="1.8" fill="#fff"/><circle cx="14" cy="-126" r="1.8" fill="#fff"/><path d="M-8 -104q8 4 16 0" stroke="${OUT}" stroke-width="2.5" fill="none"/><path d="M-22 -136q6 -4 12 0M10 -136q6 -4 12 0" stroke="${OUT}" stroke-width="2" fill="none"/>`;
    b += `<ellipse cx="0" cy="-10" rx="100" ry="90" fill="${lg(['#6a8a4a', '#3a5a32'])}" stroke="${OUT}" stroke-width="4"/>`;
    b += `<path d="M-30 -60L30 -60L50 -10L30 40L-30 40L-50 -10Z" fill="#7a9a52" stroke="${OUT}" stroke-width="3"/><path d="M-30 -60L-60 -80M30 -60L60 -80M-50 -10L-98 -10M50 -10L98 -10M-30 40L-58 66M30 40L58 66" stroke="${OUT}" stroke-width="3"/>`;
    b += `<path d="M-70 -50Q-60 -70 -40 -76M60 30Q76 10 80 -6" stroke="#9ac07a" stroke-width="4" fill="none" opacity="0.7"/>`;
  }
  return g(x, y, s, b, { rot });
}
function dragonHead(x, y, s, o = {}) {
  const { flip = false, eyes: ey = 'open', col = '#4a8a6a' } = o;
  const b = `<path d="M60 -60Q120 -110 160 -150M70 -40Q150 -60 190 -110" stroke="#d8c890" stroke-width="7" fill="none"/>
  <path d="M40 -90Q30 -150 70 -190L90 -150Q80 -120 70 -100Z" fill="#e8d8a0" stroke="${OUT}" stroke-width="3"/><path d="M80 -70Q110 -130 160 -150L150 -110Q120 -90 100 -64Z" fill="#e8d8a0" stroke="${OUT}" stroke-width="3"/>
  <path d="M120 0Q120 -90 40 -100Q-60 -110 -150 -60Q-180 -40 -170 -10Q-120 10 -60 0Q-120 30 -150 50Q-90 70 -30 40Q40 60 120 0Z" fill="${lg([col, shade(col, 0.55)])}" stroke="${OUT}" stroke-width="4"/>
  <path d="M-150 -60Q-120 -64 -100 -50" stroke="${OUT}" stroke-width="3" fill="none"/><circle cx="-150" cy="-50" r="4" fill="${OUT}"/>
  <path d="M-150 -20Q-200 -40 -260 0M-140 -10Q-200 10 -250 60" stroke="${OUT}" stroke-width="7" fill="none"/><path d="M-150 -20Q-200 -40 -260 0M-140 -10Q-200 10 -250 60" stroke="#e8d890" stroke-width="3" fill="none"/>
  <path d="M-160 -10L-150 6L-140 -8L-128 8L-116 -6L-104 8L-92 -4" fill="#fff" stroke="${OUT}" stroke-width="2"/>
  <path d="M-40 40Q-30 100 -60 150Q-20 120 0 160Q10 110 40 140Q40 80 30 44Z" fill="#3a6a4a" stroke="${OUT}" stroke-width="3"/>
  ${ey === 'closed' ? `<path d="M-60 -70q20 10 40 0" stroke="${OUT}" stroke-width="4" fill="none"/>` : `<ellipse cx="-40" cy="-68" rx="24" ry="20" fill="${ey === 'red' ? '#ff3a2a' : '#ffe070'}" stroke="${OUT}" stroke-width="3"/><ellipse cx="-44" cy="-68" rx="6" ry="15" fill="${OUT}"/><circle cx="-34" cy="-74" r="4" fill="#fff"/>`}
  <path d="M-80 -96Q-40 -110 0 -96" stroke="${OUT}" stroke-width="5" fill="none"/>`;
  return g(x, y, s, b, { flip });
}
function dragonBody(d, w, col = '#4a8a6a', belly = '#e8d8a0') {
  return `<path d="${d}" stroke="${OUT}" stroke-width="${w + 8}" fill="none"/><path d="${d}" stroke="${col}" stroke-width="${w}" fill="none"/><path d="${d}" stroke="${shade(col, 0.7)}" stroke-width="${w * 0.6}" stroke-dasharray="${w * 0.25} ${w * 0.18}" fill="none" opacity="0.6"/><path d="${d}" stroke="${belly}" stroke-width="${w * 0.22}" fill="none" transform="translate(0 ${w * 0.3})" opacity="0.8"/>`;
}
// Orochi head on a neck from (bx,by) to head at (hx,hy); faces left unless flip.
function serpentHead(hx, hy, s, o = {}) {
  const { flip = false, sleep = false, open = false, col = '#4a5a3a' } = o;
  const b = `<path d="M60 -10Q60 -60 0 -64Q-70 -66 -110 -34Q-124 -20 -110 -6Q${open ? '-80 40 -120 70Q-60 70 -20 30' : '-60 16 0 20'}Q50 24 60 -10Z" fill="${lg([col, shade(col, 0.55)])}" stroke="${OUT}" stroke-width="4"/>
  <circle cx="-108" cy="-26" r="3" fill="${OUT}"/>
  ${open ? `<path d="M-106 -6L-96 10L-86 -2L-74 16L-64 4M-110 62L-96 48L-88 60L-76 44" fill="#fff" stroke="${OUT}" stroke-width="2"/><path d="M-100 20Q-80 30 -60 26" stroke="#c8303a" stroke-width="8" fill="none"/>` : ''}
  ${sleep ? `<path d="M-60 -40q14 8 28 0" stroke="${OUT}" stroke-width="4" fill="none"/>` : `${L.glow(-46, -38, 30, '#ff3020', 0.6)}<ellipse cx="-46" cy="-38" rx="15" ry="11" fill="#ff3a2a" stroke="${OUT}" stroke-width="3"/><ellipse cx="-46" cy="-38" rx="3" ry="9" fill="${OUT}"/>`}
  <path d="M-70 -58Q-40 -72 -10 -60" stroke="${OUT}" stroke-width="4" fill="none"/>`;
  return g(hx, hy, s, b, { flip });
}
function neckPath(x1, y1, x2, y2, bend = 60) {
  const mx = (x1 + x2) / 2 + bend, my = (y1 + y2) / 2;
  return `M${x1} ${y1}Q${mx} ${my} ${x2} ${y2}`;
}
function orochiNeck(x1, y1, x2, y2, w = 46, bend = 60, col = '#4a5a3a') {
  return dragonBody(neckPath(x1, y1, x2, y2, bend), w, col, '#a8a070');
}
function umibozu(x, y, s) {
  return g(x, y, s, `<path d="M-300 0Q-300 -340 0 -360Q300 -340 300 0Z" fill="${lg(['#2a3040', '#0a0c14'])}" stroke="${OUT}" stroke-width="4"/>
  <path d="M-260 -20Q-250 -200 -150 -280" stroke="#4a5470" stroke-width="6" fill="none" opacity="0.6"/>
  ${L.glow(-90, -200, 70, '#e8f0ff', 0.6)}${L.glow(90, -200, 70, '#e8f0ff', 0.6)}
  <ellipse cx="-90" cy="-200" rx="34" ry="40" fill="#f4f8ff" stroke="${OUT}" stroke-width="3"/><ellipse cx="90" cy="-200" rx="34" ry="40" fill="#f4f8ff" stroke="${OUT}" stroke-width="3"/>
  <circle cx="-86" cy="-196" r="10" fill="#1a2030"/><circle cx="86" cy="-196" r="10" fill="#1a2030"/>
  <path d="M-200 -10q10 -40 0 -80M200 -10q-10 -40 0 -80M-120 -20q8 -30 0 -60M120 -20q-8 -30 0 -60" stroke="#8aa0c8" stroke-width="5" fill="none" opacity="0.7"/>`);
}
function lanternYokai(x, y, s, o = {}) {
  return glow(x, y, 80 * s, '#ffa040', 0.55) + g(x, y, s, `<path d="M0 -60L0 -44" stroke="${OUT}" stroke-width="3"/><rect x="-16" y="-46" width="32" height="8" fill="#2a1e1e"/><path d="M-30 -38Q-40 0 -30 38L30 38Q40 0 30 -38Z" fill="${rg(['#fff0b0', '#f0a050'])}" stroke="${OUT}" stroke-width="3"/>
  <path d="M-34 -20Q0 -14 34 -20M-36 0Q0 6 36 0" stroke="${OUT}" stroke-width="1.5" fill="none" opacity="0.4"/>
  <path d="M-28 -24Q-14 -12 0 -18" stroke="${OUT}" stroke-width="3" fill="none"/><ellipse cx="-12" cy="-8" rx="${o.big ? 13 : 9}" ry="${o.big ? 13 : 9}" fill="#fff" stroke="${OUT}" stroke-width="2.5"/><circle cx="${o.look ?? -10}" cy="-7" r="${o.big ? 6 : 4}" fill="${OUT}"/>
  <path d="M-16 14Q0 28 22 10L10 20Q14 54 0 60Q-6 40 0 22Z" fill="#e85a6a" stroke="${OUT}" stroke-width="2.5"/>
  <rect x="-16" y="38" width="32" height="8" fill="#2a1e1e"/>`, { rot: o.rot || 0 });
}
function umbrellaYokai(x, y, s, o = {}) {
  return g(x, y, s, `<path d="M0 0L0 -50" stroke="${OUT}" stroke-width="10"/><path d="M0 0L0 -50" stroke="#c8a070" stroke-width="6"/><ellipse cx="0" cy="2" rx="16" ry="6" fill="#8a5a3a" stroke="${OUT}" stroke-width="2"/>
  <path d="M-80 -50L0 -170L80 -50Q40 -40 0 -50Q-40 -40 -80 -50Z" fill="${o.col || '#d8a050'}" stroke="${OUT}" stroke-width="3"/><path d="M0 -170L-40 -44M0 -170L40 -44M0 -170L0 -50" stroke="${OUT}" stroke-width="1.5" opacity="0.6"/><path d="M-30 -120l20 6M10 -140l12 20" stroke="${OUT}" stroke-width="2" opacity="0.6"/>
  <ellipse cx="-4" cy="-104" rx="12" ry="13" fill="#fff" stroke="${OUT}" stroke-width="2.5"/><circle cx="-2" cy="-102" r="6" fill="${OUT}"/>
  <path d="M-10 -78Q0 -70 14 -80L8 -74Q14 -52 2 -48Q-2 -62 0 -74Z" fill="#e85a6a" stroke="${OUT}" stroke-width="2"/>`, { rot: o.rot || 0, flip: o.flip });
}
function oni(x, y, s, o = {}) {
  return person(x, y, s, { skin: '#d8483a', robe: '#d8483a', robe2: '#f0c040', trim: '#d8483a', sash: '#2a2a30', hair: '#1a1418', hairStyle: 'wild', hatType: 'horns', eyes: 'wide', mouth: 'grin', wide: false, w: 1.15, blush: false, ...o });
}
function rooster(x, y, s, flip = false) {
  return g(x, y, s, `<path d="M-30 0Q-50 -30 -40 -60Q-70 -80 -60 -110Q-40 -90 -30 -70Q-20 -40 0 -40Q20 -40 22 -60L30 -80Q44 -84 46 -70L56 -64L46 -60Q40 -30 10 0Z" fill="#f2ead8" stroke="${OUT}" stroke-width="3"/><path d="M30 -80q2 -14 10 -6q4 -10 10 -2" fill="#d8402a" stroke="${OUT}" stroke-width="2"/><circle cx="38" cy="-70" r="2.5" fill="${OUT}"/><path d="M42 -58q4 10 -2 14" fill="#d8402a" stroke="${OUT}" stroke-width="2"/><path d="M-40 -60Q-70 -50 -80 -20M-40 -70Q-80 -80 -90 -50" stroke="#2a3a6a" stroke-width="8" fill="none"/><path d="M0 0L-6 20M10 0L14 20" stroke="#e0a020" stroke-width="5"/>`, { flip });
}
function fishSwim(x, y, s, col = '#f0a050', flip = false) {
  return g(x, y, s, `<path d="M-40 0Q0 -30 40 0Q0 30 -40 0ZM-40 0L-64 -18L-60 0L-64 18Z" fill="${col}" stroke="${OUT}" stroke-width="2.5"/><circle cx="24" cy="-4" r="4" fill="${OUT}"/>`, { flip });
}

module.exports = {
  SKIN, HAIR, person, shade, traveller, grandmother, sarutahiko, omoikane, uzume, tajikarao, amaterasu, susanoo, weaver,
  sojobo, crowTengu, otohime, fishServant, kushinada, oldMan, oldWoman, fox, turtle, dragonHead, dragonBody, serpentHead,
  neckPath, orochiNeck, umibozu, lanternYokai, umbrellaYokai, oni, rooster, fishSwim, BELL, featherFan, woodSword,
};
