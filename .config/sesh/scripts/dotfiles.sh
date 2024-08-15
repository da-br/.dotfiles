#!/usr/bin/env bash

tmux new-window -n 'zsh' 
tmux new-window -n 'git'
tmux select-window -t 1
tmux send-keys "nvim ." Enter
