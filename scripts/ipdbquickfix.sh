#!/bin/bash
# gets the content of pane $1 and extracts an expression suitable
# for a quickfix list
tmux capture-pane -t $1 -S -100 \; show-buffer \; delete-buffer | tac | sed -n '1,/^ipdb/p' | sed -nE 's/>?\s+([/<~])/\1/p' | sed -nE 's/([^(]*)\(([0-9]+).*\)/\1:\2: /p' | sed -E "s/<ipython[^>]*>/$2/"
