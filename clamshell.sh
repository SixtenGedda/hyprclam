#!/bin/bash

#on boot -> exec-once

#on wake -> systemd service

#on plug -> acpid

echo "$(date '+%H:%M:%S') ACPI triggered" >>/tmp/clamshell.log

export XDG_RUNTIME_DIR="/run/user/1000"
export HYPRLAND_INSTANCE_SIGNATURE=$(ls /run/user/1000/hypr | head -n 1)

KBD_BACKLIGHT="/sys/class/leds/asus::kbd_backlight/brightness"
LID_STATE=$(cat /proc/acpi/button/lid/*/state | awk '{print $2}')

echo "$LID_STATE"

SAVED_BRIGHTNESS=$(cat $KBD_BACKLIGHT)

if [[ "$LID_STATE" == "closed" ]]; then
  sleep 0.2
  hyprctl keyword monitor "eDP-1, disable"
  echo 0 | tee "$KBD_BACKLIGHT"
else
  echo 3 | tee $KBD_BACKLIGHT
  hyprctl keyword monitor "eDP-1, preferred, auto, 1"

fi
