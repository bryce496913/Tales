// Characters and props specific to individual Trial of Anubis scenes.
const { OL, rng, stroke, g, at, linGrad, glow, chainLinks, heart, glyph } = require('./lib');

// Ammit: crocodile head, lion mane and forelegs, hippo body. Faces right.
// Origin: ground under the body centre. Length ~640, height ~420.
function ammit(x, y, sc = 1, opts = {}) {
  const { flip = false, mouth = 'open', chains = true } = opts;
  const hippo = '#8c7d99', hippoDk = '#6b5d7a', lion = '#d9a24a', mane = '#b8651f', croc = '#4f9a4a', crocDk = '#357035';
  const teeth = (x0, y0, x1, n, up) => {
    let s = '';
    for (let i = 0; i < n; i++) {
      const tx = x0 + ((x1 - x0) * (i + 0.5)) / n;
      s += `<path d="M${tx - 8} ${y0} L${tx} ${y0 + (up ? -16 : 16)} L${tx + 8} ${y0} Z" fill="#fffaf0" ${stroke(1.5)}/>`;
    }
    return s;
  };
  let maneSpikes = '';
  for (let i = 0; i < 22; i++) {
    const a = (i / 22) * Math.PI * 2;
    const r1 = 100, r2 = 138;
    const a2 = a + Math.PI / 22;
    maneSpikes += `${i ? 'L' : 'M'}${(Math.cos(a) * r1).toFixed(1)} ${(Math.sin(a) * r1).toFixed(1)} L${(Math.cos(a2) * r2).toFixed(1)} ${(Math.sin(a2) * r2).toFixed(1)} `;
  }
  const jawOpen = mouth === 'open';
  return at(x, y, sc, `
    <ellipse cx="0" cy="0" rx="330" ry="24" fill="#000" opacity="0.3"/>
    <!-- hind legs -->
    <rect x="-270" y="-90" width="76" height="90" rx="18" fill="${hippoDk}" ${stroke(3)}/>
    <rect x="-140" y="-90" width="76" height="90" rx="18" fill="${hippo}" ${stroke(3)}/>
    <path d="M-270 -4 L-194 -4 M-140 -4 L-64 -4" stroke="#4a3f57" stroke-width="6"/>
    <!-- tail -->
    <path d="M-300 -190 C-340 -200 -350 -170 -330 -150" fill="none" stroke="${OL}" stroke-width="16" stroke-linecap="round"/>
    <path d="M-300 -190 C-340 -200 -350 -170 -330 -150" fill="none" stroke="${hippo}" stroke-width="10" stroke-linecap="round"/>
    <!-- hippo body -->
    <ellipse cx="-150" cy="-190" rx="175" ry="135" fill="${hippo}" ${stroke(3.5)}/>
    <path d="M-280 -150 C-240 -80 -100 -70 -20 -110" fill="none" stroke="#a99bb6" stroke-width="10" stroke-linecap="round"/>
    <path d="M-250 -270 C-200 -310 -120 -315 -70 -290" fill="none" stroke="#a99bb6" stroke-width="8" stroke-linecap="round"/>
    <!-- lion forelegs -->
    <path d="M10 -200 L0 -20 L60 -20 L70 -170 Z" fill="${lion}" ${stroke(3)}/>
    <path d="M100 -200 L100 -20 L160 -20 L150 -180 Z" fill="${lion}" ${stroke(3)}/>
    <path d="M-10 0 C-10 -30 70 -30 74 0 Z M88 0 C88 -30 168 -30 172 0 Z" fill="${lion}" ${stroke(3)}/>
    <path d="M-6 0 L-12 10 M14 0 L10 12 M34 0 L32 12 M54 0 L56 12 M94 0 L88 10 M114 0 L110 12 M134 0 L132 12 M154 0 L156 12" stroke="#f6f0e0" stroke-width="5" stroke-linecap="round"/>
    <rect x="-4" y="-120" width="80" height="22" rx="6" fill="#7e7c7a" ${stroke(2.5)}/>
    <rect x="96" y="-120" width="70" height="22" rx="6" fill="#7e7c7a" ${stroke(2.5)}/>
    <!-- lion chest -->
    <ellipse cx="60" cy="-210" rx="110" ry="100" fill="${lion}" ${stroke(3)}/>
    <!-- mane -->
    <g transform="translate(120 -270)">
      <path d="${maneSpikes} Z" fill="${mane}" ${stroke(3)}/>
      <circle r="100" fill="#cf7b2c"/>
    </g>
    <!-- croc head -->
    <g transform="translate(150 -290)">
      <path d="M-60 -40 C-30 -80 40 -86 80 -60 L330 -20 C352 -16 356 6 336 10 L80 20 C30 24 -40 20 -60 -40 Z" fill="${croc}" ${stroke(3.5)}/>
      ${jawOpen ? `
      <path d="M70 18 L320 10" stroke="${OL}" stroke-width="3"/>
      <path d="M60 22 L80 22 L300 110 C320 120 316 136 296 134 L60 80 C20 70 20 30 60 22 Z" fill="${croc}" ${stroke(3.5)}/>
      <path d="M80 26 L300 104 L290 118 L70 72 Z" fill="#7a1f2a"/>
      <path d="M100 50 C160 70 220 90 270 106" stroke="#c4495a" stroke-width="12" fill="none" stroke-linecap="round"/>
      ${g(teeth(80, 0, 320, 10, false), 'rotate(-1)')}
      ${g(teeth(80, 0, 290, 9, true), 'translate(0 28) rotate(19 80 0)')}`
      : `<path d="M70 18 L330 10" stroke="${OL}" stroke-width="3"/>${teeth(90, 14, 320, 10, false)}`}
      <path d="M0 -60 Q20 -78 40 -74 M60 -66 Q80 -76 100 -66 M120 -56 Q140 -64 160 -54 M180 -46 Q200 -52 220 -44" stroke="${crocDk}" stroke-width="6" fill="none" stroke-linecap="round"/>
      <ellipse cx="30" cy="-62" rx="34" ry="26" fill="${croc}" ${stroke(3)}/>
      <ellipse cx="34" cy="-64" rx="18" ry="14" fill="#ffc43a" ${stroke(2)}/>
      <ellipse cx="36" cy="-64" rx="4" ry="11" fill="#1a1208"/>
      <path d="M12 -76 Q34 -92 58 -74" stroke="${crocDk}" stroke-width="7" fill="none" stroke-linecap="round"/>
      <ellipse cx="318" cy="-20" rx="9" ry="5" fill="${crocDk}"/>
    </g>
    ${chains ? chainLinks(20, -110, -60, -10, 20) + chainLinks(160, -110, 260, -10, 20) : ''}`, flip);
}

