#!/usr/bin/env bash
# Masters tales_ambience_loop.wav (from generate_ambience.py) into Tales/TalesAmbience.m4a.
#
# - EQ for phone speakers: the raw loop is mostly a 73 Hz drone that iPhone speakers
#   can't reproduce, so trim the rumble and lift the wind/bell range (~400 Hz–3 kHz).
# - The filters run over three back-to-back copies and keep the middle one, so the
#   result is in steady state at both ends and still loops without a click.
# - Normalise to a -1.5 dBFS true peak and encode as ALAC. ALAC stores the exact
#   sample count; AAC pads the end to a whole frame, which clicks on every loop.
#
# Usage (from this folder, with ffmpeg installed): ./master_ambience.sh [input.wav]
set -euo pipefail

in="${1:-tales_ambience_loop.wav}"
out="../../Tales/TalesAmbience.m4a"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

samples=$(ffprobe -v error -select_streams a:0 -show_entries stream=duration_ts -of csv=p=0 "$in")
eq="highpass=f=90,equalizer=f=180:t=o:w=1:g=-4,equalizer=f=450:t=o:w=1.5:g=14,equalizer=f=1200:t=o:w=1.5:g=16,equalizer=f=3000:t=o:w=1.5:g=10"

ffmpeg -v error -y -stream_loop 2 -i "$in" \
    -af "$eq,atrim=start_sample=$samples:end_sample=$((2 * samples)),asetpts=N/SR/TB" \
    -c:a pcm_f32le "$tmp/eq.wav"

peak=$(ffmpeg -nostats -i "$tmp/eq.wav" -af astats=measure_perchannel=none -f null - 2>&1 \
    | grep "Peak level dB" | tail -1 | awk '{print $NF}')
gain=$(python3 -c "print(round(-1.5 - ($peak), 2))")

ffmpeg -v error -y -i "$tmp/eq.wav" -af "volume=${gain}dB" -c:a pcm_s16le "$tmp/final.wav"
ffmpeg -v error -y -i "$tmp/final.wav" -c:a alac "$out"
echo "Wrote $out (gain ${gain} dB, $samples samples)"
