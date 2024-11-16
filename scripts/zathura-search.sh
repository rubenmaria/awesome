#!/bin/bash
PDF_FILE="$(
  (
    find ~/workspace -type f -iname '*.pdf' &
    find ~/uni -type f -iname '*.pdf' &
    find ~/.config -type f -iname '*.pdf' &
    find ~/personal/ -type f -iname '*.pdf' &
    find ~/Documents/ -type f -iname '*.pdf' &
    find ~/Downloads/ -type f -iname '*.pdf'
  ) |
    fzf --keep-right
)"
if [[ $PDF_FILE ]]; then
  nohup zathura $PDF_FILE >/dev/null 2>&1 &
fi
PPPID=$(awk '{print $4}' "/proc/$PPID/stat")
kill $PPPID
