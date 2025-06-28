#!/usr/bin/bash

source ./ansi-lib/ansi-lib.sh

trap "lines=$LINES;cols=$COLUMNS;" SIGWINCH


centered1() {
    currentline=$(echo $1)
    maxlines=$(echo $2)
    strcols=0
    strlines=0
    while IFS='' read line; do
        strlines=$(( strlines + 1 ))
        [[ ${#line} > $strcols ]] && strcols=${#line}
    done <<< "$3"
    echo $LINES
    echo $COLUMNS
    while IFS='' read line; do
        printf "\e[""$(( ((lines - maxlines) / 2) + currentline ))"";""$(( (cols - strcols) / 2))""$CUP""%s" "$line"  >&2;
    done <<< "$3"
    echo $strlines
}

centered() {
    str=$(echo -e "$@")
    strlines=0
    while IFS='' read -r line; do
        strlines=$(( strlines + 1 ))
    done <<< "$(printf \"$str\")"
    currentline=0
    while [[ -n "$1" ]]; do
        printed=$(centered1 $currentline $strlines "$1")
        currentline=$(( currentline + printed ))
        shift
    done
}

printCol() {
    [[ "$1" == "-" ]] && fg="$White" || fg="$1"
    [[ "$2" == "-" ]] && bg="$Black" || bg="$2"
    shift 2
    str=$(echo "$@")
    printf "\e[38;5;""$fg""m\e[48;5;""$bg""m%s\e[0m\n" "$str"
}

printf "\e[?1049h"
echo $LINES
echo $COLUMNS
centered1 0 1 "Hallo"
centered "HAllo"
##centered $(printCol 212 - "Hallo\nWelt")
read a
printf "\e[?1049l"

#printf "\e[?1049h"
#for i in $(seq 1 100); do
#    centered $(printCol 212 - "$i\nHallo Welt")
#    sleep 0.0;
#    printf "\e[$CUU\e[$ELE"
#done
#printf "\e[?1049l"