// Papyrus boat. Origin: hull centre at the waterline.
function boat(x, y, sc = 1, flip = false) {
  return at(x, y, sc, `
    <path d="M-260 -60 C-230 -10 -150 20 0 20 C150 20 230 -10 270 -80 L280 -110 C260 -60 200 -30 0 -30 C-180 -30 -230 -50 -270 -90 Z" fill="#4b2c17" ${stroke(3)}/>
    <path d="M-250 -60 C-200 -22 -120 -12 0 -12 C130 -12 210 -24 262 -70" fill="none" stroke="#f2b833" stroke-width="7"/>
    <path d="M-180 -30 L-176 6 M-100 -24 L-98 14 M-20 -24 L-20 18 M60 -24 L60 18 M140 -26 L136 10" stroke="#2f1a0c" stroke-width="3"/>`, flip);
}

// Linen-wrapped faceless ferryman. Origin: feet.
function ferryman(x, y, sc = 1, opts = {}) {
  const { flip = false, orb = false, pole = true } = opts;
  const lin = '#c9bea6', linDk = '#9c907a';
  let bands = '';
  for (let i = 0; i < 9; i++) {
    const yy = -40 - i * 38;
    bands += `<path d="M-70 ${yy} Q0 ${yy - 22 + (i % 2) * 12} 70 ${yy - 8}" stroke="${linDk}" stroke-width="4" fill="none"/>`;
  }
  return at(x, y, sc, `
    ${pole ? `<path d="M-150 60 L120 -520" stroke="${OL}" stroke-width="16" stroke-linecap="round"/><path d="M-150 60 L120 -520" stroke="#2a2420" stroke-width="10" stroke-linecap="round"/>` : ''}
    <path d="M-80 0 C-90 -120 -92 -260 -72 -350 C-60 -420 60 -420 72 -350 C92 -260 90 -120 84 0 Z" fill="${lin}" ${stroke(3.5)}/>
    ${bands}
    <path d="M-62 -360 C-70 -460 -40 -500 0 -504 C40 -500 70 -460 62 -360 C40 -340 -40 -340 -62 -360 Z" fill="${lin}" ${stroke(3.5)}/>
    <path d="M-40 -380 C-44 -440 -24 -470 0 -470 C24 -470 44 -440 40 -380 C20 -366 -20 -366 -40 -380 Z" fill="#141018"/>
    ${glow(-14, -420, 30, '#ffe08a', 0.8)}${glow(16, -420, 30, '#ffe08a', 0.8)}
    <ellipse cx="-14" cy="-420" rx="7" ry="9" fill="#ffe9a8"/>
    <ellipse cx="16" cy="-420" rx="7" ry="9" fill="#ffe9a8"/>
    <path d="M-60 -300 C-90 -250 -60 -200 30 -210 L30 -190 C-80 -170 -110 -260 -60 -320 Z" fill="${lin}" ${stroke(3)}/>
    ${pole ? `<ellipse cx="40" cy="-310" rx="22" ry="18" fill="${lin}" ${stroke(3)}/>` : ''}
    ${orb ? `
      <path d="M60 -320 C110 -300 150 -270 170 -250 L156 -232 C130 -250 100 -270 56 -290 Z" fill="${lin}" ${stroke(3)}/>
      ${glow(190, -280, 160, '#ffd36b', 0.75)}
      <circle cx="190" cy="-280" r="56" fill="#ffe7a0" ${stroke(3, '#b77a1a')}/>
      <circle cx="176" cy="-296" r="16" fill="#fff8d8"/>
      <path d="M150 -262 Q170 -280 190 -262 Q210 -244 230 -262" stroke="#e8a83a" stroke-width="5" fill="none"/>
      <circle cx="198" cy="-284" r="7" fill="#c77b2a"/><circle cx="214" cy="-280" r="6" fill="#c77b2a"/>
      <path d="M150 -246 C160 -228 200 -220 224 -232" fill="#c9bea6" ${stroke(3)}/>` : ''}`, opts.flip);
}

