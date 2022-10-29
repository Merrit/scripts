#!/bin/bash

set -x

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"
gsettings set org.gnome.desktop.interface scaling-factor 2
autorandr --load main --force
xrandr --output DisplayPort-0 --scale 1.33x1.33 --set TearFree on
xrandr --output DisplayPort-1 --scale 2x2 --set TearFree on
xrandr --output HDMI-A-1 --off

bash ~/Dropbox/Scripts/Linux/window_rules.sh

# Switch default audio sink if the sink name doesn't contain "analog".
defaultSink=$(pactl get-default-sink)
if [[ $defaultSink != *"analog"* ]]; then
    bash ~/Dropbox/Scripts/Linux/audio_toggle_default.sh
fi
