#!/usr/bin/env bash
#
# change-wallpaper.sh — Cycle wallpapers, bind to SUPER + ALT + SPACE.
#
set -euo pipefail

WALLPAPER_DIR="$HOME/wokemarchy-mac/wallpapers"
CONF="$HOME/wokemarchy-mac/hypr/hyprpaper.conf"

# Build an array of wallpapers paths
mapfile -t WALLS < <(ls "$WALLPAPER_DIR"/{*.png,*.jpg,*.jpeg,*.webp} 2>/dev/null)
[[ ${#WALLS[@]} -gt 0 ]] || { echo "no wallpapers found"; exit 1; }

# Get monitor, default to eDP-1
MONITOR=$(grep -oP '^\s*monitor\s*=\s*\K\S+' "$CONF" | head -1)
MONITOR="${MONITOR:-eDP-1}"

# Current wallpaper from the running hyprpaper instance (read-only)
current=$(hyprctl hyprpaper listactive 2>/dev/null | grep -oP "$MONITOR\s*:\s*\K.*" | head -1)

# Fall back to the configured path if hyprpaper isn't reporting
[[ -n "$current" ]] || current=$(grep -oP '^\s*path\s*=\s*\K.*' "$CONF" | head -1)

# Find wallpaper index, increment, and wrap
idx=0
for i in "${!WALLS[@]}"; do
  if [[ "${WALLS[$i]}" == "$current" ]]; then
    idx=$(( (i + 1) % ${#WALLS[@]} ))
    break
  fi
done

NEW="${WALLS[$idx]}"
echo "$(basename "$current") → $(basename "$NEW")"

# Switch at runtime via hyprpaper IPC; hyprpaper.conf is left untouched.
hyprctl hyprpaper wallpaper "$MONITOR,$NEW"