function scroll(x, y, len = 120, rot = 0, r = 16, paper = '#efe0b8') {
  return g(`
    <rect x="${-len / 2}" y="${-r}" width="${len}" height="${r * 2}" fill="${paper}" ${stroke(2.5)}/>
    <path d="M${-len / 2 + 6} ${-r + 6} L${len / 2 - 6} ${-r + 6}" stroke="#fff6dc" stroke-width="4"/>
    <ellipse cx="${len / 2}" cy="0" rx="${r * 0.45}" ry="${r}" fill="#d9c592" ${stroke(2.5)}/>
    <ellipse cx="${len / 2}" cy="0" rx="${r * 0.15}" ry="${r * 0.35}" fill="#8a6a3a"/>
    <path d="M${-len * 0.15} ${-r} L${-len * 0.15} ${r}" stroke="#b2462e" stroke-width="5"/>`,
    `translate(${x} ${y}) rotate(${rot})`);
}

function scrollPile(x, y, n, seed, sc = 1) {
  const r = rng(seed);
  let s = '';
  let row = 0, placed = 0;
  while (placed < n) {
    const perRow = Math.max(1, 5 - row);
    for (let i = 0; i < perRow && placed < n; i++, placed++) {
      const xx = (i - (perRow - 1) / 2) * 50 + (r() - 0.5) * 10;
      s += scroll(xx, -row * 30 - 16, 110 + r() * 30, (r() - 0.5) * 10, 15);
    }
    row++;
  }
  return at(x, y, sc, s);
}

// Masked underworld scribe sitting behind a writing desk. Origin: floor under desk centre.
function scribe(x, y, sc = 1, opts = {}) {
  const { desk = true, standing = false, flip = false } = opts;
  const robe = '#1d5a63', robeHi = '#2f7a84';
  const words = glyphRow => {
    let s = '';
    const r = rng(11);
    for (let row = 0; row < 4; row++) for (let i = 0; i < 4; i++) s += glyph(Math.floor(r() * 8), -27 + i * 18, -40 + row * 22, 0.55, '#b98a2a', 0.85);
    return s;
  };
  const baseY = standing ? 0 : -150;
  const fig = `
    <path d="M-120 ${baseY} C-120 ${baseY - 120} -110 ${baseY - 220} -70 ${baseY - 260} C-40 ${baseY - 285} 40 ${baseY - 285} 70 ${baseY - 260} C110 ${baseY - 220} 120 ${baseY - 120} 120 ${baseY} Z" fill="${robe}" ${stroke(3.5)}/>
    <path d="M-80 ${baseY - 240} C-96 ${baseY - 160} -100 ${baseY - 80} -98 ${baseY - 10}" stroke="${robeHi}" stroke-width="8" fill="none" stroke-linecap="round"/>
    <path d="M-76 ${baseY - 262} C-50 ${baseY - 220} 50 ${baseY - 220} 76 ${baseY - 262} C40 ${baseY - 290} -40 ${baseY - 290} -76 ${baseY - 262} Z" fill="#f2b833" ${stroke(3)}/>
    <path d="M-62 ${baseY - 256} C-40 ${baseY - 232} 40 ${baseY - 232} 62 ${baseY - 256}" stroke="#2c62c9" stroke-width="6" fill="none"/>
    <g transform="translate(0 ${baseY - 330})">
      <path d="M-70 40 C-80 -30 -60 -90 0 -96 C60 -90 80 -30 70 40 Z" fill="#14233a" ${stroke(3)}/>
      <path d="M-56 30 L-56 -40 M56 30 L56 -40" stroke="#f2b833" stroke-width="6"/>
      <ellipse cx="0" cy="-8" rx="44" ry="58" fill="#f3ead6" ${stroke(3)}/>
      ${words()}
      ${glow(0, -10, 70, '#ffe7a6', 0.3)}
    </g>`;
  const deskSvg = desk ? `
    <rect x="-200" y="-160" width="400" height="160" fill="#7a4a24" ${stroke(3.5)}/>
    <rect x="-216" y="-178" width="432" height="26" fill="#9a6232" ${stroke(3)}/>
    <path d="M-180 -120 L180 -120 M-180 -70 L180 -70" stroke="#5e381a" stroke-width="4"/>
    ${glyph(0, -120, -96, 1.4, '#f2b833', 0.9)}${glyph(5, 0, -96, 1.4, '#f2b833', 0.9)}${glyph(1, 120, -96, 1.4, '#f2b833', 0.9)}
    <path d="M-150 -186 L150 -186 L170 -168 L-170 -168 Z" fill="#efe0b8" ${stroke(2.5)}/>
    <path d="M-120 -178 L-20 -178 M10 -178 L120 -178" stroke="#a07a40" stroke-width="2"/>
    <ellipse cx="-70" cy="-196" rx="26" ry="18" fill="#14233a" ${stroke(2.5)}/>
    <ellipse cx="70" cy="-196" rx="26" ry="18" fill="#14233a" ${stroke(2.5)}/>
    <path d="M90 -200 L150 -260" stroke="#e9d9b4" stroke-width="6" stroke-linecap="round"/>` : `
    <path d="M60 -170 C100 -150 130 -130 150 -110" stroke="${OL}" stroke-width="30" stroke-linecap="round"/>
    <path d="M60 -170 C100 -150 130 -130 150 -110" stroke="${robe}" stroke-width="24" stroke-linecap="round"/>
    ${scroll(160, -100, 90, 70, 13)}`;
  return at(x, y, sc, fig + deskSvg, flip);
}

