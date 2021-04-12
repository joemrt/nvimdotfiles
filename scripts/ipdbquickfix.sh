#!/bin/bash
tmux capture-pane -t $1 -S -10 \; save-buffer >(cat) \; delete-buffer | tac | sed -n '1,/^ipdb/p' | sed -nE 's/>?\s+([/<~])/\1/p' | sed -nE 's/([^(]*)\(([0-9]+).*\)/\1:\2: /p'
