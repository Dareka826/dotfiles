#!/bin/sh

# The delay before restoring next workspace
DELAY=0.2

# Restore numbered workspaces
for i in $(seq 1 1 30); do
	i3-resurrect restore -w $i --layout-only \
		&& sleep $DELAY # Delay only if workspace was found
done

# Restore custom workspaces
for i in アニメ D MC tmp CTV; do
	i3-resurrect restore -w $i --layout-only \
		&& sleep $DELAY # Delay only if workspace was found
done

i3-notify "Restored workspaces"