// Masked rebel with a cracked gold mask and a dark orb.
function rebel(x, y, sc = 1, opts = {}) {
  const { flip = false } = opts;
  const cloak = '#3a2450', cloakHi = '#55376f';
  return at(x, y, sc, `
    <path d="M-130 0 C-120 -140 -110 -280 -70 -360 C-40 -410 40 -410 70 -360 C110 -280 120 -140 130 0 Z" fill="${cloak}" ${stroke(3.5)}/>
    <path d="M-60 -350 C-90 -240 -100 -120 -100 -10" stroke="${cloakHi}" stroke-width="9" fill="none" stroke-linecap="round"/>
    <path d="M-80 -360 C-90 -440 -50 -500 0 -504 C50 -500 90 -440 80 -360 C50 -330 -50 -330 -80 -360 Z" fill="${cloak}" ${stroke(3.5)}/>
    <path d="M-50 -380 C-56 -440 -30 -470 0 -470 C30 -470 56 -440 50 -380 C30 -364 -30 -364 -50 -380 Z" fill="#120a18"/>
    <path d="M-40 -384 C-46 -436 -24 -460 0 -460 L0 -372 C-20 -372 -32 -376 -40 -384 Z" fill="#f2b833" ${stroke(2.5)}/>
    <path d="M0 -460 C24 -460 46 -436 40 -384 C32 -376 20 -372 0 -372 Z" fill="#1d1d24" ${stroke(2.5)}/>
    <path d="M0 -460 L-6 -440 L4 -420 L-4 -400 L2 -372" fill="none" stroke="#120a18" stroke-width="3"/>
    <ellipse cx="-20" cy="-420" rx="9" ry="5" fill="#120a18"/>
    <ellipse cx="20" cy="-420" rx="9" ry="5" fill="#c58cff"/>
    ${glow(20, -420, 26, '#c58cff', 0.8)}
    <path d="M70 -300 C120 -280 150 -250 170 -230 L156 -210 C130 -230 100 -250 60 -270 Z" fill="${cloak}" ${stroke(3)}/>
    <ellipse cx="172" cy="-216" rx="18" ry="15" fill="#9c6b4a" ${stroke(2.5)}/>
    ${darkOrb(186, -276, 1)}`, flip);
}

function darkOrb(x, y, sc = 1) {
  const r = rng(5);
  let wisps = '';
  for (let i = 0; i < 8; i++) {
    const a = r() * Math.PI * 2, d = 50 + r() * 40;
    wisps += `<circle cx="${(Math.cos(a) * d).toFixed(1)}" cy="${(Math.sin(a) * d).toFixed(1)}" r="${(3 + r() * 5).toFixed(1)}" fill="#c58cff" opacity="0.8"/>`;
  }
  return glow(x, y, 130 * sc, '#9b4dff', 0.6) + at(x, y, sc, `
    <circle r="40" fill="#1a0f2a" ${stroke(3, '#0a0510')}/>
    <path d="M-30 -10 C-20 -30 10 -36 26 -20" stroke="#8a4ddf" stroke-width="7" fill="none" stroke-linecap="round"/>
    <circle cx="-14" cy="-18" r="7" fill="#e9d4ff"/>
    ${wisps}`);
}

