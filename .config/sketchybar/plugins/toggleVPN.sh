#!/bin/zsh
echo "WE MADE IT"
on=$(protonvpn s | awk '{print $2}'| grep nected )

if [ $on = "Disconnected" ]; then
	sudo protonvpn c -f 
else
	sudo protonvpn d 
fi
