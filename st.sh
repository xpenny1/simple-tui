#!/usr/bin/bash

source ./ansi-lib/ansi-lib.sh


centered() {
    str=$(echo -e "$@")
    strlines=$(printf "$str" | awk 'END{print NR}')
    strcols=$(printf "$str" | awk 'length($0)>len{len=length($0)}END{print len}')
    printf "$str" | awk '{print length($0),$0}END{print len}'
    printf "$str"
    echo $strlines
    echo $strcols
    printf "\e[""$(( (LINES - strlines) / 2 ))"";""$(( (COLUMNS - strcols) / 2))""$CUP""%s" "$str"
}

printCol() {
    [[ "$1" == "-" ]] && fg="$White" || fg="$1"
    [[ "$2" == "-" ]] && bg="$Black" || bg="$2"
    shift 2
    str=$(echo "$@")
    printf "\e[38;5;""$fg""m\e[48;5;""$bg""m%s\e[0m\n" "$str"
}

centered $(printCol 212 - "Hallo\nWelt")
read a

#printf "\e[?1049h"
#for i in $(seq 1 100); do
#    centered $(printCol 212 - "$i\nHallo Welt")
#    sleep 0.0;
#    printf "\e[$CUU\e[$ELE"
#done
#printf "\e[?1049l"


