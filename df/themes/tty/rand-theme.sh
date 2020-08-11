#!/bin/sh
# Randomly execute a file with .theme.sh extension

cd ~/themes/tty
# Get the number of theme scripts
NUM=$(ls -1 *.theme.sh | wc -l)
# Generate a pseudo-random number from 1 to $NUM
IDX=$(( $RANDOM % $NUM + 1 ))
# Get the selected theme file name
THF=$(ls -1 *.theme.sh | sed -n "${IDX}p")

# Apply the theme
./$THF
