// Scenery shared by the Descent to Hades pages.
const L = require('./lib');
const {
  svg, sky, shape, glow, ellipseGlow, vignette, wash, fog, at, g, rot, fade, place, stroke, OL, hand, blur, clip,
  theo, theoSitting, hermes, charon, persephone, hades, throne, fury, sisyphus, boulder, achilles, sibyl, judge, shade, shadeCrowd, cerberus,
  pomegranate, flask, bowl, bough, column, cypress, poplar, oliveTree, asphodel, asphodelField, grass, boatHull, ironGate, waves, stairsUp,
  sparks, stars, lightBeam, rain, flame, brazier, SKIN,
} = L;


const underSky = (top = '#0b1220', bottom = '#2c2450') => sky(top, bottom);

// Road from the bottom of the frame to a vanishing point.
function road(vx, vy, wBot, top, bottom, wTop = 16) {
  return shape(`M${500 - wBot / 2} 1000 L${vx - wTop / 2} ${vy} L${vx + wTop / 2} ${vy} L${500 + wBot / 2} 1000 Z`, top, bottom, 3);
}

function hills(y, seed, top, bottom, amp = 40) {
  const r = L.rng(seed);
  let d = `M0 1000 L0 ${y}`;
  for (let x = 0; x <= 1000; x += 125) d += ` Q${x + 62} ${y - amp * (0.4 + r())} ${x + 125} ${y + (r() - 0.5) * amp * 0.6}`;
  return shape(d + ' L1000 1000 Z', top, bottom, 3);
}

function milestone(x, y, sc = 1) {
  return at(x, y, sc, `
    <path d="M-40 0 L-34 -150 C-30 -176 30 -176 34 -150 L40 0 Z" fill="#8a8a96" ${stroke(3)}/>
    <path d="M-20 -120 L20 -120 M-16 -100 L10 -100 M-18 -80 L16 -80" stroke="${OL}" stroke-width="4" opacity="0.4" stroke-linecap="round"/>
    <path d="M16 -150 L22 -20" stroke="#6a6a76" stroke-width="8" opacity="0.6"/>`);
}

// Dark rock walls framing a scene.
function caveFrame(col = '#120e18') {
  return `<path d="M0 0 L1000 0 L1000 120 C900 90 820 60 700 70 C560 40 440 40 300 70 C180 60 90 90 0 140 Z" fill="${col}" ${stroke(4)}/>
    <path d="M0 0 L0 1000 L90 1000 C120 800 60 600 110 420 C140 300 60 200 0 140 Z" fill="${col}" ${stroke(4)}/>
    <path d="M1000 0 L1000 1000 L910 1000 C880 820 940 640 890 460 C860 330 940 210 1000 120 Z" fill="${col}" ${stroke(4)}/>`;
}

function blackRiver(y0, y1, o = {}) {
  const { col = '#07060c', hi = '#2a2840' } = o;
  return `<rect x="0" y="${y0}" width="1000" height="${y1 - y0}" fill="${col}"/>
    ${waves(31, y0 + 10, y1 - 10, hi, '#3c3a58', 22)}`;
}

function lightning(x, y, sc = 1) {
  return glow(x, y + 120 * sc, 260 * sc, '#e8f4ff', 0.5) + at(x, y, sc, `<path d="M0 0 L-30 110 L10 110 L-30 250 L60 80 L16 80 L46 0 Z" fill="#f4fbff" ${stroke(3, '#8ab0d0')}/>`);
}

function sunDisc(x, y, r, col = '#fff2b0') {
  return glow(x, y, r * 4, '#fff6c8', 0.55) + `<circle cx="${x}" cy="${y}" r="${r}" fill="${col}" ${stroke(3, '#e8b84a')}/>`;
}

function memoryWisps(seed, n, x0, x1, y0, y1, col = '#e6f2ff') {
  const r = L.rng(seed);
  let s = '';
  for (let i = 0; i < n; i++) {
    const x = x0 + r() * (x1 - x0), y = y0 + r() * (y1 - y0);
    s += `<path d="M${x.toFixed(0)} ${y.toFixed(0)} c-14 -24 14 -40 0 -66 c-10 -18 8 -30 4 -46" fill="none" stroke="${col}" stroke-width="${(3 + r() * 4).toFixed(1)}" stroke-linecap="round" opacity="${(0.35 + r() * 0.4).toFixed(2)}"/>`;
  }
  return s;
}