// Stone and linen guardian with a ceremonial blade. Origin: between feet.
function guardian(x, y, sc = 1, opts = {}) {
  const { flip = false, cracked = false, kneel = false } = opts;
  const st = '#a8977c', stDk = '#7e6e56', lin = '#e8dcc0';
  const crack = cracked ? `
    <path d="M-40 -560 L-20 -500 L-50 -460 L-10 -400 L-30 -340" fill="none" stroke="${OL}" stroke-width="5"/>
    <path d="M60 -520 L40 -470 L70 -430" fill="none" stroke="${OL}" stroke-width="4"/>
    <path d="M-110 -260 L-80 -220 L-100 -190" fill="none" stroke="${OL}" stroke-width="4"/>
    ${glow(-20, -480, 60, '#ffb648', 0.5)}` : '';
  const legs = kneel ? `
    <path d="M-120 -40 L-120 -180 L-30 -200 L-20 -40 Z" fill="${stDk}" ${stroke(3.5)}/>
    <path d="M30 -200 L170 -190 L180 -110 L90 -100 L90 0 L20 0 Z" fill="${st}" ${stroke(3.5)}/>
    <rect x="-170" y="-44" width="160" height="44" rx="10" fill="${stDk}" ${stroke(3)}/>`
    : `
    <path d="M-100 -260 L-110 -40 L-30 -40 L-20 -260 Z" fill="${stDk}" ${stroke(3.5)}/>
    <path d="M20 -260 L30 -40 L110 -40 L100 -260 Z" fill="${st}" ${stroke(3.5)}/>
    <rect x="-130" y="-44" width="110" height="44" rx="10" fill="${stDk}" ${stroke(3)}/>
    <rect x="20" y="-44" width="110" height="44" rx="10" fill="${st}" ${stroke(3)}/>
    <path d="M-104 -200 L-24 -180 M-106 -140 L-26 -120 M24 -200 L104 -180 M26 -140 L106 -120" stroke="${lin}" stroke-width="10"/>`;
  const up = kneel ? 140 : 0;
  return at(x, y, sc, legs + g(`
    <path d="M-150 -560 L150 -560 L120 -250 L-120 -250 Z" fill="${st}" ${stroke(3.5)}/>
    <path d="M-140 -540 L130 -300 M-130 -420 L60 -260 M140 -540 L-80 -340" stroke="${lin}" stroke-width="14" opacity="0.9"/>
    <rect x="-130" y="-280" width="260" height="40" fill="${stDk}" ${stroke(3)}/>
    <circle cx="-160" cy="-540" r="56" fill="${st}" ${stroke(3.5)}/>
    <circle cx="160" cy="-540" r="56" fill="${st}" ${stroke(3.5)}/>
    <path d="M-200 -520 L-220 -330 L-170 -320 L-140 -500 Z" fill="${st}" ${stroke(3.5)}/>
    <path d="M-214 -460 L-150 -450 M-218 -400 L-158 -390" stroke="${lin}" stroke-width="12"/>
    <path d="M200 -520 L230 -340 L180 -330 L150 -500 Z" fill="${st}" ${stroke(3.5)}/>
    <path d="M150 -470 L216 -460 M160 -410 L224 -400" stroke="${lin}" stroke-width="12"/>
    <circle cx="-196" cy="-318" r="30" fill="${stDk}" ${stroke(3)}/>
    <circle cx="206" cy="-326" r="30" fill="${stDk}" ${stroke(3)}/>
    <g transform="translate(206 -326) rotate(${kneel ? 120 : 10})">
      <rect x="-8" y="-10" width="16" height="70" fill="#5a3a1a" ${stroke(2.5)}/>
      <path d="M-4 60 L-4 200 C-4 280 70 320 110 290 C60 280 30 250 22 190 L22 60 Z" fill="#e8b14a" ${stroke(3)}/>
      <path d="M6 70 L6 196" stroke="#fde59a" stroke-width="5"/>
    </g>
    <path d="M-70 -560 L-60 -640 C-40 -690 40 -690 60 -640 L70 -560 Z" fill="${lin}" ${stroke(3.5)}/>
    <ellipse cx="0" cy="-650" rx="64" ry="76" fill="${st}" ${stroke(3.5)}/>
    <path d="M-30 -670 L-10 -672 M8 -650 L30 -652 M-20 -620 L14 -622" stroke="${stDk}" stroke-width="4" stroke-linecap="round"/>
    <path d="M-64 -680 C-60 -740 60 -740 64 -680" fill="#c9b78f" ${stroke(3)}/>
    ${crack}`, `translate(0 ${up})`), flip);
}

