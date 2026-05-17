#!/bin/bash
STATUS_LABEL=$(lsappinfo info -only StatusLabel "Discord")
ICON="󰙯"
DRAWING="on"
pgrep Discord > /dev/null 2>&1
DISC_OPEN=$?

if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"

    if [[ $LABEL == "" ]]; then
        ICON_COLOR="0xff7D7D88"
        sketchybar --set $NAME label.drawing=off
    elif [[ $LABEL == "•" ]]; then
        ICON_COLOR="0xff738ADB" 
        sketchybar --set $NAME label.drawing=on
    elif [[ $LABEL =~ ^[0-9]+$ ]]; then
        ICON_COLOR="0xff738ADB"
        sketchybar --set $NAME label.drawing=on
    fi
    sketchybar --set $NAME icon=$ICON label="${LABEL}" icon.color=${ICON_COLOR}
fi


if [[ $DISC_OPEN -eq 0 ]]; then
  sketchybar --set $NAME drawing=on icon=$ICON label="${LABEL}" icon.color=${ICON_COLOR}
else
  sketchybar --set $NAME drawing=off
fi

