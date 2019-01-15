foreground="#FFFFFF"
background="#111111"

# Powerline Separators
sep_left=""
sep_right=""

wspColorD="#4400DD" #Disabled workspace color
wspColorA="#6600FF" #Active workspace color

numWsp=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`
curWsp=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
wspNames=`xprop -root _NET_DESKTOP_NAMES | sed 's/_NET.*=//' | sed 's/[^0-9]/ /g' | tr -s ' '`

printf "%s" "%{B${wspColorD} F${wspColorD}}$sep_right%{F${foreground}}"

if [ $curWsp -ne 0 ]
then
    printf "%s" "%{F${wspColorD}}%{F${foreground}}"
fi

for w in `seq 0 $((curWsp - 1))`;
do
    if [ $w -eq $((curWsp - 1)) ]
    then
        printf " %s %s" $(echo $wspNames | cut -d " " -f $(($w+1))) "%{F${wspColorD} B${wspColorA}}$sep_right"
    else
        printf " %s %s" $(echo $wspNames | cut -d " " -f $(($w+1))) "%{F${wspColorD}}$sep_right%{F${foreground}}"
    fi
done

if [ $curWsp -eq 0 ]
then
    printf "%s" "%{B${wspColorA} F${wspColorD}}$sep_right%{F${foreground}}"
fi

printf "%s" "%{B${wspColorA} F${foreground}} "
printf "%s" $(echo $wspNames | cut -d " " -f $(($curWsp+1)))

if [ $curWsp -eq $(($numWsp - 1)) ]
then
    printf "%s" " %{F${wspColorA} B${background}}$sep_right"
else
    printf "%s" " %{F${wspColorA} B${wspColorD}}$sep_right%{B${wspColorD} F${foreground}}"
fi

for w in `seq $((curWsp + 1)) $(($numWsp - 1))`;
do
    if [ $w -eq $(($numWsp - 1)) ]
    then
        printf " %s %s" $(echo $wspNames | cut -d " " -f $(($w+1))) "%{F${wspColorD} B${background}}$sep_right"
    else
        printf " %s %s" $(echo $wspNames | cut -d " " -f $(($w+1))) "%{F${wspColorD}}$sep_right%{F${foreground}}"
    fi
done
