-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
    -- Keyring & Auth Agent
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,pkcs11")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Core UI components
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")

    -- Keyboard brightness 50%
    hl.exec_cmd("brightnessctl -d kbd_backlight -e4 -n2 set 50%")
end)
