#!/bin/bash


RAA=$(warp-cli status | grep nected)
RAA=${RAA#"Status update: "}
if [[ $RAA != "Connected" ]];then
	echo "here"
	/usr/local/bin/warp-cli connect
else
	/usr/local/bin/warp-cli disconnect 
fi