// Hanging glass jar holding a heart.
function heartJar(x, y, sc = 1, opts = {}) {
  const { chainTop = null, beat = 1 } = opts;
  return (chainTop !== null ? `<path d="M${x} ${chainTop} L${x} ${y - 70 * sc}" stroke="#4a2a20" stroke-width="${4 * sc}" stroke-dasharray="${8 * sc} ${5 * sc}"/>` : '') +
    glow(x, y, 90 * sc, '#ff4a4a', 0.45) + at(x, y, sc, `
    <rect x="-40" y="-60" width="80" height="120" rx="20" fill="#ffd6d6" fill-opacity="0.18" ${stroke(3, '#3a0e10')}/>
    ${heart(0, 4, 0.55 * beat, '#d6283f')}
    <rect x="-40" y="-60" width="80" height="120" rx="20" fill="none" ${stroke(3, '#3a0e10')}/>
    <path d="M-26 -44 L-26 40" stroke="#fff" stroke-width="6" opacity="0.5" stroke-linecap="round"/>
    <rect x="-46" y="-74" width="92" height="20" rx="6" fill="#c9952a" ${stroke(2.5)}/>
    <rect x="-46" y="54" width="92" height="16" rx="6" fill="#c9952a" ${stroke(2.5)}/>
    <rect x="-28" y="18" width="56" height="16" rx="3" fill="#efe0b8" ${stroke(1.5)}/>
    <path d="M-20 26 L20 26" stroke="#6a4a2a" stroke-width="2"/>`);
}

// Simple front-facing person (memory figures). Origin: feet.
function person(x, y, sc = 1, opts = {}) {
  const { skin = '#c08a62', hair = '#2a1a10', cloth = '#6a7fa0', dress = false, hairLong = false, mood = 'neutral', armOut = 0, flip = false, op = 1, point = false } = opts;
  const mouth = mood === 'sad' ? 'M-10 -258 Q0 -266 10 -258' : mood === 'smile' ? 'M-10 -262 Q0 -252 10 -262' : mood === 'stern' ? 'M-10 -260 L10 -260' : 'M-8 -260 Q0 -256 8 -260';
  const body = dress
    ? `<path d="M-40 -220 L40 -220 L80 0 L-80 0 Z" fill="${cloth}" ${stroke(3)}/>
       <path d="M-60 -60 Q0 -40 60 -60" stroke="#d9cdb4" stroke-width="4" fill="none"/>`
    : `<path d="M-46 -220 L46 -220 L50 -110 L-50 -110 Z" fill="${cloth}" ${stroke(3)}/>
       <path d="M-44 -112 L-40 0 L-6 0 L-4 -112 Z M4 -112 L6 0 L40 0 L44 -112 Z" fill="#3e3a44" ${stroke(3)}/>`;
  const armR = point
    ? `<path d="M40 -210 L120 -230 L122 -212 L44 -186 Z" fill="${cloth}" ${stroke(3)}/><circle cx="128" cy="-222" r="11" fill="${skin}" ${stroke(2)}/>`
    : armOut
      ? `<path d="M40 -214 C80 -210 120 -200 150 -190 L146 -170 C110 -178 76 -184 44 -184 Z" fill="${cloth}" ${stroke(3)}/><circle cx="158" cy="-180" r="13" fill="${skin}" ${stroke(2)}/>`
      : `<path d="M42 -214 L62 -110 L44 -106 L30 -200 Z" fill="${cloth}" ${stroke(3)}/><circle cx="54" cy="-100" r="11" fill="${skin}" ${stroke(2)}/>`;
  return at(x, y, sc, `<g opacity="${op}">
    ${hairLong ? `<path d="M-46 -280 C-60 -330 -30 -350 0 -350 C30 -350 60 -330 46 -280 L52 -190 L-52 -190 Z" fill="${hair}" ${stroke(3)}/>` : ''}
    ${body}
    <path d="M-42 -214 L-62 -110 L-44 -106 L-30 -200 Z" fill="${cloth}" ${stroke(3)}/><circle cx="-54" cy="-100" r="11" fill="${skin}" ${stroke(2)}/>
    ${armR}
    <rect x="-10" y="-236" width="20" height="20" fill="${skin}" ${stroke(2)}/>
    <ellipse cx="0" cy="-280" rx="36" ry="42" fill="${skin}" ${stroke(3)}/>
    <path d="M-38 -290 C-40 -330 -10 -334 0 -330 C20 -334 42 -320 38 -290 C30 -310 -20 -316 -38 -290 Z" fill="${hair}" ${stroke(2.5)}/>
    <ellipse cx="-13" cy="-282" rx="4" ry="5.5" fill="#1a1208"/>
    <ellipse cx="13" cy="-282" rx="4" ry="5.5" fill="#1a1208"/>
    ${mood === 'stern' ? '<path d="M-22 -294 L-6 -290 M22 -294 L6 -290" stroke="#1a1208" stroke-width="3"/>' : ''}
    <path d="${mouth}" stroke="#5a2a1a" stroke-width="3" fill="none" stroke-linecap="round"/>
    <circle cx="-22" cy="-268" r="6" fill="#e8907a" opacity="0.45"/><circle cx="22" cy="-268" r="6" fill="#e8907a" opacity="0.45"/>
  </g>`, flip);
}

