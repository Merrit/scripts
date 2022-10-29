#!/bin/bash

# Expand variables and echo all commands
set -x

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"
gsettings set org.gnome.desktop.interface scaling-factor 2
autorandr --load tv
xrandr --output DisplayPort-0 --off
xrandr --output DisplayPort-1 --off
xrandr --output HDMI-A-1 --scale 1.33x1.33 --primary --set TearFree on

# Switch default audio sink if the sink name doesn't contain "hdmi".
defaultSink=$(pactl get-default-sink)
if [[ $defaultSink != *"hdmi"* ]]; then
    bash /home/merritt/Dropbox/Scripts/Linux/audio_toggle_default.sh
fi
