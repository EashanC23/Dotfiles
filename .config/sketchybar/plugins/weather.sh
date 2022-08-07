#!/usr/bin/env bash

status=$(curl -s 'wttr.in/Cupertino?format=%C+|+%t')
condition=$(echo $status | awk -F '|' '{print $1}' | tr '[:upper:]' '[:lower:]')
condition="${condition// /}"
temp=$(echo $status | awk -F '|' '{print $2}')
temp="${temp//\+/}"
temp="${temp// /}"

# add more conditions here as appropriate
case "${condition}" in
  "sunny")
    icon="☀️"
    ;;
  "partlycloudy")
    icon="⛅️"
    ;;
  "cloudy")
    icon="☁️"
    ;;
  "overcast")
    icon="🌫"
    ;;
  "rainy")
    icon="🌧"
    ;;
  "clear")
    icon=""
    ;;
  "lightrain")
    icon="🌧"
    ;;
  "showerinvicinity")
    icon="􀇗"
  ;;
  "rainshower")
    icon="☔️"
    ;;
  *)
    icon="/"
    ;;
esac

sketchybar --set $NAME icon="$icon" label="$temp"
