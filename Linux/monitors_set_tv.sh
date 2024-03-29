#!/bin/bash

# Expand variables and echo all commands
set -x

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"
gsettings set org.gnome.desktop.interface scaling-factor 2
gsettings set org.gnome.desktop.interface text-scaling-factor 1

xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output HDMI-A-0 --off --output HDMI-A-1 --primary --mode 3840x2160 --scale 1.33x1.33 --primary --set TearFree on --pos 0x0 --rotate normal --output DVI-D-0 --off

# Switch default audio sink if the sink name doesn't contain "hdmi".
defaultSink=$(pactl get-default-sink)
if [[ $defaultSink != *"hdmi"* ]]; then
    bash /home/merritt/Dropbox/Scripts/Linux/audio_toggle_default.sh >> /home/merritt/monitor_errors.log 2>&1
    sleep 1
    defaultSink=$(pactl get-default-sink)
    if [[ $defaultSink != *"hdmi"* ]]; then
        echo "Failed to switch to HDMI sink" >> /home/merritt/monitors_set_tv_errors.log
    fi
fi

# Apply window rules
bash ~/Dropbox/Scripts/Linux/window_rules.sh
