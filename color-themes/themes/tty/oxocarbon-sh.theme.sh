#!/bin/sh

[ $TERM = "linux" ] || exit 0

base00="161616"
base01="282828"
base02="404040"
base03="525252"
base04="aaaaaa"
base05="d0d0d0"
base06="f2f2f2"
base07="ffffff"

base08="ee5296"
base09="82cfff"
base0A="ff7eb6"
base0B="08bdba"
base0C="3ddbda"
base0D="33b0ff"
base0E="be96ff"
base0F="78aaff"

printf '\033]P0'"${base00}"'
        \033]P8'"${base03}"'
        \033]P1'"${base08}"'
        \033]P9'"${base08}"'
        \033]P2'"${base0B}"'
        \033]PA'"${base0B}"'
        \033]P3'"${base0A}"'
        \033]PB'"${base0A}"'
        \033]P4'"${base0D}"'
        \033]PC'"${base0D}"'
        \033]P5'"${base0E}"'
        \033]PD'"${base0E}"'
        \033]P6'"${base0C}"'
        \033]PE'"${base0C}"'
        \033]P7'"${base05}"'
        \033]PF'"${base07}"'
        \033c'
