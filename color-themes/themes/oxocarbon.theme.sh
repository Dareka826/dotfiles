#!/bin/sh

base00="161616"
base01="282828"
base02="404040"
base03="525252"
base04="aaaaaa"
base05="d0d0d0"
base06="f2f2f2"
base07="ffffff"

base08="78aaff"
base09="82cfff"
base0A="ee5296"
base0B="be96ff"
base0C="08bdba"
base0D="ff7eb6"
base0E="33b0ff"
base0F="3ddbda"

printf   '\033]11;#'"${base00}"'\033\\' #BG
printf   '\033]10;#'"${base07}"'\033\\' #FG
# NOTE:                ^ is base05 in base16-shell

printf  '\033]4;0;#'"${base00}"'\033\\' #C0
printf  '\033]4;8;#'"${base03}"'\033\\' #C8
printf  '\033]4;1;#'"${base08}"'\033\\' #C1
printf  '\033]4;9;#'"${base08}"'\033\\' #C9
printf  '\033]4;2;#'"${base0B}"'\033\\' #C2
printf '\033]4;10;#'"${base0B}"'\033\\' #C10
printf  '\033]4;3;#'"${base0A}"'\033\\' #C3
printf '\033]4;11;#'"${base0A}"'\033\\' #C11
printf  '\033]4;4;#'"${base0D}"'\033\\' #C4
printf '\033]4;12;#'"${base0D}"'\033\\' #C12
printf  '\033]4;5;#'"${base0E}"'\033\\' #C5
printf '\033]4;13;#'"${base0E}"'\033\\' #C13
printf  '\033]4;6;#'"${base0C}"'\033\\' #C6
printf '\033]4;14;#'"${base0C}"'\033\\' #C14
printf  '\033]4;7;#'"${base05}"'\033\\' #C7
printf '\033]4;15;#'"${base07}"'\033\\' #C15
