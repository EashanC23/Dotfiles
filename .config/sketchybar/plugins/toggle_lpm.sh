status=$(pmset -g custom | grep lowpowermode | awk '{print $2}')

if [ "$status" == "1" ]; then
  echo "Low Power Mode is currently ENABLED. Disabling it now..."
  sudo pmset -a lowpowermode 0
  echo "Low Power Mode has been disabled."
else
  echo "Low Power Mode is currently DISABLED. Enabling it now..."
  sudo pmset -a lowpowermode 1
  echo "Low Power Mode has been enabled."
fi
