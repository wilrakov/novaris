#!/bin/bash

INTERVAL=2  # mise à jour toutes les 2 secondes

while true; do
    # --- RAM (usage en %)
    RAM_USED=$(free -m | awk '/Mem:/ {printf "%d%%", $3/$2 * 100}')

    # --- Batterie (en %)
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
    BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
    if [[ -n "$BATTERY" ]]; then
        BAT="${BATTERY}%"
        [[ "$BATTERY_STATUS" == "Charging" ]] && BAT="Charging ${BAT}"
    else
        BAT="N/A"
    fi

    # --- Réseau (IP locale)
    NET=$(ip addr show wlan0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)
    [[ -z "$NET" ]] && NET="N/A"

    # --- Heure
    TIME=$(date '+%H:%M:%S')

    # --- Combiner
    STATUS="RAM: $RAM_USED | BAT: $BAT | NET: $NET | $TIME"

    # --- Mettre à jour la barre
    xsetroot -name "$STATUS"

    sleep $INTERVAL
done

