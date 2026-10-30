# Generates the raw ambience loop for Tales/TalesAmbience.m4a. Run from this folder with
# numpy installed, then master it for phone speakers with ./master_ambience.sh
# Seamless-looping "tomb" ambience. Every component is built circularly
# (periodic frequencies, FFT noise, circular reverb/tails) so the loop has no seam.
import numpy as np, wave

SR, L = 44100, 48.0
N = int(SR * L)
t = np.arange(N) / SR
rng = np.random.default_rng(7)

def q(f):            # snap frequency to an exact loop harmonic
    return round(f * L) / L

def lfo(cycles, phase=0.0):  # 0..1 slow modulator that repeats exactly over the loop
    return 0.5 + 0.5 * np.sin(2 * np.pi * cycles * t / L + phase)

def shaped_noise(lo, hi, tilt=0.0):
    spec = np.zeros(N // 2 + 1, complex)
    f = np.fft.rfftfreq(N, 1 / SR)
    band = (f > lo) & (f < hi)
    mag = np.where(band, (np.maximum(f, 1) / lo) ** tilt, 0)
    # soft band edges
    mag *= np.clip((f - lo) / (lo * 0.5), 0, 1) * np.clip((hi - f) / (hi * 0.3), 0, 1)
    spec[:] = mag * np.exp(1j * rng.uniform(0, 2 * np.pi, len(f)))
    x = np.fft.irfft(spec, N)
    return x / np.abs(x).max()

def circ_add(buf, sig, start):
    idx = (np.arange(len(sig)) + start) % N
    np.add.at(buf, idx, sig)

out = np.zeros((2, N))
D = 73.42  # D2

# --- Drone: root, fifth, octave with slow detuned beating
for ch in range(2):
    d = np.zeros(N)
    for mult, amp, det in [(1, 1.0, 0.0), (1, 0.6, 0.11), (1.5, 0.35, -0.08),
                           (2, 0.25, 0.06), (3, 0.08, 0.0)]:
        f = q(D * mult + det * (1 if ch == 0 else -1))
        d += amp * np.sin(2 * np.pi * f * t + rng.uniform(0, 6.28))
    d *= 0.55 + 0.45 * lfo(2, ch * 1.3)
    out[ch] += 0.16 * d / 2.3

# --- Wind: low rumble + breathy mid band, slowly swelling
for ch in range(2):
    rumble = shaped_noise(40, 300, -1.0) * (0.4 + 0.6 * lfo(3, ch))
    breath = shaped_noise(350, 2200, -1.5) * (0.15 + 0.85 * lfo(4, 2 + ch) ** 2)
    whistle = shaped_noise(900, 1300, 0.0) * lfo(1, 4 + ch) ** 3
    out[ch] += 0.10 * rumble + 0.06 * breath + 0.02 * whistle

# --- Sparse soft bells in D hijaz (D Eb F# G A Bb C)
scale = [D * 4 * 2 ** (s / 12) for s in [0, 1, 4, 5, 7, 8, 10, 12]]
notes = [(2.0, 0), (9.5, 4), (14.0, 2), (21.0, 5), (27.5, 1), (33.0, 4), (40.0, 7), (44.5, 3)]
for start, deg in notes:
    f0 = scale[deg]
    n = int(SR * 9)
    tt = np.arange(n) / SR
    bell = sum(a * np.sin(2 * np.pi * f0 * r * tt) * np.exp(-tt * dcy)
               for r, a, dcy in [(1, 1, 0.6), (2.76, 0.35, 1.4), (5.4, 0.12, 3.0), (0.5, 0.2, 0.4)])
    bell *= np.minimum(tt / 0.02, 1)
    pan = rng.uniform(0.25, 0.75)
    for ch, g in enumerate([1 - pan, pan]):
        circ_add(out[ch], 0.035 * g * bell, int(start * SR))

# --- Circular "stone chamber" reverb
rlen = int(SR * 3.5)
for ch in range(2):
    ir = np.zeros(N)
    ir[:rlen] = rng.standard_normal(rlen) * np.exp(-np.arange(rlen) / SR * 2.2)
    ir[0] = 0
    wet = np.fft.irfft(np.fft.rfft(out[ch]) * np.fft.rfft(ir), N)
    out[ch] = 0.75 * out[ch] + 0.25 * wet / np.abs(wet).max() * np.abs(out[ch]).max()

# remove DC, normalise to -3 dBFS peak
out -= out.mean(axis=1, keepdims=True)
out *= 10 ** (-3 / 20) / np.abs(out).max()

def write(path, x):
    pcm = (x.T * 32767).astype('<i2')
    with wave.open(path, 'wb') as w:
        w.setnchannels(2); w.setsampwidth(2); w.setframerate(SR); w.writeframes(pcm.tobytes())

write('tales_ambience_loop.wav', out)
write('tales_ambience_preview_2x.wav', np.concatenate([out, out], axis=1))
# seam check: jump across loop boundary vs typical sample-to-sample step
print('seam step', np.abs(out[:, 0] - out[:, -1]).max(), 'median step', np.median(np.abs(np.diff(out[0]))))
