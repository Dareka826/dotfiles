#! /bin/sh

~/.local/bin/_save-i3.sh
~/.local/bin/lock.sh
sleep 0.1
systemctl suspend
# to try out
# ~/.local/bin/lock.sh && systemctl suspend

