#!/bin/bash

# Needs ENTR_INOTIFY_WORKAROUND to be set because of the MacOS implementation of Docker
# -p: postpone first run until a file changes
# -n: non-interactive mode
echo -e "$SOURCE\n$TEMPLATE" | ENTR_INOTIFY_WORKAROUND=true entr -pn /bin/build-resume.sh
