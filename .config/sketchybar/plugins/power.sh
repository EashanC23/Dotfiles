#!/bin/bash

#. ~/.cache/wal/colors.sh
BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')
LOW_BATT=$(pmset -g | grep lowpowermode | cut -d " " -f 11)
BATT_MODE=0
if [[ $LOW_BATT -eq 1 ]]; then
  BATT_MODE=2
elif [[ $CHARGING != "" ]]; then
  BATT_MODE=1
else
  BATT_MODE=0
fi


[[ ${BATT_PERCENT} -gt 20 ]] && COLOR=0xFF${color5:1} || COLOR=0xFFFF0000

case $BATT_MODE in
  2)
  case ${BATT_PERCENT} in
     100) ICON="󱊣" ;;
      9[0-9]) ICON="󱊣" ;;
      8[0-9]) ICON="󱊣" ;;
      7[0-9]) ICON="󱊣" ;;
      6[6-9]) ICON="󱊣" ;;
      6[0-5]) ICON="󱊢" ;;
      5[0-9]) ICON="󱊢" ;;
      4[0-9]) ICON="󱊢" ;;
      3[3-9]) ICON="󱊢" ;;
      3[0-2]) ICON="󱊡" ;;
      2[0-9]) ICON="󱊡" ;;
      1[0-9]) ICON="󱊡" ;;
      *) ICON="󰂎"
  esac
  FONTSIZE=13
    ;;
  1)
  case ${BATT_PERCENT} in
     100) ICON="󰂅" ;;
      9[0-9]) ICON="󰂋" ;;
      8[0-9]) ICON="󰂊" ;;
      7[0-9]) ICON="󰢞" ;;
      6[0-9]) ICON="󰂉" ;;
      5[0-9]) ICON="󰢝" ;;
      4[0-9]) ICON="󰂈" ;;
      3[0-9]) ICON="󰂇" ;;
      2[0-9]) ICON="󰂆" ;;
      1[0-9]) ICON="󰢜" ;;
      *) ICON="󰢟"
  esac
  FONTSIZE=19
    ;;
  *)
  case ${BATT_PERCENT} in
     100) ICON="󰁹" ;;
      9[0-9]) ICON="󰂂" ;;
      8[0-9]) ICON="󰂁" ;;
      7[0-9]) ICON="󰂀" ;;
      6[0-9]) ICON="󰁿" ;;
      5[0-9]) ICON="󰁾" ;;
      4[0-9]) ICON="󰁽" ;;
      3[0-9]) ICON="󰁼" ;;
      2[0-9]) ICON="󰁻" ;;
      1[0-9]) ICON="󰁺" ;;
      *) ICON="󰂎"
  esac
  FONTSIZE=12
    ;;
esac
#
# if [[ $CHARGING != "" ]]; then
# else
# fi


if [[ $BATT_PERCENT -lt 21 ]]; then 
  if [[ $CHARGING != "" ]]; then
    COLOR=0xFF00FF00
  else
    COLOR=0xFFFF0000
  fi
else 
  if [[ $CHARGING != "" ]]; then
    COLOR=0xFF00FF00
  else
    COLOR=0xFFFFFFFF
  fi
fi

#sketchybar -m --set battery
sketchybar -m --set battery icon=${ICON}
sketchybar -m --set battery icon.font="Hack Nerd Font Mono:Regular:${FONTSIZE}"
sketchybar -m --set battery icon.color=${COLOR}
sketchybar -m --set battery label=$(printf "${BATT_PERCENT}%%")
