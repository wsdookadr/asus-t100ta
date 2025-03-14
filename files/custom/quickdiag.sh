#!/bin/bash

tmux kill-session -t quickdiag 2>/dev/null || true
sleep 1;
busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b false
trap "tmux kill-session -t quickdiag" SIGHUP
tmux new-session -s quickdiag \; \
  send-keys 'while true; do timeout 6 ping -W 4 -c 4    8.8.8.8; sleep 4; clear; done' C-m \; \
  split-window -h \; \
  send-keys 'while true; do timeout 6 ping -W 4 -c 4 google.com; sleep 4; clear; done' C-m \; \
  split-window -v \; \
  send-keys 'while true; do mtr -Z 3 -c 1 -r google.com; sleep 4; clear; done' C-m \; \
  select-pane -t 0 \; \
  split-window -v \; \
  send-keys 'while true; do upower -i /org/freedesktop/UPower/devices/battery_BATC | grep "energy\|time to empty\|time to full\|percentage"; sleep 5; clear; done' C-m \;

wait
