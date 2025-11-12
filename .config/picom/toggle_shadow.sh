#!/bin/bash

STATE_FILE="/tmp/picom_shadow_state"

if [ ! -f $STATE_FILE ] || [ "$(cat "$STATE_FILE")" = "off" ]; then
	pkill picom
	picom --config $HOME/.config/picom/picom.conf &
	echo "on" > $STATE_FILE
	notify-send "Picom on"
else
	pkill picom
	echo "off" > $STATE_FILE
	notify-send "Picom off"
fi
