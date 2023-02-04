#!/bin/bash

#. ~/.cache/wal/colors.sh
BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ $BATT_PERCENT -lt 21 ]]; then 
  sketchybar -m --set battery\
    icon.color=0xFFFF0000
else 
  sketchybar -m --set battery\
    icon.color=0xFFFFFFFF
fi

if [[ $CHARGING != "" ]]; then
  sketchybar -m --set battery \
    icon.color=0xFF5DFE67 \
    icon.font="Hack Nerd Font Mono:Regular:17.5"\
    icon= \
    label=$(printf "${BATT_PERCENT}%%")
  exit 0
fi


[[ ${BATT_PERCENT} -gt 20 ]] && COLOR=0xFF${color5:1} || COLOR=0xFFFF0000

case ${BATT_PERCENT} in
   100) ICON="" ;;
    9[0-9]) ICON="" ;;
    8[0-9]) ICON="" ;;
    7[0-9]) ICON="" ;;
    6[0-9]) ICON="" ;;
    5[0-9]) ICON="" ;;
    4[0-9]) ICON="" ;;
    3[0-9]) ICON="" ;;
    2[0-9]) ICON="" ;;
    1[0-9]) ICON="" ;;
    *) ICON=""
esac
echo $BATT_PERCENT
echo $ICON



#sketchybar -m --set battery
sketchybar -m --set battery icon=${ICON}
sketchybar -m --set battery icon.font="Hack Nerd Font Mono:Regular:12"
#sketchybar -m --set battery icon.color=0xFFFFFFFF
sketchybar -m --set battery label=$(printf "${BATT_PERCENT}%%")
