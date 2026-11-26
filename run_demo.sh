#!/bin/sh
# Runs the demos with the Linux executable (make the terminal window wide, about 135 columns, for the race)
BIN="$(dirname "$0")/bin/maze5-linux-x64"
echo "===== 1. Compare all four algorithms (seed 99) ====="; "$BIN" 99
echo; echo "===== 2. Live animation: A* (seed 99) ====="; "$BIN" 99 astar anim 20
echo; echo "===== 3. Race: all four side by side ====="; "$BIN" race 99 30
echo; echo "===== 4. A saved maze that is hard for A* ====="; "$BIN" load "$(dirname "$0")/mazes/hard_for_astar_seed99.txt"
echo; echo "===== 5. Mazes with loops: A* gains more ====="; "$BIN" braid 25 100
