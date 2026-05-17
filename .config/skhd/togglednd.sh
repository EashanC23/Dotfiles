DND_ON=$(defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes")
echo $DND_ON
if [[ $DND_ON -eq 1 ]];then
  osascript -e "tell application \"System Events\" to key code 97"
  terminal-notifier -message "$(nowplaying-cli get artist) - $(nowplaying-cli get title)" -title "Now Playing" -contentImage /tmp/cover.jpg;
  sleep 1;
  osascript -e "tell application \"System Events\" to key code 97"
else
  terminal-notifier -message "$(nowplaying-cli get artist) - $(nowplaying-cli get title)" -title "Now Playing" -contentImage /tmp/cover.jpg;
fi

