#!/bin/bash


status=$(warp-cli status | grep nected)
status=${RAA#"Status update: "}
if [[ $status != "Connected" ]];then
	# echo "here"
	/usr/local/bin/warp-cli connect
else
	/usr/local/bin/warp-cli disconnect 
fi