// Gold funerary mask (like the Sphinx sarcophagi heads).
function goldMask(x, y, sc = 1, stripe = '#1fa59a') {
  return at(x, y, sc, `
    <path d="M-60 60 C-70 0 -64 -70 0 -80 C64 -70 70 0 60 60 Z" fill="#f2b833" ${stroke(3)}/>
    <path d="M-50 40 L-52 -20 M50 40 L52 -20" stroke="${stripe}" stroke-width="8"/>
    <path d="M-30 50 C-36 0 -30 -40 0 -44 C30 -40 36 0 30 50 Z" fill="#f8cc4e" ${stroke(2.5)}/>
    <path d="M-20 -6 L-8 -6 M8 -6 L20 -6" stroke="${OL}" stroke-width="4" stroke-linecap="round"/>
    <path d="M0 -2 L-4 18 L4 18" fill="none" stroke="#b9801b" stroke-width="3"/>
    <path d="M-8 30 L8 30" stroke="#b9801b" stroke-width="4" stroke-linecap="round"/>
    <path d="M-6 50 L6 50 L4 74 L-4 74 Z" fill="${stripe}" ${stroke(2)}/>`);
}

// Gold heap with jewels (like the Sphinx treasure room).
function goldPile(x, y, w, h, seed) {
  const r = rng(seed);
  let bumps = `M${-w / 2} 0 `;
  const n = 9;
  for (let i = 0; i <= n; i++) {
    const t = i / n;
    const px = -w / 2 + w * t;
    const py = -h * Math.sin(Math.PI * t) * (0.8 + r() * 0.3);
    bumps += `Q${px - w / n / 2} ${py - 20 * r()} ${px} ${py} `;
  }
  bumps += `L${w / 2} 0 Z`;
  let gems = '';
  const cols = ['#e2335a', '#2f8fd1', '#3cb35a', '#9a4ddf', '#ffffff'];
  for (let i = 0; i < w / 18; i++) {
    const gx = (r() - 0.5) * w * 0.85, gy = -r() * h * 0.7 * Math.cos((gx / w) * Math.PI);
    if (r() < 0.55) gems += `<circle cx="${gx.toFixed(0)}" cy="${gy.toFixed(0)}" r="${(3 + r() * 4).toFixed(1)}" fill="#fff4b0"/>`;
    else gems += `<path d="M${gx.toFixed(0)} ${(gy - 10).toFixed(0)} l8 10 l-8 10 l-8 -10 Z" fill="${cols[Math.floor(r() * cols.length)]}" ${stroke(1.5)}/>`;
  }
  return at(x, y, 1, `<path d="${bumps}" fill="#f2b833" ${stroke(3)}/>
    <path d="${bumps}" fill="none" stroke="#fde59a" stroke-width="6" transform="translate(0 6) scale(0.94 0.9)" opacity="0.6"/>${gems}`);
}

// Kneeling figure in Egyptian mural style holding up a heart.
function muralKneeler(x, y, sc = 1, flip = false, col = '#2a1708') {
  return at(x, y, sc, `
    <path d="M-30 0 L-34 -40 C-36 -70 -20 -90 -10 -100 L-6 -120 C-20 -128 -20 -150 -4 -154 C12 -156 20 -140 12 -126 L18 -100 L40 -84 L60 -100 L66 -94 L44 -70 L20 -80 L16 -40 L30 0 Z" fill="${col}"/>
    <path d="M60 -110 C52 -118 52 -128 60 -128 C64 -128 66 -124 66 -122 C66 -124 68 -128 72 -128 C80 -128 80 -118 72 -110 L66 -104 Z" fill="#c4283a"/>`, flip);
}

// Top-down spiral stair around a bottomless shaft.
function spiralShaft(cx, cy) {
  let s = '';
  const rings = [[480, '#6a4526'], [400, '#5a3920'], [320, '#4a2e19'], [245, '#3a2313'], [175, '#2a180c']];
  rings.forEach(([r, c]) => (s += `<circle cx="${cx}" cy="${cy}" r="${r}" fill="${c}" ${stroke(3)}/>`));
  const r = rng(21);
  for (let k = 0; k < rings.length - 1; k++) {
    const r1 = rings[k][0], r2 = rings[k + 1][0];
    const n = 16 - k * 2;
    const off = k * 0.3;
    for (let i = 0; i < n; i++) {
      const a = (i / n) * Math.PI * 2 + off;
      s += `<path d="M${cx + Math.cos(a) * r2} ${cy + Math.sin(a) * r2} L${cx + Math.cos(a) * r1} ${cy + Math.sin(a) * r1}" stroke="${OL}" stroke-width="3" opacity="0.7"/>`;
      // step riser shading
      const a2 = a + 0.06;
      s += `<path d="M${cx + Math.cos(a2) * (r2 + 4)} ${cy + Math.sin(a2) * (r2 + 4)} L${cx + Math.cos(a2) * (r1 - 4)} ${cy + Math.sin(a2) * (r1 - 4)}" stroke="#000" stroke-width="7" opacity="0.18"/>`;
    }
  }
  return s;
}

