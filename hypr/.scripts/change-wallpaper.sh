#!/usr/bin/env bash
#
# change-wallpaper.sh — Cycle wallpapers, bind to SUPER + SPACE.
#
set -euo pipefail

WALLPAPER_DIR="$HOME/wokemarchy-mac/wallpapers"
CONF="$HOME/wokemarchy-mac/hypr/hyprpaper.conf"

mapfile -t WALLS < <(ls "$WALLPAPER_DIR"/{*.png,*.jpg,*.jpeg,*.webp} 2>/dev/null)
[[ ${#WALLS[@]} -gt 0 ]] || { echo "no wallpapers found"; exit 1; }

# Current wallpaper (full path) from config
current=$(grep -oP 'path\s*=\s*\K.*' "$CONF" | head -1)

# Find index, increment, wrap
for i in "${!WALLS[@]}"; do
  [[ "${WALLS[$i]}" == "$current" ]] && break
done
idx=$(( (i + 1) % ${#WALLS[@]} ))

NEW="${WALLS[$idx]}"
echo "$(basename "$current") → $(basename "$NEW")"

# Update config
sed -i "s|path = .*|    path = $NEW|" "$CONF"

# Restart hyprpaper to pick up the new config
killall hyprpaper 2>/dev/null
setsid hyprpaper &
disown
