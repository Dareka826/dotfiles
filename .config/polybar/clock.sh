foreground=#FFFFFF
dateCol="#222222" #Date color
timeCol="#5000AA" #Time color

printf "%s" "%{F${dateCol}}%{F${foreground} B${dateCol}} $(date +%d/%m/%Y) %{B${dateCol} F${timeCol}}%{B${timeCol} F${foreground}} $(date +%H:%M:%S) "
