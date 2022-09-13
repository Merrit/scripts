#!/bin/bash

set -x

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"
gsettings set org.gnome.desktop.interface scaling-factor 2
autorandr --load main --force
xrandr --output DisplayPort-0 --scale 1.33x1.33
xrandr --output DisplayPort-1 --scale 2x2
xrandr --output HDMI-A-1 --scale 1.33x1.33
