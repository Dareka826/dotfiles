#!/bin/sh

# Clean & backup previous state
pushd
cd ~/.i3/i3-resurrect
tar cf "../bkp_$(date "+%Y-%m-%d_%H:%M:%S").tar" *

rm ~/.i3/i3-resurrect/*
popd

# Save numbered workspaces
for i in $(seq 1 1 30); do
	i3-resurrect save -w $i --swallow=class,title --layout-only
done

# Save named workspaces
for i in アニメ D MC tmp CTV; do
	i3-resurrect save -w $i --swallow=class,title --layout-only
done

notify-send -u critical "Saved i3 layout"

