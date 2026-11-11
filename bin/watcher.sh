#!/bin/bash
# Polls instead of using inotify/entr: inotify is unreliable on macOS Docker bind
# mounts, and entr only watches directories that already contain a watched file,
# so a file hardlinked into a brand new folder was never noticed.
# build.sh itself only rebuilds documents that are out of date.
INPUT_DIR=${INPUT_DIR:-/resume/input}
RESUME_TEMPLATE=${RESUME_TEMPLATE:-/resume/templates/resume.tex}
COVER_TEMPLATE=${COVER_TEMPLATE:-/resume/templates/cover-letter.tex}

mkdir -p "$INPUT_DIR"

snapshot() {
  { find -L "$INPUT_DIR" -type f \( -name '*.markdown' -o -name '*.md' \) -exec stat -c '%n %Y %i' {} +
    stat -c '%n %Y %i' "$RESUME_TEMPLATE" "$COVER_TEMPLATE"; } 2>/dev/null | sort
}

last=
while true; do
  current=$(snapshot)
  if [ "$current" != "$last" ]; then
    /resume/bin/build.sh
    last=$current
  fi
  sleep 1
done
