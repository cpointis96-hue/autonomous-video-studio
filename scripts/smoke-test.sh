#!/bin/zsh
set -euo pipefail

ROOT_DIR="${0:A:h:h}"
WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/avstudio-smoke.XXXXXX")"
trap 'rm -rf "$WORK_DIR"' EXIT

command -v ffmpeg >/dev/null
command -v ffprobe >/dev/null

ffmpeg -hide_banner -loglevel error -y \
  -f lavfi -i testsrc2=size=320x180:rate=24 \
  -f lavfi -i sine=frequency=440:sample_rate=48000 \
  -t 2 -c:v libx264 -pix_fmt yuv420p -c:a aac "$WORK_DIR/source.mp4"

ffprobe -v error -of json -show_format -show_streams "$WORK_DIR/source.mp4" > "$WORK_DIR/source.probe.json"
ffmpeg -hide_banner -loglevel error -y -ss 0.25 -i "$WORK_DIR/source.mp4" -t 1 -c:v libx264 -pix_fmt yuv420p -c:a aac "$WORK_DIR/part.mp4"
ffprobe -v error -of json -show_format -show_streams "$WORK_DIR/part.mp4" > "$WORK_DIR/part.probe.json"
test "$(jq -r '(.format.duration | tonumber) >= 0.95 and (.format.duration | tonumber) <= 1.05' "$WORK_DIR/part.probe.json")" = true
printf "file '%s'\nfile '%s'\n" "$WORK_DIR/part.mp4" "$WORK_DIR/part.mp4" > "$WORK_DIR/concat.txt"
ffmpeg -hide_banner -loglevel error -y -f concat -safe 0 -i "$WORK_DIR/concat.txt" -c copy "$WORK_DIR/concat.mp4"
ffmpeg -hide_banner -loglevel error -y -i "$WORK_DIR/concat.mp4" -af loudnorm=I=-16:TP=-1.5:LRA=11 -c:v copy -c:a aac "$WORK_DIR/normalized.mp4"
ffprobe -v error -of json -show_format -show_streams "$WORK_DIR/normalized.mp4" > "$WORK_DIR/normalized.probe.json"

test -s "$WORK_DIR/normalized.mp4"
test "$(jq -r '[.streams[].codec_type] | sort == ["audio", "video"]' "$WORK_DIR/normalized.probe.json")" = true
test "$(jq -r '(.format.duration | tonumber) >= 1.95 and (.format.duration | tonumber) <= 2.15' "$WORK_DIR/normalized.probe.json")" = true
printf '%s\n' "SMOKE PASS: FFmpeg, ffprobe, trim, concat and audio normalization"
