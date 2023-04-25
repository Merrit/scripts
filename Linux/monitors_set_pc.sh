#!/bin/bash

set -x

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"
gsettings set org.gnome.desktop.interface scaling-factor 2

xrandr --output DisplayPort-0 --primary --scale 1.33x1.33 --set TearFree on --mode 3840x2160 --pos 0x0 --rotate normal --output HDMI-A-0 --mode 1920x1080 --scale 2x2 --set TearFree on --pos 5108x356 --rotate normal --output HDMI-A-0 --off --output DisplayPort-1 --off --output DVI-D-0 --off

# Switch default audio sink if the sink name doesn't contain "analog".
defaultSink=$(pactl get-default-sink)
if [[ $defaultSink != *"analog"* ]]; then
    bash ~/Dropbox/Scripts/Linux/audio_toggle_default.sh
fi

# Restart Telegram
~/Dropbox/Scripts/Linux/restart-telegram.sh

# Wait for Telegram to start
sleep 2

# Apply window rules
bash ~/Dropbox/Scripts/Linux/window_rules.sh
