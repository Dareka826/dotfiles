foreground="#FFFFFF"
foreOff="#FF0000"
netCol="#222222" #Network color

interfaces="$(ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p' | paste -sd " ")"
int1="$(echo $interfaces | cut -d " " -f2)"
int2="$(echo $interfaces | cut -d " " -f3)"

if iwconfig $int1 >/dev/null 2>&1
then
    wifi=$int1
    eth0=$int2
else
    wifi=$int2
    eth0=$int1
fi
ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 || int=$wifi

ping -c 1 archlinux.org >/dev/null 2>&1 && printf "%s" "%{F${netCol}}%{F${foreground} B${netCol}} $int connected " || echo "%{F${netCol}}%{F${foreOff} B${netCol}} $int disconnected "
