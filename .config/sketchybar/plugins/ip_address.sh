#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
IS_VPN=$(scutil --nwi | grep -m1 'VPN' | awk '{ print $1 }')
WARP_STATUS=$(/usr/local/bin/warp-cli status | grep nected)
WARP_STATUS=${WARP_STATUS#"Status update: "}

if [[ $IS_VPN != "" ]]; then
	COLOR=$GREEN
	ICON=""
	LABEL="VPN"
elif [[ $WARP_STATUS == "Connected" ]]; then
  COLOR=$ORANGE
  ICON=
  LABEL=Warp
  CLICK="echo hi" 
elif [[ $IP_ADDRESS != "" ]]; then
	COLOR=$BLUE
	ICON=
	LABEL=WiFi 
else
	COLOR=$WHITE
	ICON=
	LABEL="Not Connected"
fi

sketchybar --set $NAME background.color=$COLOR \
	icon=$ICON \
	label=$LABEL
