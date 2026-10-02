#!/bin/bash
# Needs ENTR_INOTIFY_WORKAROUND to be set because of the MacOS implementation of Docker
# -d: exit when a new file is added to a watched directory (the loop restarts and picks it up)
# -n: non-interactive mode
INPUT_DIR=${INPUT_DIR:-/resume/input}
RESUME_TEMPLATE=${RESUME_TEMPLATE:-/resume/templates/resume.tex}
COVER_TEMPLATE=${COVER_TEMPLATE:-/resume/templates/cover-letter.tex}

mkdir -p "$INPUT_DIR"

while true; do
  { find "$INPUT_DIR" -type f \( -name '*.markdown' -o -name '*.md' \); echo "$RESUME_TEMPLATE"; echo "$COVER_TEMPLATE"; } \
    | ENTR_INOTIFY_WORKAROUND=true entr -dn /resume/bin/build.sh
  sleep 1
done