// Glowing memory panel set into a step.
function memoryPanel(x, y, rot, sc, kind) {
  const scenes = [
    `<circle cx="-14" cy="-6" r="8" fill="#3a2a1a"/><path d="M-22 18 L-14 2 L-6 18 Z" fill="#3a2a1a"/><circle cx="14" cy="0" r="6" fill="#3a2a1a"/><path d="M8 18 L14 6 L20 18 Z" fill="#3a2a1a"/><path d="M-6 6 L8 6" stroke="#3a2a1a" stroke-width="3"/>`,
    `<circle cx="0" cy="-6" r="8" fill="#3a2a1a"/><path d="M-10 18 L0 2 L10 18 Z" fill="#3a2a1a"/><path d="M-26 18 L-26 -10 L-18 -18 L-10 -10" stroke="#3a2a1a" stroke-width="3" fill="none"/>`,
    `<circle cx="-8" cy="-4" r="7" fill="#3a2a1a"/><path d="M-16 18 L-8 4 L0 18 Z" fill="#3a2a1a"/><path d="M6 -2 L22 -14 M6 -2 L22 4" stroke="#3a2a1a" stroke-width="3"/>`,
  ];
  return glow(x, y, 60 * sc, '#ffd780', 0.5) + g(`
    <rect x="-34" y="-26" width="68" height="52" rx="4" fill="#ffe3a0" ${stroke(2.5, '#7a4a14')}/>
    ${scenes[kind % 3]}`, `translate(${x} ${y}) rotate(${rot}) scale(${sc})`);
}

// Stacked stone rings around the Balance Stone. Origin: base centre.
function ringMachine(x, y, sc = 1) {
  const ring = (cy, rx, ry, w, col, notch) => {
    let n = '';
    for (let i = 0; i < 12; i++) {
      const a = (i / 12) * Math.PI * 2;
      if (Math.sin(a) < -0.1) continue;
      n += `<rect x="${Math.cos(a) * rx - 6}" y="${cy + Math.sin(a) * ry - 8}" width="12" height="16" fill="${notch}" ${stroke(1.5)}/>`;
    }
    return `<ellipse cx="0" cy="${cy}" rx="${rx}" ry="${ry}" fill="none" stroke="${OL}" stroke-width="${w + 6}"/>
      <ellipse cx="0" cy="${cy}" rx="${rx}" ry="${ry}" fill="none" stroke="${col}" stroke-width="${w}"/>
      <ellipse cx="0" cy="${cy - w * 0.25}" rx="${rx}" ry="${ry}" fill="none" stroke="#c9b48f" stroke-width="3" opacity="0.6"/>${n}`;
  };
  return at(x, y, sc, `
    <ellipse cx="0" cy="0" rx="260" ry="60" fill="#5a4a3a" ${stroke(3)}/>
    <path d="M-260 0 L-260 -40 C-260 -80 260 -80 260 -40 L260 0" fill="#7a6650" ${stroke(3)}/>
    <ellipse cx="0" cy="-40" rx="260" ry="60" fill="#8f7a60" ${stroke(3)}/>
    ${glyph(0, -180, -10, 1.6, '#f2b833', 0.8)}${glyph(5, -60, 6, 1.6, '#f2b833', 0.8)}${glyph(1, 60, 6, 1.6, '#f2b833', 0.8)}${glyph(3, 180, -10, 1.6, '#f2b833', 0.8)}
    <rect x="-30" y="-240" width="60" height="200" fill="#7a6650" ${stroke(3)}/>
    <g transform="rotate(-8 0 -200)">${ring(-200, 230, 70, 22, '#9a8468', '#f2b833')}</g>
    <g transform="rotate(10 0 -300)">${ring(-300, 180, 54, 20, '#a8916f', '#2fb5a6')}</g>
    <g transform="rotate(-14 0 -390)">${ring(-390, 130, 40, 16, '#b49c78', '#f2b833')}</g>`);
}

module.exports = { ammit, boat, ferryman, scroll, scrollPile, scribe, rebel, darkOrb, guardian, heartJar, person, goldMask, goldPile, muralKneeler, spiralShaft, memoryPanel, ringMachine };