// The milky river Lethe flowing across the frame.
function letheWater(y0, y1, seed = 4) {
  return shape(`M0 ${y0} C250 ${y0 - 20} 650 ${y0 + 30} 1000 ${y0 - 10} L1000 ${y1} C650 ${y1 + 20} 300 ${y1 - 20} 0 ${y1 + 10} Z`, '#dfe4ea', '#aeb8c6', 3) +
    waves(seed, y0 + 20, y1 - 10, '#f4f7fb', '#8e9aae', 26);
}

const meadowSky = () => sky('#9aa4b4', '#d6d8dc');

// Bronze-walled fortress of Tartarus.
function fortress(y, o = {}) {
  const { gateOpen = true, crack = true } = o;
  let s = `<path d="M60 ${y} L60 ${y - 210} L940 ${y - 210} L940 ${y} Z" fill="#8a5a2c" ${stroke(4)}/>`;
  for (let x = 60; x < 940; x += 60) s += `<rect x="${x}" y="${y - 240}" width="34" height="34" fill="#8a5a2c" ${stroke(3)}/>`;
  for (let yy = y - 170; yy < y; yy += 44) s += `<path d="M60 ${yy} L940 ${yy}" stroke="#5a3814" stroke-width="3" opacity="0.6"/>`;
  s += `<rect x="420" y="${y - 330}" width="160" height="330" fill="#9a6a34" ${stroke(4)}/>`;
  for (let x = 420; x < 580; x += 40) s += `<rect x="${x}" y="${y - 360}" width="26" height="30" fill="#9a6a34" ${stroke(3)}/>`;
  s += gateOpen ? `<path d="M450 ${y} L450 ${y - 150} C450 ${y - 200} 550 ${y - 200} 550 ${y - 150} L550 ${y} Z" fill="#1a0806" ${stroke(4)}/>` + glow(500, y - 80, 120, '#ff5a1a', 0.5)
    : `<path d="M450 ${y} L450 ${y - 150} C450 ${y - 200} 550 ${y - 200} 550 ${y - 150} L550 ${y} Z" fill="#6a4420" ${stroke(4)}/>`;
  if (crack) s += `<path d="M760 ${y - 210} L790 ${y - 150} L770 ${y - 100} L800 ${y - 40} L780 ${y}" fill="none" stroke="${OL}" stroke-width="5"/>
    <path d="M700 ${y - 211} L700 ${y - 150} L860 ${y - 150} L860 ${y - 211} Z" fill="#2a1004" opacity="0.0"/>
    <path d="M690 ${y - 210} L720 ${y - 130} L860 ${y - 130} L880 ${y - 210} Z" fill="#3a1a08" ${stroke(3)}/>`;
  return s;
}

function fireRiver(y0, y1, seed = 6, o = {}) {
  const { low = false } = o;
  const r = L.rng(seed);
  let s = shape(`M0 ${y0} C300 ${y0 - 20} 700 ${y0 + 20} 1000 ${y0} L1000 ${y1} L0 ${y1} Z`, low ? '#c85a14' : '#ff8a1a', low ? '#7a2a08' : '#c83a08', 3);
  s += glow(500, (y0 + y1) / 2, 700, '#ffb43a', low ? 0.25 : 0.45);
  for (let i = 0; i < (low ? 8 : 22); i++) {
    const t = r();
    const x = r() * 1000, y = y0 + 20 + (y1 - y0 - 30) * t;
    s += flame(x, y, 30 + t * 60, (low ? 30 : 60) + t * (low ? 50 : 130));
  }
  s += sparks(seed + 1, 60, 0, y0 - 300, 1000, y1, '#ffd27a', 4);
  return s;
}

const redSky = () => sky('#2a0a0a', '#a8341a');

// The player as a child, in the Lethe's false memory.
function figureKid(x, y, sc) {
  return place(x, y, sc, `<g transform="scale(0.82)">${L.figure({ skin: SKIN.warm, robe: L.PLAYER_SLEEVE, hair: '#4a2e1a', hairStyle: 'messy', body: 'jacket', mood: 'smile', armL: 'down', armR: 'out', legs: '#5a4a3a' })}</g>`);
}

module.exports = { underSky, road, hills, milestone, caveFrame, blackRiver, lightning, sunDisc, memoryWisps, letheWater, meadowSky, fortress, fireRiver, redSky, figureKid };
