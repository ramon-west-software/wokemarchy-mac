# An unopinionated hyprland setup for Apple Silicon

Default keybind configurations require the following packages


- pacman packages
  - alacritty (terminal)
  - bluetui (bluetooth TUI)
  - btop (resource manager TUI)
  - dolphin (File Explorer)
  - extra/otf-font-awesome (font awesome icons for waybar)
  - firefox (browser)
  - flatpak (utlity to install flatpak packages)
  - fuzzel (application launcher)
  - grim (screenshot tool)
  - hyprland (._.)
  - hyprlock (lock screen)
  - hyprpaper (wallpaper manager)
  - gnome-keyring (keyring daemon)
  - seahorse (password manager)
  - libsecret (keyring client library)
  - nvim (text editor)
  - signal-desktop (messenger)
  - waybar (top bar with time and battery)
  - wlogout (menu for sleep and shutdown and restart)
- flatpaks
  - org.chromium.Chromium
  - io.freetubeapp.FreeTube

Change default apps in the following files before running install script
-   /hypr/config/variables.lua
-   /install.sh

*Note that some apps like alacritty (terminal) are hard-coded to the waybar config! 

I stil need to update waybar configs to inject preferred packages.*
