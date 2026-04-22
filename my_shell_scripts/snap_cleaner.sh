#!/bin/bash

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
    # -e  Exit immediately if a command exits with a non-zero status.
    # -u  Treat unset variables as an error when substituting.

LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
    